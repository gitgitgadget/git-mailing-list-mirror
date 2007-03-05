From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: Re: [PATCHv2] t/t5515-fetch-merge-logic.sh: Added tests for the merge login in git-fetch
Date: Mon, 05 Mar 2007 09:09:39 +0100
Message-ID: <87abyskt6k.fsf@gmail.com>
References: <87ps7oslwk.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C. Hamano" <junkio@cox.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 05 09:09:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO8Ga-0002Yd-BK
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 09:09:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbXCEIJw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 5 Mar 2007 03:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbXCEIJw
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 03:09:52 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:37572 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932212AbXCEIJt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 03:09:49 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l2589Uw27807;
	Mon, 5 Mar 2007 09:09:31 +0100
In-Reply-To: <87ps7oslwk.fsf@gmail.com> (Santi =?utf-8?Q?B=C3=A9jar's?=
 message of "Sun, 04 Mar
	2007 23:07:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.94 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41411>

Hi *,

  this version does not remove the "note" feed to git-fmt-merge-msg.
  I've also added two &&.

Santi

P.D.: When sended this way the From: must be quoted or in UTF-8?

-- >8 --
=46rom: =3D?utf-8?q?Santi_B=3DC3=3DA9jar?=3D <sbejar@gmail.com>
Date: Sun, 4 Mar 2007 20:38:54 +0100
Subject: [PATCH] t/t5515-fetch-merge-logic.sh: Added tests for the merg=
e login in git-fetch


Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 t/t5515-fetch-merge-logic.sh                       |  161 ++++++++++++=
++++++++
 t/t5515/fetch.br-branches-default                  |    8 +
 t/t5515/fetch.br-branches-default-merge            |    8 +
 ...etch.br-branches-default-merge_branches-default |    8 +
 t/t5515/fetch.br-branches-default-octopus          |    8 +
 ...ch.br-branches-default-octopus_branches-default |    8 +
 t/t5515/fetch.br-branches-default_branches-default |    8 +
 t/t5515/fetch.br-branches-one                      |    8 +
 t/t5515/fetch.br-branches-one-merge                |    8 +
 t/t5515/fetch.br-branches-one-merge_branches-one   |    8 +
 t/t5515/fetch.br-branches-one-octopus              |    8 +
 t/t5515/fetch.br-branches-one-octopus_branches-one |    8 +
 t/t5515/fetch.br-branches-one_branches-one         |    8 +
 t/t5515/fetch.br-config-explicit                   |   11 ++
 t/t5515/fetch.br-config-explicit-merge             |   11 ++
 .../fetch.br-config-explicit-merge_config-explicit |   11 ++
 t/t5515/fetch.br-config-explicit-octopus           |   11 ++
 ...etch.br-config-explicit-octopus_config-explicit |   11 ++
 t/t5515/fetch.br-config-explicit_config-explicit   |   11 ++
 t/t5515/fetch.br-config-glob                       |   11 ++
 t/t5515/fetch.br-config-glob-merge                 |   11 ++
 t/t5515/fetch.br-config-glob-merge_config-glob     |   11 ++
 t/t5515/fetch.br-config-glob-octopus               |   11 ++
 t/t5515/fetch.br-config-glob-octopus_config-glob   |   11 ++
 t/t5515/fetch.br-config-glob_config-glob           |   11 ++
 t/t5515/fetch.br-remote-explicit                   |   11 ++
 t/t5515/fetch.br-remote-explicit-merge             |   11 ++
 .../fetch.br-remote-explicit-merge_remote-explicit |   11 ++
 t/t5515/fetch.br-remote-explicit-octopus           |   11 ++
 ...etch.br-remote-explicit-octopus_remote-explicit |   11 ++
 t/t5515/fetch.br-remote-explicit_remote-explicit   |   11 ++
 t/t5515/fetch.br-remote-glob                       |   11 ++
 t/t5515/fetch.br-remote-glob-merge                 |   11 ++
 t/t5515/fetch.br-remote-glob-merge_remote-glob     |   11 ++
 t/t5515/fetch.br-remote-glob-octopus               |   11 ++
 t/t5515/fetch.br-remote-glob-octopus_remote-glob   |   11 ++
 t/t5515/fetch.br-remote-glob_remote-glob           |   11 ++
 t/t5515/fetch.br-unconfig                          |   11 ++
 t/t5515/fetch.br-unconfig_--tags_.._.git           |    7 +
 t/t5515/fetch.br-unconfig_.._.git_one              |    2 +
 ...nfig_.._.git_one_tag_tag-one_tag_tag-three-file |    8 +
 t/t5515/fetch.br-unconfig_.._.git_one_two          |    3 +
 ...fig_.._.git_tag_tag-one-tree_tag_tag-three-file |    7 +
 ...h.br-unconfig_.._.git_tag_tag-one_tag_tag-three |    7 +
 t/t5515/fetch.br-unconfig_branches-default         |    8 +
 t/t5515/fetch.br-unconfig_branches-one             |    8 +
 t/t5515/fetch.br-unconfig_config-explicit          |   11 ++
 t/t5515/fetch.br-unconfig_config-glob              |   11 ++
 t/t5515/fetch.br-unconfig_remote-explicit          |   11 ++
 t/t5515/fetch.br-unconfig_remote-glob              |   11 ++
 t/t5515/fetch.master                               |   11 ++
 t/t5515/fetch.master_--tags_.._.git                |    7 +
 t/t5515/fetch.master_.._.git_one                   |    2 +
 ...ster_.._.git_one_tag_tag-one_tag_tag-three-file |    8 +
 t/t5515/fetch.master_.._.git_one_two               |    3 +
 ...ter_.._.git_tag_tag-one-tree_tag_tag-three-file |    7 +
 .../fetch.master_.._.git_tag_tag-one_tag_tag-three |    7 +
 t/t5515/fetch.master_branches-default              |    8 +
 t/t5515/fetch.master_branches-one                  |    8 +
 t/t5515/fetch.master_config-explicit               |   11 ++
 t/t5515/fetch.master_config-glob                   |   11 ++
 t/t5515/fetch.master_remote-explicit               |   11 ++
 t/t5515/fetch.master_remote-glob                   |   11 ++
 63 files changed, 731 insertions(+), 0 deletions(-)
 create mode 100755 t/t5515-fetch-merge-logic.sh
 create mode 100644 t/t5515/fetch.br-branches-default
 create mode 100644 t/t5515/fetch.br-branches-default-merge
 create mode 100644 t/t5515/fetch.br-branches-default-merge_branches-de=
fault
 create mode 100644 t/t5515/fetch.br-branches-default-octopus
 create mode 100644 t/t5515/fetch.br-branches-default-octopus_branches-=
default
 create mode 100644 t/t5515/fetch.br-branches-default_branches-default
 create mode 100644 t/t5515/fetch.br-branches-one
 create mode 100644 t/t5515/fetch.br-branches-one-merge
 create mode 100644 t/t5515/fetch.br-branches-one-merge_branches-one
 create mode 100644 t/t5515/fetch.br-branches-one-octopus
 create mode 100644 t/t5515/fetch.br-branches-one-octopus_branches-one
 create mode 100644 t/t5515/fetch.br-branches-one_branches-one
 create mode 100644 t/t5515/fetch.br-config-explicit
 create mode 100644 t/t5515/fetch.br-config-explicit-merge
 create mode 100644 t/t5515/fetch.br-config-explicit-merge_config-expli=
cit
 create mode 100644 t/t5515/fetch.br-config-explicit-octopus
 create mode 100644 t/t5515/fetch.br-config-explicit-octopus_config-exp=
licit
 create mode 100644 t/t5515/fetch.br-config-explicit_config-explicit
 create mode 100644 t/t5515/fetch.br-config-glob
 create mode 100644 t/t5515/fetch.br-config-glob-merge
 create mode 100644 t/t5515/fetch.br-config-glob-merge_config-glob
 create mode 100644 t/t5515/fetch.br-config-glob-octopus
 create mode 100644 t/t5515/fetch.br-config-glob-octopus_config-glob
 create mode 100644 t/t5515/fetch.br-config-glob_config-glob
 create mode 100644 t/t5515/fetch.br-remote-explicit
 create mode 100644 t/t5515/fetch.br-remote-explicit-merge
 create mode 100644 t/t5515/fetch.br-remote-explicit-merge_remote-expli=
cit
 create mode 100644 t/t5515/fetch.br-remote-explicit-octopus
 create mode 100644 t/t5515/fetch.br-remote-explicit-octopus_remote-exp=
licit
 create mode 100644 t/t5515/fetch.br-remote-explicit_remote-explicit
 create mode 100644 t/t5515/fetch.br-remote-glob
 create mode 100644 t/t5515/fetch.br-remote-glob-merge
 create mode 100644 t/t5515/fetch.br-remote-glob-merge_remote-glob
 create mode 100644 t/t5515/fetch.br-remote-glob-octopus
 create mode 100644 t/t5515/fetch.br-remote-glob-octopus_remote-glob
 create mode 100644 t/t5515/fetch.br-remote-glob_remote-glob
 create mode 100644 t/t5515/fetch.br-unconfig
 create mode 100644 t/t5515/fetch.br-unconfig_--tags_.._.git
 create mode 100644 t/t5515/fetch.br-unconfig_.._.git_one
 create mode 100644 t/t5515/fetch.br-unconfig_.._.git_one_tag_tag-one_t=
ag_tag-three-file
 create mode 100644 t/t5515/fetch.br-unconfig_.._.git_one_two
 create mode 100644 t/t5515/fetch.br-unconfig_.._.git_tag_tag-one-tree_=
tag_tag-three-file
 create mode 100644 t/t5515/fetch.br-unconfig_.._.git_tag_tag-one_tag_t=
ag-three
 create mode 100644 t/t5515/fetch.br-unconfig_branches-default
 create mode 100644 t/t5515/fetch.br-unconfig_branches-one
 create mode 100644 t/t5515/fetch.br-unconfig_config-explicit
 create mode 100644 t/t5515/fetch.br-unconfig_config-glob
 create mode 100644 t/t5515/fetch.br-unconfig_remote-explicit
 create mode 100644 t/t5515/fetch.br-unconfig_remote-glob
 create mode 100644 t/t5515/fetch.master
 create mode 100644 t/t5515/fetch.master_--tags_.._.git
 create mode 100644 t/t5515/fetch.master_.._.git_one
 create mode 100644 t/t5515/fetch.master_.._.git_one_tag_tag-one_tag_ta=
g-three-file
 create mode 100644 t/t5515/fetch.master_.._.git_one_two
 create mode 100644 t/t5515/fetch.master_.._.git_tag_tag-one-tree_tag_t=
ag-three-file
 create mode 100644 t/t5515/fetch.master_.._.git_tag_tag-one_tag_tag-th=
ree
 create mode 100644 t/t5515/fetch.master_branches-default
 create mode 100644 t/t5515/fetch.master_branches-one
 create mode 100644 t/t5515/fetch.master_config-explicit
 create mode 100644 t/t5515/fetch.master_config-glob
 create mode 100644 t/t5515/fetch.master_remote-explicit
 create mode 100644 t/t5515/fetch.master_remote-glob

diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.s=
h
new file mode 100755
index 0000000..765c83f
--- /dev/null
+++ b/t/t5515-fetch-merge-logic.sh
@@ -0,0 +1,161 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Santi B=C3=A9jar, based on t4013 by Junio C Haman=
o
+#
+#
+
+test_description=3D'Merge logic in fetch'
+
+. ./test-lib.sh
+
+LF=3D'
+'
+
+test_expect_success setup '
+	GIT_AUTHOR_DATE=3D"2006-06-26 00:00:00 +0000" &&
+	GIT_COMMITTER_DATE=3D"2006-06-26 00:00:00 +0000" &&
+	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
+
+	echo >file original &&
+	git add file &&
+	git commit -a -m One &&
+	git tag tag-one &&
+	git tag tag-one-tree HEAD^{tree} &&
+	git branch one &&
+
+	echo two >> file &&
+	git commit -a -m Two &&
+	git tag -a -m "Tag Two" tag-two &&
+	git branch two &&
+
+	echo three >> file &&
+	git commit -a -m Three &&
+	git tag -a -m "Tag Three" tag-three &&
+	git tag -a -m "Tag Three file" tag-three-file HEAD^{tree}:file &&
+	git branch three &&
+
+	echo master >> file &&
+	git commit -a -m Master &&
+	git tag -a -m "Tag Master" tag-master &&
+
+	git checkout three &&
+
+	git clone . cloned &&
+	cd cloned &&
+	git config remote.origin.url ../.git/ &&
+
+	git config remote.config-explicit.url ../.git/ &&
+	git config remote.config-explicit.fetch refs/heads/master:remotes/rem=
/master &&
+	git config --add remote.config-explicit.fetch refs/heads/one:remotes/=
rem/one &&
+	git config --add remote.config-explicit.fetch two:remotes/rem/two &&
+	git config --add remote.config-explicit.fetch refs/heads/three:remote=
s/rem/three &&
+	remotes=3D"config-explicit" &&
+
+	git config remote.config-glob.url ../.git/ &&
+	git config remote.config-glob.fetch refs/heads/*:refs/remotes/rem/* &=
&
+	remotes=3D"$remotes config-glob" &&
+
+	mkdir -p .git/remotes &&
+	{
+		echo "URL: ../.git/"
+		echo "Pull: refs/heads/master:remotes/rem/master"
+		echo "Pull: refs/heads/one:remotes/rem/one"
+		echo "Pull: two:remotes/rem/two"
+		echo "Pull: refs/heads/three:remotes/rem/three"
+	} >.git/remotes/remote-explicit &&
+	remotes=3D"$remotes remote-explicit" &&
+
+	{
+		echo "URL: ../.git/"
+		echo "Pull: refs/heads/*:refs/remotes/rem/*"
+	} >.git/remotes/remote-glob &&
+	remotes=3D"$remotes remote-glob" &&
+
+	mkdir -p .git/branches &&
+	echo "../.git" > .git/branches/branches-default &&
+	remotes=3D"$remotes branches-default" &&
+
+	echo "../.git#one" > .git/branches/branches-one &&
+	remotes=3D"$remotes branches-one" &&
+
+	for remote in $remotes ; do
+		git config branch.br-$remote.remote $remote &&
+		git config branch.br-$remote-merge.remote $remote &&
+		git config branch.br-$remote-merge.merge refs/heads/three &&
+		git config branch.br-$remote-octopus.remote $remote &&
+		git config branch.br-$remote-octopus.merge refs/heads/one &&
+		git config --add branch.br-$remote-octopus.merge two &&
+		git config --add branch.br-$remote-octopus.merge remotes/rem/three
+	done
+'
+
+# Merge logic depends on branch properties and Pull: or .fetch lines
+for remote in $remotes ; do
+    for branch in "" "-merge" "-octopus" ; do
+cat <<EOF
+br-$remote$branch
+br-$remote$branch $remote
+EOF
+    done
+done > tests
+
+# Merge logic does not depend on branch properties,
+# but does depend on Pull: or fetch lines.
+# Use two branches completely unrelated from the arguments,
+# the clone default and one without branch properties
+for branch in master br-unconfig ; do
+    echo $branch
+    for remote in $remotes ; do
+	echo $branch $remote
+    done
+done >> tests
+
+# Merge logic does not depend on branch properties
+# neither in the Pull: or .fetch config
+for branch in master br-unconfig ; do
+    cat <<EOF
+$branch ../.git one
+$branch ../.git one two
+$branch --tags ../.git
+$branch ../.git tag tag-one tag tag-three
+$branch ../.git tag tag-one-tree tag tag-three-file
+$branch ../.git one tag tag-one tag tag-three-file
+EOF
+done >> tests
+
+while read cmd
+do
+	case "$cmd" in
+	'' | '#'*) continue ;;
+	esac
+	test=3D`echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g'`
+	cnt=3D`expr $test_count + 1`
+	pfx=3D`printf "%04d" $cnt`
+	expect=3D"../../t5515/fetch.$test"
+	actual=3D"$pfx-fetch.$test"
+
+	test_expect_success "$cmd" '
+		{
+			echo "# $cmd"
+			set x $cmd; shift
+			git symbolic-ref HEAD refs/heads/$1 ; shift
+			rm -f .git/FETCH_HEAD
+			rm -f .git/refs/heads/*
+			rm -f .git/refs/remotes/rem/*
+			rm -f .git/refs/tags/*
+			git fetch "$@" >/dev/null
+			cat .git/FETCH_HEAD
+		} >"$actual" &&
+		if test -f "$expect"
+		then
+			diff -u "$expect" "$actual" &&
+			rm -f "$actual"
+		else
+			# this is to help developing new tests.
+			cp "$actual" "$expect"
+			false
+		fi
+	'
+done < tests
+
+test_done
diff --git a/t/t5515/fetch.br-branches-default b/t/t5515/fetch.br-branc=
hes-default
new file mode 100644
index 0000000..2e0414f
--- /dev/null
+++ b/t/t5515/fetch.br-branches-default
@@ -0,0 +1,8 @@
+# br-branches-default
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-branches-default-merge b/t/t5515/fetch.br=
-branches-default-merge
new file mode 100644
index 0000000..ea65f31
--- /dev/null
+++ b/t/t5515/fetch.br-branches-default-merge
@@ -0,0 +1,8 @@
+# br-branches-default-merge
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-branches-default-merge_branches-default b=
/t/t5515/fetch.br-branches-default-merge_branches-default
new file mode 100644
index 0000000..7b5fa94
--- /dev/null
+++ b/t/t5515/fetch.br-branches-default-merge_branches-default
@@ -0,0 +1,8 @@
+# br-branches-default-merge branches-default
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-branches-default-octopus b/t/t5515/fetch.=
br-branches-default-octopus
new file mode 100644
index 0000000..128397d
--- /dev/null
+++ b/t/t5515/fetch.br-branches-default-octopus
@@ -0,0 +1,8 @@
+# br-branches-default-octopus
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-branches-default-octopus_branches-default=
 b/t/t5515/fetch.br-branches-default-octopus_branches-default
new file mode 100644
index 0000000..4b37cd4
--- /dev/null
+++ b/t/t5515/fetch.br-branches-default-octopus_branches-default
@@ -0,0 +1,8 @@
+# br-branches-default-octopus branches-default
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-branches-default_branches-default b/t/t55=
15/fetch.br-branches-default_branches-default
new file mode 100644
index 0000000..4a2bf3c
--- /dev/null
+++ b/t/t5515/fetch.br-branches-default_branches-default
@@ -0,0 +1,8 @@
+# br-branches-default branches-default
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-branches-one b/t/t5515/fetch.br-branches-=
one
new file mode 100644
index 0000000..12ac8d2
--- /dev/null
+++ b/t/t5515/fetch.br-branches-one
@@ -0,0 +1,8 @@
+# br-branches-one
+8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-branches-one-merge b/t/t5515/fetch.br-bra=
nches-one-merge
new file mode 100644
index 0000000..3a4e77e
--- /dev/null
+++ b/t/t5515/fetch.br-branches-one-merge
@@ -0,0 +1,8 @@
+# br-branches-one-merge
+8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-branches-one-merge_branches-one b/t/t5515=
/fetch.br-branches-one-merge_branches-one
new file mode 100644
index 0000000..00e04b4
--- /dev/null
+++ b/t/t5515/fetch.br-branches-one-merge_branches-one
@@ -0,0 +1,8 @@
+# br-branches-one-merge branches-one
+8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-branches-one-octopus b/t/t5515/fetch.br-b=
ranches-one-octopus
new file mode 100644
index 0000000..53fe808
--- /dev/null
+++ b/t/t5515/fetch.br-branches-one-octopus
@@ -0,0 +1,8 @@
+# br-branches-one-octopus
+8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-branches-one-octopus_branches-one b/t/t55=
15/fetch.br-branches-one-octopus_branches-one
new file mode 100644
index 0000000..41b18ff
--- /dev/null
+++ b/t/t5515/fetch.br-branches-one-octopus_branches-one
@@ -0,0 +1,8 @@
+# br-branches-one-octopus branches-one
+8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-branches-one_branches-one b/t/t5515/fetch=
=2Ebr-branches-one_branches-one
new file mode 100644
index 0000000..281fa09
--- /dev/null
+++ b/t/t5515/fetch.br-branches-one_branches-one
@@ -0,0 +1,8 @@
+# br-branches-one branches-one
+8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-config-explicit b/t/t5515/fetch.br-config=
-explicit
new file mode 100644
index 0000000..e2fa9c8
--- /dev/null
+++ b/t/t5515/fetch.br-config-explicit
@@ -0,0 +1,11 @@
+# br-config-explicit
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-config-explicit-merge b/t/t5515/fetch.br-=
config-explicit-merge
new file mode 100644
index 0000000..ec1a723
--- /dev/null
+++ b/t/t5515/fetch.br-config-explicit-merge
@@ -0,0 +1,11 @@
+# br-config-explicit-merge
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-config-explicit-merge_config-explicit b/t=
/t5515/fetch.br-config-explicit-merge_config-explicit
new file mode 100644
index 0000000..54f6891
--- /dev/null
+++ b/t/t5515/fetch.br-config-explicit-merge_config-explicit
@@ -0,0 +1,11 @@
+# br-config-explicit-merge config-explicit
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-config-explicit-octopus b/t/t5515/fetch.b=
r-config-explicit-octopus
new file mode 100644
index 0000000..7011dfc
--- /dev/null
+++ b/t/t5515/fetch.br-config-explicit-octopus
@@ -0,0 +1,11 @@
+# br-config-explicit-octopus
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-config-explicit-octopus_config-explicit b=
/t/t5515/fetch.br-config-explicit-octopus_config-explicit
new file mode 100644
index 0000000..bdad51f
--- /dev/null
+++ b/t/t5515/fetch.br-config-explicit-octopus_config-explicit
@@ -0,0 +1,11 @@
+# br-config-explicit-octopus config-explicit
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-config-explicit_config-explicit b/t/t5515=
/fetch.br-config-explicit_config-explicit
new file mode 100644
index 0000000..1b237dd
--- /dev/null
+++ b/t/t5515/fetch.br-config-explicit_config-explicit
@@ -0,0 +1,11 @@
+# br-config-explicit config-explicit
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-config-glob b/t/t5515/fetch.br-config-glo=
b
new file mode 100644
index 0000000..e75ec2f
--- /dev/null
+++ b/t/t5515/fetch.br-config-glob
@@ -0,0 +1,11 @@
+# br-config-glob
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-config-glob-merge b/t/t5515/fetch.br-conf=
ig-glob-merge
new file mode 100644
index 0000000..ce8f739
--- /dev/null
+++ b/t/t5515/fetch.br-config-glob-merge
@@ -0,0 +1,11 @@
+# br-config-glob-merge
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-config-glob-merge_config-glob b/t/t5515/f=
etch.br-config-glob-merge_config-glob
new file mode 100644
index 0000000..5817bed
--- /dev/null
+++ b/t/t5515/fetch.br-config-glob-merge_config-glob
@@ -0,0 +1,11 @@
+# br-config-glob-merge config-glob
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-config-glob-octopus b/t/t5515/fetch.br-co=
nfig-glob-octopus
new file mode 100644
index 0000000..9ee213e
--- /dev/null
+++ b/t/t5515/fetch.br-config-glob-octopus
@@ -0,0 +1,11 @@
+# br-config-glob-octopus
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-config-glob-octopus_config-glob b/t/t5515=
/fetch.br-config-glob-octopus_config-glob
new file mode 100644
index 0000000..44bd0ec
--- /dev/null
+++ b/t/t5515/fetch.br-config-glob-octopus_config-glob
@@ -0,0 +1,11 @@
+# br-config-glob-octopus config-glob
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-config-glob_config-glob b/t/t5515/fetch.b=
r-config-glob_config-glob
new file mode 100644
index 0000000..a6c20f9
--- /dev/null
+++ b/t/t5515/fetch.br-config-glob_config-glob
@@ -0,0 +1,11 @@
+# br-config-glob config-glob
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-remote-explicit b/t/t5515/fetch.br-remote=
-explicit
new file mode 100644
index 0000000..83534d2
--- /dev/null
+++ b/t/t5515/fetch.br-remote-explicit
@@ -0,0 +1,11 @@
+# br-remote-explicit
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-remote-explicit-merge b/t/t5515/fetch.br-=
remote-explicit-merge
new file mode 100644
index 0000000..a9064dd
--- /dev/null
+++ b/t/t5515/fetch.br-remote-explicit-merge
@@ -0,0 +1,11 @@
+# br-remote-explicit-merge
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-remote-explicit-merge_remote-explicit b/t=
/t5515/fetch.br-remote-explicit-merge_remote-explicit
new file mode 100644
index 0000000..732a37e
--- /dev/null
+++ b/t/t5515/fetch.br-remote-explicit-merge_remote-explicit
@@ -0,0 +1,11 @@
+# br-remote-explicit-merge remote-explicit
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-remote-explicit-octopus b/t/t5515/fetch.b=
r-remote-explicit-octopus
new file mode 100644
index 0000000..ecf020d
--- /dev/null
+++ b/t/t5515/fetch.br-remote-explicit-octopus
@@ -0,0 +1,11 @@
+# br-remote-explicit-octopus
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-remote-explicit-octopus_remote-explicit b=
/t/t5515/fetch.br-remote-explicit-octopus_remote-explicit
new file mode 100644
index 0000000..af77531
--- /dev/null
+++ b/t/t5515/fetch.br-remote-explicit-octopus_remote-explicit
@@ -0,0 +1,11 @@
+# br-remote-explicit-octopus remote-explicit
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-remote-explicit_remote-explicit b/t/t5515=
/fetch.br-remote-explicit_remote-explicit
new file mode 100644
index 0000000..51fae56
--- /dev/null
+++ b/t/t5515/fetch.br-remote-explicit_remote-explicit
@@ -0,0 +1,11 @@
+# br-remote-explicit remote-explicit
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-remote-glob b/t/t5515/fetch.br-remote-glo=
b
new file mode 100644
index 0000000..94e6ad3
--- /dev/null
+++ b/t/t5515/fetch.br-remote-glob
@@ -0,0 +1,11 @@
+# br-remote-glob
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-remote-glob-merge b/t/t5515/fetch.br-remo=
te-glob-merge
new file mode 100644
index 0000000..09362e2
--- /dev/null
+++ b/t/t5515/fetch.br-remote-glob-merge
@@ -0,0 +1,11 @@
+# br-remote-glob-merge
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-remote-glob-merge_remote-glob b/t/t5515/f=
etch.br-remote-glob-merge_remote-glob
new file mode 100644
index 0000000..e2eabec
--- /dev/null
+++ b/t/t5515/fetch.br-remote-glob-merge_remote-glob
@@ -0,0 +1,11 @@
+# br-remote-glob-merge remote-glob
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-remote-glob-octopus b/t/t5515/fetch.br-re=
mote-glob-octopus
new file mode 100644
index 0000000..c1554f8
--- /dev/null
+++ b/t/t5515/fetch.br-remote-glob-octopus
@@ -0,0 +1,11 @@
+# br-remote-glob-octopus
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-remote-glob-octopus_remote-glob b/t/t5515=
/fetch.br-remote-glob-octopus_remote-glob
new file mode 100644
index 0000000..e613434
--- /dev/null
+++ b/t/t5515/fetch.br-remote-glob-octopus_remote-glob
@@ -0,0 +1,11 @@
+# br-remote-glob-octopus remote-glob
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-remote-glob_remote-glob b/t/t5515/fetch.b=
r-remote-glob_remote-glob
new file mode 100644
index 0000000..646dbc8
--- /dev/null
+++ b/t/t5515/fetch.br-remote-glob_remote-glob
@@ -0,0 +1,11 @@
+# br-remote-glob remote-glob
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-unconfig b/t/t5515/fetch.br-unconfig
new file mode 100644
index 0000000..65ce6d9
--- /dev/null
+++ b/t/t5515/fetch.br-unconfig
@@ -0,0 +1,11 @@
+# br-unconfig
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-unconfig_--tags_.._.git b/t/t5515/fetch.b=
r-unconfig_--tags_.._.git
new file mode 100644
index 0000000..8258c80
--- /dev/null
+++ b/t/t5515/fetch.br-unconfig_--tags_.._.git
@@ -0,0 +1,7 @@
+# br-unconfig --tags ../.git
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-unconfig_.._.git_one b/t/t5515/fetch.br-u=
nconfig_.._.git_one
new file mode 100644
index 0000000..11eb5a6
--- /dev/null
+++ b/t/t5515/fetch.br-unconfig_.._.git_one
@@ -0,0 +1,2 @@
+# br-unconfig ../.git one
+8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
diff --git a/t/t5515/fetch.br-unconfig_.._.git_one_tag_tag-one_tag_tag-=
three-file b/t/t5515/fetch.br-unconfig_.._.git_one_tag_tag-one_tag_tag-=
three-file
new file mode 100644
index 0000000..f02bab2
--- /dev/null
+++ b/t/t5515/fetch.br-unconfig_.._.git_one_tag_tag-one_tag_tag-three-f=
ile
@@ -0,0 +1,8 @@
+# br-unconfig ../.git one tag tag-one tag tag-three-file
+8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689		tag 'tag-one' of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-unconfig_.._.git_one_two b/t/t5515/fetch.=
br-unconfig_.._.git_one_two
new file mode 100644
index 0000000..3f1be22
--- /dev/null
+++ b/t/t5515/fetch.br-unconfig_.._.git_one_two
@@ -0,0 +1,3 @@
+# br-unconfig ../.git one two
+8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
diff --git a/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one-tree_tag_tag=
-three-file b/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one-tree_tag_ta=
g-three-file
new file mode 100644
index 0000000..85de411
--- /dev/null
+++ b/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one-tree_tag_tag-three-=
file
@@ -0,0 +1,7 @@
+# br-unconfig ../.git tag tag-one-tree tag tag-three-file
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one_tag_tag-thre=
e b/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one_tag_tag-three
new file mode 100644
index 0000000..0da2337
--- /dev/null
+++ b/t/t5515/fetch.br-unconfig_.._.git_tag_tag-one_tag_tag-three
@@ -0,0 +1,7 @@
+# br-unconfig ../.git tag tag-one tag tag-three
+8e32a6d901327a23ef831511badce7bf3bf46689		tag 'tag-one' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		tag 'tag-three' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-unconfig_branches-default b/t/t5515/fetch=
=2Ebr-unconfig_branches-default
new file mode 100644
index 0000000..fc7041e
--- /dev/null
+++ b/t/t5515/fetch.br-unconfig_branches-default
@@ -0,0 +1,8 @@
+# br-unconfig branches-default
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-unconfig_branches-one b/t/t5515/fetch.br-=
unconfig_branches-one
new file mode 100644
index 0000000..e94cde7
--- /dev/null
+++ b/t/t5515/fetch.br-unconfig_branches-one
@@ -0,0 +1,8 @@
+# br-unconfig branches-one
+8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-unconfig_config-explicit b/t/t5515/fetch.=
br-unconfig_config-explicit
new file mode 100644
index 0000000..01a283e
--- /dev/null
+++ b/t/t5515/fetch.br-unconfig_config-explicit
@@ -0,0 +1,11 @@
+# br-unconfig config-explicit
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-unconfig_config-glob b/t/t5515/fetch.br-u=
nconfig_config-glob
new file mode 100644
index 0000000..3a556c5
--- /dev/null
+++ b/t/t5515/fetch.br-unconfig_config-glob
@@ -0,0 +1,11 @@
+# br-unconfig config-glob
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-unconfig_remote-explicit b/t/t5515/fetch.=
br-unconfig_remote-explicit
new file mode 100644
index 0000000..db216df
--- /dev/null
+++ b/t/t5515/fetch.br-unconfig_remote-explicit
@@ -0,0 +1,11 @@
+# br-unconfig remote-explicit
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.br-unconfig_remote-glob b/t/t5515/fetch.br-u=
nconfig_remote-glob
new file mode 100644
index 0000000..aee65c2
--- /dev/null
+++ b/t/t5515/fetch.br-unconfig_remote-glob
@@ -0,0 +1,11 @@
+# br-unconfig remote-glob
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.master b/t/t5515/fetch.master
new file mode 100644
index 0000000..950fd07
--- /dev/null
+++ b/t/t5515/fetch.master
@@ -0,0 +1,11 @@
+# master
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.master_--tags_.._.git b/t/t5515/fetch.master=
_--tags_.._.git
new file mode 100644
index 0000000..0e59950
--- /dev/null
+++ b/t/t5515/fetch.master_--tags_.._.git
@@ -0,0 +1,7 @@
+# master --tags ../.git
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.master_.._.git_one b/t/t5515/fetch.master_..=
_.git_one
new file mode 100644
index 0000000..35deddb
--- /dev/null
+++ b/t/t5515/fetch.master_.._.git_one
@@ -0,0 +1,2 @@
+# master ../.git one
+8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
diff --git a/t/t5515/fetch.master_.._.git_one_tag_tag-one_tag_tag-three=
-file b/t/t5515/fetch.master_.._.git_one_tag_tag-one_tag_tag-three-file
new file mode 100644
index 0000000..8286852
--- /dev/null
+++ b/t/t5515/fetch.master_.._.git_one_tag_tag-one_tag_tag-three-file
@@ -0,0 +1,8 @@
+# master ../.git one tag tag-one tag tag-three-file
+8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689		tag 'tag-one' of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.master_.._.git_one_two b/t/t5515/fetch.maste=
r_.._.git_one_two
new file mode 100644
index 0000000..35ec578
--- /dev/null
+++ b/t/t5515/fetch.master_.._.git_one_two
@@ -0,0 +1,3 @@
+# master ../.git one two
+8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
diff --git a/t/t5515/fetch.master_.._.git_tag_tag-one-tree_tag_tag-thre=
e-file b/t/t5515/fetch.master_.._.git_tag_tag-one-tree_tag_tag-three-fi=
le
new file mode 100644
index 0000000..2e133ef
--- /dev/null
+++ b/t/t5515/fetch.master_.._.git_tag_tag-one-tree_tag_tag-three-file
@@ -0,0 +1,7 @@
+# master ../.git tag tag-one-tree tag tag-three-file
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.master_.._.git_tag_tag-one_tag_tag-three b/t=
/t5515/fetch.master_.._.git_tag_tag-one_tag_tag-three
new file mode 100644
index 0000000..92b18b4
--- /dev/null
+++ b/t/t5515/fetch.master_.._.git_tag_tag-one_tag_tag-three
@@ -0,0 +1,7 @@
+# master ../.git tag tag-one tag tag-three
+8e32a6d901327a23ef831511badce7bf3bf46689		tag 'tag-one' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		tag 'tag-three' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.master_branches-default b/t/t5515/fetch.mast=
er_branches-default
new file mode 100644
index 0000000..603d6d2
--- /dev/null
+++ b/t/t5515/fetch.master_branches-default
@@ -0,0 +1,8 @@
+# master branches-default
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.master_branches-one b/t/t5515/fetch.master_b=
ranches-one
new file mode 100644
index 0000000..fe9bb0b
--- /dev/null
+++ b/t/t5515/fetch.master_branches-one
@@ -0,0 +1,8 @@
+# master branches-one
+8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.master_config-explicit b/t/t5515/fetch.maste=
r_config-explicit
new file mode 100644
index 0000000..4be97c7
--- /dev/null
+++ b/t/t5515/fetch.master_config-explicit
@@ -0,0 +1,11 @@
+# master config-explicit
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.master_config-glob b/t/t5515/fetch.master_co=
nfig-glob
new file mode 100644
index 0000000..cb0726f
--- /dev/null
+++ b/t/t5515/fetch.master_config-glob
@@ -0,0 +1,11 @@
+# master config-glob
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.master_remote-explicit b/t/t5515/fetch.maste=
r_remote-explicit
new file mode 100644
index 0000000..44a1ca8
--- /dev/null
+++ b/t/t5515/fetch.master_remote-explicit
@@ -0,0 +1,11 @@
+# master remote-explicit
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
diff --git a/t/t5515/fetch.master_remote-glob b/t/t5515/fetch.master_re=
mote-glob
new file mode 100644
index 0000000..724e8db
--- /dev/null
+++ b/t/t5515/fetch.master_remote-glob
@@ -0,0 +1,11 @@
+# master remote-glob
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master'=
 of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of=
 ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' =
of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of=
 ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master=
' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' o=
f ../
+22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tr=
ee' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three'=
 of ../
+0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-=
file' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' o=
f ../
--=20
1.5.0.2.878.g38f47
