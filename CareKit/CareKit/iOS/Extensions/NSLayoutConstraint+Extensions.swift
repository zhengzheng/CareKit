/*
 Copyright (c) 2019, Apple Inc. All rights reserved.

 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:

 1.  Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.

 2.  Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation and/or
 other materials provided with the distribution.

 3. Neither the name of the copyright holder(s) nor the names of any contributors
 may be used to endorse or promote products derived from this software without
 specific prior written permission. No license is granted to the trademarks of
 the copyright holders even if such marks are included in this software.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
#if !os(watchOS)

import UIKit

public struct LayoutDirection: OptionSet {
    public let rawValue: Int
    public init(rawValue: Self.RawValue) {
        self.rawValue = rawValue
    }
    public static let top = LayoutDirection(rawValue: 1 << 0)
    public static let bottom = LayoutDirection(rawValue: 1 << 1)
    public static let leading = LayoutDirection(rawValue: 1 << 2)
    public static let trailing = LayoutDirection(rawValue: 1 << 3)

    public static let horizontal: LayoutDirection = [.leading, .trailing]
    public static let vertical: LayoutDirection = [.top, .bottom]

    public static let all: LayoutDirection = [.horizontal, .vertical]
}

extension UILayoutPriority {
    public static var almostRequired: UILayoutPriority {
        return .required - 1
    }
}

extension NSLayoutConstraint {
    public func withPriority(_ new: UILayoutPriority) -> NSLayoutConstraint {
        priority = new
        return self
    }
}

extension UIView {
    public func setContentHuggingPriorities(_ new: UILayoutPriority) {
        setContentHuggingPriority(new, for: .horizontal)
        setContentHuggingPriority(new, for: .vertical)
    }

    public func setContentCompressionResistancePriorities(_ new: UILayoutPriority) {
        setContentCompressionResistancePriority(new, for: .horizontal)
        setContentCompressionResistancePriority(new, for: .vertical)
    }

    public func constraints(equalTo other: UIView, directions: LayoutDirection = .all,
                     priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        if directions.contains(.top) {
            constraints.append(topAnchor.constraint(equalTo: other.topAnchor).withPriority(priority))
        }
        if directions.contains(.leading) {
            constraints.append(leadingAnchor.constraint(equalTo: other.leadingAnchor).withPriority(priority))
        }
        if directions.contains(.bottom) {
            constraints.append(bottomAnchor.constraint(equalTo: other.bottomAnchor).withPriority(priority))
        }
        if directions.contains(.trailing) {
            constraints.append(trailingAnchor.constraint(equalTo: other.trailingAnchor).withPriority(priority))
        }
        return constraints
    }

    public func constraints(equalTo layoutGuide: UILayoutGuide, directions: LayoutDirection = .all,
                     priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        if directions.contains(.top) {
            constraints.append(topAnchor.constraint(equalTo: layoutGuide.topAnchor).withPriority(priority))
        }
        if directions.contains(.leading) {
            constraints.append(leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).withPriority(priority))
        }
        if directions.contains(.bottom) {
            constraints.append(bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).withPriority(priority))
        }
        if directions.contains(.trailing) {
            constraints.append(trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).withPriority(priority))
        }
        return constraints
    }

    public var isRightToLeft: Bool {
        return UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft
    }
}
#endif
