From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 0/2] Work on t3404 in preparation for rebase--helper
Date: Thu, 12 May 2016 17:43:54 +0200 (CEST)
Message-ID: <cover.1463067811.git.johannes.schindelin@gmx.de>
References: <cover.1462888768.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 17:59:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0t1G-0005Gq-UU
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 17:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbcELP7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 11:59:20 -0400
Received: from mout.gmx.net ([212.227.15.15]:57387 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222AbcELP7R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 11:59:17 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LjrDd-1bcPl62reL-00brEE; Thu, 12 May 2016 17:59:02
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462888768.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Cy6gXvmt7BzZESgMcOt+fPAdhyDwWlfFw1UbaQCOPt5AGcUYhcn
 OHg9lLOtMWQWZA5j8oFZboyyVxhH/IwNigCZtEKE1f+0z3zrBdZ6O7ntaFasIVgtbDmemeJ
 WI/yodhUht+NdO9PEKcVu514KJANwK7ozcq8xb4pll9JZ+iTIBBmWpNRfa5ly+pwob9k7so
 a+Ax5uFsDgDTa1uYMwUuQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/Etgnv58TEE=:n5JXN2p9qA7MQmaymr2Rhw
 0x0YwPdAI++deNShjy+oM8ULo9S66IvwbLaHMIR6MJI4UYhOl1Oxy+ur580EvdfF+y04/K5GM
 FpGVrPjLFm9oc3zL+RRUmrN1mkgYYcEsJ77teukdZusQUjci3DinYtjuJcZXOX4wZoF+cf9JQ
 +ReDDVRtCMc2cnTsNyBoVloK6AZIBZ85YAGk39CfplPvDxWnHEIw7sn8O5hj1Yq7huBmKoZav
 Tpy6UsRAfDBY0pXtx1+bwdUMtjFHodtP1BOsJUYUYDLGU3ZEWXp2TNxStaaC+mxYQDf6lDSUW
 pahagzFeUkDZgtfF93b72etRLzAsOB0utwgWnmcKNjwgc3z8ZIYTFmmsKdMBdZ94zEpDo1yvW
 zTb3oqDxKFXw+wLf/nRhJVkzOtwVaoJHPsFJEx5VyoqI0KwT2VM12Jk/rthkF3Qp+JyN2YIbC
 Z4R6XYrkRdoid7m2aUKHSWuew5Xcly2nsmloDIwRqTYw6WPlnFIeKDrq6LwegJLAt81K7PQiF
 3jKOdEyBZ95X9UtddvRAQr2/jR2jioDaSIz/B4BGcoqLquI+odLqTGunUBZVIRrqWYu4uS99I
 gCJCYUR4GyIL1po5IS/78fSosXBG2yGieDG/+6gfVx1FRa554MDSjEz2ZIrVN1MdWcaau8Ptl
 FDGmJi3eZ4YJ23L5phmthtnqjXl0vq9oDkHv8szeoneJRVzhec5p7SchONJMByKtf4bEqYfF9
 IwQG9Xspd6aNFnRBExOjaQQq3ocXdDwBWfDl1E6LgpR3BrdYIbySdfWcPBWpngEuWuFk16Xp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294412>

This is the first patch series in preparation for a faster interactive
rebase.

It actually only prepares the test script that I mainly used to develop
the rebase--helper, and the resilience against running with -x proved to
be invaluable in keeping my sanity.


Jeff King (1):
  test-lib: set BASH_XTRACEFD automatically

Johannes Schindelin (1):
  t3404: fix typo

 t/README                      |  6 +++---
 t/t3404-rebase-interactive.sh |  2 +-
 t/test-lib.sh                 | 13 +++++++++++++
 3 files changed, 17 insertions(+), 4 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/t3404-fixes-v2
Interdiff vs v1:

 diff --git a/t/README b/t/README
 index 1dc908e..76a0daa 100644
 --- a/t/README
 +++ b/t/README
 @@ -84,9 +84,9 @@ appropriately before running "make".
  
  -x::
  	Turn on shell tracing (i.e., `set -x`) during the tests
 -	themselves. Implies `--verbose`. Note that this can cause
 -	failures in some tests which redirect and test the
 -	output of shell functions. Use with caution.
 +	themselves. Implies `--verbose`. Note that in non-bash shells,
 +	this can cause failures in some tests which redirect and test
 +	the output of shell functions. Use with caution.
  
  -d::
  --debug::
 diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
 index 25f1118..66348f1 100755
 --- a/t/t3404-rebase-interactive.sh
 +++ b/t/t3404-rebase-interactive.sh
 @@ -882,8 +882,7 @@ test_expect_success 'rebase -i --exec without <CMD>' '
  	git reset --hard execute &&
  	set_fake_editor &&
  	test_must_fail git rebase -i --exec 2>tmp &&
 -	sed -e "/option .exec. requires a value/d" -e '/^+/d' \
 -		tmp >actual &&
 +	sed -e "1d" tmp >actual &&
  	test_must_fail git rebase -h >expected &&
  	test_cmp expected actual &&
  	git checkout master
 @@ -1150,6 +1149,10 @@ test_expect_success 'drop' '
  	test A = $(git cat-file commit HEAD^^ | sed -ne \$p)
  '
  
 +cat >expect <<EOF
 +Successfully rebased and updated refs/heads/missing-commit.
 +EOF
 +
  test_expect_success 'rebase -i respects rebase.missingCommitsCheck = ignore' '
  	test_config rebase.missingCommitsCheck ignore &&
  	rebase_setup_and_clean missing-commit &&
 @@ -1157,33 +1160,52 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = ignore' '
  	FAKE_LINES="1 2 3 4" \
  		git rebase -i --root 2>actual &&
  	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
 -	test_i18ngrep \
 -		"Successfully rebased and updated refs/heads/missing-commit." \
 -		actual
 +	test_cmp expect actual
  '
  
 +cat >expect <<EOF
 +Warning: some commits may have been dropped accidentally.
 +Dropped commits (newer to older):
 + - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
 +To avoid this message, use "drop" to explicitly remove a commit.
 +
 +Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
 +The possible behaviours are: ignore, warn, error.
 +
 +Successfully rebased and updated refs/heads/missing-commit.
 +EOF
 +
  test_expect_success 'rebase -i respects rebase.missingCommitsCheck = warn' '
 -	line="$(git rev-list --pretty=oneline --abbrev-commit -1 master)" &&
  	test_config rebase.missingCommitsCheck warn &&
  	rebase_setup_and_clean missing-commit &&
  	set_fake_editor &&
  	FAKE_LINES="1 2 3 4" \
  		git rebase -i --root 2>actual &&
 -	test_i18ngrep "Warning: some commits may have been dropped" actual &&
 -	test_i18ngrep "^ - $line" actual &&
 +	test_cmp expect actual &&
  	test D = $(git cat-file commit HEAD | sed -ne \$p)
  '
  
 +cat >expect <<EOF
 +Warning: some commits may have been dropped accidentally.
 +Dropped commits (newer to older):
 + - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
 + - $(git rev-list --pretty=oneline --abbrev-commit -1 master~2)
 +To avoid this message, use "drop" to explicitly remove a commit.
 +
 +Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
 +The possible behaviours are: ignore, warn, error.
 +
 +You can fix this with 'git rebase --edit-todo'.
 +Or you can abort the rebase with 'git rebase --abort'.
 +EOF
 +
  test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
 -	line1="$(git rev-list --pretty=oneline --abbrev-commit -1 master)" &&
 -	line2="$(git rev-list --pretty=oneline --abbrev-commit -1 master~2)" &&
  	test_config rebase.missingCommitsCheck error &&
  	rebase_setup_and_clean missing-commit &&
  	set_fake_editor &&
  	test_must_fail env FAKE_LINES="1 2 4" \
  		git rebase -i --root 2>actual &&
 -	test_i18ngrep "^ - $line1" actual &&
 -	test_i18ngrep "^ - $line2" actual &&
 +	test_cmp expect actual &&
  	cp .git/rebase-merge/git-rebase-todo.backup \
  		.git/rebase-merge/git-rebase-todo &&
  	FAKE_LINES="1 2 drop 3 4 drop 5" \
 @@ -1193,13 +1215,20 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
  	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
  '
  
 +cat >expect <<EOF
 +Warning: the command isn't recognized in the following line:
 + - badcmd $(git rev-list --oneline -1 master~1)
 +
 +You can fix this with 'git rebase --edit-todo'.
 +Or you can abort the rebase with 'git rebase --abort'.
 +EOF
 +
  test_expect_success 'static check of bad command' '
 -	line=" - badcmd $(git rev-list --oneline -1 master~1)" &&
  	rebase_setup_and_clean bad-cmd &&
  	set_fake_editor &&
  	test_must_fail env FAKE_LINES="1 2 3 bad 4 5" \
  		git rebase -i --root 2>actual &&
 -	test_i18ngrep "^$line" actual &&
 +	test_cmp expect actual &&
  	FAKE_LINES="1 2 3 drop 4 5" git rebase --edit-todo &&
  	git rebase --continue &&
  	test E = $(git cat-file commit HEAD | sed -ne \$p) &&
 @@ -1221,12 +1250,20 @@ test_expect_success 'tabs and spaces are accepted in the todolist' '
  	test E = $(git cat-file commit HEAD | sed -ne \$p)
  '
  
 +cat >expect <<EOF
 +Warning: the SHA-1 is missing or isn't a commit in the following line:
 + - edit XXXXXXX False commit
 +
 +You can fix this with 'git rebase --edit-todo'.
 +Or you can abort the rebase with 'git rebase --abort'.
 +EOF
 +
  test_expect_success 'static check of bad SHA-1' '
  	rebase_setup_and_clean bad-sha &&
  	set_fake_editor &&
  	test_must_fail env FAKE_LINES="1 2 edit fakesha 3 4 5 #" \
  		git rebase -i --root 2>actual &&
 -	test_i18ngrep "^ - edit XXXXXXX False commit" actual &&
 +	test_cmp expect actual &&
  	FAKE_LINES="1 2 4 5 6" git rebase --edit-todo &&
  	git rebase --continue &&
  	test E = $(git cat-file commit HEAD | sed -ne \$p)
 diff --git a/t/test-lib.sh b/t/test-lib.sh
 index 286c5f3..0055ebb 100644
 --- a/t/test-lib.sh
 +++ b/t/test-lib.sh
 @@ -322,6 +322,19 @@ else
  	exec 4>/dev/null 3>/dev/null
  fi
  
 +# Send any "-x" output directly to stderr to avoid polluting tests
 +# which capture stderr. We can do this unconditionally since it
 +# has no effect if tracing isn't turned on.
 +#
 +# Note that this sets up the trace fd as soon as we assign the variable, so it
 +# must come after the creation of descriptor 4 above. Likewise, we must never
 +# unset this, as it has the side effect of closing descriptor 4, which we
 +# use to show verbose tests to the user.
 +#
 +# Note also that we don't need or want to export it. The tracing is local to
 +# this shell, and we would not want to influence any shells we exec.
 +BASH_XTRACEFD=4
 +
  test_failure=0
  test_count=0
  test_fixed=0

-- 
2.8.2.465.gb077790
