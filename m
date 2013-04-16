From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 03/13] pretty-formats.txt: wrap long lines
Date: Tue, 16 Apr 2013 18:24:52 +1000
Message-ID: <1366100702-31745-4-git-send-email-pclouds@gmail.com>
References: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
 <1366100702-31745-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 16 10:26:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US1DF-0005SY-I7
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 10:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935655Ab3DPIZ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 04:25:57 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:46550 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935647Ab3DPIZz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 04:25:55 -0400
Received: by mail-pa0-f44.google.com with SMTP id bi5so219019pad.17
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 01:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=NVPvA7OM88/IFdBdZug5blLCNCWXEa2TIVez0V4+22Y=;
        b=TgGoslHdcK3yW59OaZgkIg+tYK+kkoGEk5HXe+ALXCZN0a4dKUBdCa/57wJeG8iJKk
         7Go7RoBgGN5T0EF/TSOx+ANnDwjIzJsQW1F7KeJ8lgpZjRmUvouKkK/p5dMfaasbPLO2
         vpjQdwAId1XvTOpFV2kAQZaxg8I6v1xsAWIH1n1PW2jAyTKUy4SqaQuftr1bc0iG564/
         fgJ92gxtk6jyKgG5EhIsSYWeRr7+UVue2tmeswBJLYBX4mqyguuTPOCA6dYIW9xrNhST
         CtWvKL6AvGBdwa1u41TPvbqoJTPWhslYrZMrstRINqiYlSxg+IXy3tBolfXSJJlY68u1
         C/rA==
X-Received: by 10.68.209.135 with SMTP id mm7mr1743036pbc.167.1366100755326;
        Tue, 16 Apr 2013 01:25:55 -0700 (PDT)
Received: from pclouds@gmail.com (xinyep.lnk.telstra.net. [110.143.18.114])
        by mx.google.com with ESMTPS id yp2sm1758005pab.10.2013.04.16.01.25.51
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 16 Apr 2013 01:25:54 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Apr 2013 18:25:41 +1000
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1366100702-31745-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221382>

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
