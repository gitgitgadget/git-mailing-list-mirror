Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ADB81F803
	for <e@80x24.org>; Thu, 10 Jan 2019 15:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbfAJPUR (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 10:20:17 -0500
Received: from mout.gmx.net ([212.227.15.18]:53473 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbfAJPUR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 10:20:17 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mb7lL-1h0Wif3NKl-00KkKT; Thu, 10
 Jan 2019 16:20:10 +0100
Date:   Thu, 10 Jan 2019 16:19:53 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bret Barkelew <bret@corthon.com>
cc:     Bryan Turner <bturner@atlassian.com>, git@vger.kernel.org
Subject: Re: git version 2.20.1.windows.1 throws file name too long in gitk
In-Reply-To: <CAGTkKajkW-U9mhh_GmTXmZQbnceEKX_BcMtOF4hOhEDZe2u9Bw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901101616100.41@tvgsbejvaqbjf.bet>
References: <CAGTkKag2sFy+Of=6uQeiGOQm0-NBrh9ixgzDoQXKR73+Ct3raQ@mail.gmail.com> <CAGyf7-HcncFOfmm5McEkOvCTkHNdePDSEQDZwEAK=z1bmC=QKw@mail.gmail.com> <CAGTkKag-fTy3iZAKJxEnWD6_b_3pfuYvQQKBkLaeSL8wKM2sfg@mail.gmail.com> <nycvar.QRO.7.76.6.1901091936420.41@tvgsbejvaqbjf.bet>
 <CAGTkKajkW-U9mhh_GmTXmZQbnceEKX_BcMtOF4hOhEDZe2u9Bw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-776849698-1547133610=:41"
X-Provags-ID: V03:K1:NyyoTZ0eTjk6ahhBKIBl0V+Z53pmmK6itqH8UC+YeTOWjEvpB5i
 M3KZv0kqdcZRY/aTrRHG4Oo3Y8BdB0/mNnghBcJnjOQkZWADtC7zDL3DnAl70xmeh6EyLd9
 49o/+hlzrKseCuLCNkQ0nonxQfwWNKK/iv25UUHZelLBlQm/QKuJa3zwSrRdVe9FfLnyTLn
 2KMV091BnKk5CqDYGRUrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ms+Z9wivrk0=:mtOBoWI3PJi1yX3ICz25jH
 3VsTrK6VuGRWSaUqvSNkIZC4DU4mtvsKef2Kn+pSF3eFZgUrFfxJt3uH7ABGrkSgCExNNvSZp
 mYp2kKtWK+fVSm0gc7jvfdM6hCypdW/1ilXKEK9lrvN8E4e42zVstKhbVWDmgdrUN+OwZjgJQ
 v3tIDGwW4aVNp7aZXHvIigbN+hOuPA6aEudeFVnOUDY5fmx/8Dz9D+NbOOc0ourEjDyWavcLF
 2WJZwiE2JffXL1IsPaCxVZ7rQnzo6Mmdy70YlMeds+EOHIpitUbkumT628okNopt0KXZhmbME
 WpqT+Og1ULUBqgHUkIBftHn31Hsbvyg++/x3FOks+Y9rW4lYYggjyx/+oPGlr/j1VkCafxoXV
 qeI/mfDSJrxDjZO6TmCm3wR9QxKZ4eX0vSsjQUn6iiqhQ9Mo/mBTcMYmXFyKsyiu7CqL3ZAig
 5EAmS/+eGwM0gKcApo+sDXSRLZsb69M196IbCAsJvKeh+RQGylD1MdDDOameTJhVepbRnZH1J
 KX6a5nbcmLFzr5juVWojph0aFF+y4Fnxkxm67EmDHBsE45dR0oL3pqADiz7cohwbYlAImtOqC
 l4FGfmSFrkudeBWIYpDydfK9+KMJHaGpgrYw5ooDdz+ZITxB2pjhIxkcR84Ego1Pc2P+OsAgm
 BEYJAyC1L0mofvmS1TfIKNRI7POpD5Q4rmVwE8leDK4SoTD3ErkY9pnsWEPFxQWh6cgN6IRWM
 50RTR/7tmtIFGuSQoLFk+zrj8Y5LECdSa9LZKxgDjzbH1OHWV87BY1nrYqfRyDzMJVmp0lO+g
 fyyFbQUQb1JDo364zvDdyDJ16Pqhv2EOJ9f1Pqll9alTP4tGX015Kx4YnA3pKCcUREgqxJTaR
 PT0Th4i4eri82xMigyz9c6kpTX1bjIUBjYH954PCftWKTyV1Og/W5aVz3QI2jYEz4ijV+lEyx
 UN/N8fjzNVw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-776849698-1547133610=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Bret,

in that case, please try to find a way to trace the commands in a Tcl/Tk
program (which gitk is) and see which command triggers the error.

Ciao,
Johannes


On Wed, 9 Jan 2019, Bret Barkelew wrote:

> Will try to reply in-line, when appropriate.
> The latest snapshot (git version 2.20.1.windows.1.5.g6b286585b1) still
> has the issue.
> 
> - Bret
> 
> 
> On Wed, Jan 9, 2019 at 10:39 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi Bret,
> >
> >
> > On Thu, 3 Jan 2019, Bret Barkelew wrote:
> >
> > > They are the exact same path (with a different drive letter).
> >
> > [it's a bit hard to follow the thread if you top-post a reply to an
> > inline-replied answer, maybe imitate the style of other mails in the
> > future.]
> >
> > > Another thing I've been able to confirm is I uninstalled git 2.20.1
> > > and installed 2.19.0 on the failing system, and the older version of
> > > Git works.
> > > I've also tried a suggested fix I saw elsewhere to enable long path
> > > names in the Windows registry, which did not resolve the issue with
> > > git 2.20.1.
> > >
> > > Happy to collect any additional data.
> >
> > Please try the latest snapshot at
> > https://wingit.blob.core.windows.net/files/index.html (I *think* the bug
> > might be fixed via
> > https://github.com/git-for-windows/MINGW-packages/pull/32).
> >
> > Ciao,
> > Johannes
> >
> > > - Bret
> > >
> > > On Thu, Jan 3, 2019 at 7:10 PM Bryan Turner <bturner@atlassian.com> wrote:
> > > >
> > > > On Thu, Jan 3, 2019 at 6:21 PM Bret Barkelew <bret@corthon.com> wrote:
> > > >>
> > > >> When I open gitk in a particular repository under this version of Git
> > > >> for Windows, I now get a dialog box that says "Error: couldn't execute
> > > >> "git": file name too long". I've noticed that the most pronounced
> > > >> effect is that I cannot see the file diffs (or sometimes the file name
> > > >> list) for any of the commits. I don't know the exact repro, but I've
> > > >> narrowed down the following things:
> > > >>
> > > >> - This does not happen with the same repo if I use a system that has
> > > >> git 2.19.0.windows.1 on another machine.
> > > >> - This does not happen on my current machine in a freshly cloned repo.
> > > >
> > > >
> > > > How “deep” are the paths to the different clones on the different systems? Are all of the clones at exactly the same path on disk?
> > > >
> > > > Git on Windows is (by defaulted) limited by MAX_PATH, which is 260 characters. That length is calculated including the path to the repository itself and then to the file inside the repository. That means, for example, a given repository cloned to C:\repo may not have issues, but the same repository cloned to C:\Users\Bryan\Documents\workspaces\repo may.
> > > >
> > > >>
> > > >> However, as soon as the remote updates with any changes on a given
> > > >> fetch/pull, the repo is put in a bad state permanently.
> > > >>
> > > >> I've pasted the output from gitk below...
> > > >>
> > > >> couldn't execute "git": file name too long
> > > >> couldn't execute "git": file name too long
> > > >>     while executing
> > > >> "open $cmd r"
> > > >>     (procedure "getallcommits" line 48)
> > > >>     invoked from within
> > > >> "getallcommits"
> > > >>     (procedure "readcache" line 80)
> > > >>     invoked from within
> > > >> "readcache file827e200"
> > > >>     ("eval" body line 1)
> > > >>     invoked from within
> > > >> "eval $script"
> > > >>     (procedure "dorunq" line 11)
> > > >>     invoked from within
> > > >> "dorunq"
> > > >>     ("after" script)
> > > >>
> > > >> Happy to gather whatever data needed.
> > > >> Thanks!
> > > >> - Bret Barkelew
> > >
> 
--8323328-776849698-1547133610=:41--
