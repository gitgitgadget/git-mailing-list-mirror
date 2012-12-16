From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH] Move api-command.txt to the end of API list in
 api-index.txt
Date: Sun, 16 Dec 2012 13:23:12 +0100 (CET)
Message-ID: <1702872710.62174.1355660592713.JavaMail.ngmail@webmail12.arcor-online.net>
References: <1582223824.296627.1355560147565.JavaMail.ngmail@webmail08.arcor-online.net> <1479174763.154268.1350408444997.JavaMail.ngmail@webmail15.arcor-online.net> <1213313884.154031.1350407865830.JavaMail.ngmail@webmail15.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: th.acker@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 16 13:23:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkDFk-0001Ib-Cz
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 13:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682Ab2LPMXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 07:23:15 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:47923 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752375Ab2LPMXO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Dec 2012 07:23:14 -0500
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mx.arcor.de (Postfix) with ESMTP id B829A107C08
	for <git@vger.kernel.org>; Sun, 16 Dec 2012 13:23:12 +0100 (CET)
Received: from mail-in-18.arcor-online.net (mail-in-18.arcor-online.net [151.189.21.58])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id B5D087FEC9B;
	Sun, 16 Dec 2012 13:23:12 +0100 (CET)
Received: from webmail12.arcor-online.net (webmail12.arcor-online.net [151.189.8.64])
	by mail-in-18.arcor-online.net (Postfix) with ESMTP id ACA513DC30C;
	Sun, 16 Dec 2012 13:23:12 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-18.arcor-online.net ACA513DC30C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1355660592; bh=mT00/dAqcUW4QX5Gr3SCBMtVTdb4L44PMfeUdhS7HU4=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=SiueeaB0Yv9AG1Gn3DCsbNNFk0PHdDXhsKwo9+X92fJ+hJJIm6pRfcYzAvEUdH3PY
	 d7UfDoKIUHWAzID/BW9HpBKUMgl8BDklqnY1MkWLf3pC7HtqI9KB9D73kRE2PC+nUR
	 M05BEa8aATf+K/KmASGmznx5mg0EY7I9W4S73x2g=
Received: from [94.217.21.17] by webmail12.arcor-online.net (151.189.8.64) with HTTP (Arcor Webmail); Sun, 16 Dec 2012 13:23:12 +0100 (CET)
In-Reply-To: <1582223824.296627.1355560147565.JavaMail.ngmail@webmail08.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.21.17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211591>


- because it describes a different form of API than the other api-* documents

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/technical/api-index.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-index.sh b/Documentation/technical/api-index.sh
index 9c3f413..c2c68ed 100755
--- a/Documentation/technical/api-index.sh
+++ b/Documentation/technical/api-index.sh
@@ -10,12 +10,16 @@
 	while read filename
 	do
 		case "$filename" in
-		api-index-skel.txt | api-index.txt) continue ;;
+		api-index-skel.txt | api-index.txt | api-command.txt) continue ;;
 		esac
 		title=$(sed -e 1q "$filename")
 		html=${filename%.txt}.html
 		echo "* link:$html[$title]"
 	done
+	filename=api-command.txt
+	title=$(sed -e 1q "$filename")
+	html=${filename%.txt}.html
+	echo "* link:$html[$title]"
 	echo "$c"
 	sed -n -e '/^\/\/ table of contents end/,$p' "$skel"
 ) >api-index.txt+
-- 
1.8.0.msysgit.0


---
Thomas
