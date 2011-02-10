From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Move test-* to t/helper/ subdirectory
Date: Thu, 10 Feb 2011 09:14:29 +0700
Message-ID: <1297304069-14764-1-git-send-email-pclouds@gmail.com>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 03:16:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnM4p-0000QX-7P
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 03:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125Ab1BJCQE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 21:16:04 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:61336 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992Ab1BJCQC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 21:16:02 -0500
Received: by pxi15 with SMTP id 15so149457pxi.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 18:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=jwhLgD+oVKpngPIMl7T+rwgH7UYQlSiLm5rtjdXdLfo=;
        b=U4Wn4hDs2Ue3MMTh7+exDhwFHhs04lxrVWPri88cXwSsN7jOW44w2HlBJk7rL156yX
         qt7A9reAABSMLhB7MeJ+NXI1yGFR0xIVG3ll97CsvhI5+AOpqwYLLR9JN9JCbSP/k4+M
         5WRCwoy+QUr/T7OLG3wr8OsHZqWwbHntbW4mo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AY0rvU+pzQ1exV8zDPkQXudydBO82E95qnhbPbcXQNK7aAbDYkQ8jBPSnI/igUVfxt
         gImNU/0+8Mg99SIsla7wCPOHvXPE8+1gwEEmj5X5QBl/sEuUbO36v2oELjeJZqedbdc+
         138U+9m0Rms7O4O3xzkgJPXh4rkfwSe9d0UFw=
Received: by 10.142.49.1 with SMTP id w1mr7173161wfw.45.1297304162057;
        Wed, 09 Feb 2011 18:16:02 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id v19sm1198492wfh.12.2011.02.09.18.15.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 18:16:00 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 10 Feb 2011 09:14:31 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166463>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore                                         |   19 ------------
 Makefile                                           |   30 ++++++++++--=
--------
 t/helper/.gitignore                                |   19 ++++++++++++
 test-chmtime.c =3D> t/helper/test-chmtime.c          |    0
 test-ctype.c =3D> t/helper/test-ctype.c              |    0
 test-date.c =3D> t/helper/test-date.c                |    0
 test-delta.c =3D> t/helper/test-delta.c              |    0
 .../helper/test-dump-cache-tree.c                  |    0
 test-genrandom.c =3D> t/helper/test-genrandom.c      |    0
 .../helper/test-index-version.c                    |    0
 test-line-buffer.c =3D> t/helper/test-line-buffer.c  |    0
 test-match-trees.c =3D> t/helper/test-match-trees.c  |    0
 test-obj-pool.c =3D> t/helper/test-obj-pool.c        |    0
 .../helper/test-parse-options.c                    |    0
 test-path-utils.c =3D> t/helper/test-path-utils.c    |    0
 test-run-command.c =3D> t/helper/test-run-command.c  |    0
 test-sha1.c =3D> t/helper/test-sha1.c                |    0
 test-sha1.sh =3D> t/helper/test-sha1.sh              |    4 +-
 test-sigchain.c =3D> t/helper/test-sigchain.c        |    0
 test-string-pool.c =3D> t/helper/test-string-pool.c  |    0
 test-subprocess.c =3D> t/helper/test-subprocess.c    |    0
 test-svn-fe.c =3D> t/helper/test-svn-fe.c            |    0
 test-treap.c =3D> t/helper/test-treap.c              |    0
 t/test-lib.sh                                      |    4 +-
 24 files changed, 38 insertions(+), 38 deletions(-)
 create mode 100644 t/helper/.gitignore
 rename test-chmtime.c =3D> t/helper/test-chmtime.c (100%)
 rename test-ctype.c =3D> t/helper/test-ctype.c (100%)
 rename test-date.c =3D> t/helper/test-date.c (100%)
 rename test-delta.c =3D> t/helper/test-delta.c (100%)
 rename test-dump-cache-tree.c =3D> t/helper/test-dump-cache-tree.c (10=
0%)
 rename test-genrandom.c =3D> t/helper/test-genrandom.c (100%)
 rename test-index-version.c =3D> t/helper/test-index-version.c (100%)
 rename test-line-buffer.c =3D> t/helper/test-line-buffer.c (100%)
 rename test-match-trees.c =3D> t/helper/test-match-trees.c (100%)
 rename test-obj-pool.c =3D> t/helper/test-obj-pool.c (100%)
 rename test-parse-options.c =3D> t/helper/test-parse-options.c (100%)
 rename test-path-utils.c =3D> t/helper/test-path-utils.c (100%)
 rename test-run-command.c =3D> t/helper/test-run-command.c (100%)
 rename test-sha1.c =3D> t/helper/test-sha1.c (100%)
 rename test-sha1.sh =3D> t/helper/test-sha1.sh (96%)
 rename test-sigchain.c =3D> t/helper/test-sigchain.c (100%)
 rename test-string-pool.c =3D> t/helper/test-string-pool.c (100%)
 rename test-subprocess.c =3D> t/helper/test-subprocess.c (100%)
 rename test-svn-fe.c =3D> t/helper/test-svn-fe.c (100%)
 rename test-treap.c =3D> t/helper/test-treap.c (100%)

diff --git a/.gitignore b/.gitignore
index 3dd6ef7..a99a216 100644
--- a/.gitignore
+++ b/.gitignore
@@ -161,25 +161,6 @@
 /gitweb/GITWEB-BUILD-OPTIONS
 /gitweb/gitweb.cgi
 /gitweb/static/gitweb.min.*
-/test-chmtime
-/test-ctype
-/test-date
-/test-delta
-/test-dump-cache-tree
-/test-genrandom
-/test-index-version
-/test-line-buffer
-/test-match-trees
-/test-obj-pool
-/test-parse-options
-/test-path-utils
-/test-run-command
-/test-sha1
-/test-sigchain
-/test-string-pool
-/test-subprocess
-/test-svn-fe
-/test-treap
 /common-cmds.h
 *.tar.gz
 *.dsc
diff --git a/Makefile b/Makefile
index 775ee83..e2b3b92 100644
--- a/Makefile
+++ b/Makefile
@@ -436,7 +436,7 @@ TEST_PROGRAMS_NEED_X +=3D test-svn-fe
 TEST_PROGRAMS_NEED_X +=3D test-treap
 TEST_PROGRAMS_NEED_X +=3D test-index-version
=20
-TEST_PROGRAMS =3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
+TEST_PROGRAMS =3D $(patsubst %,t/helper/%$X,$(TEST_PROGRAMS_NEED_X))
=20
 # List built-in command $C whose implementation cmd_$C() is not in
 # builtin/$C.o but is linked in as part of some other command.
@@ -1829,7 +1829,7 @@ git.o git.spec \
 	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	: GIT-VERSION-FILE
=20
-TEST_OBJS :=3D $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
+TEST_OBJS :=3D $(patsubst %$X,%.o,$(TEST_PROGRAMS))
 GIT_OBJS :=3D $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS)=
 \
 	git.o
 ifndef NO_CURL
@@ -1963,12 +1963,12 @@ xdiff-interface.o $(XDIFF_OBJS): \
 	xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
=20
-$(VCSSVN_OBJS) $(VCSSVN_TEST_OBJS): $(LIB_H) \
+$(VCSSVN_OBJS) $(patsubst %,t/helper/%,$(VCSSVN_TEST_OBJS)): $(LIB_H) =
\
 	vcs-svn/obj_pool.h vcs-svn/trp.h vcs-svn/string_pool.h \
 	vcs-svn/line_buffer.h vcs-svn/repo_tree.h vcs-svn/fast_export.h \
 	vcs-svn/svndump.h
=20
-test-svn-fe.o: vcs-svn/svndump.h
+t/helper/test-svn-fe.o: vcs-svn/svndump.h
 endif
=20
 exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS =3D \
@@ -2108,7 +2108,7 @@ bin-wrappers/%: wrap-for-bin.sh
 	@mkdir -p bin-wrappers
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
-	     -e 's|@@PROG@@|$(@F)|' < $< > $@ && \
+	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))|' < $< >=
 $@ && \
 	chmod +x $@
=20
 # GNU make supports exporting all variables by "export" without parame=
ters.
@@ -2122,27 +2122,27 @@ export NO_SVN_TESTS
 test: all
 	$(MAKE) -C t/ all
=20
-test-ctype$X: ctype.o
+t/helper/test-ctype$X: ctype.o
=20
-test-date$X: date.o ctype.o
+t/helper/test-date$X: date.o ctype.o
=20
-test-delta$X: diff-delta.o patch-delta.o
+t/helper/test-delta$X: diff-delta.o patch-delta.o
=20
-test-line-buffer$X: vcs-svn/lib.a
+t/helper/test-line-buffer$X: vcs-svn/lib.a
=20
-test-parse-options$X: parse-options.o
+t/helper/test-parse-options$X: parse-options.o
=20
-test-string-pool$X: vcs-svn/lib.a
+t/helper/test-string-pool$X: vcs-svn/lib.a
=20
-test-svn-fe$X: vcs-svn/lib.a
+t/helper/test-svn-fe$X: vcs-svn/lib.a
=20
 .PRECIOUS: $(TEST_OBJS)
=20
-test-%$X: test-%.o $(GITLIBS)
+t/helper/test-%$X: t/helper/test-%.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) $(filter %.a,$^) $(LIBS)
=20
-check-sha1:: test-sha1$X
-	./test-sha1.sh
+check-sha1:: t/helper/test-sha1$X
+	t/helper/test-sha1.sh
=20
 check: common-cmds.h
 	if sparse; \
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
new file mode 100644
index 0000000..8f1b042
--- /dev/null
+++ b/t/helper/.gitignore
@@ -0,0 +1,19 @@
+/test-chmtime
+/test-ctype
+/test-date
+/test-delta
+/test-dump-cache-tree
+/test-genrandom
+/test-index-version
+/test-line-buffer
+/test-match-trees
+/test-obj-pool
+/test-parse-options
+/test-path-utils
+/test-run-command
+/test-sha1
+/test-sigchain
+/test-string-pool
+/test-subprocess
+/test-svn-fe
+/test-treap
diff --git a/test-chmtime.c b/t/helper/test-chmtime.c
similarity index 100%
rename from test-chmtime.c
rename to t/helper/test-chmtime.c
diff --git a/test-ctype.c b/t/helper/test-ctype.c
similarity index 100%
rename from test-ctype.c
rename to t/helper/test-ctype.c
diff --git a/test-date.c b/t/helper/test-date.c
similarity index 100%
rename from test-date.c
rename to t/helper/test-date.c
diff --git a/test-delta.c b/t/helper/test-delta.c
similarity index 100%
rename from test-delta.c
rename to t/helper/test-delta.c
diff --git a/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
similarity index 100%
rename from test-dump-cache-tree.c
rename to t/helper/test-dump-cache-tree.c
diff --git a/test-genrandom.c b/t/helper/test-genrandom.c
similarity index 100%
rename from test-genrandom.c
rename to t/helper/test-genrandom.c
diff --git a/test-index-version.c b/t/helper/test-index-version.c
similarity index 100%
rename from test-index-version.c
rename to t/helper/test-index-version.c
diff --git a/test-line-buffer.c b/t/helper/test-line-buffer.c
similarity index 100%
rename from test-line-buffer.c
rename to t/helper/test-line-buffer.c
diff --git a/test-match-trees.c b/t/helper/test-match-trees.c
similarity index 100%
rename from test-match-trees.c
rename to t/helper/test-match-trees.c
diff --git a/test-obj-pool.c b/t/helper/test-obj-pool.c
similarity index 100%
rename from test-obj-pool.c
rename to t/helper/test-obj-pool.c
diff --git a/test-parse-options.c b/t/helper/test-parse-options.c
similarity index 100%
rename from test-parse-options.c
rename to t/helper/test-parse-options.c
diff --git a/test-path-utils.c b/t/helper/test-path-utils.c
similarity index 100%
rename from test-path-utils.c
rename to t/helper/test-path-utils.c
diff --git a/test-run-command.c b/t/helper/test-run-command.c
similarity index 100%
rename from test-run-command.c
rename to t/helper/test-run-command.c
diff --git a/test-sha1.c b/t/helper/test-sha1.c
similarity index 100%
rename from test-sha1.c
rename to t/helper/test-sha1.c
diff --git a/test-sha1.sh b/t/helper/test-sha1.sh
similarity index 96%
rename from test-sha1.sh
rename to t/helper/test-sha1.sh
index 0f0bc5d..4e691d1 100755
--- a/test-sha1.sh
+++ b/t/helper/test-sha1.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
=20
 dd if=3D/dev/zero bs=3D1048576 count=3D100 2>/dev/null |
-/usr/bin/time ./test-sha1 >/dev/null
+/usr/bin/time t/helper/test-sha1 >/dev/null
=20
 while read expect cnt pfx
 do
@@ -11,7 +11,7 @@ do
 			test -z "$pfx" || echo "$pfx"
 			dd if=3D/dev/zero bs=3D1048576 count=3D$cnt 2>/dev/null |
 			perl -pe 'y/\000/g/'
-		} | ./test-sha1 $cnt
+		} | t/helper/test-sha1 $cnt
 	`
 	if test "$expect" =3D "$actual"
 	then
diff --git a/test-sigchain.c b/t/helper/test-sigchain.c
similarity index 100%
rename from test-sigchain.c
rename to t/helper/test-sigchain.c
diff --git a/test-string-pool.c b/t/helper/test-string-pool.c
similarity index 100%
rename from test-string-pool.c
rename to t/helper/test-string-pool.c
diff --git a/test-subprocess.c b/t/helper/test-subprocess.c
similarity index 100%
rename from test-subprocess.c
rename to t/helper/test-subprocess.c
diff --git a/test-svn-fe.c b/t/helper/test-svn-fe.c
similarity index 100%
rename from test-svn-fe.c
rename to t/helper/test-svn-fe.c
diff --git a/test-treap.c b/t/helper/test-treap.c
similarity index 100%
rename from test-treap.c
rename to t/helper/test-treap.c
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0fdc541..eebf7a8 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -984,9 +984,9 @@ then
 	}
 fi
=20
-if ! test -x "$GIT_BUILD_DIR"/test-chmtime; then
+if ! test -x "$GIT_BUILD_DIR"/t/helper/test-chmtime; then
 	echo >&2 'You need to build test-chmtime:'
-	echo >&2 'Run "make test-chmtime" in the source (toplevel) directory'
+	echo >&2 'Run "make t/helper/test-chmtime" in the source (toplevel) d=
irectory'
 	exit 1
 fi
=20
--=20
1.7.4.74.g639db
