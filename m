From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/8] CodingGuidelines: give an example for control statements
Date: Wed, 30 Apr 2014 14:45:08 -0700
Message-ID: <1398894312-30763-5-git-send-email-gitster@pobox.com>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 23:45:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfcJx-0004xn-BE
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 23:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759319AbaD3Vpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 17:45:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62524 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752566AbaD3Vpi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 17:45:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1586825FE;
	Wed, 30 Apr 2014 17:45:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=KX6J
	9pGWPLFWJegFQAOUOzATVzA=; b=FMc95YoBWS0KR2Yjny66sEZSAZS76a5Sov3p
	Bz6EG/iRA14l4/mRSAW4oovHxHDEWgmoEOFPJv2WcWhxOPZDAM7tBfGKYrOFJcpP
	K+i6sXP9chhFLNiQT9ew1rMZz+N4Fw/2B+Si7I9eXzmw6Jm89SMzGd87YZJQ3QUd
	q1rgW10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=kozHQv
	aTjQ7A6Z6Hxcz6tA475icqlNdAvaqH5sVAbA4kcFsOgmQKLKDZeExHgKevhuvsoe
	4LRsk9qUegFtpYJutIqknGBpXRkI6djkaAio67ugvC8k2IbfQU96/7qCEFD++AqV
	alw7lBKVaqmzf3942aErOnLdR7MZJcMPBZ42g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7624825FD;
	Wed, 30 Apr 2014 17:45:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B003825F2;
	Wed, 30 Apr 2014 17:45:31 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-rc1-355-gd6d6511
In-Reply-To: <1398894312-30763-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C0978EC6-D0B0-11E3-A3BE-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247787>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 1e0c4cf..d72e912 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -97,6 +97,17 @@ For shell scripts specifically (not exhaustive):
    "then" should be on the next line for if statements, and "do"
    should be on the next line for "while" and "for".
 
+	(incorrect)
+	if test -f hello; then
+		do this
+	fi
+
+	(correct)
+	if test -f hello
+	then
+		do this
+	fi
+
  - We prefer "test" over "[ ... ]".
 
  - We do not write the noiseword "function" in front of shell
-- 
2.0.0-rc1-355-gd6d6511
