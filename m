Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1698C48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 10:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A14BF60698
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 10:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhFKKce (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 06:32:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:56809 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230230AbhFKKcc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 06:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623407423;
        bh=lzuj546ujX66ufFj4pSrshSIXK85kxmIPcMpBuHNse4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=abFpbcwYAiLD3SYNx4j1UO5lgm+T11OHXQHrOY8efScFTsan9Gw+bANIl1N8/cBq/
         R2E88ctV12lMVZRSAbKNS3+Urn3SSF1XutqWQc/5BS8xNQo0s8X/ZDR8/Ec46Oan8v
         XPkJACxGK39CWoRdjtDljXyUf9NO8AlQuQjUhT+M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.213.18]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Fnj-1lwJFx3lxf-006S1w; Fri, 11
 Jun 2021 12:30:23 +0200
Date:   Fri, 11 Jun 2021 12:30:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Luke Shumaker <lukeshu@lukeshu.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>,
        =?UTF-8?Q?=22=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason=22?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/2] Fix git subtree on Windows
In-Reply-To: <87a6nx6wtv.wl-lukeshu@lukeshu.com>
Message-ID: <nycvar.QRO.7.76.6.2106111224060.57@tvgsbejvaqbjf.bet>
References: <pull.978.git.1623316412.gitgitgadget@gmail.com> <87a6nx6wtv.wl-lukeshu@lukeshu.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2071805135-1623407423=:57"
X-Provags-ID: V03:K1:rfbCY5MTcIm+XGi/gy3/+mUN10CwuqB5ovYjd0SroF7gAXu5VxF
 repJuWrJ/tpu18RkR3ULO85k4lyTMbFveLBAmZEvGQTeVoumzwZ0lJeTy0BPjII3aejQ6l1
 4nJQuT4KusNTP6lgqWJcrrgFYDY5JyBgigOKfXGbClY+rTz7zJhHerB6L7vdE3shf1wpZhn
 /ojII0aGuHjVCVzSZX+DA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NYNhksjwoT0=:ioy6uIuJ7hvdX6HkVUYFv7
 BREkoFjg4uOc+CKsM5rAjgLKry4ZMI2sjnYJPGsljgHitvvi0B7jrBhbbIsyVUQ1YOAkM9tMP
 JWrFBRyCCsqOvbiIqAo6mDA5O4DwNqBgAEG6SUz84LZmLYAhUTsitV3/fundG2x6P7BnAxjT2
 dIhoG0sNbt9+ZL21QlqZzG12/LUtTxxIxrs3hurT24VIwMDVxQ13n4hdlobsXYVrLwh631+0D
 4FOskdydBDCg5nzzzWD/LrTJaLXib6i3VS+b3du08PpwLuf51vzV/cQDYXmto1RzDWSwFMOge
 2nhfvT8FDEtJQlC5yMk5IJMM5ZaC/ET9AgNf7r9QLVSvOPVohSXWl99KNl/xr9VpEEj09bAPL
 eb168ysplgk3XPKusqL9vEc96mIF7W8nizgWy2Nh1WKtELOE6d5BmrEzNd5k4eWEvEVI4YgdF
 V+rjCS3P+EI88ppMwbWPEtFVDseuNtNG0x8GtrbGqzg9gqA8LBonhgGzN7daPJNb/8CjjCHki
 Gz3jDu7+2Y02dc9wIXidRkyNf0uMT44x/lHr0EeFS6SB62DT/XcipuUjWUVwGfioVaE+RB7Jg
 A49lcYZJaselQ9KCgHRUR3i42g81cXTTOQVeCbcwZrXMGo/Fa3GjetfsAbxh67L/i4u0Y5Ecy
 fODdMeasmc0emehZKPc8AIUAhkQJSnnzhNH5gt3HSQztueNuw+7BDPMUFbkeJ+u2Th9943t4f
 VOzrW7eyyKEv/HF3fmaDPAhrAMzywbRfOyPKiVRqjH/bcMZzdIFTaDnicGwvEeN8rrxTDQPc/
 uMPlzmvdtQwZpeV/v0RpZQmod6O6+DGMGhXhK06NnuZJtWcC5i7Y3GPPHN4X4Rxd0Tbi3PAuh
 a6McDTqm1DVDVZ/VGQwO88oUz4ni3R1DAG1b661pRYGW/00YEubZAoABdL/QIGuOOCuSoj+SI
 2vbtCTdd4YUt8i6xdFGj++nJYqTqryKAxNm/tzVE62XQoQfqXMblJvd806HWlWvxkP4FsSHVg
 dfBhbXv6b2sqwwWWSTXFjGMmfkuZatm3H7q/u3SciuKvMrcRz64PFYluC7vr7qGjUCtDizhIY
 SqIzTk9KT/LtVMAAHkTDAcYZ3HGNZHfcxpZrr7BruVapCI21d0PFxgGVQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2071805135-1623407423=:57
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Luke,

On Thu, 10 Jun 2021, Luke Shumaker wrote:

> On Thu, 10 Jun 2021 03:13:29 -0600,
> Johannes Schindelin via GitGitGadget wrote:
> > This particular condition, however, was never tested on Windows,
>
> I was going to say that I do have CI set up[0] to run the subtree
> tests on Windows, and was going to ask for assistance in figuring out
> how to set up CI's Windows to match the behavior that you're seeing
> with Cygwin.
>
> However, upon closer inspection: Because of how run-test-slice.sh
> works, it wasn't actually running the subtree test on Windows.  Oops.

Right, I am sorry about that, it did bite me recently, too.

> Now, that CI setup was just on my personal copies and hadn't been
> submitted upstream, since I wasn't sure if it was welcome[1].  I never
> really got a reply to that part, but but now that we've got buy-in
> from =C3=86var for running the tests in contrib/,[2] I might spend some
> more time on it and try to get that submitted.

I am not so sure about running tests in contrib/ as part of the CI. Those
bits and pieces are in contrib/ to indicate that they should _not_ be
considered as adding to Junio's maintenance burden, and adding them to CI
would contradict that.

Having said that, in _Git for Windows_, we do bundle `git subtree`.
Therefore, I would be interested in running its tests as part of CI
because it is part of _my_ maintenance burden.

As to your 30-strong patch series: Sorry, I really cannot afford even
looking at such a large patch series. There are only 24h in a day, I need
to sleep from time to time, and there is a pandemic raging on, and the Git
mailing list's current atmosphere requires more self-care time from me
that I need to spend elsewhere.

But _if_ I had time to even look at it, I would suggest to first spend
time to turn it into a full-fledged built-in in Git. I.e. move it from
contrib/ to builtin/, rewriting it in C in the process.

Please take that suggestion with a large rock of salt, though: as I said,
I don't have time to assist in that endeavor, unfortunately not even as a
reviewer.

Ciao,
Dscho

>
> [0]: https://github.com/LukeShu/git/commit/359c71be69749621125181b9d8c10=
9baba6bf745
> [1]: https://lore.kernel.org/git/20210426174525.3937858-1-lukeshu@lukesh=
u.com/
> [2]: https://lore.kernel.org/git/87o8d0o2or.fsf@evledraar.gmail.com/
>
> --
> Happy hacking,
> ~ Luke Shumaker
>

--8323328-2071805135-1623407423=:57--
