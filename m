Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AD121F453
	for <e@80x24.org>; Wed, 30 Jan 2019 13:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbfA3NMj (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 08:12:39 -0500
Received: from mout.gmx.net ([212.227.15.19]:58937 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfA3NMj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 08:12:39 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lpspj-1hKt5c1HQF-00fhiA; Wed, 30
 Jan 2019 14:12:31 +0100
Date:   Wed, 30 Jan 2019 14:12:15 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH (Apple Git) 03/13] t0500: New regression test for git
 add of a path that contains a .git directory
In-Reply-To: <20190129193818.8645-4-jeremyhu@apple.com>
Message-ID: <nycvar.QRO.7.76.6.1901301355140.41@tvgsbejvaqbjf.bet>
References: <20190129193818.8645-1-jeremyhu@apple.com> <20190129193818.8645-4-jeremyhu@apple.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:R/JQqk3Ww1RaQABYofu1hTgZ79/NcMJjm8kUPo+zw18MS8XPRa2
 2SRGd0njLti+QYh0DGWag0UGV+5wgTgBdFL//uFaR7OGL5Cekbe0bv0sEa2v9OQwgJ5d92e
 c97yzRtVF5sFSCG+22aPZ5qq2+6/gYM+kQ9L2teAWejnpZY1r6djSJ81n390IfK3N0wPcCo
 P/mriMBO8obcapcOlQF+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+R7lg9wfd6k=:EwaMv+3EkfZ9A5Zv5Z5arL
 mrOwp539utqOXDOcQl17jdJw98XrITwmWrnKqs2yjEGlSmnRLsYjnpy6VAEcnr5oXf0Vz9kv8
 z+jplWzyKKMpdpLFfueRsfOsJJl+IkwfOd0rQ2wI9NkA8O40wjuS+fmuSJcviooSAe8YUWRPZ
 jinvDU7QRj/EM7+gxF5RNd5VTQN4cSh8eaUf+U6UAd5HhG0PTmMcGIvpBsQCHN4iHDE/LO1nb
 Odhgwj8TR0oiGWVZvJXxYJUJYabn0XMrllorA/r4Jl/WgmoxW5eDpy43209N6uiwhcdaNBTFq
 LjNNS9HoU6bZCskq+hzIu5nC+fYBnQXfARRbBVJjwT0xve0bWk1rk3OmC64Poa7mQG8JhYOsG
 L4n3MKOaJ7+LX4tw9enSrecMEIlANvMRzYjcHzgaaoXQoKcJ+iWcJXYcvWyZ6GZsbIClmAJ7f
 5JtZaYKaJk4FfM3OCZneAcil/YFEdfUS097MTb6BGxDExkxYy7cAg9gNCK9pQMlF4iq/fhptk
 3rLFHND/z/C5yYSTwPistCWOswPY4rihhQdIB0gG1Gg1liUyLOLk5PxKRhD/ztfC8JPMWcy6v
 gkpb0J1H37DN/srcrxE5znUR0QnC7lryYo5hjQB763DG5ju1G1tDkEfR+GOosAxDLTk+lpItO
 PcNGLvmZTPJJ/4qtpKzQWD+Jzu3bjcHxjDqEmy/sLkHTNsoxn8X/fSRa2n9jDncohK8rVqcSc
 KkNfyBQsw6KX1g2/vK7FXVYTgF+u7O2Hj3lv5D+lAfoycVmkzxUdYcWq66cqLcCv8cqse7lIZ
 wLTYYm1WQ6WE/blthjI4aTXjAKLsdMuxS8/+60YJ3MK3Dsdrf4qM78bPyTah0iVjoSmo3ct3l
 uzkXyF02tgaz+zt79iVDgtbjK3qYExDnnA7qT4RyPf1sfvUKZ8yadU7m0I0UPEctatt40m8KA
 iTL7znUlr3g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeremy,

On Tue, 29 Jan 2019, Jeremy Huddleston Sequoia wrote:

> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>

As Eric pointed out, commits with such a vanishing commit message are
very, very sad commits. And somewhere, a kitten dies every time you submit
such a commit.

> +test_expect_success '<rdar://problem/10238070> -- git add of a path that contains a .git directory' '
> +	rm -rf .git &&
> +	mkdir -p orig/sub/dir/otherdir &&
> +	cd orig/sub &&
> +	echo "1" > dir/file &&
> +	echo "2" > dir/otherdir/file &&
> +	git init --quiet &&
> +	git add -A &&
> +	git commit -m "Initial Commit" --quiet &&
> +	cd - > /dev/null &&
> +	git init --bare --quiet "${TESTROOT}/git_dir.git" &&
> +	git --git-dir="${TESTROOT}/git_dir.git" --work-tree=/ add -f -- "${TESTROOT}/orig/sub/" &&
> +	git --git-dir="${TESTROOT}/git_dir.git" --work-tree=/ add -f -- "${TESTROOT}/orig/" &&
> +	git --git-dir="${TESTROOT}/git_dir.git" --work-tree=/ commit -m "Commit." |
> +		grep -q "2 files changed, 2 insertions"
> +'

Let's try to waste some time and reverse engineer what this test is about,
shall we?

So first the .git directory is removed. I really have to wonder why
because we seem to do pretty much everything after that outside of that
directory, so I bet that the test would do the exact same thing without
mucking with that .git directory.

The some submodule with nested directories is set up (we could do this
much easier by using `mkdir orig && git init orig/sub && test_commit -C
orig/sub 1 && mkdir orig/sub/dir & test_commit -C orig/sub dir/2`, but
let's look further before suggesting a better way to implement this).

Then a bare directory is created *somewhere*, and then the submodule as
well as its parent directory is added.

Finally, a commit is created with that new index.

So is the problem that this test tries to catch that a directory
containing a submodule is added together with its .git directory?

I could understand that, I would understand that you would add a
regression test to catch this, but since it is added with
`test_expect_success`, I would expect this regression to be fixed for a
long time (and probably be committed together with a regression test that
verifies the very same as your new test).

Okay, so I give up on analyzing this further and simply go back to the
indicated commit introducing the regression, and applying your patch on
top, to see whether it fails. Because there is nothing Apple-specific
about it, I'll do this in an Ubuntu VM (because I have no Apple hardware
handy, so the only way for me to debug this on macOS would be via Azure
Pipelines, which is tedious and slow).

But no, this test fails with or without 18e051a3981f (setup: translate
symlinks in filename when using absolute paths, 2010-12-27) reverted.

So the ball is squarely back in your court: care to explain what the
haggling heck your patch is trying to achieve?

Thanks,
Johannes

> +
> +test_done
> -- 
> 2.20.0 (Apple Git-115)
> 
> 
