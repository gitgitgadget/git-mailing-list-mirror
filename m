Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA1AC388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 14:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5E1422226
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 14:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="c7X/q1c3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgKMOX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 09:23:28 -0500
Received: from mout.gmx.net ([212.227.17.20]:38649 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgKMOX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 09:23:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605277406;
        bh=6gGM9SORECxoc0/S7LCnNyJNgchrvSJwtR+d4sWTnS4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=c7X/q1c3am/ICqJW9l3FiP5JX88wIKQCb64HfVq0aiR/QXEqMl0d7rnJ5biZEgMzr
         g0lo72vVygPxWGEZEGtYqOFjIhkTEy8DYQTSbPczHOUsvfX5Ku/ba7mFPCK34r+Ws1
         CH9JemwEfbxsw5Uy5oiFb0RN4cKgHTeiweaLjXo8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7i8Y-1kGyb93hYY-014o62; Fri, 13
 Nov 2020 15:23:25 +0100
Date:   Fri, 13 Nov 2020 15:22:27 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 00/28] Use main as default branch name
In-Reply-To: <87pn4hfmc4.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011131519170.18437@tvgsbejvaqbjf.bet>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com> <87pn4hfmc4.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-379568793-1605277349=:18437"
X-Provags-ID: V03:K1:nOuF4w/DOIUugID5q73ATiuQu7ITIVPUScFMoHQV7X48S28xBJI
 wLv0OVyJR/G8jfYC1xDrUApR3FPLjVgyBl4vFmjHHu56VmJcrcQe4f95Ddrb4gh7JmrmDRV
 QZf5cEdi1N1VhCpQM2FoL+o5FkFIwuKHsnsP4YVyEdzD33aT4Z3C20uIRzHmqmm4Xh63j2e
 87pQHQpPcIXowGU6/qA5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rbKKuEocllU=:FSwRaNhJC8RtkibUwzRN04
 bscjiHur4JTVxAmrcjRn2HJFUdwHAHsn33rH/q2h7ZUT5N4RF6OoI3T1FrmIQg5SEBLmOpwf2
 senY61yb9oTBWfGTJ6cLF3llN6Q86xglYkt2bT1lwL0D3R6qdEGDSFYbH/OFpuXOW7MKUFBsC
 XTuRuHKx05EpOAtVGTSAvTixMNz7S1pR2tKiHc1snXPBZvjHQB1L5uqyJ8jalm35HeoaZRvpt
 Ird0vfn4AdS9rTJafMrB8+GciE1Mk6EqufNVnuXd5k31BG2WtjWre68kjkU9dByeuMLJwfvX2
 T5EX10SkeGQTQo54KSIX/H7b02nmoeu3vqYXpo/YavJnxdV/v0t6iznKLY5BoYQVdx+TUwK14
 fvuYCPlnyGefWMlbx04SF+z2eEMjD9C6QyrXjkpC4cLWx/hTF601RfRk9fExTgQn4aelh0zzV
 C63lTDUR4vpU/0JlsuGnxGjxxKwSJ4WH1sxm7pLt8YMvu0PZLdf9IGugM7/+0R4NBqAJEz6G6
 YMrY2OgmfkbPEdCh3zZdYSlEXvM8inufpE8gO/0RZQiqqoh33G+AneDc7m4xNDhD08SWQ1DBi
 Kd7fS9tYc44L8CwbD6Lztw4hYKZ3+kMFahiq/V+5eoPVra9s0C81LMbbzZq1GIQc4WpfZXGci
 4ydHyd1vazBKYTJo1wOYUWn2PuhqB7FavhP4ir2LG1SF/T16fTUZbCwLAt8Z2D2S9UJWvlHkD
 mty4yiEh4xmF23VF/42idf6YyGBGKwCNBBB53enXuI2ACHvY8S42t/n4ge6FrDFURUKLo02rd
 rL2RTUry0t6XDuuWjvxuWyvpGDP14ZhitJ68+c9waQKyTFyf4GV2yTriBlRccPWujnvXHHWuH
 z26L36SXRVsaIoZxUGlhBCP/pd+1WTXyTiveblLnk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-379568793-1605277349=:18437
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Fri, 13 Nov 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Nov 12 2020, Johannes Schindelin via GitGitGadget wrote:
>
> > This is the big one. This changes the default of init.defaultBranch to=
 main,
> > reflecting what many open source projects already did (which was follo=
wed by
> > GitHub, Azure Repos and others).
>
> I don't have an issue with the end goal of s/master/main|$whatever/ as
> UX here as noted in previous related review rounds. But I don't think
> this series as it stands is anywhere near ready.
>
> This is 27 patches of s/master/main/ in the tests, followed by making
> the change to the default in refs.c without as much as a single
> documentation update to inform users of the change.

Of course, this is _the one_ patch series mentioned in
https://github.com/gitgitgadget/git/pull/655 that does _not_ link back to
the meta-PR.

So you're right, on its own, these 28 patches do not make sense.

And if you split off the 28th patch, the remaining 27 patches make even
less sense.

The reason why I partitioned the changes this way was that it is a _ton_
of patches to review, and in many ways, these 28 patches are the most
important ones to review (I didn't want to just rely on the CI builds
passing, I reviewed those patches carefully, multiple times, to make sure
that they made sense in the goal to transition to `main`).

I will respond to the rest of your concerns later,
Dscho

>
> I don't see the point in doing these sorts of test suite changes, it
> just seems like needless churn. But I have not read the whole backlog of
> previous iterations of this & related patches, so bear with me.
>
> Why not instead do what we did when we added protocol v2 to the tests,
> e.g. in 8a1b0978ab ("test: request GIT_TEST_PROTOCOL_VERSION=3D0 when
> appropriate", 2019-12-23) we simply set the t5515 test to always run
> with protocol v1. If you'd do this:
>
>     diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logi=
c.sh
>     index 70a9d2d8ab..939c8b2f83 100755
>     --- a/t/t5515-fetch-merge-logic.sh
>     +++ b/t/t5515-fetch-merge-logic.sh
>     @@ -11,6 +11,9 @@ test_description=3D'Merge logic in fetch'
>      GIT_TEST_PROTOCOL_VERSION=3D0
>      export GIT_TEST_PROTOCOL_VERSION
>
>     +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmaster
>     +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>     +
>      . ./test-lib.sh
>
>      build_script () {
>
> Of course that also needs:
>
>     index fa347ed3e1..2d700a171b 100644
>     --- a/t/test-lib.sh
>     +++ b/t/test-lib.sh
>     @@ -1711,10 +1711,8 @@ test_lazy_prereq SHA1 '
>      test_lazy_prereq REBASE_P '
>      	test -z "$GIT_TEST_SKIP_REBASE_P"
>      '
>     -# Special-purpose prereq for transitioning to a new default branch =
name:
>     -# Some tests need more than just a mindless (case-preserving) s/mas=
ter/main/g
>     -# replacement. The non-trivial adjustments are guarded behind this
>     -# prerequisite, acting kind of as a feature flag
>     -test_lazy_prereq PREPARE_FOR_MAIN_BRANCH '
>     -	test "$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME" =3D main
>     +
>     +test_lazy_prereq MAIN_BRANCH_IS_MASTER '
>     +	test -z "$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME" ||
>     +	test "$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME" =3D "master"
>      '
>
> Because (but see "later" a few paragraphs later), the logic as it stands
> on "master" is entirely backwards & broken. I.e. if you don't set
> GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME or set it to "master" we now skip a
> bunch of tests ... which only work if the value is "master". If you set
> it to "main" they'll break.
>
> Then instead of ending up with a hardcoding of "main" we'd be able to
> run the tests with a new custom branch name (even one with whitespace in
> it). That coverage is plenty to test any branch name hardcoding.
>
> The remaining tests that would still have "master" would then just be
> dealt with by the same thing we did for the too-protocol-v1-specific
> tests, i.e.:
>
>     diff --git a/t/t3502-cherry-pick-merge.sh b/t/t3502-cherry-pick-merg=
e.sh
>     index 8b635a196d..354f9bd851 100755
>     --- a/t/t3502-cherry-pick-merge.sh
>     +++ b/t/t3502-cherry-pick-merge.sh
>     @@ -8,6 +8,8 @@ test_description=3D'cherry picking and reverting a m=
erge
>
>      '
>
>     +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmaster
>     +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>      . ./test-lib.sh
>
>      test_expect_success setup '
>
> Except unlike protocol v1/v2 we're really not gaining anything in
> coverage by going further, it's not the point of any of these tests to
> test for the default branch name. It's a *lot* of churn,
>
> "Later": After writing the above I see from 704fed9ea2 ("tests: start
> moving to a different default main branch name", 2020-10-23) that this
> state of affairs is intentional. But doesn't discuss why the more usual
> (because we've done it that way a few times before) v1/v2-esque
> transition wasn't done instead.
>
> Doing it the other way still seems better. We're now not running our
> full tests in anticipation for this series landing on "master", and
> after applying this we're still not running all of them.
>
> Anyway, enough with discussing this detail of the test suite churn. My
> main objection to this version of it is:
>
> After this series as it stands lands what's a rather big UI change in
> git isn't discussed *anywhere* in the docs.
>
> I'm not saying we need some similar s/master/main/g in Documentation/ as
> what's being done here in t/, but I think a bare minimum for a rather
> big UI change like this is:
>
>  1) Let's at least talk about it in some way in git-init(1), i.e. that
>     it used to be "master" before version so-and-so and is now
>     different. With this series applied we still say:
>
>     Documentation/git-init.txt:If not specified, fall back to the defaul=
t name: `master`.
>
>  2) Ditto in the init.defaultBranch and things like that
>
>  3) After all this effort at eliminating "master" entirely in the tests
>     we're still shipping a sample hook that expects "master" on "git
>     init", and breaks now that it's "main"
>
> And maybe stuff like:
>
>  4) Have "git init" emit some new advice message saying that the default
>     has changed and we've init-ed a new repo with a "main" branch.
>
> Our primary concern should be the vast majority of users who don't
> follow this topic on Twitter, don't read this mailing list, and are just
> going to waste 10 minutes of their day because some script they've had
> working for years using "git init" did something unexpected.
>
> Let's at least aim to make that 5 minutes instead by making the change
> more discoverable.
>

--8323328-379568793-1605277349=:18437--
