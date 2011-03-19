From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] git-init.txt: move description section up
Date: Sat, 19 Mar 2011 22:16:55 +0700
Message-ID: <1300547816-4768-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 16:19:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0xw4-0006iX-W2
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 16:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755346Ab1CSPTQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 11:19:16 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58239 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab1CSPTN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 11:19:13 -0400
Received: by mail-iy0-f174.google.com with SMTP id 26so4984416iyb.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 08:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=EHPf2v2iPkqbq30ngziQSJsxO3/qpoL0UF460SSTfpw=;
        b=kL2hESXo6/g+OfcvGtlTEp917TL9FCarqUoq409C3Ja39EYIQXg4TcUB9XcFsaxICC
         YUuxyOkR8O2XlY4unKtSDvjAM002pCSiH+3wrQDyUBljSgU61UyVuEUMpL1jMt38Ad6p
         bLjT8TViNV7xdmJ3gaGZnKOvBSgYTF24Yd1x4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=cfagSNB8Ssg2CwJazgS9Vog2JsJJS6ZElYPZr9CSBICB5OW+G4Fd2VSA0V+wDSZuDD
         +vPiljWPpLOeXwgNBfx89i4KnMdDuDLiX0bgCrSxrCtJFyaw8fxeRCGeAB/ViZZoimDj
         0pQoaCPN11ejf74qzg7aGYWmZFs94jNsKFHLY=
Received: by 10.231.199.71 with SMTP id er7mr2161008ibb.146.1300547953688;
        Sat, 19 Mar 2011 08:19:13 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.209.201])
        by mx.google.com with ESMTPS id 41sm2296810ibi.61.2011.03.19.08.19.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Mar 2011 08:19:12 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 19 Mar 2011 22:16:57 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169437>

It's more or less standard that synopsis is followed by description,
then options.

This is not just a clean move though:

 - The paragraphs are realigned a bit
 - The text mentioning git-init-db is dropped. init-db is
   deprecated, no need to confuse new users

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-init.txt |   46 +++++++++++++++++++-----------------=
-------
 1 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 5931925..0a4a20e 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -11,6 +11,26 @@ SYNOPSIS
 'git init' [-q | --quiet] [--bare] [--template=3D<template_directory>]=
 [--shared[=3D<permissions>]] [directory]
=20
=20
+DESCRIPTION
+-----------
+
+This command creates an empty git repository - basically a `.git`
+directory with subdirectories for `objects`, `refs/heads`,
+`refs/tags`, and template files.  An initial `HEAD` file that
+references the HEAD of the master branch is also created.
+
+If the `$GIT_DIR` environment variable is set then it specifies a path
+to use instead of `./.git` for the base of the repository.
+
+If the object storage directory is specified via the
+`$GIT_OBJECT_DIRECTORY` environment variable then the sha1 directories
+are created underneath - otherwise the default `$GIT_DIR/objects`
+directory is used.
+
+Running 'git init' in an existing repository is safe. It will not
+overwrite things that are already there. The primary reason for
+rerunning 'git init' is to pick up newly added templates.
+
 OPTIONS
 -------
=20
@@ -74,32 +94,6 @@ line, the command is run inside the directory (possi=
bly after creating it).
 --
=20
=20
-DESCRIPTION
------------
-This command creates an empty git repository - basically a `.git` dire=
ctory
-with subdirectories for `objects`, `refs/heads`, `refs/tags`, and
-template files.
-An initial `HEAD` file that references the HEAD of the master branch
-is also created.
-
-If the `$GIT_DIR` environment variable is set then it specifies a path
-to use instead of `./.git` for the base of the repository.
-
-If the object storage directory is specified via the `$GIT_OBJECT_DIRE=
CTORY`
-environment variable then the sha1 directories are created underneath =
-
-otherwise the default `$GIT_DIR/objects` directory is used.
-
-Running 'git init' in an existing repository is safe. It will not over=
write
-things that are already there. The primary reason for rerunning 'git i=
nit'
-is to pick up newly added templates.
-
-Note that 'git init' is the same as 'git init-db'.  The command
-was primarily meant to initialize the object database, but over
-time it has become responsible for setting up the other aspects
-of the repository, such as installing the default hooks and
-setting the configuration variables.  The old name is retained
-for backward compatibility reasons.
-
 TEMPLATE DIRECTORY
 ------------------
=20
--=20
1.7.4.74.g639db
