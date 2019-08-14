Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39D9C1F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 20:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfHNUqG (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 16:46:06 -0400
Received: from mout.gmx.net ([212.227.17.22]:43707 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729885AbfHNUqF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 16:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565815560;
        bh=4RFRheupjo36uz1G5pT7S+Kkci8HjerdLU2uxaW4Mds=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lavVcJ2FAS2uZDVv9LhIyBq0JMdEet1U0o9lmzLQ4MjblMa281lfPf0Ot5utpJp4d
         TSiusMd+ghDanXWI2iFEiMMiScgb+Br3u8zPNd3ZGhShUGNzjQR8bVK5OYoDJLUhhd
         lv+MxUEC3ce6lpX8Wvz+28dFCTUqBrXRLWV+vsKE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.63] ([77.165.132.136]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7K3Y-1huhIA3Iaq-007jdU; Wed, 14
 Aug 2019 22:46:00 +0200
Date:   Wed, 14 Aug 2019 22:45:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood123@gmail.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: minor interactive rebase regression: HEAD points to wrong commit
 while rewording
In-Reply-To: <2a7d69a9-cb3e-eb84-188f-5713876f6d78@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1908142241080.656@tvgsbejvaqbjf.bet>
References: <20190812175046.GM20404@szeder.dev> <2a7d69a9-cb3e-eb84-188f-5713876f6d78@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1375367643-1565815552=:656"
X-Provags-ID: V03:K1:44pYR8koTT3BSGxAfPZ1IwjoowFDC6+Ek3eOF8UJg53Z9Va82zx
 QaJ03zzG3LrjAu+053BwoG5RCSTTKZfAdXBKIExCAbnbVCsOhxsvVTbN04bnGWuRGFZI0Bs
 fx6mdfT/wpKYFhteiBnJ8hhwcjS4oKRyYuwD+QAkmQztZqks77Oi3rnuqFDznSPZ/dIYYa2
 laVoLv+3kTjLtJWpfBkWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VgoQYW+ljao=:4C8J5QK+ph/zYTqmRUwE12
 WTmVny5nfDa/TvIbpiIY2EtFDBWCfDZUAC6lTkd0Q8veLgcoYbzpICLxHfQt882u/qyJ+dOG6
 GvCDTHePZJZSA1zy649poaDvMGj0UhD6e8KIr70qULWfs2M0U1kBE1hUrnTInsh9yUq1LoXdv
 B15o7MzjeQhLxnLniqdwpXTX+5rcgYqSTxZg26yWd9lxr3ToEask8Qd/yHd21Pb4F4vIbfrfZ
 SeEE6XjI/wrrfEaNxZQ72rS/j4glImfNtj6loX7fw4f9lI0i92TCA7NiX12n7xvdTbKhf349H
 0INDv+Nhn4VUd9WOWoMvcn3K6O+HlCw9lWtisuc9/17WLNVxv9aNqcjOs7+P0r7MZAhec9PBi
 +RV4GzJWGwF49RqBIOE9rwcgzzcaz20D2F9heiORd8kgmeW3QtU6LAIXh8YYP8tz4Vx1mAGAr
 rScVX1FJyxCubQ+fUB/svZ5Ex6Oj/aTJFob5gZhLcwRaGnGX0XE8vqauqBtCiueLGXMo091UC
 jOrPro6Z7EjiscmPCl9A3xGGpp6TfC753/AyjwY7KcuaT/XDVYMZnXmgA9HbFAlNyNw9GaVtx
 ym4MhS5jL/BuvIHxpmrvfJ1MgMpHPV7e8M+ULvR4GP4w+g39fw8kXUTn3nY2W4vE5Mv6OeyAP
 PwqT1/QKphPf1HmIVhT/EW2CjM+0OeM5PBgUwyebzFPhUX281VDMmGmllgb+xEa6CQD/brCok
 1QrSRVwPXquXcCDX5EjaA3Fkq5sZ8ccMWDRWKultzILKJaw/oeP3G3hmQCYeztY4p727Drheq
 iYiw5lhIbxW9ZoZYvYZXXPL0osYFvfvJo1YMinWU9ghwbZJ336pFrtj1X9Ns7Pt+DrVzcpaF8
 AeWAkRKWp3UTBNm9ykE0T/tXhbgQAeazIquTaIi7zO5WMN98CIyp8qLKquOfRKnWraFZCj1Aq
 h6X0cd6f/bjHIgbPlrClCci+qz7XIweu9ith2oZtDJJcy7iv4kurnfmsD3Ivg0NNd4uTIy2Ee
 dnMmkCh1JV8uDmkPCR0E/fF+JQGWNJf6iwcKI0EdTk68uKdr4aiKxeX8RGqRI9KwruPMs698Y
 F/jtE3/dealAxZXs4sIk8BQ4YIIOvi6ctzoaY6cq4y9UCBCsUSFNnqLiCscpYtC4djcWK/Uya
 cv/hU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1375367643-1565815552=:656
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 12 Aug 2019, Phillip Wood wrote:

> On 12/08/2019 18:50, SZEDER G=C3=A1bor wrote:
> >
> > When running interactive rebase to reword a commit message, I would
> > expect that the commit whose message I'm rewording is checked out.
> > This is not quite the case when rewording multiple subsequent commit
> > messages.
> >
> > Let's start with four commits, and start an interactive rebase from
> > the first commit:
> >
> >    $ git log --oneline
> >    5835aa1 (HEAD -> master) fourth
> >    64ecc64 third
> >    d5fad83 second
> >    384b86f first
> >    $ git rebase -i 384b86f
> >
> > Update the instruction sheet to edit the log messages of two
> > subsequent commits:
> >
> >    r d5fad83 second
> >    r 64ecc64 third
> >    pick 5835aa1 fourth
> >
> > Now, after the editor opens up the second commit's log message, start
> > a new terminal and check where HEAD is pointing to:
> >
> >    ~/tmp/reword (master|REBASE-i 1/3)$ head -n1 .git/COMMIT_EDITMSG
> >    second
> >    ~/tmp/reword (master|REBASE-i 1/3)$ git log --oneline -1
> >    d5fad83 (HEAD) second
> >
> > So far so good.
>
> Because the sequencer can fast-forwarded to second from first it does th=
at and
> then run 'commit --amend' to do the reword.
>
> > Save the updated commit message, and after the editor opens up the
> > third commit's log message, check again where HEAD is pointing to now:
> >
> >    ~/tmp/reword (master +|REBASE-i 2/3)$ head -n1 .git/COMMIT_EDITMSG
> >    third
> >    ~/tmp/reword (master +|REBASE-i 2/3)$ git log --oneline -1
> >    c3db735 (HEAD) second - updated
>
> As second has been updated the sequencer cannot fast-forward to third so=
 it
> cherry-picks third and then passes --edit when it runs 'git commit' to c=
ommit
> the cherry-pick. HEAD is updated once the reworded commit has been creat=
ed.
>
> I think the scripted rebase always ran cherry-pick and then ran 'commit
> --amend' afterwards if the commit was being reworded. The C implementati=
on is
> more efficient as it avoids creating an redundant commit but has the sid=
e
> effect that HEAD is not updated before the reword which was surprising h=
ere.

Indeed, that was even intentional.

> I don't think I've ever looked at HEAD while rewording, my shell prompt =
gets
> the current pick from .git/rebase-merge/done so does not look at HEAD. W=
hile
> it might seem odd if the user looks at HEAD it's quite nice not to creat=
e a
> new commit only to amend it straight away when it's reworded. We have
> REBASE_HEAD which always points to the current pick - HEAD is also an
> unreliable indicator of the current pick if there are conflicts.

That is interesting; I would never have thought about scripting around
`reword`.

However, I am reluctant to accept the performance impact: in the long
run, I would love to have an interactive rebase that actually only
updates `HEAD` (and the worktree) when interrupting the rebase (via
`break` or `edit`), and `reword` does not qualify for "interrupting" in
my mind.

Ciao,
Dscho

--8323328-1375367643-1565815552=:656--
