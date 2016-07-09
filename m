Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6CA42018E
	for <e@80x24.org>; Sat,  9 Jul 2016 14:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbcGIObU (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 10:31:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:54314 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752076AbcGIObT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 10:31:19 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MOwY7-1bRga047XT-006MlG; Sat, 09 Jul 2016 16:31:12
 +0200
Date:	Sat, 9 Jul 2016 16:31:11 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Duy Nguyen <pclouds@gmail.com>
cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: reflogs and worktrees?
In-Reply-To: <CACsJy8A=_0RfMsDkqyeyro3Xw3NbS4qU0bkVAkapky52jphH7w@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607091626270.6426@virtualbox>
References: <alpine.DEB.2.20.1607051704490.8378@virtualbox> <CACsJy8A=_0RfMsDkqyeyro3Xw3NbS4qU0bkVAkapky52jphH7w@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:c+vrAzoZmr8BCTUtX3Rfme1bbLGHXForJzuAUjAL7xlfU3Q9QtB
 y2p3gn1zRlsj92OGCgOE1hbJbLpj7I/OeqwBO61yVEW3VY0D2DqOgm0II8BWdDtkFgdvm8w
 ul30a43PjjpRbX3lubEUEzaeX9Ge+Rb8i96g9UdTvYNbSow+uJJuvtWWgFEsELpl1m5w2sT
 2+P4z8hIqDJcWhpg0Ln6Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:ygdCAn9zFso=:um88xhbiNdYE5y5fmMHUNp
 AkOnxo8DzPHkBuNxneIrdtB0xi4S2mgxtoEftjfEOLYwqqYaUy0bUyuZJbajp0UoemZ28JwAH
 /jjf+h9rqJW9XzgPGK9JmnJea9MlFI8PChtHSnPGVzS7Cfh8uHWZJ3SUWyxq+P4QzWF0tIqH9
 ZboC/AJOjnU0CviJN9mQmlpaEQQCVCM3nnbCzRyVOywZFxbFHKzWm+p36nGqPYqzNeeDFx66N
 sso0qqX1VQzLrQWe1IlM46/2xhA8HY9EO05/O+/Izwy+IEHByQeFZSxwVWlt1sfHETLI+4zic
 6w1uVS2hP1SG3ZyBRNF5fNGyEr/ZdZl8bJYtdPtDAoh2GVcSd+C+xqxZLQu1DhjeqSg4UsD79
 r0+dn5yTWq38V/HKvnBP+CGOBP9ntmUH3wTTfey0BJUrNhz9dOuL3d4howHNl1C0q694mzNcp
 9tTWfM2dLoFD2qhhWhrvGlzcM2Wxj3R318uEFKFD3u3R/q2rF8Wqhw8ogm8HvJK4z+uE8+1nD
 OQPbvCRae+LANSJJgYSb6tA9w9mf4CLYe2LGfhefEHGLw48gP7lOj65D3O+f1yygpvG+lvgTE
 68xBvIKavAYl/DZs3Yl4q4xb3HdIpIO9C0j3MkfasPKggPFdOWWAexCyWT2tTFaoYOZ1Yw2nN
 PtMo/mnRliraujgrrVXIkS2JCYn5WSLlNxfqyLR5zNUYjIalS+nQB/gMQ2hfclzkf6wEd+Rhi
 HEEod1wd9lK/5u+Z2A8PR5oN7KuF4DQJPVdiKpJGO7frJMeNbO31BJQvsCN9bGLlViIiSC+zg
 L1SZU4A
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Duy,

On Tue, 5 Jul 2016, Duy Nguyen wrote:

> On Tue, Jul 5, 2016 at 5:07 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi Duy,
> >
> > ever since I started working extensively with worktrees, I end up with
> > these funny gc problems, like broken links and stale reflogs.
> 
> Yeah we have problem with gc not traversing all worktree refs.

That is a bit of an understatement.

I get tons of errors like this one, just from the regular auto gc:

error: Could not read 296ee31af712b02469c4bb606fbf2fac229bcca6
fatal: Failed to traverse parents of commit 3c22e84e2ccdec5d8243344fc4ec68942b87a393
error: failed to run repack

I still have to address all of them, in particular because we do not (yet)
have tools to identify how certain objects are expected to be reachable
when they are missing (see my `gc-worktree` branch for my current progress
of teaching git-fsck to describe the broken links better).

For the moment, I am working around this problem with the following hook
(wrapped into a unit test to verify that it does what I expect it to do):

-- snipsnap --
Subject: [PATCH] Demonstrate a workaround for the worktree/gc problem

When gc --auto is called in the presence of worktrees, pretty much all of
the reflogs go to hell.

In the --auto case, we can install a hook that runs before-hand,
accumulates all the worktree-specific refs and reflogs and installs them
into a very special reflog in the common refs namespace. The only purpose
of this stunt is to let gc pick up on those refs and reflogs, of course,
and *not* ignore them.

Unfortunately, this still does not address the "git gc" case, but
hopefully a real fix will be here some time soon.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6500-gc.sh | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 5d7d414..518e809 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -43,4 +43,67 @@ test_expect_success 'gc is not aborted due to a stale symref' '
 	)
 '
 
+test_expect_success 'install pre-auto-gc hook for worktrees' '
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/pre-auto-gc <<-\EOF
+	echo "Preserving refs/reflogs of worktrees" >&2 &&
+	dir="$(git rev-parse --git-common-dir)" &&
+	refsdir="$dir/logs/refs" &&
+	rm -f "$refsdir"/preserve &&
+	ident="$(GIT_COMMITTER_DATE= git var GIT_COMMITTER_IDENT)" &&
+	(
+		find "$dir"/logs "$dir"/worktrees/*/logs \
+			-type f -exec cat {} \; |
+		cut -d" " -f1
+		find "$dir"/HEAD "$dir"/worktrees/*/HEAD "$dir"/refs \
+			"$dir"/worktrees/*/refs -type f -exec cat {} \; |
+		grep -v "/^ref:/"
+	) 2>/dev/null |
+	sort |
+	uniq |
+	sed "s/.*/& & $ident	dummy/" >"$dir"/preserve &&
+	mkdir -p "$refsdir" &&
+	mv "$dir"/preserve "$refsdir"/
+	EOF
+'
+
+trigger_auto_gc () {
+	# This is unfortunately very, very ugly
+	gdir="$(git rev-parse --git-common-dir)" &&
+	mkdir -p "$gdir"/objects/17 &&
+	touch "$gdir"/objects/17/17171717171717171717171717171717171717 &&
+	touch "$gdir"/objects/17/17171717171717171717171717171717171718 &&
+	git -c gc.auto=1 -c gc.pruneexpire=now -c gc.autodetach=0 gc --auto
+}
+
+test_expect_success 'gc respects refs/reflogs in all worktrees' '
+	test_commit something &&
+	git worktree add worktree &&
+	(
+		cd worktree &&
+		git checkout --detach &&
+		echo 1 >something.t &&
+		test_tick &&
+		git commit -m worktree-reflog something.t &&
+		git rev-parse --verify HEAD >../commit-reflog &&
+		echo 2 >something.t &&
+		test_tick &&
+		git commit -m worktree-ref something.t &&
+		git rev-parse --verify HEAD >../commit-ref
+	) &&
+	trigger_auto_gc &&
+	git rev-parse --verify $(cat commit-ref)^{commit} &&
+	git rev-parse --verify $(cat commit-reflog)^{commit} &&
+
+	# Now, add a reflog in the top-level dir and verify that `git gc` in
+	# the worktree does not purge that
+	git checkout --detach &&
+	echo 3 >something.t &&
+	test_tick &&
+	git commit -m commondir-reflog something.t &&
+	git rev-parse --verify HEAD >commondir-reflog &&
+	(cd worktree && trigger_auto_gc) &&
+	git rev-parse --verify $(cat commondir-reflog)^{commit}
+'
+
 test_done
-- 
2.9.0.278.g1caae67

