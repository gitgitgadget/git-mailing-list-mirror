From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 8/8] CodingGuidelines: once it is in, it is not worth the code churn
Date: Wed, 30 Apr 2014 14:45:12 -0700
Message-ID: <1398894312-30763-9-git-send-email-gitster@pobox.com>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 23:46:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfcKO-0005ZE-BW
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 23:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759556AbaD3Vp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 17:45:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35318 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759485AbaD3Vp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 17:45:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA38382630;
	Wed, 30 Apr 2014 17:45:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=wNf4
	tfO/XQZM0YCXWvHSQIolBUk=; b=VoDqnOAf0ao0bCX7fqF8nBwA/8fi0LFqfCC4
	Gs262BgU8g4xaK/0BM2H8YKFpIgS9n8i1+Ukz1XBbO3eJiNHTz70iZ/UbHfzxpQx
	9+Det1BTrm3Tt772Df4v9ZPK6VBCVGnSS0kLbecI8wPnqhuKlKIr6j6A5Vr4LP4D
	vDttK4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=c+7QFd
	kdrrRmGy5R7iFg9CSIo0TDrG9hJx42mgIXlE7FBavUBctMXWZXNJIuX+ZGz57fuM
	XJGDV6oQpl+nkuVJUniucGMRG1rwGi+OGHqzTum0se2C0tkFmTDooy7IbVbUG/24
	tkyDhbvZOo0lINNHvIgjX/py0REfQo6CzzGqw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7EDC8262F;
	Wed, 30 Apr 2014 17:45:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F46A8261E;
	Wed, 30 Apr 2014 17:45:49 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-rc1-355-gd6d6511
In-Reply-To: <1398894312-30763-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CB40EB06-D0B0-11E3-9E54-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247792>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 86fb9f6..759003e 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -18,6 +18,14 @@ code.  For Git in general, three rough rules are:
    judgement call, the decision is based more on real world
    constraints people face than what the paper standard says.
 
+ - Fixing style violations while working on a real change as a
+   preparatory clean-up step is good, but otherwise avoid useless code
+   churn for the sake of conforming to the style.
+
+   "Once it _is_ in the tree, it's not really worth the patch noise to
+   go and fix it up."
+   Cf. http://article.gmane.org/gmane.linux.kernel/943020
+
 Make your code readable and sensible, and don't try to be clever.
 
 As for more concrete guidelines, just imitate the existing code
-- 
2.0.0-rc1-355-gd6d6511
