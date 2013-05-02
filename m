From: =?UTF-8?q?Anders=20Granskogen=20Bj=C3=B8rnstad?= 
	<andersgb@gmail.com>
Subject: [PATCH] Documentation/git-commit: Typo under --edit
Date: Thu,  2 May 2013 20:24:15 +0200
Message-ID: <1367519056-8889-1-git-send-email-andersgb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?UTF-8?q?Anders=20Granskogen=20Bj=C3=B8rnstad?= 
	<andersgb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 02 20:24:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXyBF-0002Xg-NO
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 20:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761402Ab3EBSY3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 May 2013 14:24:29 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:59296 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760668Ab3EBSY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 14:24:28 -0400
Received: by mail-la0-f44.google.com with SMTP id ed20so827100lab.17
        for <git@vger.kernel.org>; Thu, 02 May 2013 11:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=jCP78ATLeln5cx+WX4v4ZUEQ8Yfz4BSs6sazH1gwDSQ=;
        b=G1Wo8YqchU+OlqEFALY+UtZ+NL5beV+LBcs0gDqENauABZ2LXXYoJ3Pi2khBuoaCnj
         vC9bwts294BHkByhHhdEUdLcd8qCm6YBbcNBmEl95HUprhqEvWPB77OR8rcaTkWdiPAa
         K0XzLYpqkU/Xq1GsAMRWqyicyMPuL4uELh35lhlQnvBLUY8iEi927EHpjwm9/dmn2GM0
         afkLaoDbWHorZ6l1WKCUCnz85PzTveewofsGv+iSAls7++5eKQH/ZHcCi7SQpHCfo4m8
         l7LU8WJ7psPQK3CQ46aWa0I+evF6UYLftOQn494dGykhsd9ph+VTjdcUXLSjHvXKYBEo
         vahw==
X-Received: by 10.152.21.74 with SMTP id t10mr2957690lae.52.1367519066919;
        Thu, 02 May 2013 11:24:26 -0700 (PDT)
Received: from hingsten.lyse.net (94-246-23.38.3p.ntebredband.no. [94.246.23.38])
        by mx.google.com with ESMTPSA id m9sm3160584lag.10.2013.05.02.11.24.25
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 May 2013 11:24:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223245>

-C takes a commit object, not a file.

Signed-off-by: Anders Granskogen Bj=C3=B8rnstad <andersgb@gmail.com>
---
 Documentation/git-commit.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
index 9b1be55..8172938 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -197,8 +197,8 @@ variable (see linkgit:git-config[1]).
 -e::
 --edit::
 	The message taken from file with `-F`, command line with
-	`-m`, and from file with `-C` are usually used as the
-	commit log message unmodified.  This option lets you
+	`-m`, and from commit object with `-C` are usually used as
+	the commit log message unmodified. This option lets you
 	further edit the message taken from these sources.
=20
 --no-edit::
--=20
1.7.9.5
