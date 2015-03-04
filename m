From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/7] Documentation/config.txt: explain multi-valued variables once
Date: Wed,  4 Mar 2015 13:33:18 -0800
Message-ID: <1425504803-16039-3-git-send-email-gitster@pobox.com>
References: <xmqqpp9628tl.fsf@gitster.dls.corp.google.com>
 <1425504803-16039-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 22:33:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTGvH-0007Ex-94
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 22:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044AbbCDVdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 16:33:32 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54824 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753030AbbCDVda (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 16:33:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E2293C770;
	Wed,  4 Mar 2015 16:33:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=L362
	2E0D1H6bl/kTXzWyBv/OJtQ=; b=ImCvKwLvcNtT/KcCraYo1MAgsYJSn7s2qf/m
	EYFWHiYov9urgSVKGnceM33cSaZDH8ckSQlh58n1NtinwiptH0/fYL6kw09sIE0/
	Cwdo9BiVmQkc4AaGlsQ8C09AI0QnQTcgrWOrx2JjJxc4msoEobxGvq/I9yBm7N+Q
	keevez4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=bNsI7p
	bQnEDaGGgWS+y29SuUkRf8hC8qw/pNdO5tzcg5TUq5hArhovx3k2SyWjo6MyXZYM
	s6QCv9tu0Tg13RV3UEL3mxk8ySpd6Dau9VgAKAlVHYx6i61NGSoc9OpKR2fW9IOV
	09N37RFaHiq42SvfO2BBLYQgUnJ1GLi33wHG8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 067C43C76F;
	Wed,  4 Mar 2015 16:33:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FA923C76E;
	Wed,  4 Mar 2015 16:33:29 -0500 (EST)
X-Mailer: git-send-email 2.3.1-318-g5233f23
In-Reply-To: <1425504803-16039-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 19543242-C2B6-11E4-B603-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264784>

The syntax section repeats what the preamble explained already.
That a variable can have multiple values is more about what a
variable is than the syntax of the file.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index dbe7035..405bf25 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -14,7 +14,8 @@ the fully qualified variable name of the variable itself is the last
 dot-separated segment and the section name is everything before the last
 dot. The variable names are case-insensitive, allow only alphanumeric
 characters and `-`, and must start with an alphabetic character.  Some
-variables may appear multiple times.
+variables may appear multiple times; we say then that the variable is
+multivalued.
 
 Syntax
 ~~~~~~
@@ -56,9 +57,7 @@ header) are recognized as setting variables, in the form
 'name = value'.  If there is no equal sign on the line, the entire line
 is taken as 'name' and the variable is recognized as boolean "true".
 The variable names are case-insensitive, allow only alphanumeric characters
-and `-`, and must start with an alphabetic character.  There can be more
-than one value for a given variable; we say then that the variable is
-multivalued.
+and `-`, and must start with an alphabetic character.
 
 Leading and trailing whitespace in a variable value is discarded.
 Internal whitespace within a variable value is retained verbatim.
-- 
2.3.1-316-g7c93423
