Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D92C1F453
	for <e@80x24.org>; Sat, 27 Apr 2019 23:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfD0XUz (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Apr 2019 19:20:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:35695 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfD0XUz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Apr 2019 19:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556407248;
        bh=rhkRK3Hyht905wLclLdqHucNx4R9I++o2XVAumGXbk0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UOibWPG+r0rptE3j5F6oGhf0QN35u39PsgDsVXfU++6S+glx7Jeg+4qjw4j+k/Lmy
         DCWrq5nk7ucYATBVJSSbgV1I+WU0mQte7ZoKYmFk7Hop0wCLPhNBNOW7ko3bofm6b3
         ItDASqUtlmV3vKd9/f6Ghd1Ctfl/mqi8rBHqypR4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.96.188] ([12.174.135.204]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Gj-1hPlQC3kpP-005JSK; Sun, 28
 Apr 2019 01:20:48 +0200
Date:   Sat, 27 Apr 2019 19:20:42 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Bret Barkelew <bret@corthon.com>
cc:     Bryan Turner <bturner@atlassian.com>, git@vger.kernel.org
Subject: Re: git version 2.20.1.windows.1 throws file name too long in gitk
In-Reply-To: <CAGTkKajYiyT_OtX1mQECvxjvKXndjBYAqwgKMimJrroPAAvZJA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904271722290.45@tvgsbejvaqbjf.bet>
References: <CAGTkKag2sFy+Of=6uQeiGOQm0-NBrh9ixgzDoQXKR73+Ct3raQ@mail.gmail.com> <CAGyf7-HcncFOfmm5McEkOvCTkHNdePDSEQDZwEAK=z1bmC=QKw@mail.gmail.com> <CAGTkKag-fTy3iZAKJxEnWD6_b_3pfuYvQQKBkLaeSL8wKM2sfg@mail.gmail.com> <nycvar.QRO.7.76.6.1901091936420.41@tvgsbejvaqbjf.bet>
 <CAGTkKajkW-U9mhh_GmTXmZQbnceEKX_BcMtOF4hOhEDZe2u9Bw@mail.gmail.com> <nycvar.QRO.7.76.6.1901101616100.41@tvgsbejvaqbjf.bet> <CAGTkKagTCw-EcMo3M1P3XVtjbTcm4HPjCWGZ1sM_NnJwH7v_hg@mail.gmail.com>
 <CAGTkKajYiyT_OtX1mQECvxjvKXndjBYAqwgKMimJrroPAAvZJA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-696936068-1556407250=:45"
X-Provags-ID: V03:K1:DnW5KyAcE0hl8rKSSGjh7zV7nI5lV1NNB03dacEYwVi1ZmWl9lb
 T/oPxSlLS0VuBwusQqLAb1WSi2gTnrP5WBY4HlI/YLQI+ee6iqn/IxWI9VBN1XoZMu0KOCs
 dQGoUIkZNXc0OmEfKWizceZSc2qjbx3fYuBjO/syCHXw1xUGBhwz6s/VKNpa8nHj5Leyjig
 pCwAU0wkr2DlIQ6H3G5uQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HVOEfjrqlqk=:x+H2JWsMWecE5lVKAC41V0
 vn/gnPaalUqgZXL7xK9RNXkqIY9U/xpwPJkFH8T9/ZDZxJnts9QHJaYQpf2cyrXsEDP9kWoEv
 YyfoWoedQg/0uY16BYwEJ20/Ewh4KviTGqxVIqQ629Slus9qxCOb9erl70wxPa7qSJ8LNhStI
 fJ8QSDlFRqixcUPCL6ruVZeOdvps+uwJuQvbuEcmXagyrBPXeZQp1rzZFp5QV8GLNQvEdYcsP
 RkCL6rk3p/70z0S4tSQNOjdN5ZoCCNxsdu+pVdFA0Tnc18XhIu/UPSy+OVUS4RK7w5Ae35UBE
 sCthCKTaBnA+0gVnVR4aZnZ5bH/mG/ntZR+lGT6L8c7lkYpnA2XuxBJipsHIxI/3NbCyh+/4u
 uC47bmqWvGiO6WjiUG7okBiGDuseBU/5YeGKmu9uLXu2UCd48D/k9Oy4K/d2yKLEvtptDaGf7
 mCX/LaZGKY7Xyt02uQZP2xenTasptwJg1s4+jHA/0eUU1LFjbYwnQPzWfcKPaBawzt/ZdBRxC
 QF5V/ItjOukTz4AwYJ9F7JbbF1MFJafC9PbL2itsR1HGMR/TOaTzdtGS0ukxEss5dZyQ2noHH
 6Z7VOxIih+miasdPIqWWkmF91mrXD5x9/xKx9Dfj5JiYws29njFp1sjEWEnLKn5AfBctZu9CV
 QX7/aMcbkUZdGw+pyaZNL+QBqqIAcnkDnoy7CJHqc8UMBy+oC5hjN98eut9NRzIqXXnYxptDW
 Clip1G5OxzBleHqdSrk71I8QMq09DA4Lvn3+WFEQPcqRrDJ1n1hgLMHIiaj9dBSNDqmmXfdFp
 POul8iWLF/l4Eun6mMrbdFqHB5VVZF+Vi6lVsCkjQj6ANX9RmANalfBwqCtx6jtPm+DxwWrIN
 yiIYtP2yiFTxftcrRy5rc+WKYrQUYlhxrrPqA/dwUyJ8PW4g9nFu60R68jXYA18nl4OQc6IlB
 BXr01/udoWdZfO70pUdgFQAuKkRDW+chRdPWk0FCjFuL36qOYzgCprP5kfOH4tFlBMmRrXpjK
 mwmphje4+h2RHc2DgCuky0w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-696936068-1556407250=:45
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Bret,

On Thu, 18 Apr 2019, Bret Barkelew wrote:

> This issue is now being reported by more users inside MS. I'll also
> reach out to the Git for Windows advocacy group to see if they have
> any ideas.
>
> I have not had time to figure out the inner workings of Tcl/Tk. Is
> there any way to turn on tracing/logging in Git for which commands are
> being called by gitk?

Thank you for reaching out with detailed information internally, I am
happy to report that together with the help of Max Kirillov, this is now
resolved and a snapshot is available from
https://wingit.blob.core.windows.net/files/index.html that has the fix.

Ciao,
Johannes

> On Thu, Jan 10, 2019 at 10:55 AM Bret Barkelew <bret@corthon.com> wrote:
> >
> > On Thu, Jan 10, 2019 at 7:20 AM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > Hi Bret,
> > >
> > > in that case, please try to find a way to trace the commands in a Tc=
l/Tk
> > > program (which gitk is) and see which command triggers the error.
> >
> > Er... that's a little out of my depth. I'll see if I can find time to =
learn.
> > Meanwhile, is there any way to request better instrumentation for the
> > error dialog so this data could have been collected for me?
> >
> > >
> > > Ciao,
> > > Johannes
> > >
> > >
> > > On Wed, 9 Jan 2019, Bret Barkelew wrote:
> > >
> > > > Will try to reply in-line, when appropriate.
> > > > The latest snapshot (git version 2.20.1.windows.1.5.g6b286585b1) s=
till
> > > > has the issue.
> > > >
> > > > - Bret
> > > >
> > > >
> > > > On Wed, Jan 9, 2019 at 10:39 AM Johannes Schindelin
> > > > <Johannes.Schindelin@gmx.de> wrote:
> > > > >
> > > > > Hi Bret,
> > > > >
> > > > >
> > > > > On Thu, 3 Jan 2019, Bret Barkelew wrote:
> > > > >
> > > > > > They are the exact same path (with a different drive letter).
> > > > >
> > > > > [it's a bit hard to follow the thread if you top-post a reply to=
 an
> > > > > inline-replied answer, maybe imitate the style of other mails in=
 the
> > > > > future.]
> > > > >
> > > > > > Another thing I've been able to confirm is I uninstalled git 2=
.20.1
> > > > > > and installed 2.19.0 on the failing system, and the older vers=
ion of
> > > > > > Git works.
> > > > > > I've also tried a suggested fix I saw elsewhere to enable long=
 path
> > > > > > names in the Windows registry, which did not resolve the issue=
 with
> > > > > > git 2.20.1.
> > > > > >
> > > > > > Happy to collect any additional data.
> > > > >
> > > > > Please try the latest snapshot at
> > > > > https://wingit.blob.core.windows.net/files/index.html (I *think*=
 the bug
> > > > > might be fixed via
> > > > > https://github.com/git-for-windows/MINGW-packages/pull/32).
> > > > >
> > > > > Ciao,
> > > > > Johannes
> > > > >
> > > > > > - Bret
> > > > > >
> > > > > > On Thu, Jan 3, 2019 at 7:10 PM Bryan Turner <bturner@atlassian=
.com> wrote:
> > > > > > >
> > > > > > > On Thu, Jan 3, 2019 at 6:21 PM Bret Barkelew <bret@corthon.c=
om> wrote:
> > > > > > >>
> > > > > > >> When I open gitk in a particular repository under this vers=
ion of Git
> > > > > > >> for Windows, I now get a dialog box that says "Error: could=
n't execute
> > > > > > >> "git": file name too long". I've noticed that the most pron=
ounced
> > > > > > >> effect is that I cannot see the file diffs (or sometimes th=
e file name
> > > > > > >> list) for any of the commits. I don't know the exact repro,=
 but I've
> > > > > > >> narrowed down the following things:
> > > > > > >>
> > > > > > >> - This does not happen with the same repo if I use a system=
 that has
> > > > > > >> git 2.19.0.windows.1 on another machine.
> > > > > > >> - This does not happen on my current machine in a freshly c=
loned repo.
> > > > > > >
> > > > > > >
> > > > > > > How =E2=80=9Cdeep=E2=80=9D are the paths to the different cl=
ones on the different systems? Are all of the clones at exactly the same p=
ath on disk?
> > > > > > >
> > > > > > > Git on Windows is (by defaulted) limited by MAX_PATH, which =
is 260 characters. That length is calculated including the path to the rep=
ository itself and then to the file inside the repository. That means, for=
 example, a given repository cloned to C:\repo may not have issues, but th=
e same repository cloned to C:\Users\Bryan\Documents\workspaces\repo may.
> > > > > > >
> > > > > > >>
> > > > > > >> However, as soon as the remote updates with any changes on =
a given
> > > > > > >> fetch/pull, the repo is put in a bad state permanently.
> > > > > > >>
> > > > > > >> I've pasted the output from gitk below...
> > > > > > >>
> > > > > > >> couldn't execute "git": file name too long
> > > > > > >> couldn't execute "git": file name too long
> > > > > > >>     while executing
> > > > > > >> "open $cmd r"
> > > > > > >>     (procedure "getallcommits" line 48)
> > > > > > >>     invoked from within
> > > > > > >> "getallcommits"
> > > > > > >>     (procedure "readcache" line 80)
> > > > > > >>     invoked from within
> > > > > > >> "readcache file827e200"
> > > > > > >>     ("eval" body line 1)
> > > > > > >>     invoked from within
> > > > > > >> "eval $script"
> > > > > > >>     (procedure "dorunq" line 11)
> > > > > > >>     invoked from within
> > > > > > >> "dorunq"
> > > > > > >>     ("after" script)
> > > > > > >>
> > > > > > >> Happy to gather whatever data needed.
> > > > > > >> Thanks!
> > > > > > >> - Bret Barkelew
> > > > > >
> > > >
>

--8323328-696936068-1556407250=:45--
