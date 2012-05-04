From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Makefile: keep many variable list sorted
Date: Fri,  4 May 2012 20:52:36 +0700
Message-ID: <1336139556-28410-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 04 15:56:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQIza-0005G3-FQ
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 15:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757302Ab2EDN4O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 09:56:14 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39820 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322Ab2EDN4N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 09:56:13 -0400
Received: by pbbrp8 with SMTP id rp8so3870609pbb.19
        for <git@vger.kernel.org>; Fri, 04 May 2012 06:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=tD0IDilxtwdkijeFhXBPt00GMfUcR+bQkCVT3CjMLvA=;
        b=Ky9Z+CRUdZsYoPP2up3k91SdY3PlyAHE6CyI3FwCsiN/HtOZC15/BW/3fOklvn+/2G
         37XO7YOKG9VIW1bRlVJHa8z+6aIZGGSSu9zgaKw5aftnd2fd6qXHxGxFfdl0bMXYVtEf
         aakcUUAdUXeM9KDNI1x8XezyFxVeXGMH4Xm/C9W/AnsMKo4V8N9OODh5E7b4DcQGevNA
         Vtq380TJyVCRId54su2AgKs2mJwy26t2g2YuHVWtU6JtV0ttPrqtTFXok+/8gdkdUd2O
         b/QD8d3UFQdLg0ufRBF6clTcqzxkE4kAZ+1fIxA8+1XyxUkwDsmXcYPk6dwQYyX/rTGm
         1oGA==
Received: by 10.68.233.103 with SMTP id tv7mr672399pbc.97.1336139773375;
        Fri, 04 May 2012 06:56:13 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.42.111])
        by mx.google.com with ESMTPS id wn5sm1466740pbc.51.2012.05.04.06.56.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 May 2012 06:56:12 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 04 May 2012 20:52:39 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197023>

We tend to keep long lists sorted (extensions are not taken into
account), which helps spot a name easily by eye. Rearrange a few
items so these lists remain sorted.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index ac40e24..2fa7211 100644
--- a/Makefile
+++ b/Makefile
@@ -461,15 +461,15 @@ EXTRA_PROGRAMS =3D
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS +=3D $(EXTRA_PROGRAMS)
=20
+PROGRAM_OBJS +=3D credential-store.o
 PROGRAM_OBJS +=3D daemon.o
 PROGRAM_OBJS +=3D fast-import.o
+PROGRAM_OBJS +=3D http-backend.o
 PROGRAM_OBJS +=3D imap-send.o
+PROGRAM_OBJS +=3D sh-i18n--envsubst.o
 PROGRAM_OBJS +=3D shell.o
 PROGRAM_OBJS +=3D show-index.o
 PROGRAM_OBJS +=3D upload-pack.o
-PROGRAM_OBJS +=3D http-backend.o
-PROGRAM_OBJS +=3D sh-i18n--envsubst.o
-PROGRAM_OBJS +=3D credential-store.o
=20
 # Binary suffix, set to .exe for Windows builds
 X =3D
@@ -482,7 +482,6 @@ TEST_PROGRAMS_NEED_X +=3D test-ctype
 TEST_PROGRAMS_NEED_X +=3D test-date
 TEST_PROGRAMS_NEED_X +=3D test-delta
 TEST_PROGRAMS_NEED_X +=3D test-dump-cache-tree
-TEST_PROGRAMS_NEED_X +=3D test-scrap-cache-tree
 TEST_PROGRAMS_NEED_X +=3D test-genrandom
 TEST_PROGRAMS_NEED_X +=3D test-index-version
 TEST_PROGRAMS_NEED_X +=3D test-line-buffer
@@ -493,6 +492,7 @@ TEST_PROGRAMS_NEED_X +=3D test-parse-options
 TEST_PROGRAMS_NEED_X +=3D test-path-utils
 TEST_PROGRAMS_NEED_X +=3D test-revision-walking
 TEST_PROGRAMS_NEED_X +=3D test-run-command
+TEST_PROGRAMS_NEED_X +=3D test-scrap-cache-tree
 TEST_PROGRAMS_NEED_X +=3D test-sha1
 TEST_PROGRAMS_NEED_X +=3D test-sigchain
 TEST_PROGRAMS_NEED_X +=3D test-subprocess
@@ -568,19 +568,19 @@ VCSSVN_H +=3D vcs-svn/fast_export.h
 VCSSVN_H +=3D vcs-svn/svndiff.h
 VCSSVN_H +=3D vcs-svn/svndump.h
=20
+MISC_H +=3D bisect.h
 MISC_H +=3D branch.h
 MISC_H +=3D bundle.h
-MISC_H +=3D bisect.h
 MISC_H +=3D common-cmds.h
 MISC_H +=3D fetch-pack.h
-MISC_H +=3D thread-utils.h
+MISC_H +=3D reachable.h
 MISC_H +=3D send-pack.h
 MISC_H +=3D shortlog.h
-MISC_H +=3D reachable.h
-MISC_H +=3D wt-status.h
 MISC_H +=3D tar.h
+MISC_H +=3D thread-utils.h
 MISC_H +=3D url.h
 MISC_H +=3D walker.h
+MISC_H +=3D wt-status.h
=20
 LIB_H +=3D advice.h
 LIB_H +=3D archive.h
@@ -598,18 +598,18 @@ LIB_H +=3D compat/cygwin.h
 LIB_H +=3D compat/mingw.h
 LIB_H +=3D compat/obstack.h
 LIB_H +=3D compat/terminal.h
+LIB_H +=3D compat/win32/dirent.h
+LIB_H +=3D compat/win32/poll.h
 LIB_H +=3D compat/win32/pthread.h
 LIB_H +=3D compat/win32/syslog.h
-LIB_H +=3D compat/win32/poll.h
-LIB_H +=3D compat/win32/dirent.h
 LIB_H +=3D connected.h
 LIB_H +=3D convert.h
 LIB_H +=3D credential.h
 LIB_H +=3D csum-file.h
 LIB_H +=3D decorate.h
 LIB_H +=3D delta.h
-LIB_H +=3D diffcore.h
 LIB_H +=3D diff.h
+LIB_H +=3D diffcore.h
 LIB_H +=3D dir.h
 LIB_H +=3D exec_cmd.h
 LIB_H +=3D fmt-merge-msg.h
@@ -718,8 +718,8 @@ LIB_OBJS +=3D entry.o
 LIB_OBJS +=3D environment.o
 LIB_OBJS +=3D exec_cmd.o
 LIB_OBJS +=3D fsck.o
-LIB_OBJS +=3D gpg-interface.o
 LIB_OBJS +=3D gettext.o
+LIB_OBJS +=3D gpg-interface.o
 LIB_OBJS +=3D graph.o
 LIB_OBJS +=3D grep.o
 LIB_OBJS +=3D hash.o
@@ -768,9 +768,9 @@ LIB_OBJS +=3D rerere.o
 LIB_OBJS +=3D resolve-undo.o
 LIB_OBJS +=3D revision.o
 LIB_OBJS +=3D run-command.o
+LIB_OBJS +=3D sequencer.o
 LIB_OBJS +=3D server-info.o
 LIB_OBJS +=3D setup.o
-LIB_OBJS +=3D sequencer.o
 LIB_OBJS +=3D sha1-array.o
 LIB_OBJS +=3D sha1-lookup.o
 LIB_OBJS +=3D sha1_file.o
--=20
1.7.8.36.g69ee2
