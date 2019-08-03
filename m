Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 903F61F732
	for <e@80x24.org>; Sat,  3 Aug 2019 23:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbfHCXwR (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 19:52:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35588 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbfHCXwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 19:52:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so69725868wmg.0
        for <git@vger.kernel.org>; Sat, 03 Aug 2019 16:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pKINM13/1k/NbUQBeBvkJY1GLn7K5JHTsE9x63b2tC8=;
        b=IGbUs//6ikMBhtTcMYLJ3O8aQn5gXIIwcLR3NVTxZ48zdbR89cIfpo18MXzFeWmBjF
         y1OxFYXJr+KBLGg56cFHEpiC6fab1DvtyA1yf3aaQMa0Jd74QhSQviTLGyrkdzDnK5Y5
         NlQrHc4mNPC+gP4vwXWxV970T/zYp+UOfk4p9cf9ZaxGAtb+qpcIs3YVn3VBcZDiND6A
         j4NP3W9JLqvgB0jWcPB0OH465jYNZGuQg07O3x8Gb6vBD4/HbYvf7buV6ymhoVaxBg6L
         4l2MF9wG5QMPB0HJ2n9k6NHTAPm+t8coRIzHgKfCBoOLqDqFvY/q+8eYCmHSiacih9OY
         VqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pKINM13/1k/NbUQBeBvkJY1GLn7K5JHTsE9x63b2tC8=;
        b=UQtMTaSqNvoHXjjXr1sML/Cneen8rBdDe2Z/rxifK5GQ2xF2Tu9ZtIJz+xFKSsxx3Z
         k6gjOpx/9QYCyYzMN/+XqWod629Iu8ClO6B4HPg8EMxUhvuc3N9Xr55AJoIPi3Ui5ZRN
         Pfdj8Z81NRUBxB6z/Suo5bl6QYzDOVKc3bhw0t3ZjXDMQCaQLQVDlDgT/xgh9ESVFdR9
         IgSE8HsfPexIqNg4xsvgHHUx9LLiMZciNQK/25UxCyumBFHokdpnglLj983YrlaQHnXO
         UTCOdNzXRLrwCSanyDDzpoEcExRvLmov13nDmLx9YPUXG/BL1+k45Iyx1s2QRp/qYi6m
         hdnA==
X-Gm-Message-State: APjAAAW5nJFuuyC6zG1+u4dLsrfGIY5raaZIfjbsKw7nDJH6yRXwrzW8
        cYv9wKBn+qIzMNqatanF6IIKjuMy
X-Google-Smtp-Source: APXvYqzyfpVMKtFzZ8Zxg8VCrmNiw/G9ijIzvzY7Ha3QFpxO6Fd/8rduBB4tGShr0tV0v9HPmhGt2g==
X-Received: by 2002:a1c:7414:: with SMTP id p20mr10197892wmc.145.1564876333744;
        Sat, 03 Aug 2019 16:52:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g12sm114242660wrv.9.2019.08.03.16.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 16:52:13 -0700 (PDT)
Date:   Sat, 03 Aug 2019 16:52:13 -0700 (PDT)
X-Google-Original-Date: Sat, 03 Aug 2019 23:52:07 GMT
Message-Id: <04949713061ba95784b5523c6ce57542a8e87abe.1564876327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.305.git.gitgitgadget@gmail.com>
References: <pull.305.git.gitgitgadget@gmail.com>
From:   "lufia via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 6/6] Add mkfile to build git and subcommands for Plan 9
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, lufia <lufia@lufia.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: lufia <lufia@lufia.org>

Signed-off-by: lufia <lufia@lufia.org>
---
 mkfile | 195 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 195 insertions(+)
 create mode 100644 mkfile

diff --git a/mkfile b/mkfile
new file mode 100644
index 0000000000..f0b06437ed
--- /dev/null
+++ b/mkfile
@@ -0,0 +1,195 @@
+</sys/src/ape/config
+
+CFILES=`{sed -n '/^BUILTIN_OBJS *\+= *(.*)\.o$/s//\1.c/p' Makefile}
+OFILES=\
+	${CFILES:%.c=%.$O}\
+	common-main.$O\
+
+X_CFILES=`{sed -n '/^BUILT_INS *\+= *git-(.*)\$X$/s//\1/p' Makefile}
+
+#APP_CFILES=`{sed -n '/^PROGRAM_OBJS *\+= *(.*)\.o$/s//\1.c/p' Makefile}
+APP_CFILES=\
+	credential-store.c\
+	http-fetch.c\
+	http-push.c\
+
+TARG=\
+	git\
+	${CFILES:builtin/%.c=git-%}\
+	${X_CFILES:%=git-%}\
+	${APP_CFILES:%.c=git-%}\
+	git-remote-http\
+	git-remote-https\
+	git-remote-ftp\
+	git-remote-ftps\
+
+# NO_UNIXSOCK
+#	git-credential-cache\
+#	git-credential-cache--daemon\
+
+#GIT_HOST_CPU=i386|i686|x86_64
+
+ROOT=`{pwd}
+<GIT-VERSION-FILE
+COMMIT_HASH=`{git rev-parse -q --verify HEAD}
+
+# -w flag isn't intentionally set because it is noisy.
+# -T flag isn't intentionally set.
+CFLAGS=-FVB+ -c\
+	-I$ROOT\
+	-I$ROOT/compat/plan9\
+	-I$ROOT/compat/regex\
+	-D__PLAN9__\
+	-D_POSIX_SOURCE\
+	-D_BSD_EXTENSION\
+	-D_SUSV2_SOURCE\
+	-D_PLAN9_SOURCE\
+	-D_RESEARCH_SOURCE\
+	-D_REENTRANT_SOURCE\
+	-DHAVE_SOCK_OPTS\
+	-DNO_NSEC\
+	-DNO_SYMLINK_HEAD\
+	-DNO_GECOS_IN_PWENT\
+	-DNO_GETTEXT\
+	-DNO_STRCASESTR\
+	-DNO_STRLCPY\
+	-DNO_STRTOUMAX\
+	-DNO_MBSUPPORT\
+	-DNO_MKDTEMP\
+	-DNO_UNSETENV\
+	-DNEEDS_SYS_PARAM_H\
+	-DNO_INITGROUPS\
+	-DNO_MMAP\
+	-DNO_ST_BLOCKS_IN_STRUCT_STAT\
+	-DNO_STRUCT_ITIMERVAL\
+	-DNO_SETITIMER\
+	-Dsockaddr_storage=sockaddr_in6\
+	-DNO_UNIX_SOCKETS\
+	-DNO_ICONV\
+	-DSHA1_OPENSSL\
+	-DSHA256_OPENSSL\
+	-DNO_MEMMEM\
+	-DHAVE_STDBOOL_H\
+	-DHAVE_STDINT_H\
+	-DHAVE_LOCALE_H\
+	-DHAVE_CLOCK_GETTIME\
+	-DGIT_VERSION="$GIT_VERSION"\
+	-DGIT_BUILT_FROM_COMMIT="$COMMIT_HASH"\
+	-DGIT_USER_AGENT="git/$GIT_VERSION"\
+	-DETC_GITCONFIG="/sys/lib/git/config"\
+	-DETC_GITATTRIBUTES="/sys/lib/git/attributes"\
+	-DUSER_GITCONFIG="~/lib/git/config"\
+	-DUSER_GITCREDENTIALS="~/lib/git/credentials"\
+	-DUSER_GITCREDENTIAL_CACHE="~/lib/git/credential-cache"\
+	-DDEFAULT_GIT_TEMPLATE_DIR="/sys/lib/git/templates"\
+	-DGIT_HOST_CPU="i386"\
+	-DGIT_EXEC_PATH="/bin/git-core"\
+	-DGIT_MAN_PATH="/sys/man"\
+	-DGIT_INFO_PATH=""\
+	-DGIT_HTML_PATH=""\
+	-DFALLBACK_RUNTIME_PREFIX="/bin/git-core"\
+	-DDEFAULT_PAGER="/bin/p"\
+	-DPAGER_ENV="terminal="\
+	-DHOME_ENVIRONMENT="home"\
+	-DPATH_ENVIRONMENT="path"\
+	-D_PATH_SEP=1\
+	-D_PATH_DEFPATH="/bin"\
+	-DSHELL_PATH="/bin/rc"\
+
+LIB_CFILES=`{sed -n '/^LIB_OBJS *\+= *(.*)\.o$/s//\1.c/p' Makefile}
+LIB_OFILES=\
+	${LIB_CFILES:%.c=%.$O}\
+	compat/qsort_s.$O\
+	compat/strcasestr.$O\
+	compat/strlcpy.$O\
+	compat/strtoumax.$O\
+	compat/strtoimax.$O\
+	compat/setenv.$O\
+	compat/mkdtemp.$O\
+	compat/unsetenv.$O\
+	compat/mmap.$O\
+	compat/memmem.$O\
+	compat/regex/regex.$O\
+
+XDIFF_CFILES=`{sed -n '/^XDIFF_OBJS *\+= *(.*)\.o$/s//\1.c/p' Makefile}
+XDIFF_OFILES=${XDIFF_CFILES:%.c=%.$O}
+
+HFILES=\
+	`{ls *.h}\
+	`{ls */*.h}\
+	`{ls */*/*.h}\
+	`{ls */*/*/*.h}\
+	command-list.h\
+
+BIN=/$objtype/bin/git-core
+OBJBIN=/$objtype/bin
+
+LIB=\
+	libgit.a$O\
+	xdiff/lib.a$O\
+	/$objtype/lib/ape/libcurl.a\
+	/$objtype/lib/ape/libssl.a\
+	/$objtype/lib/ape/libcrypto.a\
+	/$objtype/lib/ape/libexpat.a\
+	/$objtype/lib/ape/libz.a\
+
+CLEANFILES=command-list.h
+
+</sys/src/cmd/mkmany
+
+LIBGIT=libgit.a$O
+LIBGITOBJ=${LIB_OFILES:%=$LIBGIT(%)}
+LIBXDIFF=xdiff/lib.a$O
+LIBXDIFFOBJ=${XDIFF_OFILES:%=$LIBXDIFF(%)}
+
+command-list.h:D:	command-list.txt
+	rc ./generate-cmdlist.rc $prereq >$target
+
+${CFILES:builtin/%.c=$O.git-%} ${X_CFILES:%=$O.git-%}:D:	plan9/wrap.c
+	for(i in $target)
+		$CC -FTVw -o $i $prereq
+
+$O.git-credential-store:	credential-store.$O common-main.$O $LIB
+	$LD $LDFLAGS -o $target $prereq
+
+$O.git-http-fetch:	http-fetch.$O http.$O http-walker.$O common-main.$O $LIB
+	$LD $LDFLAGS -o $target $prereq
+
+$O.git-http-push:	http-push.$O http.$O common-main.$O $LIB
+	$LD $LDFLAGS -o $target $prereq
+
+git-http-%.$O:	http-%.c
+	$CC $CFLAGS -o $target $prereq
+
+$O.git-remote-http:	remote-curl.$O http.$O http-walker.$O common-main.$O $LIB
+	$LD $LDFLAGS -o $target $prereq
+
+$O.git-remote-https:	remote-curl.$O http.$O http-walker.$O common-main.$O $LIB
+	$LD $LDFLAGS -o $target $prereq
+
+$O.git-remote-ftp:	remote-curl.$O http.$O http-walker.$O common-main.$O $LIB
+	$LD $LDFLAGS -o $target $prereq
+
+$O.git-remote-ftps:	remote-curl.$O http.$O http-walker.$O common-main.$O $LIB
+	$LD $LDFLAGS -o $target $prereq
+
+# git should be copied into both $BIN and $OBJBIN
+git.install:V:	$O.git
+	cp $O.git $OBJBIN/git
+
+$LIBGIT:	$LIBGITOBJ
+	ar vu $target $newmember
+
+$LIBXDIFF:	$LIBXDIFFOBJ
+	ar vu $target $newmember
+
+%.$O:	%.c
+	$CC $CFLAGS -o $target $stem.c
+
+$LIBGIT(%.$O):N:	%.$O
+
+$LIBXDIFF(%.$O):N:	%.$O
+
+clean:V:
+	rm -f *.[$OS] [$OS].out y.tab.? lex.yy.c y.debug y.output $CLEANFILES
+	rm -f */*.[$OS] */*/*.[$OS]
-- 
gitgitgadget
