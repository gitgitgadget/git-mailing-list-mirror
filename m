From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 03/48] remote-helpers: test: cleanup white-spaces
Date: Fri, 24 May 2013 21:29:19 -0500
Message-ID: <1369449004-17981-4-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:32:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4H0-0001Mb-KI
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123Ab3EYCbx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 May 2013 22:31:53 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:42674 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab3EYCbv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:31:51 -0400
Received: by mail-ob0-f169.google.com with SMTP id 16so5783876obc.28
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+Ey2k9wmBt5QVW1hNAjopeRB/CsOrjpH6RXByXToYk8=;
        b=NLEAjlL00AjurBYt02v83Lc4h3CO2v/Qv/uUu8yV0o8MWl5+16ao7RFAiZABBkIReL
         qVjag8G+m9th28BN3FGCJeCK8mU7ZHqWw24qz/GeLz9BAh86i547d9wPNWeV9Xz5Cd1S
         9lM/gLuYu/JfvodcFLhFjZddTateIsRMt52zy/NztnojFBWgOwWQnHP+EdR/sjcUyyRG
         aNSD0IFv7YkahAjs+/A7XuCxcjqYGBfKvNLtjHk6KQKfdJLbzG+FBmK1qZ9kUif/5/MI
         VP9BATKzUqR8CzklYz9rqwvr0XMxZiT2JpNsTwdkrf0/eVKC7rtKP3JchzVs9oiKgq0D
         DnqQ==
X-Received: by 10.60.42.140 with SMTP id o12mr13947574oel.60.1369449111179;
        Fri, 24 May 2013 19:31:51 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x5sm20591341oep.1.2013.05.24.19.31.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:31:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225417>

We prefer tabs to spaces.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-bzr.sh | 460 ++++++++++++++++++-----------=
--------
 contrib/remote-helpers/test-hg.sh  | 176 +++++++-------
 2 files changed, 318 insertions(+), 318 deletions(-)

diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helper=
s/test-bzr.sh
index 5dfa070..a3220c8 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -29,69 +29,69 @@ check () {
 bzr whoami "A U Thor <author@example.com>"
=20
 test_expect_success 'cloning' '
-  (bzr init bzrrepo &&
-  cd bzrrepo &&
-  echo one > content &&
-  bzr add content &&
-  bzr commit -m one
-  ) &&
-
-  git clone "bzr::$PWD/bzrrepo" gitrepo &&
-  check gitrepo one master
+	(bzr init bzrrepo &&
+	cd bzrrepo &&
+	echo one > content &&
+	bzr add content &&
+	bzr commit -m one
+	) &&
+
+	git clone "bzr::$PWD/bzrrepo" gitrepo &&
+	check gitrepo one master
 '
=20
 test_expect_success 'pulling' '
-  (cd bzrrepo &&
-  echo two > content &&
-  bzr commit -m two
-  ) &&
+	(cd bzrrepo &&
+	echo two > content &&
+	bzr commit -m two
+	) &&
=20
-  (cd gitrepo && git pull) &&
+	(cd gitrepo && git pull) &&
=20
-  check gitrepo two master
+	check gitrepo two master
 '
=20
 test_expect_success 'pushing' '
-  (cd gitrepo &&
-  echo three > content &&
-  git commit -a -m three &&
-  git push
-  ) &&
-
-  echo three > expected &&
-  cat bzrrepo/content > actual &&
-  test_cmp expected actual
+	(cd gitrepo &&
+	echo three > content &&
+	git commit -a -m three &&
+	git push
+	) &&
+
+	echo three > expected &&
+	cat bzrrepo/content > actual &&
+	test_cmp expected actual
 '
=20
 test_expect_success 'roundtrip' '
-  (cd gitrepo &&
-  git pull &&
-  git log --format=3D"%s" -1 origin/master > actual) &&
-  echo three > expected &&
-  test_cmp expected actual &&
+	(cd gitrepo &&
+	git pull &&
+	git log --format=3D"%s" -1 origin/master > actual) &&
+	echo three > expected &&
+	test_cmp expected actual &&
=20
-  (cd gitrepo && git push && git pull) &&
+	(cd gitrepo && git push && git pull) &&
=20
-  (cd bzrrepo &&
-  echo four > content &&
-  bzr commit -m four
-  ) &&
+	(cd bzrrepo &&
+	echo four > content &&
+	bzr commit -m four
+	) &&
=20
-  (cd gitrepo && git pull && git push) &&
+	(cd gitrepo && git pull && git push) &&
=20
-  check gitrepo four master &&
+	check gitrepo four master &&
=20
-  (cd gitrepo &&
-  echo five > content &&
-  git commit -a -m five &&
-  git push && git pull
-  ) &&
+	(cd gitrepo &&
+	echo five > content &&
+	git commit -a -m five &&
+	git push && git pull
+	) &&
=20
-  (cd bzrrepo && bzr revert) &&
+	(cd bzrrepo && bzr revert) &&
=20
-  echo five > expected &&
-  cat bzrrepo/content > actual &&
-  test_cmp expected actual
+	echo five > expected &&
+	cat bzrrepo/content > actual &&
+	test_cmp expected actual
 '
=20
 cat > expected <<EOF
@@ -101,29 +101,29 @@ cat > expected <<EOF
 EOF
=20
 test_expect_success 'special modes' '
-  (cd bzrrepo &&
-  echo exec > executable
-  chmod +x executable &&
-  bzr add executable
-  bzr commit -m exec &&
-  ln -s content link
-  bzr add link
-  bzr commit -m link &&
-  mkdir dir &&
-  bzr add dir &&
-  bzr commit -m dir) &&
-
-  (cd gitrepo &&
-  git pull
-  git ls-tree HEAD > ../actual) &&
-
-  test_cmp expected actual &&
-
-  (cd gitrepo &&
-  git cat-file -p HEAD:link > ../actual) &&
-
-  printf content > expected &&
-  test_cmp expected actual
+	(cd bzrrepo &&
+	echo exec > executable
+	chmod +x executable &&
+	bzr add executable
+	bzr commit -m exec &&
+	ln -s content link
+	bzr add link
+	bzr commit -m link &&
+	mkdir dir &&
+	bzr add dir &&
+	bzr commit -m dir) &&
+
+	(cd gitrepo &&
+	git pull
+	git ls-tree HEAD > ../actual) &&
+
+	test_cmp expected actual &&
+
+	(cd gitrepo &&
+	git cat-file -p HEAD:link > ../actual) &&
+
+	printf content > expected &&
+	test_cmp expected actual
 '
=20
 cat > expected <<EOF
@@ -134,134 +134,134 @@ cat > expected <<EOF
 EOF
=20
 test_expect_success 'moving directory' '
-  (cd bzrrepo &&
-  mkdir movedir &&
-  echo one > movedir/one &&
-  echo two > movedir/two &&
-  bzr add movedir &&
-  bzr commit -m movedir &&
-  bzr mv movedir movedir-new &&
-  bzr commit -m movedir-new) &&
-
-  (cd gitrepo &&
-  git pull &&
-  git ls-tree HEAD > ../actual) &&
-
-  test_cmp expected actual
+	(cd bzrrepo &&
+	mkdir movedir &&
+	echo one > movedir/one &&
+	echo two > movedir/two &&
+	bzr add movedir &&
+	bzr commit -m movedir &&
+	bzr mv movedir movedir-new &&
+	bzr commit -m movedir-new) &&
+
+	(cd gitrepo &&
+	git pull &&
+	git ls-tree HEAD > ../actual) &&
+
+	test_cmp expected actual
 '
=20
 test_expect_success 'different authors' '
-  (cd bzrrepo &&
-  echo john >> content &&
-  bzr commit -m john \
-    --author "Jane Rey <jrey@example.com>" \
-    --author "John Doe <jdoe@example.com>") &&
-
-  (cd gitrepo &&
-  git pull &&
-  git show --format=3D"%an <%ae>, %cn <%ce>" --quiet > ../actual) &&
-
-  echo "Jane Rey <jrey@example.com>, A U Thor <author@example.com>" > =
expected &&
-  test_cmp expected actual
+	(cd bzrrepo &&
+	echo john >> content &&
+	bzr commit -m john \
+	  --author "Jane Rey <jrey@example.com>" \
+	  --author "John Doe <jdoe@example.com>") &&
+
+	(cd gitrepo &&
+	git pull &&
+	git show --format=3D"%an <%ae>, %cn <%ce>" --quiet > ../actual) &&
+
+	echo "Jane Rey <jrey@example.com>, A U Thor <author@example.com>" > e=
xpected &&
+	test_cmp expected actual
 '
=20
 test_expect_success 'fetch utf-8 filenames' '
-  mkdir -p tmp && cd tmp &&
-  test_when_finished "cd .. && rm -rf tmp && LC_ALL=3DC" &&
-
-  LC_ALL=3Den_US.UTF-8
-  export LC_ALL
-  (
-  bzr init bzrrepo &&
-  cd bzrrepo &&
-
-  echo test >> "=C3=A6r=C3=B8" &&
-  bzr add "=C3=A6r=C3=B8" &&
-  echo test >> "=C3=B8~?" &&
-  bzr add "=C3=B8~?" &&
-  bzr commit -m add-utf-8 &&
-  echo test >> "=C3=A6r=C3=B8" &&
-  bzr commit -m test-utf-8 &&
-  bzr rm "=C3=B8~?" &&
-  bzr mv "=C3=A6r=C3=B8" "=C3=B8~?" &&
-  bzr commit -m bzr-mv-utf-8
-  ) &&
-
-  (
-  git clone "bzr::$PWD/bzrrepo" gitrepo &&
-  cd gitrepo &&
-  git -c core.quotepath=3Dfalse ls-files > ../actual
-  ) &&
-  echo "=C3=B8~?" > expected &&
-  test_cmp expected actual
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp && LC_ALL=3DC" &&
+
+	LC_ALL=3Den_US.UTF-8
+	export LC_ALL
+	(
+	bzr init bzrrepo &&
+	cd bzrrepo &&
+
+	echo test >> "=C3=A6r=C3=B8" &&
+	bzr add "=C3=A6r=C3=B8" &&
+	echo test >> "=C3=B8~?" &&
+	bzr add "=C3=B8~?" &&
+	bzr commit -m add-utf-8 &&
+	echo test >> "=C3=A6r=C3=B8" &&
+	bzr commit -m test-utf-8 &&
+	bzr rm "=C3=B8~?" &&
+	bzr mv "=C3=A6r=C3=B8" "=C3=B8~?" &&
+	bzr commit -m bzr-mv-utf-8
+	) &&
+
+	(
+	git clone "bzr::$PWD/bzrrepo" gitrepo &&
+	cd gitrepo &&
+	git -c core.quotepath=3Dfalse ls-files > ../actual
+	) &&
+	echo "=C3=B8~?" > expected &&
+	test_cmp expected actual
 '
=20
 test_expect_success 'push utf-8 filenames' '
-  mkdir -p tmp && cd tmp &&
-  test_when_finished "cd .. && rm -rf tmp && LC_ALL=3DC" &&
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp && LC_ALL=3DC" &&
=20
-  LC_ALL=3Den_US.UTF-8
-  export LC_ALL
+	LC_ALL=3Den_US.UTF-8
+	export LC_ALL
=20
-  (
-  bzr init bzrrepo &&
-  cd bzrrepo &&
+	(
+	bzr init bzrrepo &&
+	cd bzrrepo &&
=20
-  echo one >> content &&
-  bzr add content &&
-  bzr commit -m one
-  ) &&
+	echo one >> content &&
+	bzr add content &&
+	bzr commit -m one
+	) &&
=20
-  (
-  git clone "bzr::$PWD/bzrrepo" gitrepo &&
-  cd gitrepo &&
+	(
+	git clone "bzr::$PWD/bzrrepo" gitrepo &&
+	cd gitrepo &&
=20
-  echo test >> "=C3=A6r=C3=B8" &&
-  git add "=C3=A6r=C3=B8" &&
-  git commit -m utf-8 &&
+	echo test >> "=C3=A6r=C3=B8" &&
+	git add "=C3=A6r=C3=B8" &&
+	git commit -m utf-8 &&
=20
-  git push
-  ) &&
+	git push
+	) &&
=20
-  (cd bzrrepo && bzr ls > ../actual) &&
-  printf "content\n=C3=A6r=C3=B8\n" > expected &&
-  test_cmp expected actual
+	(cd bzrrepo && bzr ls > ../actual) &&
+	printf "content\n=C3=A6r=C3=B8\n" > expected &&
+	test_cmp expected actual
 '
=20
 test_expect_success 'pushing a merge' '
-  mkdir -p tmp && cd tmp &&
-  test_when_finished "cd .. && rm -rf tmp" &&
-
-  (
-  bzr init bzrrepo &&
-  cd bzrrepo &&
-  echo one > content &&
-  bzr add content &&
-  bzr commit -m one
-  ) &&
-
-  git clone "bzr::$PWD/bzrrepo" gitrepo &&
-
-  (
-  cd bzrrepo &&
-  echo two > content &&
-  bzr commit -m two
-  ) &&
-
-  (
-  cd gitrepo &&
-  echo three > content &&
-  git commit -a -m three &&
-  git fetch &&
-  git merge origin/master || true &&
-  echo three > content &&
-  git commit -a --no-edit &&
-  git push
-  ) &&
-
-  echo three > expected &&
-  cat bzrrepo/content > actual &&
-  test_cmp expected actual
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	(
+	bzr init bzrrepo &&
+	cd bzrrepo &&
+	echo one > content &&
+	bzr add content &&
+	bzr commit -m one
+	) &&
+
+	git clone "bzr::$PWD/bzrrepo" gitrepo &&
+
+	(
+	cd bzrrepo &&
+	echo two > content &&
+	bzr commit -m two
+	) &&
+
+	(
+	cd gitrepo &&
+	echo three > content &&
+	git commit -a -m three &&
+	git fetch &&
+	git merge origin/master || true &&
+	echo three > content &&
+	git commit -a --no-edit &&
+	git push
+	) &&
+
+	echo three > expected &&
+	cat bzrrepo/content > actual &&
+	test_cmp expected actual
 '
=20
 cat > expected <<EOF
@@ -271,71 +271,71 @@ origin/trunk
 EOF
=20
 test_expect_success 'proper bzr repo' '
-  mkdir -p tmp && cd tmp &&
-  test_when_finished "cd .. && rm -rf tmp" &&
-
-  bzr init-repo bzrrepo &&
-
-  bzr init bzrrepo/trunk &&
-  (
-  cd bzrrepo/trunk &&
-  echo one >> content &&
-  bzr add content &&
-  bzr commit -m one
-  ) &&
-
-  bzr branch bzrrepo/trunk bzrrepo/branch &&
-  (
-  cd bzrrepo/branch &&
-  echo two >> content &&
-  bzr commit -m one
-  ) &&
-
-  git clone "bzr::$PWD/bzrrepo" gitrepo &&
-  (
-  cd gitrepo &&
-  git for-each-ref --format "%(refname:short)" refs/remotes/origin > .=
=2E/actual
-  ) &&
-
-  test_cmp ../expected actual
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	bzr init-repo bzrrepo &&
+
+	bzr init bzrrepo/trunk &&
+	(
+	cd bzrrepo/trunk &&
+	echo one >> content &&
+	bzr add content &&
+	bzr commit -m one
+	) &&
+
+	bzr branch bzrrepo/trunk bzrrepo/branch &&
+	(
+	cd bzrrepo/branch &&
+	echo two >> content &&
+	bzr commit -m one
+	) &&
+
+	git clone "bzr::$PWD/bzrrepo" gitrepo &&
+	(
+	cd gitrepo &&
+	git for-each-ref --format "%(refname:short)" refs/remotes/origin > ..=
/actual
+	) &&
+
+	test_cmp ../expected actual
 '
=20
 test_expect_success 'strip' '
-  # Do not imitate this style; always chdir inside a subshell instead
-  mkdir -p tmp && cd tmp &&
-  test_when_finished "cd .. && rm -rf tmp" &&
+	# Do not imitate this style; always chdir inside a subshell instead
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
=20
-  (
-  bzr init bzrrepo &&
-  cd bzrrepo &&
+	(
+	bzr init bzrrepo &&
+	cd bzrrepo &&
=20
-  echo one >> content &&
-  bzr add content &&
-  bzr commit -m one &&
+	echo one >> content &&
+	bzr add content &&
+	bzr commit -m one &&
=20
-  echo two >> content &&
-  bzr commit -m two
-  ) &&
+	echo two >> content &&
+	bzr commit -m two
+	) &&
=20
-  git clone "bzr::$PWD/bzrrepo" gitrepo &&
+	git clone "bzr::$PWD/bzrrepo" gitrepo &&
=20
-  (
-  cd bzrrepo &&
-  bzr uncommit --force &&
+	(
+	cd bzrrepo &&
+	bzr uncommit --force &&
=20
-  echo three >> content &&
-  bzr commit -m three &&
+	echo three >> content &&
+	bzr commit -m three &&
=20
-  echo four >> content &&
-  bzr commit -m four &&
-  bzr log --line | sed -e "s/^[0-9][0-9]*: //" > ../expected
-  ) &&
+	echo four >> content &&
+	bzr commit -m four &&
+	bzr log --line | sed -e "s/^[0-9][0-9]*: //" > ../expected
+	) &&
=20
-  (cd gitrepo &&
-  git fetch &&
-  git log --format=3D"%an %ad %s" --date=3Dshort origin/master > ../ac=
tual) &&
+	(cd gitrepo &&
+	git fetch &&
+	git log --format=3D"%an %ad %s" --date=3Dshort origin/master > ../act=
ual) &&
=20
-  test_cmp expected actual
+	test_cmp expected actual
 '
=20
 test_done
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers=
/test-hg.sh
index f8d1f9e..dac3756 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -39,119 +39,119 @@ setup () {
 setup
=20
 test_expect_success 'cloning' '
-  test_when_finished "rm -rf gitrepo*" &&
-
-  (
-  hg init hgrepo &&
-  cd hgrepo &&
-  echo zero > content &&
-  hg add content &&
-  hg commit -m zero
-  ) &&
-
-  git clone "hg::$PWD/hgrepo" gitrepo &&
-  check gitrepo zero master
+	test_when_finished "rm -rf gitrepo*" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo zero > content &&
+	hg add content &&
+	hg commit -m zero
+	) &&
+
+	git clone "hg::$PWD/hgrepo" gitrepo &&
+	check gitrepo zero master
 '
=20
 test_expect_success 'cloning with branches' '
-  test_when_finished "rm -rf gitrepo*" &&
+	test_when_finished "rm -rf gitrepo*" &&
=20
-  (
-  cd hgrepo &&
-  hg branch next &&
-  echo next > content &&
-  hg commit -m next
-  ) &&
+	(
+	cd hgrepo &&
+	hg branch next &&
+	echo next > content &&
+	hg commit -m next
+	) &&
=20
-  git clone "hg::$PWD/hgrepo" gitrepo &&
-  check gitrepo next next &&
+	git clone "hg::$PWD/hgrepo" gitrepo &&
+	check gitrepo next next &&
=20
-  (cd hgrepo && hg checkout default) &&
+	(cd hgrepo && hg checkout default) &&
=20
-  git clone "hg::$PWD/hgrepo" gitrepo2 &&
-  check gitrepo2 zero master
+	git clone "hg::$PWD/hgrepo" gitrepo2 &&
+	check gitrepo2 zero master
 '
=20
 test_expect_success 'cloning with bookmarks' '
-  test_when_finished "rm -rf gitrepo*" &&
-
-  (
-  cd hgrepo &&
-  hg bookmark feature-a &&
-  echo feature-a > content &&
-  hg commit -m feature-a
-  ) &&
+	test_when_finished "rm -rf gitrepo*" &&
=20
-  git clone "hg::$PWD/hgrepo" gitrepo &&
-  check gitrepo feature-a feature-a
+	(
+	cd hgrepo &&
+	hg bookmark feature-a &&
+	echo feature-a > content &&
+	hg commit -m feature-a
+	) &&
+
+	git clone "hg::$PWD/hgrepo" gitrepo &&
+	check gitrepo feature-a feature-a
 '
=20
 test_expect_success 'cloning with detached head' '
-  test_when_finished "rm -rf gitrepo*" &&
+	test_when_finished "rm -rf gitrepo*" &&
=20
-  (
-  cd hgrepo &&
-  hg update -r 0
-  ) &&
+	(
+	cd hgrepo &&
+	hg update -r 0
+	) &&
=20
-  git clone "hg::$PWD/hgrepo" gitrepo &&
-  check gitrepo zero master
+	git clone "hg::$PWD/hgrepo" gitrepo &&
+	check gitrepo zero master
 '
=20
 test_expect_success 'update bookmark' '
-  test_when_finished "rm -rf gitrepo*" &&
-
-  (
-  cd hgrepo &&
-  hg bookmark devel
-  ) &&
-
-  (
-  git clone "hg::$PWD/hgrepo" gitrepo &&
-  cd gitrepo &&
-  git checkout --quiet devel &&
-  echo devel > content &&
-  git commit -a -m devel &&
-  git push --quiet
-  ) &&
-
-  hg -R hgrepo bookmarks | egrep "devel[	 ]+3:"
+	test_when_finished "rm -rf gitrepo*" &&
+
+	(
+	cd hgrepo &&
+	hg bookmark devel
+	) &&
+
+	(
+	git clone "hg::$PWD/hgrepo" gitrepo &&
+	cd gitrepo &&
+	git checkout --quiet devel &&
+	echo devel > content &&
+	git commit -a -m devel &&
+	git push --quiet
+	) &&
+
+	hg -R hgrepo bookmarks | egrep "devel[	 ]+3:"
 '
=20
 author_test () {
-  echo $1 >> content &&
-  hg commit -u "$2" -m "add $1" &&
-  echo "$3" >> ../expected
+	echo $1 >> content &&
+	hg commit -u "$2" -m "add $1" &&
+	echo "$3" >> ../expected
 }
=20
 test_expect_success 'authors' '
-  mkdir -p tmp && cd tmp &&
-  test_when_finished "cd .. && rm -rf tmp" &&
-
-  (
-  hg init hgrepo &&
-  cd hgrepo &&
-
-  touch content &&
-  hg add content &&
-
-  author_test alpha "" "H G Wells <wells@example.com>" &&
-  author_test beta "test" "test <unknown>" &&
-  author_test beta "test <test@example.com> (comment)" "test <test@exa=
mple.com>" &&
-  author_test gamma "<test@example.com>" "Unknown <test@example.com>" =
&&
-  author_test delta "name<test@example.com>" "name <test@example.com>"=
 &&
-  author_test epsilon "name <test@example.com" "name <test@example.com=
>" &&
-  author_test zeta " test " "test <unknown>" &&
-  author_test eta "test < test@example.com >" "test <test@example.com>=
" &&
-  author_test theta "test >test@example.com>" "test <test@example.com>=
" &&
-  author_test iota "test < test <at> example <dot> com>" "test <unknow=
n>" &&
-  author_test kappa "test@example.com" "Unknown <test@example.com>"
-  ) &&
-
-  git clone "hg::$PWD/hgrepo" gitrepo &&
-  git --git-dir=3Dgitrepo/.git log --reverse --format=3D"%an <%ae>" > =
actual &&
-
-  test_cmp expected actual
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+
+	touch content &&
+	hg add content &&
+
+	author_test alpha "" "H G Wells <wells@example.com>" &&
+	author_test beta "test" "test <unknown>" &&
+	author_test beta "test <test@example.com> (comment)" "test <test@exam=
ple.com>" &&
+	author_test gamma "<test@example.com>" "Unknown <test@example.com>" &=
&
+	author_test delta "name<test@example.com>" "name <test@example.com>" =
&&
+	author_test epsilon "name <test@example.com" "name <test@example.com>=
" &&
+	author_test zeta " test " "test <unknown>" &&
+	author_test eta "test < test@example.com >" "test <test@example.com>"=
 &&
+	author_test theta "test >test@example.com>" "test <test@example.com>"=
 &&
+	author_test iota "test < test <at> example <dot> com>" "test <unknown=
>" &&
+	author_test kappa "test@example.com" "Unknown <test@example.com>"
+	) &&
+
+	git clone "hg::$PWD/hgrepo" gitrepo &&
+	git --git-dir=3Dgitrepo/.git log --reverse --format=3D"%an <%ae>" > a=
ctual &&
+
+	test_cmp expected actual
 '
=20
 test_done
--=20
1.8.3.rc3.312.g47657de
