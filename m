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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4642C1F461
	for <e@80x24.org>; Wed, 17 Jul 2019 02:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfGQCtj (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 22:49:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35105 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfGQCtj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 22:49:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so20518106wmg.0
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 19:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WpicQyulJagCxJFfYfMt7psYQCu2befkBJ/oRr0lrls=;
        b=t71BK20vhgf7Psl6uyWh1tpsXCKladYsscn9c4AMD59FlyTTpenqQAmiZ/rR7tuFsQ
         TKevcLRQz4nml67ngHLKVuF2vU/XRpKx60ixLTBsLliDC5KNyC3tEjvpMCV8R3o/tDqE
         v/+voMhk13PzvUYybBwJZKOirPHxehPJiic9au09SRC1PY+ujauk77P+4ucGao7fnzF4
         mFzgTfmCSwwBN93gikMGf0IJvwvNsYi5b0lVbpxHW+PdPVicQScRsGGV2np5t33m0/s1
         VprVglZn9ppy14DMUZU9jffHydltkOdbkbJ7XH22cMdUYIhXk8fzoNGGe99mBALvQPlt
         YlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WpicQyulJagCxJFfYfMt7psYQCu2befkBJ/oRr0lrls=;
        b=BldwvYnvq7+wWMFHpV9tTaGDcsHp9WbPaktrguyNaAKP7dgeUG1I1XFHQKSsBq7IGO
         t84aIEnHDokVLjDI0GDTdLEybTVrxPt5FLNVqOkxX6FmD/mjxceg0Sje2HgwNgrT2oIP
         QEQ8fLvpQ9MKPV6B5VVZCaKCSsrhdxNOwb4QZUobSYuF2gvGtTlW14AfbLguJRbXKDVz
         if1UjNJwRozjhY0B4iK2yYb5pajXBm41pvyT3OBPmzPlD1m5fNXlk+rskfOYrLPXBVxj
         rnadCMkHT3Ymq2E9B2fG6fDj++KC05c3SXyloaIhxLCuBlSOfREjbRgLEOkViy/wPPB2
         CUmg==
X-Gm-Message-State: APjAAAXtfLAKawzbpwWuqN74Gnus1bnVL7AFpx0mdnb6usEh90TSDehj
        +KeWVojqjMItCdtatvq1ZPpBwpRa
X-Google-Smtp-Source: APXvYqzx5/7/EdZ8U9FpsK8rjssHvH8Sk9zUeGdpJap84clYDn2PDTmb74PqP/S3AC/ZIfHrgN90Nw==
X-Received: by 2002:a1c:200a:: with SMTP id g10mr31010856wmg.160.1563331775000;
        Tue, 16 Jul 2019 19:49:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w7sm27154826wrn.11.2019.07.16.19.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 19:49:34 -0700 (PDT)
Date:   Tue, 16 Jul 2019 19:49:34 -0700 (PDT)
X-Google-Original-Date: Wed, 17 Jul 2019 02:49:32 GMT
Message-Id: <b0b4034c93c4066605a669536988d0c9ad71f401.1563331772.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.264.git.gitgitgadget@gmail.com>
References: <pull.264.git.gitgitgadget@gmail.com>
From:   "Thurston Stone via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] Adding git ignore command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thurston Stone <tstone2077@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thurston Stone <tstone2077@gmail.com>

The 'git ignore' command modifies a .gitignore file in your path
easily. By default, it adds lines to the .gitignore found in the
root of your repository. It can, however, add lines to a gitignore
anywhere inbetween the file(s) passed in and the root of the
repository. The lines added to the gitignore can be based on
filename, extension, directory, or recursive glob.

Also, you can easily open the gitignore file using your $EDITOR
with 'git ignore --edit'.

This can make things much easier when ignore files in subdirectories.
No longer will you have to run:
echo "path/to/the/file.txt" >../../../../../../.gitignore
instead:
git ignore file.txt

Signed-off-by: Thurston Stone <tstone2077@gmail.com>
---
 .gitignore                   |   1 +
 Documentation/git-ignore.txt | 116 ++++++++++++++++++
 Makefile                     |   1 +
 git-ignore.sh                | 222 +++++++++++++++++++++++++++++++++++
 t/t7070-ignore.sh            | 180 ++++++++++++++++++++++++++++
 5 files changed, 520 insertions(+)
 create mode 100644 Documentation/git-ignore.txt
 create mode 100755 git-ignore.sh
 create mode 100755 t/t7070-ignore.sh

diff --git a/.gitignore b/.gitignore
index 4470d7cfc0..fd0707fadf 100644
--- a/.gitignore
+++ b/.gitignore
@@ -76,6 +76,7 @@
 /git-http-backend
 /git-http-fetch
 /git-http-push
+/git-ignore
 /git-imap-send
 /git-index-pack
 /git-init
diff --git a/Documentation/git-ignore.txt b/Documentation/git-ignore.txt
new file mode 100644
index 0000000000..df1dfd7a88
--- /dev/null
+++ b/Documentation/git-ignore.txt
@@ -0,0 +1,116 @@
+git-ignore(1)
+=============
+
+NAME
+----
+git-ignore - Easily add entries to your .gitignore file
+
+
+SYNOPSIS
+--------
+[verse]
+'git ignore' [--dry-run | -n] [--ext | -e] [--all-ext | -E] [--dir | -d]
+	[--all-file | -a] [--parent-level | -p <parent_level>] pathspec [...]
+'git ignore' --edit [--parent-level | -p <parent_level>]
+
+
+DESCRIPTION
+-----------
+The command modifies a .gitignore file in your path easily. By default,
+it adds lines to the .gitignore found in the root of your repository. It
+can, however, add lines to a gitignore anywhere inbetween the file(s)
+passed in and the root directory. The lines added can be based on
+filename, extension, directory, or recursive glob.
+
+Also, you can easily open the gitignore file using the $EDITOR environment
+variable.
+
+
+OPTIONS
+-------
+<pathspec>...::
+	Files to add to a gitignore. Fileglobs (e.g. `*.c`) can
+	be given to add all matching files.  Also a
+	directory name can be given to add it to the gitignore
+	as well.
+
+--edit::
+	Open the appropriate gitignore file in your default editor (using the
+	$EDITOR variable). This option can be combined with `--parent-level` based
+	on your current working directory.
+
+-n::
+--dry-run::
+	Don't actually edit the gitignore(s), just show what changes
+	would have taken place.
+
+-e::
+--ext::
+	Add the relative filepath based on extension. If pathspec
+	references path/to/file.log, the added gitignore line would
+	be path/to/*.log.
+
+-E::
+--all-ext::
+	Add a global exclusion of the given extension. If pathspec
+	references path/to/file.log, the added gitignore line would
+	be **/*.log.
+
+-d::
+--dir::
+	Add the contents of the parent directory. If pathspec references
+	path/to/file.log, the added gitignore line would be path/to/*.
+
+-a::
+--all-file::
+	Add a global exclusion of the given filename. If pathspec references
+	path/to/file.log, the added gitignore line would be **/file.log.
+
+-p::
+--parent-level <parent_level>::
+	Modifications will go to a gitignore located <parent_level>
+	directories above each of the files passed in. If the number
+	of parent levels causes the directory to fall outside of the
+	root of the git repository, a warning is printed and the root
+	of the repository is used instead. Using a parent-level of 0
+	will use the gitignore in the directory of each file passed in.
+
++
+Note that the parent level is calculated for each file passed in. If multiple
+files are passed in that have different parents at a given parent level, then
+they will cause separate gitignore files to be written.
+
+
+EXAMPLES
+--------
+
+* Adds all `*.log` files under `tmp` directory
+and its subdirectories to the gitignore file found at the
+root of the repository:
++
+------------
+$ pwd
+/user/test/git_repo/src
+$ git ignore -e tmp/file.log
+------------
++
+Results in `tmp/*.log` added to /user/test/git_repo/.gitignore
+
+
+* Add the files under the `var/uploaded` directory to the gitignore above
+
++
+------------
+$ pwd
+/user/test/git_repo/
+$ git ignore -d --parent-level=1 www/var/uploaded/\*
+------------
+Results in `var/uploaded/*` added to /user/test/git_repo/www/.gitignore
+
+SEE ALSO
+--------
+linkgit:gitignore[5]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index f58bf14c7b..77ad5bd8e2 100644
--- a/Makefile
+++ b/Makefile
@@ -606,6 +606,7 @@ TEST_PROGRAMS_NEED_X =
 unexport CDPATH
 
 SCRIPT_SH += git-bisect.sh
+SCRIPT_SH += git-ignore.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-merge-octopus.sh
diff --git a/git-ignore.sh b/git-ignore.sh
new file mode 100755
index 0000000000..7cdc76caaf
--- /dev/null
+++ b/git-ignore.sh
@@ -0,0 +1,222 @@
+#!/bin/sh
+#
+# Copyright (c) 2016, Thurston Stone
+#
+# unit test: t7900
+
+test -z "$DDDEBUG" || set -x
+
+_verbose=0
+
+SUBDIRECTORY_OK=Yes
+OPTIONS_KEEPDASHDASH=
+OPTIONS_STUCKLONG=t
+# Would be nice to have examples, but rev-parse sees '*' as a symbol to hide everything afterwards
+#e,ext		 add relative path for any file of that type (ex. path/to/*.ext)
+#E,all-ext	 all files of that extention anywhere (ex. **/*.ext)
+#d,dir		 all files under the parent directory (ex. directory/*)
+#a,all-file	 all files of that file name (ex. **/filename.ext)
+OPTIONS_SPEC="git ignore [options] [file|glob ...]
+--
+ Miscelleneous
+edit		 open the pertinent gitignore with your default text editor (Requires \$EDITOR to be set)
+v,verbose	 show verbose output
+n,dry-run	 do not actually edit any .gitignore files
+ Determine what files to add to the gitignore(s):
+e,ext		 add relative path for any file of that type
+E,all-ext	 all files of that extention anywhere
+d,dir		 all files under the parent directory
+a,all-file	 all files of that file name
+ Determine what gitignore(s) to use:
+p,parent-level=  number of parent directories containing the gitignore to edit. Set to 0 to put it in the local directory"
+
+. git-sh-setup
+. git-sh-i18n
+
+write_output () {
+	if test $_verbose -eq 1
+	then
+	say $1
+	fi
+}
+
+get_git_ignore () {
+	directory=$1
+
+	# if we don't yet have the repo root directory, get it
+	if test -z "$repo_root"
+	then
+	#First, determine the root of the repository
+	repo_root="$(git rev-parse --show-toplevel)/"
+	write_output "repo_root=$repo_root"
+	fi
+
+	# get the path relative to the repo root
+	rel_directory="${directory#$repo_root}"
+	# if the relative path is the same as it was, try converting it to aa *nix
+	# style path
+	if test "$rel_directory" = "$directory"
+	then
+		# repo root 2 (cygwin-ified path) didn't work
+		# try the other one
+		write_output "changing repo_root from $repo_root"
+		#On windows, this turns to C:\... instead of /c/... from some other commands
+		repo_root=$(printf "$repo_root" | awk -F":" '{ if ($2) print "/" tolower($1) $2; else print $1 }')
+		write_output "	to $repo_root"
+		rel_directory="${directory#$repo_root}"
+	fi
+	# default gitignore
+	gitignore="${repo_root}.gitignore"
+
+	# ------------------------------------------------
+	# Determine the correct git ignore and the path of
+	# the file relative to it
+	# ------------------------------------------------
+	if test $_parent_level -ge 0
+	then
+		parent=${directory}
+		write_output "parent=${parent}"
+
+		if test $_parent_level -ne 0
+		then
+			i=1
+			while test "$i" -le $_parent_level
+			do
+				parent="$(dirname "$parent")/"
+				write_output "parent=${parent}"
+				i=$(($i + 1))
+			done
+		fi
+		root_len=$(printf "${repo_root}" | wc -m)
+		parent_len=$(printf "${parent}" | wc -m)
+		if test $root_len -ge $parent_len
+		then
+			write_output "root_len(${root_len}) >= parent_len(${parent_len})...
+			uh-oh"
+			gettextln "WARNING: Parent directory is outside of the repository"
+			parent="${repo_root}"
+		else
+			write_output "root_len(${root_len}) < parent_len(${parent_len})...
+			good"
+		fi
+		rel_directory="${directory#$parent}"
+		gitignore="${parent}.gitignore"
+	fi
+
+	write_output "rel_directory=${rel_directory}"
+	write_output "gitignore=${gitignore}"
+
+}
+
+add_ignore () {
+	# get the absolute path of the file
+	file="$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"
+	write_output "file=$file"
+
+	directory="$(dirname "$file")/"
+	write_output "directory=$directory"
+	get_git_ignore "$directory"
+
+	filename=$(basename "$file")
+	write_output "filename=$filename"
+	extension="${filename##*.}"
+	write_output "extension=$extension"
+	# defaault line
+	line="${rel_directory}${filename}"
+
+	# ------------------------------------------------
+	# Determine the correct line to add to the gitignore
+	# based on user inputs
+	# ------------------------------------------------
+	if test $_ext -eq 1
+	then
+		line="${rel_directory}*.$extension"
+	fi
+	if test $_directory -eq 1
+	then
+		line="${rel_directory}*"
+	fi
+	if test $_file_anywhere -eq 1
+	then
+		line="**/$filename"
+	fi
+	if test $_ext_anywhere -eq 1
+	then
+		line="**/*.$extension"
+	fi
+	write_output "line=${line}"
+	dryrun=""
+	if test $_dry_run -eq 1
+	then
+		dryrun="$(gettext "DRY-RUN!")"
+	fi
+	say "$dryrun $(eval_gettext "Adding \$line to \$gitignore")"
+	if test $_dry_run -eq 0
+	then
+		echo "$line" >>"$gitignore"
+	fi
+}
+
+_ext=0
+_directory=0
+_file_anywhere=0
+_ext_anywhere=0
+_parent_level=-1
+_edit=0
+_dry_run=0
+
+while test $# != 0
+do
+	case "$1" in
+	--ext)
+		_ext=1
+	;;
+	--all-ext)
+		_ext_anywhere=1
+	;;
+	--dir)
+		_directory=1
+	;;
+	--all-file)
+		_file_anywhere=1
+	;;
+	--parent-level=*)
+		_parent_level="${1#--parent-level=}"
+		if ! echo $_parent_level | grep -q '^[0-9]\+$'
+		then
+			gettextln "ILLEGAL PARAMETER: -p|--parent-level requires a numerical argument"
+			usage
+		fi
+	;;
+	--dry-run)
+		_dry_run=1
+	;;
+	--edit)
+		if test -z $EDITOR
+		then
+			gettextln "ERROR: Shell variable \$EDITOR must be set"
+			usage
+		fi
+		_edit=1
+	;;
+	--verbose)
+		_verbose=1
+	;;
+	--)
+		only_files_left=1
+	;;
+	*)
+		if test $only_files_left -eq 1
+		then
+			add_ignore "$1"
+		fi
+	;;
+	esac
+	shift
+done
+if test $_edit -eq 1
+then
+	get_git_ignore "$(pwd)/"
+	git_editor "$gitignore"
+fi
+exit 0
diff --git a/t/t7070-ignore.sh b/t/t7070-ignore.sh
new file mode 100755
index 0000000000..4966f62ac2
--- /dev/null
+++ b/t/t7070-ignore.sh
@@ -0,0 +1,180 @@
+#!/bin/sh
+#
+# Copyright (c) 2016 Thurston Stone
+#
+
+
+test_description='check-git-ignore-cmd'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo a >a &&
+	git add a &&
+	git commit -m"adding initial files"
+'
+
+
+test_expect_success 'ignore at root' '
+	echo a >ignoreme.txt &&
+	DDDEBUG=1 git ignore ignoreme.txt &&
+	echo "ignoreme.txt"  >expect &&
+	cat .gitignore >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ignore in subdir' '
+	rm .gitignore &&
+	mkdir -p "sub/dir with space" &&
+	echo a >"sub/dir with space/ignoreme.txt" &&
+	(
+		cd "sub/dir with space" &&
+		DDDEBUG=1 git ignore -v ignoreme.txt
+	) &&
+	echo "sub/dir with space/ignoreme.txt"	>expect &&
+	cat .gitignore >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ignore extentions at root' '
+	rm .gitignore &&
+	echo a >ignoreme.txt &&
+	DDDEBUG=1 git ignore -v -e ignoreme.txt &&
+	echo "*.txt" >expect &&
+	cat .gitignore >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ignore extentions in subdir' '
+	rm .gitignore &&
+	mkdir -p "sub/dir with space" &&
+	echo a >"sub/dir with space/ignoreme.txt" &&
+	(
+		cd "sub/dir with space" &&
+		DDDEBUG=1 git ignore -v -e ignoreme.txt
+	) &&
+	echo "sub/dir with space/*.txt" >expect &&
+	cat .gitignore >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ignore extentions anywhere' '
+	rm .gitignore &&
+	mkdir -p "sub/dir with space" &&
+	echo a >"sub/dir with space/ignoreme.txt" &&
+	(
+		cd "sub/dir with space" &&
+		DDDEBUG=1 git ignore -v -E ignoreme.txt
+	) &&
+	echo "**/*.txt" >expect &&
+	cat .gitignore >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ignore directory' '
+	rm .gitignore &&
+	mkdir -p "sub/dir with space" &&
+	echo a >"sub/dir with space/ignoreme.txt" &&
+	(
+		cd "sub/dir with space" &&
+		DDDEBUG=1 git ignore -v -d ignoreme.txt
+	) &&
+	echo "sub/dir with space/*" >expect &&
+	cat .gitignore >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ignore filename anywhere' '
+	rm .gitignore &&
+	mkdir -p "sub/dir with space" &&
+	echo a >"sub/dir with space/ignoreme.txt" &&
+	(
+		cd "sub/dir with space" &&
+		DDDEBUG=1 git ignore -v -a ignoreme.txt
+	) &&
+	echo "**/ignoreme.txt" >expect &&
+	cat .gitignore >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'dry run does not write anything' '
+	rm .gitignore &&
+	echo a >ignoreme.txt &&
+	DDDEBUG=1 git ignore -v -n ignoreme.txt >output &&
+	grep "^DRY-RUN!" <output &&
+	test_path_is_missing .gitignore
+'
+
+test_expect_success 'parent-level set to current dir' '
+	mkdir -p "sub/dir with space" &&
+	echo a >"sub/dir with space/ignoreme.txt" &&
+	(
+		cd "sub/dir with space" &&
+		DDDEBUG=1 git ignore -v -p 0 ignoreme.txt
+	) &&
+	echo "ignoreme.txt" >expect &&
+	cat "sub/dir with space/.gitignore" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'parent-level set to dir outside of repo top-level' '
+	mkdir -p "sub/dir with space" &&
+	echo a >"sub/dir with space/ignoreme.txt" &&
+	(
+		cd "sub/dir with space" &&
+		DDDEBUG=1 git ignore -v -p 2 ignoreme.txt >output
+	) &&
+	grep "^WARNING" <"sub/dir with space/output" &&
+	echo "sub/dir with space/ignoreme.txt" >expect &&
+	cat .gitignore >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'parent-level set to mutliple gitignores' '
+	mkdir -p "sub/dir1 with space/test" &&
+	echo a >"sub/dir1 with space/test/ignoreme.txt" &&
+	mkdir -p "sub/dir2 with space/test" &&
+	echo a >"sub/dir2 with space/test/ignoreme.txt" &&
+	DDDEBUG=1 git ignore -v -p 1 "sub/dir1 with space/test/ignoreme.txt" "sub/dir2 with space/test/ignoreme.txt" &&
+	echo "test/ignoreme.txt" >expect &&
+	cat "sub/dir1 with space/.gitignore" >actual &&
+	test_cmp expect actual &&
+	cat "sub/dir2 with space/.gitignore" >actual &&
+	test_cmp expect actual
+'
+
+setup_fake_editor () {
+	write_script fake-editor <<-\EOF
+set -x
+file=$1
+printf "edited the file like a boss">"$1"
+EOF
+}
+
+test_set_editor "$(pwd)/fake-editor"
+
+test_expect_success 'edit root gitignore' '
+	setup_fake_editor &&
+	mkdir -p "sub/dir with space" &&
+	(
+		cd "sub/dir with space" &&
+		DDDEBUG=1 git ignore -v --edit
+	) &&
+	printf "edited the file like a boss" >expect &&
+	cat .gitignore >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'edit root gitignore using --parent-level' '
+	setup_fake_editor &&
+	mkdir -p "sub/dir with space/test" &&
+	(
+		cd "sub/dir with space/test" &&
+		DDDEBUG=1 git ignore -p 2 --edit
+	) &&
+	printf "edited the file like a boss" >expect &&
+	cat sub/.gitignore >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
gitgitgadget
