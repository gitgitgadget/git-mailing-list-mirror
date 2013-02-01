From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 1/6] fixup! fixup! Change 'git' to 'Git' whenever the whole
 system is referred to #2
Date: Fri, 1 Feb 2013 19:06:45 +0100 (CET)
Message-ID: <7880599.1090070.1359742005398.JavaMail.ngmail@webmail18.arcor-online.net>
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
X-From: git-owner@vger.kernel.org Fri Feb 01 19:07:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1L13-0001sP-Ei
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 19:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309Ab3BASGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 13:06:48 -0500
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:49156 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753109Ab3BASGq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Feb 2013 13:06:46 -0500
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mx.arcor.de (Postfix) with ESMTP id 62D8735AC6E;
	Fri,  1 Feb 2013 19:06:45 +0100 (CET)
Received: from mail-in-14.arcor-online.net (mail-in-14.arcor-online.net [151.189.21.54])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 645A31F600E;
	Fri,  1 Feb 2013 19:06:45 +0100 (CET)
Received: from webmail18.arcor-online.net (webmail18.arcor-online.net [151.189.8.76])
	by mail-in-14.arcor-online.net (Postfix) with ESMTP id 5A4E79BCEC;
	Fri,  1 Feb 2013 19:06:45 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-14.arcor-online.net 5A4E79BCEC
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1359742005; bh=OOGD/AMjLW/CA6GUEoY9so/DYa8WQ/ayro8sGF2BDAE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=eDDFWJ3sL9GhZMzejEHgj56BieZkuN9JONZ1ZOsn3rM+Syg7na5fHrfF7yVkL54wE
	 J2VexA6yBvYK0pVW9nfmH5ZSX76z4jEdnqr+LCOhvMyAF489ZLmWg2aw4qE/5x94HQ
	 naJ5P1XLg7JorK20gca7sHHw+AEA9cLmN/a9mNrM=
Received: from [188.105.106.49] by webmail18.arcor-online.net (151.189.8.76) with HTTP (Arcor Webmail); Fri, 1 Feb 2013 19:06:45 +0100 (CET)
In-Reply-To: <210945773.1090030.1359741840305.JavaMail.ngmail@webmail18.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.106.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215238>

Found by David and Junio:
Inconsistent quoting within config.txt should be fixed in a separate patch.

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3652ee0..1bfbc7a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1773,7 +1773,7 @@ pull.twohead::
 	The default merge strategy to use when pulling a single branch.
 
 push.default::
-	Defines the action Git push should take if no refspec is given
+	Defines the action `git push` should take if no refspec is given
 	on the command line, no refspec is configured in the remote, and
 	no refspec is implied by any of the options given on the command
 	line. Possible values are:
-- 
1.8.0.msysgit.0


---
Thomas
