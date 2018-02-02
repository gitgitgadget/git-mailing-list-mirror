Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 637FC1F404
	for <e@80x24.org>; Fri,  2 Feb 2018 20:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752748AbeBBUyI (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 15:54:08 -0500
Received: from mout.gmx.net ([212.227.15.18]:38477 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752543AbeBBUyD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 15:54:03 -0500
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M6ilI-1etcT832eq-00wYwn; Fri, 02
 Feb 2018 21:52:43 +0100
Date:   Fri, 2 Feb 2018 21:52:39 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Genki Sky <sky@genki.is>
cc:     git@vger.kernel.org, Chris Webb <chris@arachsys.com>,
        Junio C Hamano <gitster@pobox.com>,
        Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] rebase: add --allow-empty-message option
In-Reply-To: <9d0414b869f21f38b81f92ee0619fd76410cbcfc.1517552392.git.sky@genki.is>
Message-ID: <nycvar.QRO.7.76.6.1802022054290.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <9d0414b869f21f38b81f92ee0619fd76410cbcfc.1517552392.git.sky@genki.is>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:guJbKLJ/d83+NbvrsT1jsMTEvY6y5qeTTiwD/ftu3uIZJ4spe1r
 BffyAgRPV2WUvBJiM5f/MOwKV8bxagZwOS9W5kjI64VUZi5pfR3SlT+puEeUKCpsxgk8N1f
 038T4OLjabogKqbJYgdSRWxpFmDrkgo7Zf7B0BcmBLzRR8G3M1Hi/2Cpo5IzO6bL+g0te4E
 qvwvMk0hHqoNHqIRcBaHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XkRofzgU/EE=:Pb0W63yTbCT9I7+R44onDk
 W1Kkwfbg4HrFhHk6+/U/zBn6Xw03izl/WCphZDt8U+rbnXw7ZubXvoDVSjP+CqZx71+Iw9jTp
 4nKWdDV3EncyNRS+xv7g5H7YJYa+FtSp5/5eSOukW3Wp94cDPnxRceBZ3KMrq/5z2vJQ9ysKh
 u+MzS23hRi5/XsjS9CAg4/zJ3ctBplMl5MryaHGB6uT3iubVs4y7rRrNmW8Ct7l4TbjvrKUt3
 4a33orDDBoSgzgbe78/jZLvU3QV1wuXaiDg7Tuq0NlmN8aE/ePTvUYGbJUcFzzaNyuV3CiRmK
 Yrg67nLsb7ev6x+yD22SrLzTKPEQeRXoB8oTZD6K+WlxbdPEh+xkTAui9X3FvdPEVrXuWXhEn
 CGtMS1PNHCME+tqvHLLLnnfKcR02MUIKxd7gQKlIlLYC+Y1LuC6+EoAb7uu/+9xheIvvotYgZ
 my/sJIEhIlbf9kuzqfo4yXGPMWGsg37OWuYUeOpfZuVotaYmPfSinOLq2eVLRe3LMduoJOMQy
 kH9vqUDmCi+Pj++XYHCkT+PlW77sW0TmbVxDrbfCXVgk0wYlon46Kf9bmNart1fFSCkVGhVT6
 6S3QzFLw0a7a3aLcK/fx1BWpp9wEPEj3R5RuL/hBABYLlGC+9m6QoGavSlrIej0cbE8kZw+79
 9mQTGpNUmGP1LMI2hUugwQ5D7z5OnkIkwoW5PVaqckpb1RTwBO9NboYA7rN1VfKQ0cQ8q1Rlt
 Kx7kbBiMTVA8UlE5TEXSR4WAG4PbO7CHbNynQ4WQ5EV3d32856elp4Yv65A/M/mlwnWAr9O0g
 cLROigC5QqagCi1XNq4fmc0lxHBn/4p7KQEUp8HvBknoUXnjRsIyAYG5cGckOb7SnS6BLEQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 2 Feb 2018, Genki Sky wrote:

> --> Motivation

I won't comment on the motivation (leaving that up to the Git maintainer),
but on the patch.

The patch on the shell scripts and the C code looks straight-forward
enough, if a little repetitive (but that is hardly your fault).

> diff --git a/t/t3430-rebase-empty-message.sh b/t/t3430-rebase-empty-message.sh
> new file mode 100755
> index 000000000..74af73f3c
> --- /dev/null
> +++ b/t/t3430-rebase-empty-message.sh
> @@ -0,0 +1,79 @@
> +#!/bin/sh
> +
> +test_description='rebase: option to allow empty commit messages'
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-rebase.sh
> +
> +test_expect_success 'setup: three regular commits' '
> +	test_commit A &&
> +	test_commit B &&
> +	test_commit C
> +'

None of these commits have empty commit messages, which is a little
curious for a 'setup' test case.

> +test_expect_success 'rebase -i "reword" should fail to create an empty commit message' '
> +	set_fake_editor &&
> +	test_must_fail env FAKE_COMMIT_MESSAGE=" " FAKE_LINES="1 reword 2" \
> +		git rebase -i HEAD~2
> +'

Why not make this more focused via

	... FAKE_LINES="reword 1" git rebase -i HEAD^

The effect will be the same because the first pick will be skipped as an
unnecessary pick anyway.

> +test_expect_success '... but should succeed with --allow-empty-message' '
> +	git rebase --abort &&

This should be part of the previous test case:

	test_when_finished "test_might_fail git rebase --abort" &&

Also, I think this test case should be folded into the previous test case
(which would make that test_when_finished suggestion moot).

> +	set_fake_editor &&
> +	FAKE_COMMIT_MESSAGE=" " FAKE_LINES="1 reword 2" \
> +		git rebase -i --allow-empty-message HEAD~2
> +'
> +
> +test_expect_success 'rebase -i "fixup" should fail to fixup an empty commit message' '
> +	test_commit D &&
> +	set_fake_editor &&
> +	test_must_fail env FAKE_LINES="1 fixup 2" git rebase -i HEAD~2
> +'
> +
> +test_expect_success '... but should succeed with --allow-empty-message' '
> +	git rebase --abort &&
> +	FAKE_LINES="1 fixup 2" git rebase -i --allow-empty-message HEAD~2
> +'
> +
> +# The test expects the following rebase to fail. It will only fail if it
> +# actually has to cmd_commit() a new [empty message] commit. However, this
> +# rebase makes no actual changes.

Don't you want to use `--force-rebase` here?

> So if the date does not change in time, it is
> +# possible for it to simply take the original commits exactly as they are.
> +# So, we test_tick() just to be safe.
> +test_expect_success 'rebase --root should fail on an empty commit message' '
> +	test_tick &&
> +	test_must_fail git rebase --root
> +'
> +
> +test_expect_success '... but should succeed with --allow-empty-message' '
> +	git rebase --abort &&
> +	git rebase --root --allow-empty-message
> +'
> +
> +test_expect_success 'setup: multiple branches' '
> +	git checkout -b branch-keep-empty HEAD^1 &&
> +	echo E >E &&
> +	git add E &&
> +	git commit --allow-empty-message -m "" &&
> +	git branch branch-merge
> +'
> +
> +test_expect_success 'rebase --keep-empty should fail on an empty commit message' '
> +	test_must_fail git rebase --keep-empty master branch-keep-empty
> +'
> +
> +test_expect_success '... but should succeed with --allow-empty-message' '
> +	git cherry-pick --abort &&
> +	git rebase --keep-empty --allow-empty-message master branch-keep-empty
> +'

I do not really see why we have to test --keep-empty here. The code paths
overlap with what was tested previously.

> +test_expect_success 'rebase -m should fail on an empty commit message' '
> +	test_must_fail git rebase -m master branch-merge
> +'
> +
> +test_expect_success '... but should succeed with --allow-empty-message' '
> +	git rebase --abort &&
> +	git rebase -m --allow-empty-message master branch-merge
> +'
> +
> +test_done

In general, I would much rather fold the test cases that verify the
behavior with --allow-empty-message into the same test case as verifying
the behavior without --allow-empty-message.

One of my aims in the Git project is to avoid test bloat. I know that
several other active contributors could not care less, and even the Git
maintainer seems to be oblivious to the danger of making a test suite so
unsuitable (both in terms of run-time and in terms of being able to
understand regressions) as to make it less useful. I certainly had painful
discussions on this very mailing list about that, and I still don't feel
heard nor understood.

While your patch certainly is clear enough to make it really easy to
understand regressions, I find that it errs on the side of over-testing.

And this is not an academic consideration. The test suite takes an insane
70-90 minutes *on a fast* Windows machine, even skipping all of the
git-svn tests. That's insane. (And the fact that Git is optimized for
Linux and runs the test suite much faster there is only a very feeble
excuse, if you want my opinion.)

The reason? It's death by a thousand only partially necessary tests.

In that light, I would really like to make at least new tests a lot more
focused, and I would really like it if newly-added tests would be
considerate of the time they take to run, and not only on Linux.

Thank you,
Johannes
