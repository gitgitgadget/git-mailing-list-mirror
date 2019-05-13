Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD9741F461
	for <e@80x24.org>; Mon, 13 May 2019 14:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbfEMOCt (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 10:02:49 -0400
Received: from mout.gmx.net ([212.227.17.20]:58353 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730313AbfEMOCr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 10:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557756162;
        bh=AeAy2FNf0hzb3iywx54h+3JTW3egreVgnLD0OzXGvkE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LKUbR9hd9AhB1KVo21ROAUx9gmJi+AdevdCZRaAYjPBZKp65znn4/cYJwX+SSBwvS
         gY8OGX9+mDks0I0k9j3BNhKv7yRfsNVdl8W2Dpjo/TgOuW7auJSlK3Gg3GLuri6hqU
         69cAOxLzPUUIxtiSkTGsbC9WQ6JBWeyQyAGr1BLU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxUrx-1gSYZv2WID-00xpzs; Mon, 13
 May 2019 16:02:42 +0200
Date:   Mon, 13 May 2019 16:02:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: nd/merge-quit, was Re: What's cooking in git.git (May 2019, #01;
 Thu, 9)
In-Reply-To: <CACsJy8DTErpeoNHUkCieDafnjc3iwg6QKAp2VP-8tUNYh33tJA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905131531000.44@tvgsbejvaqbjf.bet>
References: <xmqqlfzgg8s3.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1905092251200.44@tvgsbejvaqbjf.bet> <CACsJy8DTErpeoNHUkCieDafnjc3iwg6QKAp2VP-8tUNYh33tJA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yF1cErnolHsWTR74ltKRMtLjKZZKUupYqD+iEXtP0kd0gXIaU8O
 gbBwkMyLG2eYvMjbQYv23TBFhXyvOpveheTty2HhAkKhtE/tlH/jJSUo+Apb2t7Hj87Bjf4
 CFL32/tkZpxHI23aqyCI9KpomArayrbOPXzRDZ+aTSpjk0DvuAheall+8gpG38XFw3KSBcx
 63sq/WTYACI6Zf4hOk55A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uatkqaJQKGw=:K7M0YbqAm26QjmSu+Ksak6
 9S/F2nVXPbgSIeMWFfqJzDMYqYPPm81xfvUgOQLuCZYMjDP/DmmxemmspM5s9y4TqMxmNbAhf
 sk9Fch/nQDN8QsyBUKWVQFZuYO5ifSwLuqO815VspDycAfYLnmutXflC73IHdeBECiv4WP4J5
 OpPA7S9z2yV5DVWOmG+NPDJZZTSR9wnB24OLxYhUPF5s9Cva6hffKcdxUcRHX47FrZDfbCmL/
 iYmVCnt57WAN81wVibxgg7kypvP8tRKsQNLN6NaVUa0en2AfrqLT7oSSxgtPNvaC8Y7qy68lp
 c/TJQZ8CpKW0SKbFHPUj0/bJlRkeGnQIH0dSkg7+Su4NP8Nn9eITNpI41yU1ViXeueOGdO9yj
 blsUAq42Uktgd0LeBo8ctnTabvVHdCGRpZLChYtHqN/pWMb3cte9ABrBpV2Ns7O+Yx2mywynp
 U1aFZRmhmTdctWn00ul8TRK7eyHar9iA05JSZNZ8Y13Pfja652FdyEdET9yPJx1raUK9Pjgtc
 B3db/ZmEy4HG6QxexisbIA0AkoxOwiMp9s1/mnOlYmChrwnlYqYIfm7Ug3GwNgYs6Qr6v995z
 JXh1Wey0sYIVGGr233KPOlOFPSF//aRp6iPzgY6+rWKtQj11ZkRCq9XOWYm0qQNozIJY1N1cv
 zBATDZPfyHXWv1flZM20B4gEfWYU+TVJv43gpRsDBWYV2+SnCEYsDI2gOeVXyB8/IonLVk+Rf
 WN3OthKeijT78dUQEKnrrRGGRqzuu5l6fhhC00tp/jYqqXz3wg+tLWHinHQED0HgjivQAbzS/
 luYo9zwy7mh45BJ6JTWLEuT0odS1k6PsGQAjWgcpV5Ph26TBNGAOrcZbMPFX3CMUXdL+0zsd9
 A3LBMdXN/PPAsT15X+MXl/LxWMpz4qjbSYbebI06KGt5HcGcx9bQCWiCbcvSL0843tK82whPX
 lfPllQiaZrQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Fri, 10 May 2019, Duy Nguyen wrote:

> On Fri, May 10, 2019 at 3:54 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi Junio & Duy,
> >
> > On Thu, 9 May 2019, Junio C Hamano wrote:
> >
> > > * nd/merge-quit (2019-05-07) 2 commits
> > >  - merge: add --quit
> > >  - merge: remove drop_save() in favor of remove_merge_branch_state()
> > >
> > >  "git merge" learned "--quit" option that cleans up the in-progress
> > >  merge while leaving the working tree and the index still in a mess.
> > >
> > >  Hmph, why is this a good idea?
> >
> > It also seems to work *only* on Linux. At least the tests break on mac=
OS
> > and on Windows:
> >
> > https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D8313&v=
iew=3Dms.vss-test-web.build-test-results-tab
>
> Sorry I have no idea what the problem is. That's basically the same as
> the 'merge detects mod-256 conflicts (recursive)' test earlier but
> with rerere enabled. It does not even look like some leftover rerere
> records accidentally fix the conflict.
>
> I tried with a case-insensitive filesytem (on linux) and with
> --valgrind, no problem found. Travis on pu seemed ok with t7600 on
> mac.
>
> One difference I notice is the the failed test looks like it found the
> wrong merge base
>
> found 1 common ancestor:
> c4c4222 commit 1
>
> while my tests have "commit 0" as the base. "git log --graph
> --oneline" indicates "commit 1" is the wrong base.
>
> Something is wrong with the merge code (this has not even reached the
> new --quit code). I could change the setup steps to be more stable,
> using a simpler commit history, but this looks like something we
> should find and fix.

Yeah... someone should look at this... Someone. But who?

:-)

Well, since you seemed quite reluctant to figure out why your patches fail
the test suite, and since we're about to enter the -rc0 phase (where we
all spend all of our time to hammer out the next version, right? Right?),
I figured out I better look into it before nobody does.

Turns out that the culprit is not even hard to figure out. All I had to do
is to compare, carefully, the logs from the Azure Pipelines and from a
local run in a local Ubuntu.

It has nothing to do with our merge code. There might be bugs, but this
breakage is safely in this here patch series: the test case you introduced
relies on side effects.

Namely, when test cases 51 and 52 are skipped because of a missing GPG
prerequisite [*1*], and those two are obviously required to run for the
`git merge to fail in your test case, as you can very easily verify by
downloading the artifact containing the `trash directory.t7600-merge`
directory and re-running the last steps on Linux (where the `git -c
rerere.enabled=3Dtrue merge master` *succeeds*).

In fact, you can very, very easily emulate the whole situation on your box
by running:

	sh t7600-merge.sh -i -v -x --run=3D1-50,53-59

And then you can fix your test case so that it does not need to rely on
test cases that may, or may not, have run previously.

Ciao,
Johannes

Footnote *1*: GNU Privacy Guard is not actually missing from Git for
Windows' SDK, quite to the contrary. But it fails to start a gpg-agent due
to the fact that we pass a `--homedir` that contains a colon, something
that is totally expected on Windows, and at the same something that GNU
Privacy Guard totally cannot handle.

