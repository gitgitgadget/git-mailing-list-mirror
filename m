From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC] Move test-*.c to test/ subdirectory
Date: Wed,  9 Feb 2011 22:14:29 +0700
Message-ID: <1297264469-13675-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 09 16:16:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnBm9-0007DQ-D8
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 16:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034Ab1BIPQE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 10:16:04 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:34709 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935Ab1BIPQC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 10:16:02 -0500
Received: by pxi15 with SMTP id 15so45737pxi.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 07:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=IZhO2lgWNyCqgi/P9NM53sNcu6HMbaXsyOKUVroL4x8=;
        b=GCxrnX8ilR6Cnw5KJOrdKxFuuTzZQMyPBfQdZbeLZEo3ggA/jL6FVq7dRzJLyOmSp4
         rAc9UPH6Jzrv/ZCiIVRW7I8jaIuPjamSD09vnCVCbp77PbqmvD8wYQ22+9+6qjxVgmpQ
         RuePUwwNWENTzB/r+hTVeR/diXoOiiGgzSYjs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=W+BMgkrWEe/0Rpp7u3kLT5zrZkPq1xguQdxH7u7Hc3ULM8xQk1v+00UqljgKHtJwnI
         aLHJdQ+gmqF+/ozDZVhtmVEFN/YU8hGmSUTHFubIhSI0QxJCWsslEfgVjmLOEAXFYZr7
         /zxiF8eZj778oxcIsp/OMQOJQpb+U/+Qq0BfI=
Received: by 10.142.187.1 with SMTP id k1mr1805957wff.152.1297264561633;
        Wed, 09 Feb 2011 07:16:01 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id e14sm515939wfg.20.2011.02.09.07.15.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 07:15:59 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 09 Feb 2011 22:14:30 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166424>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This makes topdir 19 files less and does not seem to break tests.
 There's only one new test(-mktemp) on pu.

 .gitignore                                       |   19 ------
 Makefile                                         |   71 +++++++++++---=
--------
 t/test-lib.sh                                    |    6 +-
 test/.gitignore                                  |   19 ++++++
 test-chmtime.c =3D> test/chmtime.c                 |    0
 test-ctype.c =3D> test/ctype.c                     |    0
 test-date.c =3D> test/date.c                       |    0
 test-delta.c =3D> test/delta.c                     |    0
 test-dump-cache-tree.c =3D> test/dump-cache-tree.c |    0
 test-genrandom.c =3D> test/genrandom.c             |    0
 test-index-version.c =3D> test/index-version.c     |    0
 test-line-buffer.c =3D> test/line-buffer.c         |    0
 test-match-trees.c =3D> test/match-trees.c         |    0
 test-obj-pool.c =3D> test/obj-pool.c               |    0
 test-parse-options.c =3D> test/parse-options.c     |    0
 test-path-utils.c =3D> test/path-utils.c           |    0
 test-run-command.c =3D> test/run-command.c         |    0
 test-sha1.c =3D> test/sha1.c                       |    0
 test-sigchain.c =3D> test/sigchain.c               |    0
 test-string-pool.c =3D> test/string-pool.c         |    0
 test-subprocess.c =3D> test/subprocess.c           |    0
 test-svn-fe.c =3D> test/svn-fe.c                   |    0
 test-treap.c =3D> test/treap.c                     |    0
 23 files changed, 58 insertions(+), 57 deletions(-)
 create mode 100644 test/.gitignore
 rename test-chmtime.c =3D> test/chmtime.c (100%)
 rename test-ctype.c =3D> test/ctype.c (100%)
 rename test-date.c =3D> test/date.c (100%)
 rename test-delta.c =3D> test/delta.c (100%)
 rename test-dump-cache-tree.c =3D> test/dump-cache-tree.c (100%)
 rename test-genrandom.c =3D> test/genrandom.c (100%)
 rename test-index-version.c =3D> test/index-version.c (100%)
 rename test-line-buffer.c =3D> test/line-buffer.c (100%)
 rename test-match-trees.c =3D> test/match-trees.c (100%)
 rename test-obj-pool.c =3D> test/obj-pool.c (100%)
 rename test-parse-options.c =3D> test/parse-options.c (100%)
 rename test-path-utils.c =3D> test/path-utils.c (100%)
 rename test-run-command.c =3D> test/run-command.c (100%)
 rename test-sha1.c =3D> test/sha1.c (100%)
 rename test-sigchain.c =3D> test/sigchain.c (100%)
 rename test-string-pool.c =3D> test/string-pool.c (100%)
 rename test-subprocess.c =3D> test/subprocess.c (100%)
 rename test-svn-fe.c =3D> test/svn-fe.c (100%)
 rename test-treap.c =3D> test/treap.c (100%)

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
index 775ee83..617f910 100644
--- a/Makefile
+++ b/Makefile
@@ -416,25 +416,25 @@ PROGRAM_OBJS +=3D http-backend.o
=20
 PROGRAMS +=3D $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
=20
-TEST_PROGRAMS_NEED_X +=3D test-chmtime
-TEST_PROGRAMS_NEED_X +=3D test-ctype
-TEST_PROGRAMS_NEED_X +=3D test-date
-TEST_PROGRAMS_NEED_X +=3D test-delta
-TEST_PROGRAMS_NEED_X +=3D test-dump-cache-tree
-TEST_PROGRAMS_NEED_X +=3D test-genrandom
-TEST_PROGRAMS_NEED_X +=3D test-line-buffer
-TEST_PROGRAMS_NEED_X +=3D test-match-trees
-TEST_PROGRAMS_NEED_X +=3D test-obj-pool
-TEST_PROGRAMS_NEED_X +=3D test-parse-options
-TEST_PROGRAMS_NEED_X +=3D test-path-utils
-TEST_PROGRAMS_NEED_X +=3D test-run-command
-TEST_PROGRAMS_NEED_X +=3D test-sha1
-TEST_PROGRAMS_NEED_X +=3D test-sigchain
-TEST_PROGRAMS_NEED_X +=3D test-string-pool
-TEST_PROGRAMS_NEED_X +=3D test-subprocess
-TEST_PROGRAMS_NEED_X +=3D test-svn-fe
-TEST_PROGRAMS_NEED_X +=3D test-treap
-TEST_PROGRAMS_NEED_X +=3D test-index-version
+TEST_PROGRAMS_NEED_X +=3D test/chmtime
+TEST_PROGRAMS_NEED_X +=3D test/ctype
+TEST_PROGRAMS_NEED_X +=3D test/date
+TEST_PROGRAMS_NEED_X +=3D test/delta
+TEST_PROGRAMS_NEED_X +=3D test/dump-cache-tree
+TEST_PROGRAMS_NEED_X +=3D test/genrandom
+TEST_PROGRAMS_NEED_X +=3D test/line-buffer
+TEST_PROGRAMS_NEED_X +=3D test/match-trees
+TEST_PROGRAMS_NEED_X +=3D test/obj-pool
+TEST_PROGRAMS_NEED_X +=3D test/parse-options
+TEST_PROGRAMS_NEED_X +=3D test/path-utils
+TEST_PROGRAMS_NEED_X +=3D test/run-command
+TEST_PROGRAMS_NEED_X +=3D test/sha1
+TEST_PROGRAMS_NEED_X +=3D test/sigchain
+TEST_PROGRAMS_NEED_X +=3D test/string-pool
+TEST_PROGRAMS_NEED_X +=3D test/subprocess
+TEST_PROGRAMS_NEED_X +=3D test/svn-fe
+TEST_PROGRAMS_NEED_X +=3D test/treap
+TEST_PROGRAMS_NEED_X +=3D test/index-version
=20
 TEST_PROGRAMS =3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
=20
@@ -1829,7 +1829,7 @@ git.o git.spec \
 	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	: GIT-VERSION-FILE
=20
-TEST_OBJS :=3D $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
+TEST_OBJS :=3D $(patsubst test/%$X,test/%.o,$(TEST_PROGRAMS))
 GIT_OBJS :=3D $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS)=
 \
 	git.o
 ifndef NO_CURL
@@ -1839,8 +1839,8 @@ XDIFF_OBJS =3D xdiff/xdiffi.o xdiff/xprepare.o xd=
iff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
 VCSSVN_OBJS =3D vcs-svn/string_pool.o vcs-svn/line_buffer.o \
 	vcs-svn/repo_tree.o vcs-svn/fast_export.o vcs-svn/svndump.o
-VCSSVN_TEST_OBJS =3D test-obj-pool.o test-string-pool.o \
-	test-line-buffer.o test-treap.o
+VCSSVN_TEST_OBJS =3D test/obj-pool.o test/string-pool.o \
+	test/line-buffer.o test/treap.o
 OBJECTS :=3D $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_OBJS)
=20
 dep_files :=3D $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
@@ -1968,7 +1968,7 @@ $(VCSSVN_OBJS) $(VCSSVN_TEST_OBJS): $(LIB_H) \
 	vcs-svn/line_buffer.h vcs-svn/repo_tree.h vcs-svn/fast_export.h \
 	vcs-svn/svndump.h
=20
-test-svn-fe.o: vcs-svn/svndump.h
+test/svn-fe.o: vcs-svn/svndump.h
 endif
=20
 exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS =3D \
@@ -2100,7 +2100,8 @@ GIT-GUI-VARS: FORCE
             fi
 endif
=20
-test_bindir_programs :=3D $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAM=
S_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
+test_bindir_programs :=3D $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAM=
S_NEED_X) $(BINDIR_PROGRAMS_NO_X))
+test_bindir_programs +=3D $(patsubst test/%,bin-wrappers/test-%,$(TEST=
_PROGRAMS_NEED_X))
=20
 all:: $(TEST_PROGRAMS) $(test_bindir_programs)
=20
@@ -2108,7 +2109,7 @@ bin-wrappers/%: wrap-for-bin.sh
 	@mkdir -p bin-wrappers
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
-	     -e 's|@@PROG@@|$(@F)|' < $< > $@ && \
+	     -e 's|@@PROG@@|$(patsubst test-%,test/%,$(@F))|' < $< > $@ && \
 	chmod +x $@
=20
 # GNU make supports exporting all variables by "export" without parame=
ters.
@@ -2122,27 +2123,27 @@ export NO_SVN_TESTS
 test: all
 	$(MAKE) -C t/ all
=20
-test-ctype$X: ctype.o
+test/ctype$X: ctype.o
=20
-test-date$X: date.o ctype.o
+test/date$X: date.o ctype.o
=20
-test-delta$X: diff-delta.o patch-delta.o
+test/delta$X: diff-delta.o patch-delta.o
=20
-test-line-buffer$X: vcs-svn/lib.a
+test/line-buffer$X: vcs-svn/lib.a
=20
-test-parse-options$X: parse-options.o
+test/parse-options$X: parse-options.o
=20
-test-string-pool$X: vcs-svn/lib.a
+test/string-pool$X: vcs-svn/lib.a
=20
-test-svn-fe$X: vcs-svn/lib.a
+test/svn-fe$X: vcs-svn/lib.a
=20
 .PRECIOUS: $(TEST_OBJS)
=20
-test-%$X: test-%.o $(GITLIBS)
+test/%$X: test/%.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) $(filter %.a,$^) $(LIBS)
=20
-check-sha1:: test-sha1$X
-	./test-sha1.sh
+check-sha1:: test/sha1$X
+	./test/sha1.sh
=20
 check: common-cmds.h
 	if sparse; \
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0fdc541..240caec 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -984,9 +984,9 @@ then
 	}
 fi
=20
-if ! test -x "$GIT_BUILD_DIR"/test-chmtime; then
-	echo >&2 'You need to build test-chmtime:'
-	echo >&2 'Run "make test-chmtime" in the source (toplevel) directory'
+if ! test -x "$GIT_BUILD_DIR"/test/chmtime; then
+	echo >&2 'You need to build test/chmtime:'
+	echo >&2 'Run "make test/chmtime" in the source (toplevel) directory'
 	exit 1
 fi
=20
diff --git a/test/.gitignore b/test/.gitignore
new file mode 100644
index 0000000..6e8a2a1
--- /dev/null
+++ b/test/.gitignore
@@ -0,0 +1,19 @@
+/chmtime
+/ctype
+/date
+/delta
+/dump-cache-tree
+/genrandom
+/index-version
+/line-buffer
+/match-trees
+/obj-pool
+/parse-options
+/path-utils
+/run-command
+/sha1
+/sigchain
+/string-pool
+/subprocess
+/svn-fe
+/treap
diff --git a/test-chmtime.c b/test/chmtime.c
similarity index 100%
rename from test-chmtime.c
rename to test/chmtime.c
diff --git a/test-ctype.c b/test/ctype.c
similarity index 100%
rename from test-ctype.c
rename to test/ctype.c
diff --git a/test-date.c b/test/date.c
similarity index 100%
rename from test-date.c
rename to test/date.c
diff --git a/test-delta.c b/test/delta.c
similarity index 100%
rename from test-delta.c
rename to test/delta.c
diff --git a/test-dump-cache-tree.c b/test/dump-cache-tree.c
similarity index 100%
rename from test-dump-cache-tree.c
rename to test/dump-cache-tree.c
diff --git a/test-genrandom.c b/test/genrandom.c
similarity index 100%
rename from test-genrandom.c
rename to test/genrandom.c
diff --git a/test-index-version.c b/test/index-version.c
similarity index 100%
rename from test-index-version.c
rename to test/index-version.c
diff --git a/test-line-buffer.c b/test/line-buffer.c
similarity index 100%
rename from test-line-buffer.c
rename to test/line-buffer.c
diff --git a/test-match-trees.c b/test/match-trees.c
similarity index 100%
rename from test-match-trees.c
rename to test/match-trees.c
diff --git a/test-obj-pool.c b/test/obj-pool.c
similarity index 100%
rename from test-obj-pool.c
rename to test/obj-pool.c
diff --git a/test-parse-options.c b/test/parse-options.c
similarity index 100%
rename from test-parse-options.c
rename to test/parse-options.c
diff --git a/test-path-utils.c b/test/path-utils.c
similarity index 100%
rename from test-path-utils.c
rename to test/path-utils.c
diff --git a/test-run-command.c b/test/run-command.c
similarity index 100%
rename from test-run-command.c
rename to test/run-command.c
diff --git a/test-sha1.c b/test/sha1.c
similarity index 100%
rename from test-sha1.c
rename to test/sha1.c
diff --git a/test-sigchain.c b/test/sigchain.c
similarity index 100%
rename from test-sigchain.c
rename to test/sigchain.c
diff --git a/test-string-pool.c b/test/string-pool.c
similarity index 100%
rename from test-string-pool.c
rename to test/string-pool.c
diff --git a/test-subprocess.c b/test/subprocess.c
similarity index 100%
rename from test-subprocess.c
rename to test/subprocess.c
diff --git a/test-svn-fe.c b/test/svn-fe.c
similarity index 100%
rename from test-svn-fe.c
rename to test/svn-fe.c
diff --git a/test-treap.c b/test/treap.c
similarity index 100%
rename from test-treap.c
rename to test/treap.c
--=20
1.7.4.74.g639db
