From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 25/25] list-files: documentation
Date: Mon,  6 Apr 2015 20:52:34 +0700
Message-ID: <1428328354-14897-26-git-send-email-pclouds@gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 1425896314-10941-1-git-send-email-pclouds@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:55:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7Un-0006Th-Qb
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbbDFNzS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:55:18 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35552 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448AbbDFNzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 09:55:16 -0400
Received: by patj18 with SMTP id j18so45153948pat.2
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=1YTvS2DSSeGazOH3uFFQOqUTNQNSdeUJ1jdfbvUZK4Y=;
        b=hNW0aMajFohZt1Wb3eEjMQC9saslDUQQNqKiOfvkS4OFOFo6mEZIJcleBoQ3liPdoJ
         GD1vHcCDuFGEBwzaIrPYS77gdZ/6IM+CXaMei7g12gLTyej9DMcdeULeCRjZpaIzZDnB
         0/Of7TMGFmY+MMhtY4zL2M7CQECFZSOlj6ZLQvIu+qYQz7m0ZMdA3GSFXlKAhmfYIy1i
         c8o7vR8NXNT09I9hVFnlR1cdKSFb2qjjLgxpgzL20J924gUwvjENu7o6+JyxGDT8A7P0
         7Q6BiM79S7RWyaiM7ckmMv2crkC08CDYk/nulIK0SYSqsSjaCyIQ0W/AhG+4sSCpQzCS
         2cCg==
X-Received: by 10.68.107.69 with SMTP id ha5mr27442864pbb.140.1428328515762;
        Mon, 06 Apr 2015 06:55:15 -0700 (PDT)
Received: from lanh ([115.73.245.217])
        by mx.google.com with ESMTPSA id xj1sm4762349pbb.92.2015.04.06.06.55.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 06:55:15 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Apr 2015 20:55:26 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266869>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-list-files.txt (new) | 115 +++++++++++++++++++++++++=
++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 Documentation/git-list-files.txt

diff --git a/Documentation/git-list-files.txt b/Documentation/git-list-=
files.txt
new file mode 100644
index 0000000..9b9edce
--- /dev/null
+++ b/Documentation/git-list-files.txt
@@ -0,0 +1,115 @@
+git-list-files(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+git-list-files - List files
+
+SYNOPSIS
+--------
+[verse]
+'git list-files [options] [<pathspec>...]
+
+DESCRIPTION
+-----------
+List files (by default in current working directory) that are in the
+index. Depending on the chosen options, maybe only modified files in
+working tree are shown, or untracked files... The builtin alias "ls"
+is set to "list-files".
+
+OPTIONS
+-------
+-c::
+--cached::
+	Show cached files (default)
+
+-d::
+--deleted::
+	Show deleted files in index, compared to HEAD
+
+-a::
+--added::
+	Show added files in index, compared to HEAD
+
+-m::
+--modified::
+	Show modified files in index, compared to HEAD. This implies
+	--deleted and --added
+
+-D::
+--wt-deleted::
+	Show deleted files in working directory
+
+-A::
+--wt-added::
+	Show added files in working directory
+
+-M::
+--wt-modified::
+	Show modified files in working directory. This implies
+	--wt-deleted and --wt-added
+
+-o::
+--others::
+	Show untracked files (and only unignored ones unless -i is
+	specified)
+
+-i::
+--ignored::
+	Show only ignored files. When showing files in the index,
+	print only those matched by an exclude pattern. When showing
+	"other" files, show only those matched by an exclude pattern.
+
+-u::
+--unmerged::
+	Show unmerged files
+
+-F::
+--classify::
+	Append indicator (one of `*/=3D>@|&`, which is executable,
+	directory, socket, Solaris door, symlink, fifo, or submodule
+	respectively) to entries.
+
+--color[=3D<when>]::
+--no-color::
+	Color file names. The value must be `always`, `never`, or
+	`auto`. `--no-color` is equivalent to
+	`--color=3Dnever`. `--color` is equivalent to
+	`--color=3Dauto`. See configuration variable `color.list-files`
+	for the default settings.
+
+--column[=3D<options>]::
+--no-column::
+-1::
+	Display files in columns. See configuration variable column.ui
+	for option syntax. `--column` and `--no-column` without options
+	are equivalent to 'always' and 'never' respectively.
+	`-1` is a shortcut for --no-column.
+
+--max-depth=3D<depth>::
+--recursive::
+-R::
+	For each <pathspec> given on command line, descend at most <depth>
+	levels of directories. A negative value means no limit.
+	This option is ignored if <pathspec> contains active wildcards.
+	In other words if "a*" matches a directory named "a*",
+	"*" is matched literally so --max-depth is still effective.
+	`-R` or `--recursive` is equivalent of `--max-depth=3D-1`
+	(infinite recursion).  The default is `--max-depth=3D0`.
+
+--tag::
+--no-tag::
+	Usually when tags are displayed by the left of the file name if
+	there are more than one file selection. Use either of these options
+	to force always or never display tags.
+
+<pathspec>::
+	Files to show. :(glob) magic is enabled by default.
+
+SEE ALSO
+--------
+linkgit:git-ls-files[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
--=20
2.3.0.rc1.137.g477eb31
