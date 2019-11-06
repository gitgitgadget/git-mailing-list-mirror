Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0094C1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 17:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbfKFRqC (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 12:46:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40116 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfKFRqC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 12:46:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id i10so6285036wrs.7
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 09:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=niemier-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bcge2crLz8tQVHkG/4mUUWk7uh1KczCfGNbeyv57+J0=;
        b=I8+LxKJY93p8SlWXlfCtMTw4NGpwKtorwHxlxzHHiD+WT58WwvBY3nmv/oSJoERCiM
         txZQ0GFO68B9PzduujNZHhf/MWTw0v8l5zK8020n6o7WgLf2V6MX61HvvZhj6+DmkDBI
         Gpy7MXrkdexSjoKdKvvGu9Jc/mJmB0vKmsbLNKvE4iVf8y5a5eAyAbMJsakxC6aVdbuG
         fTbCh6Gsk69oUVhXvyj8lgja/+qqLK14+sde48EBzr+Wk0OXO3Otvqg2d242u68//4P9
         4rmzkczdk0LeErd81nd16xYNkOOZlpVm7HJ3gcNUsqr/jX+0j3Q+reD7zfdxAemvKIF5
         xf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bcge2crLz8tQVHkG/4mUUWk7uh1KczCfGNbeyv57+J0=;
        b=qEppB78ly2qM1rS3I+TgOJOip/f+a8N6iHx2XK+rTCg2gl/SvZIOpnh1VurwqHUaXg
         96lI5WvExAREJWd1sh9KpDbssWT/V3GiWBlFa/8N94R7XEe4l74IMX0pscPc/n2Rjf3l
         GDi6u59nAfpNyBA9Iu2lCRTaR7fDrb/GrZZavUK2QrnAj3jihcQlQuGQEoKNOCwGl+qj
         mybubxTdLcwab02VnQ9e/QDcbGmp0PyIcVSK7Jfu7A166HCJcwudI3eQ6WJ9nAM7FXno
         KSsG2FnnIPLrVNwFo078EDlNogxQQdiB+0ByJ8dgQ8L8S2RLLUpjzrNaqZZl4Gy19d46
         BhwA==
X-Gm-Message-State: APjAAAX9AiR4Hlaq6/uA/F3/K0GA5lLtDecIixdkN0gk1sQ2DhS/HXIu
        7fbrDHKB40yVfOB8KSlJzKotDqdG9q+QBg==
X-Google-Smtp-Source: APXvYqxPxya4mvlDaUH1B+0ZaewGulJS5LFLWEyDx581GqI0n6B9QmDnrNpmW1C8xoQHZeccgUO0GQ==
X-Received: by 2002:adf:eb8d:: with SMTP id t13mr3738785wrn.321.1573062360110;
        Wed, 06 Nov 2019 09:46:00 -0800 (PST)
Received: from localhost.localdomain (83.25.107.61.ipv4.supernova.orange.pl. [83.25.107.61])
        by smtp.gmail.com with ESMTPSA id u1sm19949548wrp.56.2019.11.06.09.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 09:45:59 -0800 (PST)
From:   =?UTF-8?q?=C5=81ukasz=20Niemier?= <lukasz@niemier.pl>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Niemier?= <lukasz@niemier.pl>
Subject: [PATCH] feat: add Elixir to supported userdiff languages
Date:   Wed,  6 Nov 2019 18:45:56 +0100
Message-Id: <20191106174556.23113-1-lukasz@niemier.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 t/t4018-diff-funcname    | 115 +++++++++++++++++++++++++++++++++++++++
 t/t4018-diff-funcname.sh |   1 +
 t/t4018/elixir-function  |   5 ++
 t/t4018/elixir-module    |   9 +++
 userdiff.c               |   7 +++
 5 files changed, 137 insertions(+)
 create mode 100755 t/t4018-diff-funcname
 create mode 100644 t/t4018/elixir-function
 create mode 100644 t/t4018/elixir-module

diff --git a/t/t4018-diff-funcname b/t/t4018-diff-funcname
new file mode 100755
index 0000000000..194310377e
--- /dev/null
+++ b/t/t4018-diff-funcname
@@ -0,0 +1,115 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes E. Schindelin
+#
+
+test_description='Test custom diff function name patterns'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	# a non-trivial custom pattern
+	git config diff.custom1.funcname "!static
+!String
+[^ 	].*s.*" &&
+
+	# a custom pattern which matches to end of line
+	git config diff.custom2.funcname "......Beer\$" &&
+
+	# alternation in pattern
+	git config diff.custom3.funcname "Beer$" &&
+	git config diff.custom3.xfuncname "^[ 	]*((public|static).*)$" &&
+
+	# for regexp compilation tests
+	echo A >A.java &&
+	echo B >B.java
+'
+
+diffpatterns="
+	ada
+	bibtex
+	cpp
+	csharp
+	css
+	elixir
+	dts
+	fortran
+	fountain
+	golang
+	html
+	java
+	matlab
+	objc
+	pascal
+	perl
+	php
+	python
+	ruby
+	rust
+	tex
+	custom1
+	custom2
+	custom3
+"
+
+for p in $diffpatterns
+do
+	test_expect_success "builtin $p pattern compiles" '
+		echo "*.java diff=$p" >.gitattributes &&
+		test_expect_code 1 git diff --no-index \
+			A.java B.java 2>msg &&
+		test_i18ngrep ! fatal msg &&
+		test_i18ngrep ! error msg
+	'
+	test_expect_success "builtin $p wordRegex pattern compiles" '
+		echo "*.java diff=$p" >.gitattributes &&
+		test_expect_code 1 git diff --no-index --word-diff \
+			A.java B.java 2>msg &&
+		test_i18ngrep ! fatal msg &&
+		test_i18ngrep ! error msg
+	'
+done
+
+test_expect_success 'last regexp must not be negated' '
+	echo "*.java diff=java" >.gitattributes &&
+	test_config diff.java.funcname "!static" &&
+	test_expect_code 128 git diff --no-index A.java B.java 2>msg &&
+	test_i18ngrep ": Last expression must not be negated:" msg
+'
+
+test_expect_success 'setup hunk header tests' '
+	for i in $diffpatterns
+	do
+		echo "$i-* diff=$i"
+	done > .gitattributes &&
+
+	# add all test files to the index
+	(
+		cd "$TEST_DIRECTORY"/t4018 &&
+		git --git-dir="$TRASH_DIRECTORY/.git" add .
+	) &&
+
+	# place modified files in the worktree
+	for i in $(git ls-files)
+	do
+		sed -e "s/ChangeMe/IWasChanged/" <"$TEST_DIRECTORY/t4018/$i" >"$i" || return 1
+	done
+'
+
+# check each individual file
+for i in $(git ls-files)
+do
+	if grep broken "$i" >/dev/null 2>&1
+	then
+		result=failure
+	else
+		result=success
+	fi
+	test_expect_$result "hunk header: $i" "
+		test_when_finished 'cat actual' &&	# for debugging only
+		git diff -U1 $i >actual &&
+		grep '@@ .* @@.*RIGHT' actual
+	"
+done
+
+test_done
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 6f5ef0035e..194310377e 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -31,6 +31,7 @@ diffpatterns="
 	cpp
 	csharp
 	css
+	elixir
 	dts
 	fortran
 	fountain
diff --git a/t/t4018/elixir-function b/t/t4018/elixir-function
new file mode 100644
index 0000000000..d452f495a7
--- /dev/null
+++ b/t/t4018/elixir-function
@@ -0,0 +1,5 @@
+def function(RIGHT, arg) do
+  # comment
+  # comment
+  ChangeMe
+end
diff --git a/t/t4018/elixir-module b/t/t4018/elixir-module
new file mode 100644
index 0000000000..91a4e7aa20
--- /dev/null
+++ b/t/t4018/elixir-module
@@ -0,0 +1,9 @@
+defmodule RIGHT do
+  @moduledoc """
+  Foo bar
+  """
+
+  def ChangeMe(a) where is_map(a) do
+    a
+  end
+end
diff --git a/userdiff.c b/userdiff.c
index e187d356f6..31fff34e1e 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -32,6 +32,13 @@ PATTERNS("dts",
 	 /* Property names and math operators */
 	 "[a-zA-Z0-9,._+?#-]+"
 	 "|[-+*/%&^|!~]|>>|<<|&&|\\|\\|"),
+PATTERNS("elixir",
+	 "^[ \t]*((def(macro|module|impl|guard|protocol)?p?|test)[ \t].*)$",
+	 "[a-zA-Z0-9_.]+"
+	 "|:[a-zA-Z0-9@_]+"
+	 "|:'a-zA-Z0-9@_]+'"
+	 "|:\"[a-zA-Z0-9@_]+\""
+	 "|@[a-zA-Z0-9_]+"),
 IPATTERN("fortran",
 	 "!^([C*]|[ \t]*!)\n"
 	 "!^[ \t]*MODULE[ \t]+PROCEDURE[ \t]\n"
-- 
2.23.0

