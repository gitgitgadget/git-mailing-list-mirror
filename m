From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/7] Documentation/config.txt: avoid unnecessary negation
Date: Wed,  4 Mar 2015 13:33:17 -0800
Message-ID: <1425504803-16039-2-git-send-email-gitster@pobox.com>
References: <xmqqpp9628tl.fsf@gitster.dls.corp.google.com>
 <1425504803-16039-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 22:33:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTGv6-0007Af-W1
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 22:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbbCDVd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 16:33:29 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61295 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751678AbbCDVd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 16:33:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DD8293C76B;
	Wed,  4 Mar 2015 16:33:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=oiV1
	G3kAFBkv1RnacUFJhV884lY=; b=CZq9Ax2xMX9d8HGr0ktVJz6cEqy4tFWyLjFQ
	6YajYButng41+IB+ckmclqfqu96zfBO1n1pvPdsNWFjv8HgMUIClzKlfLnhhinaj
	fU8xhawf+PuMlds0+lP5CwpCpSXO89NvDhEgOjp2kx29OKZ/H4oRYunPLlxJ1rHn
	anwO+b4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=iQ5r3z
	ZdZ12ZZCk8xISf8VXNmksnjy7RTMEGorrtdTy8Q3t5Mcb8xmCnOFVvKdkh7V2efB
	kdXZGlZSD49womKTIZqWk0zs6AFic99dFiBUgkQg0iaXuXk1umPNBVGss6NYVlRc
	2UdzPC42D5wqRYfjOu/zU5VlrvysorJQB2Yng=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C40D23C76A;
	Wed,  4 Mar 2015 16:33:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 228963C767;
	Wed,  4 Mar 2015 16:33:27 -0500 (EST)
X-Mailer: git-send-email 2.3.1-318-g5233f23
In-Reply-To: <1425504803-16039-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 18106D4C-C2B6-11E4-96A8-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264780>

Section names and variable names are both case-insensitive, but one
is described as "not case sensitive".  Use "case-insensitive" for
both.

Instead of saying "... have to be escaped" without telling what that
escaping achieves, state it in a more positive way, i.e. "... can be
included by escaping".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 097fdd4..dbe7035 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -25,7 +25,7 @@ blank lines are ignored.
 
 The file consists of sections and variables.  A section begins with
 the name of the section in square brackets and continues until the next
-section begins.  Section names are not case sensitive.  Only alphanumeric
+section begins.  Section names are case-insensitive.  Only alphanumeric
 characters, `-` and `.` are allowed in section names.  Each variable
 must belong to some section, which means that there must be a section
 header before the first setting of a variable.
@@ -40,8 +40,8 @@ in the section header, like in the example below:
 --------
 
 Subsection names are case sensitive and can contain any characters except
-newline (doublequote `"` and backslash have to be escaped as `\"` and `\\`,
-respectively).  Section headers cannot span multiple
+newline (doublequote `"` and backslash can be included by escaping them
+as `\"` and `\\`, respectively).  Section headers cannot span multiple
 lines.  Variables may belong directly to a section or to a given subsection.
 You can have `[section]` if you have `[section "subsection"]`, but you
 don't need to.
-- 
2.3.1-316-g7c93423
