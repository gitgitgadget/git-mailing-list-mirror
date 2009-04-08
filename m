From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/8] archive: add shortcuts for --format and --prefix
Date: Wed,  8 Apr 2009 20:05:26 +1000
Message-ID: <1239185133-4181-2-git-send-email-pclouds@gmail.com>
References: <1239185133-4181-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 12:08:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrUhy-0005bq-NB
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 12:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763695AbZDHKGk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2009 06:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763570AbZDHKGi
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 06:06:38 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:46357 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763061AbZDHKGh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 06:06:37 -0400
Received: by rv-out-0506.google.com with SMTP id b25so751452rvf.5
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 03:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=yBJvPT3Bgg1g8hZ2mg/o+wHfuPzXpQgXY4au1t3teng=;
        b=GflE1xEfb4MgXcIa860fPdv8j2+rfwT6TT5C3Q9lMpe340NXSjLA19bYs6m7bFc0Kc
         i2D959eD69WTr1X9Rp51FtLLByp01FljGSdI1mVsyxBFWJs9+6mxXPVRYiFGXpJs3Ejc
         FxlD51tStNgKkMYbNILj1fGbzg1iht8frYeNA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=CMi7am7gOsWIvvkasFDEHcG9cv4XAIFKk8mJPSqpevLKWThoeN6H0lU/Bag/f9Gdmz
         Bo4RamS3/RG4VZg3R/Ok6/UF20RNkREpQ2OCtq4D4ONIL+Y3aH9+FDQz6dyK3rf7wcH/
         zT0US8QB0ugEvTnRsW6J+H4gfJXRa6s5cwofg=
Received: by 10.141.20.7 with SMTP id x7mr468758rvi.14.1239185197173;
        Wed, 08 Apr 2009 03:06:37 -0700 (PDT)
Received: from dektop ([121.91.216.142])
        by mx.google.com with ESMTPS id f42sm24884166rvb.41.2009.04.08.03.06.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Apr 2009 03:06:36 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed,  8 Apr 2009 20:06:26 +1000
X-Mailer: git-send-email 1.6.2.2.602.g83ee9f
In-Reply-To: <1239185133-4181-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116069>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-archive.txt |    4 +++-
 archive.c                     |    4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.=
txt
index c1adf59..c9fff54 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -9,7 +9,7 @@ git-archive - Create an archive of files from a named t=
ree
 SYNOPSIS
 --------
 [verse]
-'git archive' --format=3D<fmt> [--list] [--prefix=3D<prefix>/] [<extra=
>]
+'git archive' [-f|--format=3D<fmt>] [--list] [-p|--prefix=3D<prefix>/]=
 [<extra>]
 	      [--output=3D<file>]
 	      [--remote=3D<repo> [--exec=3D<git-upload-archive>]] <tree-ish>
 	      [path...]
@@ -33,6 +33,7 @@ comment.
 OPTIONS
 -------
=20
+-f=3D<fmt>::
 --format=3D<fmt>::
 	Format of the resulting archive: 'tar' or 'zip'.  The default
 	is 'tar'.
@@ -45,6 +46,7 @@ OPTIONS
 --verbose::
 	Report progress to stderr.
=20
+-p=3D<prefix>/::
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
