Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 222401F462
	for <e@80x24.org>; Wed, 29 May 2019 18:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfE2SH4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 14:07:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:47189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfE2SHz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 14:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559153267;
        bh=+ypF8PuNnJZF36FnD7sbRAXBGD4j37cQDxkb7/uMsZo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=STge3XaCMrfiQlw26S1cq3/4NONV6xRsovEQedIOglmhMAvsYe2O/5u7PX4CGN0il
         1X0GtTAN66CEOadlmJ77lvgIrlRZvgQALWJm5avIYFg2zvEhTlde70orERsvESVv82
         DsHjpQjxZozBJGqkOR1zEKjtlUN5z6OV3eJ8Vd/Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Md3li-1hDpLd1q66-00IHF8; Wed, 29
 May 2019 20:07:47 +0200
Date:   Wed, 29 May 2019 20:07:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bret Barkelew <bret@corthon.com>
cc:     Bryan Turner <bturner@atlassian.com>, git@vger.kernel.org
Subject: Re: git version 2.20.1.windows.1 throws file name too long in gitk
In-Reply-To: <CAGTkKagwzceU51O6dK_6-MRZdEW52-xEFoGBVf9z9XLVEJoAGg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905292004380.44@tvgsbejvaqbjf.bet>
References: <CAGTkKag2sFy+Of=6uQeiGOQm0-NBrh9ixgzDoQXKR73+Ct3raQ@mail.gmail.com> <CAGyf7-HcncFOfmm5McEkOvCTkHNdePDSEQDZwEAK=z1bmC=QKw@mail.gmail.com> <CAGTkKag-fTy3iZAKJxEnWD6_b_3pfuYvQQKBkLaeSL8wKM2sfg@mail.gmail.com> <nycvar.QRO.7.76.6.1901091936420.41@tvgsbejvaqbjf.bet>
 <CAGTkKajkW-U9mhh_GmTXmZQbnceEKX_BcMtOF4hOhEDZe2u9Bw@mail.gmail.com> <nycvar.QRO.7.76.6.1901101616100.41@tvgsbejvaqbjf.bet> <CAGTkKagTCw-EcMo3M1P3XVtjbTcm4HPjCWGZ1sM_NnJwH7v_hg@mail.gmail.com> <CAGTkKajYiyT_OtX1mQECvxjvKXndjBYAqwgKMimJrroPAAvZJA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1904271722290.45@tvgsbejvaqbjf.bet> <CAGTkKagwzceU51O6dK_6-MRZdEW52-xEFoGBVf9z9XLVEJoAGg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-964857275-1559153267=:44"
X-Provags-ID: V03:K1:+laJZwrXvqFS+t0WV5tYXTax1uX20BIFmc36W1rW++mHxVeU6ks
 Evis9LnhzfDrjWVugaI9baEsAGaX0XufKKRC49OI2RoOgfu51XdbIahT25ST3v0gqNw70wd
 tWPBudgVl7Fitp220ka84h8B5XmSUd37EHxPYX9YFnZQGVVeNWb0iVcCcsAeKg6kAvGJzQv
 8CERC4+aP+FuDqwE/N0ZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5qG21283jjs=:As3BAwAxXmJQO3FzkiMMjM
 2wRARNVLHM/XsrKo0aGEBOQIQbTPs4faf4NZMr2nzgnKwhanUwZq6LGq6TKTe7q4uEaRZY3Tt
 Itmqx9JgvxUrT2Qf2flB8JdZZ2zcJADwkXeBubdtAC0kVALpyF4oGJRR+z9KN3g1RHBzZaLVg
 K/q1p4vo0SFZPiW2t9Ds5TJitWXMtGnSMASwCAu9FEuMlKhfPjaYqvQ4lNnvOTMIbmmZVqvUj
 sEm2XpUp2r/RosdINpv4/0UhwnfWlZCJrpyM73oFfpJFtmvylrDFX6BeM9vhRSf8N9O+mpWzm
 JhQE4T2LqO37D4wia/fvcugZb3TdXMFh5X2kgmZP7geR62DATLCL2Fv1S95kdvr4KlW8NUa87
 2dhxMdKoyB1x1otTyNpT2p+1A+JLZePsI+C57M1z/mD9Ea6Vb8n2TibyDyzf/mxvABy23hPmR
 HSCIm3PA99RxyFgV8ecBvnVnU+yJ7v/+C2pfSs5ZsV08iuiQUJ3iuP15qvfWQLs/TGzEycOOF
 quqyfTpSXiTw4Iedrs7oZSkvMx8Spsyg+a6MeGfa2xnPtR6AZhCG9yi/KRcRywRrpLfOs/mRb
 LbtjhotvwjXZK5hXPfVdw+P7MlTYjMDtMzlOODT8oi2YieknK21SQtAYm1cQVoGQD5z/GRNe/
 vQZ0fC02UIl3DKrNRMDC8wizt4JB5h8+LQ2GO73ucWs/CT3IY0rSAV+EdgBaA6Gf2FXFGxMOv
 eMxtDuTKu0gXorWKsGlI6juc/nO3gDy1zql3m4DZ39B9Blrn0GbmUXIQCMMzDLyKtUmaOaI3g
 QTYd62bfJic0zJeUvx/LG/lh0rZ9oD2JVsv9ho1dja/meDqwB22TR1U75nC7/RJwV2eHuZhM8
 cay5NxJukbqOB3ahFsYNmQN4vCyZhAOCTIHRFoggXJ7IIPPwnGRVFHoOe09e1DdYQhUJHd4JU
 ZTFW0n1wf5cvft4Itd2Iop+rvpuUOEO7J8eo99UjOB/GeYfU19290
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-964857275-1559153267=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Bret,

On Wed, 29 May 2019, Bret Barkelew wrote:

> I know it's an incredibly late reply, but I have not seen this issue
> reappear since the patches. Thank you very much for helping!

It might be late, but it is even more welcome! Thanks for the feedback
(and I am particularly happy that it works for you).

Ciao,
Johannes

P.S.: For lurkers, I just realized that I never linked to the patches:
https://github.com/git-for-windows/git/pull/2170

As this PR really only touches code that is already in Git for Windows,
but not yet in git.git, I think I'll try to find some time post-v2.22.0 to
brush up those gitk patches and contribute them to the Git mailing list
for review.

> On Sat, Apr 27, 2019 at 4:20 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi Bret,
> >
> > On Thu, 18 Apr 2019, Bret Barkelew wrote:
> >
> > > This issue is now being reported by more users inside MS. I'll also
> > > reach out to the Git for Windows advocacy group to see if they have
> > > any ideas.
> > >
> > > I have not had time to figure out the inner workings of Tcl/Tk. Is
> > > there any way to turn on tracing/logging in Git for which commands a=
re
> > > being called by gitk?
> >
> > Thank you for reaching out with detailed information internally, I am
> > happy to report that together with the help of Max Kirillov, this is n=
ow
> > resolved and a snapshot is available from
> > https://wingit.blob.core.windows.net/files/index.html that has the fix=
.
> >
> > Ciao,
> > Johannes
> >
> > > On Thu, Jan 10, 2019 at 10:55 AM Bret Barkelew <bret@corthon.com> wr=
ote:
> > > >
> > > > On Thu, Jan 10, 2019 at 7:20 AM Johannes Schindelin
> > > > <Johannes.Schindelin@gmx.de> wrote:
> > > > >
> > > > > Hi Bret,
> > > > >
> > > > > in that case, please try to find a way to trace the commands in =
a Tcl/Tk
> > > > > program (which gitk is) and see which command triggers the error=
.
> > > >
> > > > Er... that's a little out of my depth. I'll see if I can find time=
 to learn.
> > > > Meanwhile, is there any way to request better instrumentation for =
the
> > > > error dialog so this data could have been collected for me?
> > > >
> > > > >
> > > > > Ciao,
> > > > > Johannes
> > > > >
> > > > >
> > > > > On Wed, 9 Jan 2019, Bret Barkelew wrote:
> > > > >
> > > > > > Will try to reply in-line, when appropriate.
> > > > > > The latest snapshot (git version 2.20.1.windows.1.5.g6b286585b=
1) still
> > > > > > has the issue.
> > > > > >
> > > > > > - Bret
> > > > > >
> > > > > >
> > > > > > On Wed, Jan 9, 2019 at 10:39 AM Johannes Schindelin
> > > > > > <Johannes.Schindelin@gmx.de> wrote:
> > > > > > >
> > > > > > > Hi Bret,
> > > > > > >
> > > > > > >
> > > > > > > On Thu, 3 Jan 2019, Bret Barkelew wrote:
> > > > > > >
> > > > > > > > They are the exact same path (with a different drive lette=
r).
> > > > > > >
> > > > > > > [it's a bit hard to follow the thread if you top-post a repl=
y to an
> > > > > > > inline-replied answer, maybe imitate the style of other mail=
s in the
> > > > > > > future.]
> > > > > > >
> > > > > > > > Another thing I've been able to confirm is I uninstalled g=
it 2.20.1
> > > > > > > > and installed 2.19.0 on the failing system, and the older =
version of
> > > > > > > > Git works.
> > > > > > > > I've also tried a suggested fix I saw elsewhere to enable =
long path
> > > > > > > > names in the Windows registry, which did not resolve the i=
ssue with
> > > > > > > > git 2.20.1.
> > > > > > > >
> > > > > > > > Happy to collect any additional data.
> > > > > > >
> > > > > > > Please try the latest snapshot at
> > > > > > > https://wingit.blob.core.windows.net/files/index.html (I *th=
ink* the bug
> > > > > > > might be fixed via
> > > > > > > https://github.com/git-for-windows/MINGW-packages/pull/32).
> > > > > > >
> > > > > > > Ciao,
> > > > > > > Johannes
> > > > > > >
> > > > > > > > - Bret
> > > > > > > >
> > > > > > > > On Thu, Jan 3, 2019 at 7:10 PM Bryan Turner <bturner@atlas=
sian.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Jan 3, 2019 at 6:21 PM Bret Barkelew <bret@corth=
on.com> wrote:
> > > > > > > > >>
> > > > > > > > >> When I open gitk in a particular repository under this =
version of Git
> > > > > > > > >> for Windows, I now get a dialog box that says "Error: c=
ouldn't execute
> > > > > > > > >> "git": file name too long". I've noticed that the most =
pronounced
> > > > > > > > >> effect is that I cannot see the file diffs (or sometime=
s the file name
> > > > > > > > >> list) for any of the commits. I don't know the exact re=
pro, but I've
> > > > > > > > >> narrowed down the following things:
> > > > > > > > >>
> > > > > > > > >> - This does not happen with the same repo if I use a sy=
stem that has
> > > > > > > > >> git 2.19.0.windows.1 on another machine.
> > > > > > > > >> - This does not happen on my current machine in a fresh=
ly cloned repo.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > How =E2=80=9Cdeep=E2=80=9D are the paths to the differen=
t clones on the different systems? Are all of the clones at exactly the sa=
me path on disk?
> > > > > > > > >
> > > > > > > > > Git on Windows is (by defaulted) limited by MAX_PATH, wh=
ich is 260 characters. That length is calculated including the path to the=
 repository itself and then to the file inside the repository. That means,=
 for example, a given repository cloned to C:\repo may not have issues, bu=
t the same repository cloned to C:\Users\Bryan\Documents\workspaces\repo m=
ay.
> > > > > > > > >
> > > > > > > > >>
> > > > > > > > >> However, as soon as the remote updates with any changes=
 on a given
> > > > > > > > >> fetch/pull, the repo is put in a bad state permanently.
> > > > > > > > >>
> > > > > > > > >> I've pasted the output from gitk below...
> > > > > > > > >>
> > > > > > > > >> couldn't execute "git": file name too long
> > > > > > > > >> couldn't execute "git": file name too long
> > > > > > > > >>     while executing
> > > > > > > > >> "open $cmd r"
> > > > > > > > >>     (procedure "getallcommits" line 48)
> > > > > > > > >>     invoked from within
> > > > > > > > >> "getallcommits"
> > > > > > > > >>     (procedure "readcache" line 80)
> > > > > > > > >>     invoked from within
> > > > > > > > >> "readcache file827e200"
> > > > > > > > >>     ("eval" body line 1)
> > > > > > > > >>     invoked from within
> > > > > > > > >> "eval $script"
> > > > > > > > >>     (procedure "dorunq" line 11)
> > > > > > > > >>     invoked from within
> > > > > > > > >> "dorunq"
> > > > > > > > >>     ("after" script)
> > > > > > > > >>
> > > > > > > > >> Happy to gather whatever data needed.
> > > > > > > > >> Thanks!
> > > > > > > > >> - Bret Barkelew
> > > > > > > >
> > > > > >
> > >
>

--8323328-964857275-1559153267=:44--
