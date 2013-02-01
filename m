From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 2/6] fixup! fixup! fixup! Change 'git' to 'Git' whenever the
 whole system is referred to #1
Date: Fri, 1 Feb 2013 19:07:56 +0100 (CET)
Message-ID: <242116275.1090080.1359742076320.JavaMail.ngmail@webmail18.arcor-online.net>
References: <210945773.1090030.1359741840305.JavaMail.ngmail@webmail18.arcor-online.net> <7vzjzodfp1.fsf@alter.siamese.dyndns.org> <7v38xsjzxg.fsf@alter.siamese.dyndns.org>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
 <CAJDDKr4fnUp_35ni72XJS_NSp4jxbvQPENLnk3AhFv2FBg3DTg@mail.gmail.com>
 <50804391.814945.1358931502165.JavaMail.ngmail@webmail07.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, davvid@gmail.com
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Fri Feb 01 19:08:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1L2B-0002dr-J2
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 19:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094Ab3BASH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 13:07:58 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:59404 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753109Ab3BASH5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Feb 2013 13:07:57 -0500
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mx.arcor.de (Postfix) with ESMTP id 4C2BBD7F71;
	Fri,  1 Feb 2013 19:07:56 +0100 (CET)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 51A501F6016;
	Fri,  1 Feb 2013 19:07:56 +0100 (CET)
Received: from webmail18.arcor-online.net (webmail18.arcor-online.net [151.189.8.76])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 47AD3E440B;
	Fri,  1 Feb 2013 19:07:56 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-05.arcor-online.net 47AD3E440B
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1359742076; bh=P4f8OfUThd0pl1shx8bu0kBWzuj5xaxy+9YDDqFd/S0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=KSP/OQ+meDzggIiqqYHBCGM6PyrbqUKvjN5WT6zS4xPZHRUscREAhkAoiwRy9wq2+
	 r8HlXjsbI2XQc9PG4lSD1t70b612oQSMAN4Ls7XZEl7steXnZWTXlm9b+oLV4RiOlo
	 ittR234VnNTQ5Umd06bPhWwhJTEY10GFRIDUf1WQ=
Received: from [188.105.106.49] by webmail18.arcor-online.net (151.189.8.76) with HTTP (Arcor Webmail); Fri, 1 Feb 2013 19:07:56 +0100 (CET)
In-Reply-To: <210945773.1090030.1359741840305.JavaMail.ngmail@webmail18.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.106.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215239>

Found by Junio:
Change git-dir to $GIT_DIR and git-file to gitfile.

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/git-rev-parse.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index c743469..14386ed 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -187,9 +187,9 @@ print a message to stderr and exit with nonzero status.
 	Flags and parameters to be parsed.
 
 --resolve-git-dir <path>::
-	Check if <path> is a valid git-dir or a git-file pointing to a valid
-	git-dir. If <path> is a valid git-dir the resolved path to git-dir will
-	be printed.
+	Check if <path> is a valid `$GIT_DIR` or a gitfile pointing to a valid
+	`$GIT_DIR`. If <path> is a valid `$GIT_DIR` the resolved path to `$GIT_DIR`
+	will be printed.
 
 include::revisions.txt[]
 
-- 
1.8.0.msysgit.0


---
Thomas
