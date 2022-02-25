Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F9DC433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 14:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239097AbiBYOLe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 09:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiBYOLb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 09:11:31 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86671DD0FD
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 06:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645798248;
        bh=gcGMFfsWMUmmeBYhdQD72cZefpbdlAq7tF/pw5pIcTs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HmT+nnNDCr1HyOhydWm1CSEqBSr3XuVlmYTCbNd9mrfu6sEzEi3Cs4qSkakX+HFEW
         GLf+xshPESyFhsKt3XAzfsMyk8Z+xenwbEdiRyKvHS1Y4UIu1w0OB7SFpcUGyLyfkk
         Kfd4Q+Kr+38lTn25S8mdEWvA2EBgb4ROnV4tjB1U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV67y-1npY0X3pe2-00SAiB; Fri, 25
 Feb 2022 15:10:48 +0100
Date:   Fri, 25 Feb 2022 15:10:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
In-Reply-To: <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202251440330.11118@tvgsbejvaqbjf.bet>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet> <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com> <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet> <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>
 <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1606598083-1645798248=:11118"
X-Provags-ID: V03:K1:krliRaVK/dEmQKRLB/eU4KrXUy0jNoVPehOwEc5oZA19gd9kFUW
 +B6oE25r0YNOHrE6DuhSZeCg5az+o+nWTUloN9v45zi1wPtmUq6NC/pOSJzAvnclTFmIHoI
 EMxqEbWyfS2XQQ9tTnbAqqA54Q56qq2ksJyNaqE6y2fhldpnbQ/qpioMU1xX5BlFkkhlK3w
 2dyyn6oxTYFKGsmRzOHxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pgvsb1Jwl3w=:/M6hmYIPktamLz4a6bAl9y
 nJOKQbAhS317hYPdEmsTQCbRsh61oJ00uu1Mlkco63sheuYx4baZu7Ut67WEJ4PI+oJNDQF2g
 PvX2RRtUpvbKFinUgD//gul4pvanEfL+tk8Iw8ZbEJHBhWNay1hDNKtxrJU+Hf8OUwuNwNVed
 BRJWT5wZGdIm3qaY4cRzpoY0g87yiQvk9Y1fmeeQr3HylvzVnVbx740GIJJUE613xfb7iPABw
 uQUiDIkU/QsTrR/9O1v82JObXWnZjiKXYdtSfEpqstfsT82KzOGAkJLgvWbWaoMM3KZy4oQSe
 qAV67hXgAj73JgKX1E6VPJpd1slVjDSYevJWu/FO3TI3rxsNpLNBTbRDeq1RHr04S7VZeETPG
 GpZS7CSMMAGNXLyxo89ilul7JS6S13km2K6h50NIPF2AJ/nKXAzNdYCeHKTD9Wpz8VqyKlMQy
 or7yo8Wd1PHjud7Cus8+/mGNxeAtct/aW6GU/3Xnk8i1qdsabhrpU2ws0UMSW7DMUFrpS7lo0
 DwVqIVHbdPyzSuGUVxRLccSbTtG0Rl8g2f6JnmSDFJ9U1lnI72xPUt3J0UIr8Yg+kV5SrcXvd
 H7JPSuuDVODZuZp4X4yUv+8mAsQ0RITF1WWxrl8QL2OjSw5ve+STsA+Tw6HXZplodq+dGFxCP
 QTIm99l8JkVRgqi15pQoH04uRRZ6u9EIhCMhTszGckfTSNTFZ/LVsJgooeQ7anoD58Fks7uWQ
 pefXzsiXdGtOFSIOfC3iAeMJknBIuh5a7syH+Hpz5Fehr/IWhT6kUSSnhVfV3gkssvUWV0SA7
 wlNK2UAYeQ2V9C+R3NjV58AHqV41+KuLF3012LvEJ45apDakzCfj+oOp0qY89pHndAkmt5oVf
 qfX3LvAqOe2Al8G0udz7GlDIwXpRt6im02vv8zLnlzxotjaNQcP/+LvOpG9vRVcJisiuliNcc
 a117HAOVfCnY4h/dQzbIkCw+a2VJJ97++ACrLioj9YhR0VDYUejfIG0JryetL92iLWflOx24t
 WKvBL8WFaagRk4X2q+lJ6I3YKi9MpnBfyk5TSZK30xq3twOxVDu9zpWCdeIs0veTfYhTdNgb+
 80gN4MBUCh2IL3c+sCw1S/M/AC9/JQOiPpD
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1606598083-1645798248=:11118
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Wed, 23 Feb 2022, Phillip Wood wrote:

> On 22/02/2022 13:31, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > [...]
> > So just to make the point about one of those mentioned in my [1] with
> > some further details (I won't go into the whole thing to avoid repeati=
ng
> > myself):
> >
> > I opened both of:
> >
> > https://github.com/git-for-windows/git/runs/4822802185?check_suite_foc=
us=3Dtrue
> > https://github.com/dscho/git/runs/4840190622?check_suite_focus=3Dtrue
> >
> > Just now in Firefox 91.5.0esr-1. Both having been opened before, so
> > they're in cache, and I've got a current 40MB/s real downlink speed et=
c.
> >
> > The former fully loads in around 5100ms, with your series here that's
> > just short of 18000ms.
> >
> > So your CI changes are making the common case of just looking at a CI
> > failure more than **3x as slow as before**.
>
> I don't think that is the most useful comparison between the two. When I
> am investigating a test failure the time that matters to me is the time
> it takes to display the output of the failing test case.

Thank you for expressing this so clearly. I will adopt a variation of this
phrasing in my commit message, if you don't mind?

> With the first link above the initial page load is faster but to get to
> the output of the failing test case I have click on "Run
> ci/print_test_failures.sh" then wait for that to load and then search
> for "not ok" to actually get to the information I'm after.

And that's only because you are familiar with what you have to do.

Any new contributor would be stuck with the information presented on the
initial load, without any indication that more information _is_ available,
just hidden away in the next step's log (which is marked as "succeeding",
therefore misleading the inclined reader into thinking that this cannot
potentially contain any information pertinent to the _failure_ that needs
to be investigated).

> With the second link the initial page load does feel slower but then I'm
> presented with the test failures nicely highlighted in red, all I have
> to do is click on one and I've got the information I'm after.
>
> Overall that is much faster and easier to use.

Thank you for your comment. I really started to doubt myself, getting the
idea that it's just a case of me holding this thing wrong.

For what it's worth, I did make a grave mistake by using that particular
`seen` CI failure with all of those failing p4 tests, which obviously
resulted in an incredibly large amount of logs. Obviously that _must_ be
slow to load. I just did not have the time to fabricate a CI failure.

However, I do agree with you that the large amount of logs would have to
be looked at _anyway_, whether it is shown upon loading the job's logs or
only when expanding the `print-test-failures` step's logs. The amount of
the logs is a constant, after all, I did not change anything there (nor
would I).

So a better example might be my concrete use case yesterday: the CI build
of `seen` failed. Here is the link to the regular output:

	https://github.com/git/git/actions/runs/1890665968

On that page, you see the following:


	Annotations
	8 errors and 1 warning

	=E2=93=A7 win test (3)
	  Process completed with exit code 2.

	=E2=93=A7 win test (6)
	  Process completed with exit code 2.

	=E2=93=A7 win test (2)
	  Process completed with exit code 2.

	=E2=93=A7 win+VS test (3)
	  Process completed with exit code 2.

	=E2=93=A7 win+VS test (6)
	  Process completed with exit code 2.

	=E2=93=A7 win+VS test (2)
	  Process completed with exit code 2.

	=E2=93=A7 osx-gcc (macos-latest)
	  Process completed with exit code 2.

	=E2=93=A7 osx-clang (macos-latest)
	  Process completed with exit code 2.

	=E2=9A=A0 CI: .github#L1
	  windows-latest workflows now use windows-2022. For more details, see ht=
tps://github.com/actions/virtual-environments/issues/4856

So I merged my branch into `seen` and pushed it. The corresponding run can
be seen here:

	https://github.com/dscho/git/actions/runs/1892982393

On that page, you see the following:

	Annotations
	50 errors and 1 warning

	=E2=93=A7 win test (3)
	  failed: t7527.1 explicit daemon start and stop

	=E2=93=A7 win test (3)
	  failed: t7527.2 implicit daemon start

	=E2=93=A7 win test (3)
	  failed: t7527.3 implicit daemon stop (delete .git)

	=E2=93=A7 win test (3)
	  failed: t7527.4 implicit daemon stop (rename .git)

	=E2=93=A7 win test (3)
	  failed: t7527.5 implicit daemon stop (rename GIT~1)

	=E2=93=A7 win test (3)
	  failed: t7527.6 implicit daemon stop (rename GIT~2)

	=E2=93=A7 win test (3)
	  failed: t7527.8 cannot start multiple daemons

	=E2=93=A7 win test (3)
	  failed: t7527.10 update-index implicitly starts daemon

	=E2=93=A7 win test (3)
	  failed: t7527.11 status implicitly starts daemon

	=E2=93=A7 win test (3)
	  failed: t7527.12 edit some files

	=E2=93=A7 win test (2)
	  failed: t0012.81 fsmonitor--daemon can handle -h

	=E2=93=A7 win test (2)
	  Process completed with exit code 1.

	=E2=93=A7 win test (6)
	  failed: t7519.2 run fsmonitor-daemon in bare repo

	=E2=93=A7 win test (6)
	  failed: t7519.3 run fsmonitor-daemon in virtual repo

	=E2=93=A7 win test (6)
	  Process completed with exit code 1.

	=E2=93=A7 win+VS test (3)
	  failed: t7527.1 explicit daemon start and stop

	=E2=93=A7 win+VS test (3)
	  failed: t7527.2 implicit daemon start

	=E2=93=A7 win+VS test (3)
	  failed: t7527.3 implicit daemon stop (delete .git)

	=E2=93=A7 win+VS test (3)
	  failed: t7527.4 implicit daemon stop (rename .git)

	=E2=93=A7 win+VS test (3)
	  failed: t7527.5 implicit daemon stop (rename GIT~1)

	=E2=93=A7 win+VS test (3)
	  failed: t7527.6 implicit daemon stop (rename GIT~2)

	=E2=93=A7 win+VS test (3)
	  failed: t7527.8 cannot start multiple daemons

	=E2=93=A7 win+VS test (3)
	  failed: t7527.10 update-index implicitly starts daemon

	=E2=93=A7 win+VS test (3)
	  failed: t7527.11 status implicitly starts daemon

	=E2=93=A7 win+VS test (3)
	  failed: t7527.12 edit some files

	=E2=93=A7 win+VS test (2)
	  failed: t0012.81 fsmonitor--daemon can handle -h

	=E2=93=A7 win+VS test (2)
	  Process completed with exit code 1.

	=E2=93=A7 win+VS test (6)
	  failed: t7519.2 run fsmonitor-daemon in bare repo

	=E2=93=A7 win+VS test (6)
	  failed: t7519.3 run fsmonitor-daemon in virtual repo

	=E2=93=A7 win+VS test (6)
	  Process completed with exit code 1.

	=E2=93=A7 osx-clang (macos-latest)
	  failed: t0012.81 fsmonitor--daemon can handle -h

	=E2=93=A7 osx-clang (macos-latest)
	  failed: t7519.2 run fsmonitor-daemon in bare repo

	=E2=93=A7 osx-clang (macos-latest)
	  failed: t7527.1 explicit daemon start and stop

	=E2=93=A7 osx-clang (macos-latest)
	  failed: t7527.2 implicit daemon start

	=E2=93=A7 osx-clang (macos-latest)
	  failed: t7527.3 implicit daemon stop (delete .git)

	=E2=93=A7 osx-clang (macos-latest)
	  failed: t7527.4 implicit daemon stop (rename .git)

	=E2=93=A7 osx-clang (macos-latest)
	  failed: t7527.7 MacOS event spelling (rename .GIT)

	=E2=93=A7 osx-clang (macos-latest)
	  failed: t7527.8 cannot start multiple daemons

	=E2=93=A7 osx-clang (macos-latest)
	  failed: t7527.10 update-index implicitly starts daemon

	=E2=93=A7 osx-clang (macos-latest)
	  failed: t7527.11 status implicitly starts daemon

	=E2=93=A7 osx-gcc (macos-latest)
	  failed: t0012.81 fsmonitor--daemon can handle -h

	=E2=93=A7 osx-gcc (macos-latest)
	  failed: t7519.2 run fsmonitor-daemon in bare repo

	=E2=93=A7 osx-gcc (macos-latest)
	  failed: t7527.1 explicit daemon start and stop

	=E2=93=A7 osx-gcc (macos-latest)
	  failed: t7527.2 implicit daemon start

	=E2=93=A7 osx-gcc (macos-latest)
	  failed: t7527.3 implicit daemon stop (delete .git)

	=E2=93=A7 osx-gcc (macos-latest)
	  failed: t7527.4 implicit daemon stop (rename .git)

	=E2=93=A7 osx-gcc (macos-latest)
	  failed: t7527.7 MacOS event spelling (rename .GIT)

	=E2=93=A7 osx-gcc (macos-latest)
	  failed: t7527.8 cannot start multiple daemons

	=E2=93=A7 osx-gcc (macos-latest)
	  failed: t7527.10 update-index implicitly starts daemon

	=E2=93=A7 osx-gcc (macos-latest)
	  failed: t7527.11 status implicitly starts daemon

	=E2=9A=A0 CI: .github#L1
	  windows-latest workflows now use windows-2022. For more details, see ht=
tps://github.com/actions/virtual-environments/issues/4856

In my mind, this is already an improvement. (Even if this is a _lot_ of
output, and a lot of individual errors, given that all of them are fixed
with a single, small patch to adjust an option usage string, but that's
not the fault of my patch series, but of the suggestion to put the check
for the option usage string linting into the `parse_options()` machinery
instead of into the static analysis job.)

Since there are still plenty of failures, the page admittedly does load
relatively slowly. But that's not the time I was trying to optimize for.
My time comes at quite a premium these days, so if the computer has to
work a little harder while I can do something else, as long as it saves
_me_ time, I'll take that time. Every time.

Ciao,
Dscho

--8323328-1606598083-1645798248=:11118--
