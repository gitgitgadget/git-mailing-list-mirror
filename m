From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/8] CodingGuidelines: give an example for shell function preamble
Date: Wed, 30 Apr 2014 14:45:09 -0700
Message-ID: <1398894312-30763-6-git-send-email-gitster@pobox.com>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 23:45:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfcK7-0005Df-FS
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 23:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759536AbaD3Vpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 17:45:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59822 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759485AbaD3Vpn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 17:45:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31DB482615;
	Wed, 30 Apr 2014 17:45:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=cxIj
	3MD+fVCn+HGUI+ilrzEBgAI=; b=rn12O9j0apBtcicmwe23nUYTR5g7v9KyhNAx
	kVwSKhinxtgqNbydFwAkMoqOQYYVDVUxMHDYrna9xTa+0zvfKZzwfqls3tr3GctJ
	eVRj1CD30EMZ7wJTYXTWmb6vq6D7+NHL58FovmgR2EuRQ3dcpwLcfSxSD+NZL94a
	Zx8r0Nw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=p+RutK
	cycEx2zU3tfa1x79nJYK26sFwGuF8Gk62PmyLMndFwyYyrWrNK93jKA8jMI+qx4P
	EtNT2OGBp9SJ/3q0DgtAP/xUJBg2Q/v7+VhVF1iCtdbZyqh8OniWzI6DXsmsZnGl
	WYJxVtLHtQUowTW3eZj1+sU5L+5oMyRXPDTqU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DFA282613;
	Wed, 30 Apr 2014 17:45:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62A05825F9;
	Wed, 30 Apr 2014 17:45:36 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-rc1-355-gd6d6511
In-Reply-To: <1398894312-30763-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C38354C6-D0B0-11E3-A991-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247790>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index d72e912..1b0cd2b 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -113,9 +113,17 @@ For shell scripts specifically (not exhaustive):
  - We do not write the noiseword "function" in front of shell
    functions.
 
- - We prefer a space between the function name and the parentheses. The
-   opening "{" should also be on the same line.
-   E.g.: my_function () {
+ - We prefer a space between the function name and the parentheses,
+   and no space inside the parentheses. The opening "{" should also
+   be on the same line.
+
+	(incorrect)
+	my_function(){
+		...
+
+	(correct)
+	my_function () {
+		...
 
  - As to use of grep, stick to a subset of BRE (namely, no \{m,n\},
    [::], [==], or [..]) for portability.
-- 
2.0.0-rc1-355-gd6d6511
