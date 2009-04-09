From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/3] archive: add shortcuts for --format and --prefix
Date: Thu,  9 Apr 2009 17:01:28 +1000
Message-ID: <1239260490-6318-2-git-send-email-pclouds@gmail.com>
References: <1239260490-6318-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Apr 09 09:04:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LroId-0004of-7V
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 09:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756AbZDIHBs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Apr 2009 03:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753830AbZDIHBr
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 03:01:47 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:2112 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbZDIHBq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 03:01:46 -0400
Received: by wf-out-1314.google.com with SMTP id 29so498805wff.4
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 00:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=7Dk3pvPr+vSAFhhSIxsnDxJdNen2zLh6vlV4YEEvLdw=;
        b=Rxf/Qes2sqwEoWpHxUASviRrIKkP83Bv1eZfCWTSmXmckhx0TMw664kkEu4FhFT/M/
         w7YYCiwlOUKHAei9XnrJn8MrSKuWHvte3F9BlVWOq4nVdJLwu74EoNBnrmgL0kCrZzst
         OuNzpA3f+QcD9JwUxAOSvGll39F1iRufoXdXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Wzll+yMVUB6cGl/7jY6OXZQAd48CSDMTQzF+z/qaHAqnFCfwFgg0DlLfa7+Ka2CeuL
         dG+uwcJZWyeM9DxZE5mCd6ugtTdRd0MNmWHZ+wPempNSqFIpw6+vB0i2vxnsU+wbmvjR
         2sTrNOAzMa7UetqT9dZ+ldei8PMZMCRd0emp8=
Received: by 10.142.218.4 with SMTP id q4mr770175wfg.74.1239260505529;
        Thu, 09 Apr 2009 00:01:45 -0700 (PDT)
Received: from dektop (dektec.lnk.telstra.net [203.45.32.221])
        by mx.google.com with ESMTPS id 30sm1541717wfc.24.2009.04.09.00.01.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Apr 2009 00:01:44 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu,  9 Apr 2009 17:01:39 +1000
X-Mailer: git-send-email 1.6.2.2.602.g83ee9f
In-Reply-To: <1239260490-6318-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116143>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-archive.txt |    4 +++-
 archive.c                     |    4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.=
txt
index c1adf59..2e31142 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -9,7 +9,7 @@ git-archive - Create an archive of files from a named t=
ree
 SYNOPSIS
 --------
 [verse]
-'git archive' --format=3D<fmt> [--list] [--prefix=3D<prefix>/] [<extra=
>]
+'git archive' [-f <fmt>|--format=3D<fmt>] [--list] [-p <prefix>/|--pre=
fix=3D<prefix>/] [<extra>]
 	      [--output=3D<file>]
 	      [--remote=3D<repo> [--exec=3D<git-upload-archive>]] <tree-ish>
 	      [path...]
@@ -33,6 +33,7 @@ comment.
 OPTIONS
 -------
=20
+-f <fmt>::
 --format=3D<fmt>::
 	Format of the resulting archive: 'tar' or 'zip'.  The default
 	is 'tar'.
@@ -45,6 +46,7 @@ OPTIONS
 --verbose::
 	Report progress to stderr.
=20
+-p <prefix>/::
 --prefix=3D<prefix>/::
 	Prepend <prefix>/ to each filename in the archive.
=20
diff --git a/archive.c b/archive.c
index 96b62d4..e87fed7 100644
--- a/archive.c
+++ b/archive.c
@@ -260,8 +260,8 @@ static int parse_archive_args(int argc, const char =
**argv,
 	int list =3D 0;
 	struct option opts[] =3D {
 		OPT_GROUP(""),
-		OPT_STRING(0, "format", &format, "fmt", "archive format"),
-		OPT_STRING(0, "prefix", &base, "prefix",
+		OPT_STRING('f', "format", &format, "fmt", "archive format"),
+		OPT_STRING('p', "prefix", &base, "prefix",
 			"prepend prefix to each pathname in the archive"),
 		OPT_STRING(0, "output", &output, "file",
 			"write the archive to this file"),
--=20
1.6.2.2.602.g83ee9f
