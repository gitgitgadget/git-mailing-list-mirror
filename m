From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 03/13] pretty-formats.txt: wrap long lines
Date: Fri, 19 Apr 2013 09:08:42 +1000
Message-ID: <1366326532-28517-4-git-send-email-pclouds@gmail.com>
References: <1366100702-31745-1-git-send-email-pclouds@gmail.com>
 <1366326532-28517-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 01:09:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USxxJ-0007MV-Uk
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 01:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966174Ab3DRXJ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Apr 2013 19:09:26 -0400
Received: from mail-da0-f42.google.com ([209.85.210.42]:56623 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497Ab3DRXJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 19:09:25 -0400
Received: by mail-da0-f42.google.com with SMTP id n15so1159951dad.15
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 16:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=NVPvA7OM88/IFdBdZug5blLCNCWXEa2TIVez0V4+22Y=;
        b=EdEDqomjrQ7d8sU93kZ0trrnhWV3CBWZve0U8Y+mh7MYIipqTMx3kXo95mSUYzaoEI
         cqAkTh3YoEtu62y2o/lTJSdWT8QtfWbCm9AIVDE0NRTgSfVuTkHXLRUEP93olRGsEWaV
         DyYu4u96Cn+EkfvQCtiMlJicDetioNTXwK6kIe3O5vZtALCglocLlY1tPiYw+0hLCJLX
         q4EXlDnfNnRJy/OLV7A+ETVC1eKL61gV79tWOgKNu56BoLX2H3ETZiCYzsBf+ISzegEv
         JgvqtdwSnBxRtpQKtzLNlsIiwlTP08eD/+GknqvmaipNk+33K+lZrV1nBpdeFAiMJ2LE
         QAHQ==
X-Received: by 10.68.220.2 with SMTP id ps2mr15868179pbc.51.1366326565055;
        Thu, 18 Apr 2013 16:09:25 -0700 (PDT)
Received: from pclouds@gmail.com (dektec3.lnk.telstra.net. [165.228.202.174])
        by mx.google.com with ESMTPS id ak1sm11214881pbc.10.2013.04.18.16.09.21
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 16:09:24 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 19 Apr 2013 09:09:15 +1000
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1366326532-28517-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221705>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/pretty-formats.txt | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
index afac703..6bde67e 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -106,18 +106,22 @@ The placeholders are:
 - '%P': parent hashes
 - '%p': abbreviated parent hashes
 - '%an': author name
-- '%aN': author name (respecting .mailmap, see linkgit:git-shortlog[1]=
 or linkgit:git-blame[1])
+- '%aN': author name (respecting .mailmap, see linkgit:git-shortlog[1]
+  or linkgit:git-blame[1])
 - '%ae': author email
-- '%aE': author email (respecting .mailmap, see linkgit:git-shortlog[1=
] or linkgit:git-blame[1])
+- '%aE': author email (respecting .mailmap, see
+  linkgit:git-shortlog[1] or linkgit:git-blame[1])
 - '%ad': author date (format respects --date=3D option)
 - '%aD': author date, RFC2822 style
 - '%ar': author date, relative
 - '%at': author date, UNIX timestamp
 - '%ai': author date, ISO 8601 format
 - '%cn': committer name
-- '%cN': committer name (respecting .mailmap, see linkgit:git-shortlog=
[1] or linkgit:git-blame[1])
+- '%cN': committer name (respecting .mailmap, see
+  linkgit:git-shortlog[1] or linkgit:git-blame[1])
 - '%ce': committer email
-- '%cE': committer email (respecting .mailmap, see linkgit:git-shortlo=
g[1] or linkgit:git-blame[1])
+- '%cE': committer email (respecting .mailmap, see
+  linkgit:git-shortlog[1] or linkgit:git-blame[1])
 - '%cd': committer date
 - '%cD': committer date, RFC2822 style
 - '%cr': committer date, relative
@@ -138,9 +142,11 @@ The placeholders are:
 - '%gD': reflog selector, e.g., `refs/stash@{1}`
 - '%gd': shortened reflog selector, e.g., `stash@{1}`
 - '%gn': reflog identity name
-- '%gN': reflog identity name (respecting .mailmap, see linkgit:git-sh=
ortlog[1] or linkgit:git-blame[1])
+- '%gN': reflog identity name (respecting .mailmap, see
+  linkgit:git-shortlog[1] or linkgit:git-blame[1])
 - '%ge': reflog identity email
-- '%gE': reflog identity email (respecting .mailmap, see linkgit:git-s=
hortlog[1] or linkgit:git-blame[1])
+- '%gE': reflog identity email (respecting .mailmap, see
+  linkgit:git-shortlog[1] or linkgit:git-blame[1])
 - '%gs': reflog subject
 - '%Cred': switch color to red
 - '%Cgreen': switch color to green
--=20
1.8.2.82.gc24b958
