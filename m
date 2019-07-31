Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 028871F731
	for <e@80x24.org>; Wed, 31 Jul 2019 13:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfGaNAk (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 09:00:40 -0400
Received: from mout.gmx.net ([212.227.15.15]:57381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfGaNAj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 09:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564578038;
        bh=01z0eNPyJ7CVADkrTWma1pRAgf45XtQ75TX+KY48d5Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=b4kMy75R5d0sQCwDhWJu9nDTDPy3iCcZ+h7rqJLhU5srisLYc2wOiO6cGJxj15+rF
         NIbHnpnu5zFM8hdAMR5dRhdgEgP+MHVxkjW3psAsagOVjwhfXeePGPvpVgjLtIoyKF
         6LInwx6ND/LAV6uu2qKAn6maoSA/Sn3y2i4jLfXk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LcSAg-1icMIi0CYw-00jrWN; Wed, 31
 Jul 2019 15:00:38 +0200
Date:   Wed, 31 Jul 2019 15:00:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
cc:     git@vger.kernel.org
Subject: Re: Antw: Re: blank lines in pre-created merge message
In-Reply-To: <5D3FE919020000A100032932@gwsmtp.uni-regensburg.de>
Message-ID: <nycvar.QRO.7.76.6.1907311448280.21907@tvgsbejvaqbjf.bet>
References: <5D382AC1020000A100032608@gwsmtp.uni-regensburg.de> <nycvar.QRO.7.76.6.1907251204310.21907@tvgsbejvaqbjf.bet> <5D39812C020000A10003265F@gwsmtp.uni-regensburg.de> <nycvar.QRO.7.76.6.1907251355500.21907@tvgsbejvaqbjf.bet>
 <5D3FE919020000A100032932@gwsmtp.uni-regensburg.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-287557691-1564578039=:21907"
X-Provags-ID: V03:K1:WMpxdvSFrgonf7zRHQ/C8nI+bwy8HGDOy32vCaAa/8NGLoxZ0mg
 Iqtf+qZ+7hfeA7j6lfcLDf9vm8H9o5lkv56hqHjIxtPPFNNqPF46tHkjciwYwDr5rPDphpW
 xfhTtvIJZaQu8KWIi0EEu1EB2ZMGKgHJNasYmwDBtZmr+2SGpDrCcuXHcatA6hCrx9dgPmB
 8qbZkPlrpJKQPt+pL99tA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mnrzh0eCafw=:i9Av10kN3UJX9dNRREfT1m
 Os7kFTemKk1PAhfrRQB69cacPET99RSBXL4c9urPGJCzwVhFovT4gM/TVukJyGn0MpUpBD+p2
 eckbCGrSj8T9Y4AcihnUiXfWB7Dsr5Zzg3KTZtAcqlLq1p5x3FrkjI5RJaSBUu73bhebS/YHK
 C8ApJGjymPxMTJEEZHHruzRufyTj0L3g9SvmJQKy72mVCOvgp8kLBbNNcVe8nGTGyJGdef3j/
 7IWHdVsmbP2m2WCWoGA0s+b7M/B02YWYwPCSUFIaeifvhkZYsMJmupuJoHcHJo2dCjgBxh8NB
 Qg9OV+5YT/XzJbSqq8bcLS3CpElc2hk+7er/RF+fafZn3GE+SGgA4pVigdB66emjBGIlNE5A0
 bvR3g3hvcljjTk/fIbYCmVapn6J+yq48Dz0zI0PF69aZ5SM577ffmzle4NeVMvAj/zn9YFYs2
 d1UVpyN0uNGXmprMcCr4ajeqEOBE/JHAOzQS5jd4DmlfZDFgqcRTn0ynEz07u7dPmjouzNcqQ
 37WPf4nyGERMFTyMyE4c+jwzghxHyEE3E+58QpEx8xEUSdIdMgdLPHYLGuRzQgpvU6EjB8NI4
 gZ0QbnFAWlZtGmvsrBTRluv8TT2qdUl4VacXRF3NMb5Yx5yI8PpZ8uTw1iPtFWHGSqd/keW9E
 j5NGcepmZdABttiVhoGONN5N7mpd7wua/AO/g1VF2NLYYP8bBrvWAhwOXx4EG01cm7wd78tnC
 +GoEANKdcHwN8GhzAXu9FR/24ETYTPCWqttCFMYO1oVcVDd+cWjN9iAChM/VdWr1G6ahcJuGU
 Bfmoe0ZiGg8x9TL4U+ukNT5YreOWhRlThjmvwzAmsxyhWqr1K/8kf8AtGgZ/VobfCREln7ZGw
 McXukElVlRwbgqdPgYqwmN8VmXSHPQqsF7TP8m2a+p2jO0oyeiY7eSBs3L6fmszO3YlD6KUNi
 B+3JfhVRl2QYeR9uwtS4sCuTks4SvyyPzueELlu8L7J+4V3gZUkoYN7wynVAiQoAWbSrvVcOO
 mMwOcAmVpwv4KqYVHMnLVJGzHSni3/X5qDsN6b2XdNxkb3AaAdhzMwMG9uDzfXjjRN6S8XdXv
 4milGRA5EPWvJqj9kwkts2vGSWQuTq+VVuK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-287557691-1564578039=:21907
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ulrich,

On Tue, 30 Jul 2019, Ulrich Windl wrote:

> >>> Johannes Schindelin <Johannes.Schindelin@gmx.de> schrieb am
> >>> 25.07.2019 um 13:58 in Nachricht
> >>> <nycvar.QRO.7.76.6.1907251355500.21907@tvgsbejvaqbjf.bet>:
> >
> > On Thu, 25 Jul 2019, Ulrich Windl wrote:
> >
> >> >>> Johannes Schindelin <Johannes.Schindelin@gmx.de> schrieb am
> >> >>> 25.07.2019 um 12:07 in Nachricht
> >> >>> <nycvar.QRO.7.76.6.1907251204310.21907@tvgsbejvaqbjf.bet>:
> >> >
> >> > On Wed, 24 Jul 2019, Ulrich Windl wrote:
> >> >
> >> >> When using "git merge =E2=80=91=E2=80=91no=E2=80=91ff =E2=80=91=E2=
=80=91no=E2=80=91commit ..", the pre=E2=80=91created
> >> >> merge message always contains two empty lines in between the
> >> >> comment lines. However if there was a merge conflict (being
> >> >> resolved) an extra blank line is added after the fiVrst line.
> >>
> >> [...]
> >
> >> Could anybody provide a rough overview how and where these editor
> >> comments are created?
> >
> > The best bet would be to call `git grep` with text in that pre=E2=80=
=91created
> > merge message, preferably some text that is most likely fixed, i.e. th=
at
> > does not depend on the current worktree/commit.
> >
> > If you give me an example of such a merge message, I can provide you
> > with the appropriate `git grep` call and the code locations to touch.
>
> Hi!
>
> Sorry for the delay:
> OK, here is an example where the auto-generated comment has two blank li=
nes:
> ---snip---
> Merge branch 'shared'
> #
> # It looks like you may be committing a merge.

The command-line I used was:

	git grep "It looks like you may be committing a merge"

It points you to
https://github.com/git/git/blob/v2.22.0/builtin/commit.c#L827

As you can easily see, that message does end in a `\n`, (and also in the
other conditional arm, for cherry-pick), and it is printed via
`status_printf_ln()` (the `_ln` means that it adds another newline), and
in addition another newline is printed directly after that if block:

		fprintf(s->fp, "\n");

Since this extra empty line is bothering you, how about giving it a try
to fix it yourself? I guess the best bet is to delete the `_ln` from the
function call, as it avoids changing a message that was already
translated into about a dozen languages (and would have to be translated
again if you changed it, even if only to remove a trailing newline).

If this works for you, please follow
https://github.com/git/git/blob/v2.22.0/Documentation/SubmittingPatches
to contribute the patch to the Git mailing list.

Ciao,
Johannes

> # If this is not correct, please remove the file
> #       .git/MERGE_HEAD
> # and try again.
>
>
> # Please enter the commit message for your changes. Lines starting
> # with '#' will be ignored, and an empty message aborts the commit.
> # On branch master
> # All conflicts fixed but you are still merging.
> #
> # Changes to be committed:
> #       new file:   .filelist
> #       new file:   .gitignore
> ...more lines omitted
> ---snip---
>
> >
> > Ciao,
> > Johannes
>
>
>
>

--8323328-287557691-1564578039=:21907--
