Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C649FC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 12:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A90AD63276
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 12:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbhHPMqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 08:46:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:49473 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229972AbhHPMqa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 08:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629117957;
        bh=e5mkZ5ycjdvURtoAJ7mdzlrCCtLwqzpvpVf9cbBHroM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QeHtezxkdHhS8EmkgzW4ehu5Kte36fkTiQkSk/ElQ5MbcAGggfCEVAqc/T5lmx8U1
         yAb2F+EqaUHS+OMqdliarMuHnt3VBzJMcnOwFkTuy0iWe3yglsPzokaTPsU018TQT1
         dQBIq/5gNNLd2DBdBZH7fL0z1mJWpAAo9xFHkTic=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.229]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEFzx-1mPokS2nUj-00AFGi; Mon, 16
 Aug 2021 14:45:57 +0200
Date:   Mon, 16 Aug 2021 14:45:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Gerhard Buch <Gerhard.Buch@web.de>
cc:     git@vger.kernel.org
Subject: Re: Aw: Re: Git GUI does not start
In-Reply-To: <trinity-37fd48fb-6205-4e1c-8a76-d2eab6a3dc26-1629093923606@3c-app-webde-bap47>
Message-ID: <nycvar.QRO.7.76.6.2108161443390.55@tvgsbejvaqbjf.bet>
References: <trinity-37fd48fb-6205-4e1c-8a76-d2eab6a3dc26-1629093923606@3c-app-webde-bap47>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-359410723-1629117957=:55"
X-Provags-ID: V03:K1:gXVWa7qW/JhhqabrKjio2TVKd9rSsVNEkZX4M/Vm3VXckgFvwmN
 D43DagnbEqnJu70ST5uBwAN7YO8BzbxhgUxX5ZGnAqjhG8bj8oIfd3lDZFJsu5BD9iBxMoW
 36z90/sicHEvYiyuW9C5EyUVR4KD5lrQ9nQejogkpycTiHoLuVHEMUhNGzlD19TMhOUEZ5Y
 LsuTAHY9BHTNI7p5q3H3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gDBZ9CtYrfU=:1tG0q+Nbr/pNqJiObLwHU0
 /cfdrxCGkHFyBrz9JBRvSNMxfx9kkj8izh/VeelHoKeLFCeYzsiAh+aKmKoFSOHx//1/+Hx10
 fNAZMA7orBatGmNxaM0x3ngwMVteRFis9/ZV70UEOkgKzMRh1kAL/GQefwrZXw8mMTLGMH43A
 +qW44DUJn52tJbCVb/T4YRV7A4ZkQ+AfShD1DmRgDLog+6YQ6CNs2JtswTroncABZtUZKBMv7
 3UEucUpTU9sXaJvl0MDgNN2YcfOsk4cHdivxzz98dOldG1v1sRiLP8gj5Jyce4Sp4OkGBp688
 lCyN6WjEUnXqRo1F7wIpGWMKe4Hp2lgdBqAuq++BMuepVleOv71DhBUnMCROdXWqU7IhupvVc
 wPr4hEtNTThk0FH5eexbE01EE6UByVFVO78GSW1QuH9CsA2LR2Aez7xqvaf8570I0iRsiofRc
 rGEVOeFDMHtOUOyQ8msEbbhJfeSptl1eDKQOAzQhDuDwQ6qAj1JshSZzYSSopJspM76uGGaSG
 9QAou6LkyNf7QO7NvWs9KHg/c4JiNpKuqpV6RKge8Yi6RN5kaBFG8dWqlBMoVAyk8d4iX2H43
 T/uDFtoD+zdU22o8pBoBGagwz6LuJ3BQdu64XiDokeDawo1sBCfFHEOhKrVEdFG3f+mLmXZBw
 Rikzh1TeZgtrvHc0cI08j4HG4AXu+03uMJ4MASRpqp6ATflfDomA/wrIdesU8PdApu6ClUQzU
 /DPqj05LfWrwBZ4Dp1c14JX9zH156EytmlKMj3jridNuIvrW4hXdJOj1Na6qmoWdxt1Ei3MWq
 Hj9YGg9uP92ehAJc/Nk2VbE67A0Ik2IYvNTunYA5Gg5Yk9YOwPg2+VDQ9HlSPoaA4iqLAQNKR
 M6FomZy2UG3295QHyjbrPrXSFZXTsHZ7o5GhMegEzq3imPsR6TEEKgQx5V/yadiZDJQlmfCQO
 X6zq4fFq0tKqhBH/S0b/PTE8VVzEACJq/ruwI6QllqO94mLZLqUc6fljaIriW5uiDoD0GRd/h
 bHeu0Nxh1jWXxJF80M0kt4viVdoGM0zVfPNudyf2Jtwy7wHPyy64EZLsloK4dC8ohpe14BJxz
 9ZvgIKbbFMGC8+ed3W8Sll+Cl1PzRNGdfDZNkq+qxEzMTchXfGQO8wVpw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-359410723-1629117957=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Gerhard,

On Mon, 16 Aug 2021, Gerhard Buch wrote:

> thanks for looking into the topic. Here is the information requested and=
 results of the test with Git V2.30.2:
> =C2=A0
> The problem described could be reproduced with a Notebook with Windows
> 10 Enterprise (1809, Build 17763.1879) and also with a Citrix
> Installation with Build 19042.1083. But - as we'll see later, this will
> be of minor relevance.
> =C2=A0
> So, this morning after booting both systems, I checked again the
> behaviour with Git V2.32 and found the problem as described in the big
> report.
> =C2=A0
> Then I downloaded Git V2.30.2 Portable and could open the repository
> successfully with Git-gui.
> =C2=A0
> After this I tried again with Git-gui V2.32 and could then also open the
> repository successfully on the Notebook as well as on Citrix.
> =C2=A0
> Conclusion: the problem is not on the Git-gui itself, but more on the
> repository. There seems to be a migration issue when opening a
> repository with V2.28 formatting with V2.32. Looks like the migration is
> done automatically from V2.28 to V2.30 to V2.32, but not from V2.28 to
> V2.32.

There is not actually any migration being performed.

My best guess is that your repository's shape might have been suboptimal,
and that a warm cache helped.

If this is the case, you might want to register regular Git maintenance on
it, so that future Git GUI starts won't be so slow as to appear to hang:
`git maintenance start`.

> I believe you will know whom to contact with this finding.

You already did: the Git mailing list ;-)

Ciao,
Johannes

> =C2=A0
> So my problem is solved - thank you for your help-
> =C2=A0
> best regards
> =C2=A0
> Gerhard
> =C2=A0
> =C2=A0
> =C2=A0
> > Gesendet: Sonntag, 15. August 2021 um 00:11 Uhr
> > Von: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> > An: "Gerhard Buch" <Gerhard.Buch@web.de>
> > Cc: git@vger.kernel.org
> > Betreff: Re: Git GUI does not start
> >
> > Hi Gerhard,
> >=C2=A0
> > On Wed, 11 Aug 2021, Gerhard Buch wrote:
> >=C2=A0
> > > Git GUI does not start any more and I'd like to share the bugreport
> > > below.
> >=C2=A0
> > Since bug reports easily get lost on the mailing list, I have a prefer=
ence
> > for Git for Windows reports to be opened at
> > https://github.com/git-for-windows/git/issues/new. That method also
> > provides a more helpful bug report template.
> >=C2=A0
> > I have to admit that I am somewhat surprised by your bug report becaus=
e I
> > specifically verify that Git GUI starts whenever releasing a new Git f=
or
> > Windows version.
> >=C2=A0
> > > Any idea how I can get diagnostic information to find die
> > > problem?
> >=C2=A0
> > Since you reported this for your Windows setup, it would be good to kn=
ow
> > what your Windows version is.
> >=C2=A0
> > Having said that, the most obvious difference between v2.28.0 and
> > v2.32.0(2) with regards to Git GUI is that Tcl/Tk was upgraded from
> > v8.6.10 to v8.6.11.
> >=C2=A0
> > If you could test with v2.30.0 (which still has the old Tcl/Tk) and wi=
th
> > v2.30.1 (which has the new one), that could help pinpoint the issue.
> >=C2=A0
> > Ciao,
> > Johannes
> >=C2=A0
> > >
> > > best regards
> > >
> > > Gerhard
> > >
> > >
> > > --------------------------------------------
> > > What did you do before the bug happened? (Steps to reproduce your is=
sue)
> > > Open Git GUI -> choose open existing projekt
> > > It worked with the previsous version 2.28 before. Before posting the=
 bugreport I updated to the most recent version to be at the latest versio=
n.
> > >
> > > What did you expect to happen? (Expected behavior)
> > > That Git GUI opens...
> > >
> > > What happened instead? (Actual behavior)
> > > Git GUI icon appears in task bar, but not the usual Git GUI window.
> > > On left click on the task bar icon, the top entry says Wish Applicat=
ion. On choosing this entry two Windows appear.
> > > One is empty. The second is titled "Konsole" and has (System32) 1% i=
n the field below the menu bar.
> > > What's different between what you expected and what actually happene=
d?
> > > Git Gui does not start and there is no indication on possible reason=
s for this.
> > >
> > > Anything else you want to add:
> > > I've checked the project directory with git cmd:
> > > git status:
> > > On branch <branch name>
> > > nothing to commit, working tree clean
> > >
> > >
> > > [System Info]
> > > git version:
> > > git version 2.32.0.windows.2
> > > cpu: x86_64
> > > built from commit: 3d45ac813c4adf97fe3733c1f763ab6617d5add5
> > > sizeof-long: 4
> > > sizeof-size_t: 8
> > > shell-path: /bin/sh
> > > feature: fsmonitor--daemon
> > > uname: Windows 10.0 17763
> > > compiler info: gnuc: 10.3
> > > libc info: no libc information available
> > > $SHELL (typically, interactive shell): <unset>
> > > [Enabled Hooks]
> > >
> > >
> >=C2=A0
>
>

--8323328-359410723-1629117957=:55--
