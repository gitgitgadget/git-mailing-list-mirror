Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAB0C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 19:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbiEWTAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 15:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243270AbiEWTAB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 15:00:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C7575230
        for <git@vger.kernel.org>; Mon, 23 May 2022 11:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653331284;
        bh=82jyLKZntrHl0ua2mnaYbiWRN3c3nn5BjW6O14bZ65I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JWco/T1az7xmpQwVzvKL7QWO+2CMt7Fv6AV+7m1SIV8sJOboWhlus1XVXIAtBlpv1
         ijGZHyM0rCFW3tLv01uQN9qFgjDX4bYasKcZhnKo3fXSNcJCVOqEHBJJQm3jg1iXCT
         Q7Jos6rt28P/wMgDeqIe9of7B0QxjNbgkvy+Aj7g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8GMq-1nocVg2oHQ-0148JP; Mon, 23
 May 2022 20:41:24 +0200
Date:   Mon, 23 May 2022 20:41:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 0/9] ci: make Git's GitHub workflow output much more
 helpful
In-Reply-To: <220523.86ee0kzjix.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2205232040130.352@tvgsbejvaqbjf.bet>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com> <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com> <6b83bb83-32b9-20c9-fa02-c1c3170351c3@github.com> <nycvar.QRO.7.76.6.2205212307090.352@tvgsbejvaqbjf.bet> <xmqq35h2cwrm.fsf@gitster.g>
 <220523.86ee0kzjix.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-844986294-1653331284=:352"
X-Provags-ID: V03:K1:JiHmWZ7YL4mLtZ6MSeISoEgmsWtiqSheiIShj4Tp6BwjcYYBVx/
 BEBO67PANFhVX8SF0QkS66GIXK179xdW/aYEW9b2mKEb0jHb84bP2CAivskQF4lXZj292Ih
 xndHQOi4o8MgLxvbLzRxOWS12uHvzYRTXF7gQWQNO8HUNeNr70E/cPdVd2umq1mRy1ktnIF
 P+m8uW6nckBhjrAgCsZCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oryzxyIkm7Y=:Q5zB+2l4yoHWSggw06o2YJ
 Bg6PIjhQo0BmF1n0Azcj1KydZ4uugd62UR1oVKhBuOGBxRyP/qicvQjumXt4kh9OnSehCE1a3
 P+vDY9UEks0iqZdR9zdFkt4TBHqyJ/kZ1/+88fov6Ek4Bg4ameE+PouZGi0g6CiGAwTi0Bl2/
 tFa7EIodjNWSf3SPakS4hEqylEHZoXa8b0wpH8zzCpQGJ7PXw+IdLnO9j1OJ///YrE3ZBEHl2
 AzW/U1PAe14tTo/1nUmIqOECfGKddYY8kl1B6X23UuQppdxrCmftJPwq2o89Pdj7obUV+IImi
 aH/2rzrPNBMCgCF6M2oiYhflaQ7qqwGqyKKjOHTzznEjh3IOCAT0XrneTzGN4GaHAsjXey2WS
 ID1/CNqsqWZi2fnoXSdG8WL9AFvveSyZW5uhpscpCW51JqkQqB9m6Q71KIha+lFzRpOz1DLor
 HvUHTn62bAFzZ+wxrSqchgHhnPCZOr/Xep1JXM9725QQajm+k8ypTiRYasBUDaxzsJr0zyiYt
 0xiV5u4dKM39oExM7KV1YhnAbh5ZfIXoruuEmbyJ6BoNC/j4W5PwKpTMtyIaJpujR66GIEIzy
 oItxtHx4n/ecInmVX31rFecZx/ZQaQhHW8tO3MmODp3tVpPRpfAUFeXB+BavI1K5H4wxoa5De
 0ZfY+JLwYg6Lg4JVNpfI10+lLcPfiDQZRO7xg2NSSspx54Ljza5tMHuyCVNNwlD7/0PUeHr9m
 845KtKVlokqAs7xVm2G0BfImM8FcBfpnTgJnc04/EK4uJWe8YJ8WpHEbJb41Km0/MZhi9FE1f
 R16F6VmddlSoUwOBOoMbOozrojhKNn21uws9vL+HMXKk2aJ42GD8S5gf+OV1D3YEEzAkNLURn
 Rh+D+9AOxzqbLQnvm7FXRRkNhCJl/qXYRYS70lMOByXeScPfIvHMBS7t+e/HoWejMpCoQuTkz
 zbe7/uKdPn7gXj1YsW9HM/Kl4DHIhhdinFPWjE5ZgJoGGQEadPxr17uQ7AzmjX50cH5hycGFh
 1m348xNwy8h3uCDWCLUg7GiUeWU1KIatySFCmnErz/5LmSRepdy5c7++uEbEs7yPTIey0NjyE
 dR6qbTzk1/PuPzaBwmRlvE0f8TUqsMyuLiHoTQDnkBc7cBOz31fkabbdw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-844986294-1653331284=:352
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 23 May 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Re selling point & feature comparison: The point of the ab/* variant was
> to re-roll Johannes's onto a "base" topic that made much of his
> unnecessary, because the building up of features to emit GitHub markup
> can be replaced by unrolling things like "make" and "make test" to the
> top-level.
>
> That has its own UX benefits, e.g. you can see at a glance what command
> was run and what the environment was, and "make" and "make test" are now
> split up from one monolithic "build and test" step.
>
> But the primary intention was not to provide a prettier UX, but to show
> that this arrangement made sense. I was hoping that Johannes would reply
> with some variant of "ah, I see what you mean, that does make things
> simpler!" and run with it, but alas...

I believe that we share the goal to make the Git project more welcoming
and easier to navigate for new contributors.

The patch series you wanted me to look at claims to make the CI/PR
definitions/scripts simpler. As it matters more to contributors how to
investigate test failures, i.e. what information they are provided about
the failures, I disagree that that patch series needs to be connected to
my patch series in any way.

Further, the result does not look like a simplification to me. For
example, I consider it an absolute no-go to remove the remnants of Azure
Pipelines support. As I had hinted, and as you saw on the git-security
list, I require this support for embargoed releases. That=E2=80=99s what I=
 did
when working on the patches that made it into v2.35.2. In my book,
removing such vital (if dormant) code is not a simplification, but a
Chesterton=E2=80=99s Fence. While we do not need to use Azure Pipelines fo=
r our
regular CI, we definitely need it for embargoed releases. =E2=80=9CSimply =
revert
it back=E2=80=9D is not an excuse for removing something that should not b=
e
removed in the first place.

As another example where I have a different concept of what constitutes
=E2=80=9Csimple=E2=80=9D: In Git for Windows=E2=80=99 fork, we carry a pat=
ch that integrates the
`git-subtree` tests into the CI builds. This patch touches two places,
`ci/run-build-and-tests.sh` and `ci/run-test-slice.sh`. These changes
would be inherited by any CI definition that uses the scripts in `ci/`.
With the proposed patches, there are four places to patch, and they are
all limited to the GitHub workflow definition. Since you asked me for my
assessment: this is de-DRYing the code, making it more cumbersome instead
of simpler.

In other words, I have fundamental objections about the approach and about
tying it to the patches that improve the output of Git=E2=80=99s CI/PR run=
s.

> In Chrome/Firefox the time to load the page (as in the spinner stops,
> and we "focus" on the right content) is:
>
>     JS: ~60s / ~80s
>     =C3=86: ~25s / ~18s

My focus is on the experience of occasional and new contributors who need
to investigate test failures in the CI/PR runs. In this thread, we already
discussed the balance between speed of loading the page on the one hand
and how well the reader is guided toward the relevant parts on the other
hand. I disagree with you that the former should be prioritized over the
latter, on the contrary, guiding the readers along a path to success is
much more important than optimizing for a quick page load.

Most contributors who chimed in seemed to not mind a longer page load time
anyway, as long as the result would help them identify quickly what causes
the test failures. Besides, the page load times are only likely to become
better anyway, as GitHub engineers continuously improve Actions.

Ciao,
Dscho

--8323328-844986294-1653331284=:352--
