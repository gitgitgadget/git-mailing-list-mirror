Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAFB520248
	for <e@80x24.org>; Fri, 29 Mar 2019 14:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfC2Osg (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 10:48:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:53855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728848AbfC2Osf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 10:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553870908;
        bh=gfDnWVHTHbUHt8Oa4c/wR6y0jqUWglzTsd/i23Pr7Iw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=L89Ztu31lsdqhPjGfo+IhzQ75zq1RPGJafhMfl1LobhBkkt6swq4c42/D99CBY5zl
         3s0Ca0989G5mo9LABY0D4Iro4AQF9/L7hGrggQIE4IzKfnac4kNPLs3FuHqdNvg9Y1
         DCvNCSe5lBrxvk47UhUy8d/nbJI01XsAH6LraJQY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lmqxo-1gT7Sa0JLw-00h8XC; Fri, 29
 Mar 2019 15:48:28 +0100
Date:   Fri, 29 Mar 2019 15:48:28 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] docs: do not document the `git remote-testgit`
 command
In-Reply-To: <nycvar.QRO.7.76.6.1903272317550.41@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1903291546010.41@tvgsbejvaqbjf.bet>
References: <pull.162.git.gitgitgadget@gmail.com> <pull.162.v2.git.gitgitgadget@gmail.com> <810d2c5a94b40544652c97ffa644b29e0db8af82.1553550094.git.gitgitgadget@gmail.com> <87a7hhbszc.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.1903272317550.41@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-108526342-1553870909=:41"
X-Provags-ID: V03:K1:8BfmlyZJDRiKL0tfqDflBvoeqnD7W6fBlvM0H3INsOzHL1g7Tul
 5jc4mQoRkIjxMADH51aIJpp3yZhQS6YAkyTAIrV9nb3WKa2ZuJDhXsWo4ZqIgJKifKQWYCN
 2BDVHuz2jMphDuzXbOr3UxZ9uuJR75OMPey/YHffpuflb8qasTzmyU8Hx86BKcA+gwC3NhC
 BzccXajrffjuaZxETkv9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+DhMEe2Lst4=:MLSXPnUlutCQbmlJr5/BP9
 6KSdKH1R9hIU+7SVenIp5geRLpuVgijxcaIQVOBmuYQ93yXhUQGId16XsRRjE2McRI/H5nYLo
 bihAfcwjW5RSLNJUGdjfjiQoFNN9l07E69U/SEETTg/lInIg6KKiqecUHE2m8M8jxDxrqimTu
 csRYyQKTxNOf+qJzeo0OBk1oQ7YKjneKTruUs2YHYoI6iVFqTXYbBR6Xd8gL8ycKOVagF3vph
 4yB5AHQbCfUHMAk4r98rEt8FoUBfvvH6YSgrjU1ceci3UXxSvmasuoXTUnMsW4Wi/LrtemwJq
 XVq9wL/LlzM3DVPlDNoC/qAV0GEdkInUeD4tPbZFLC5p4bNttkukH+jpHkU2gZ0uiPFtsZemG
 LRMQN6XewHdSBIMyBvRdFEEphF/en1yqmhsVzaurSP0HGWMP5tur/qzXMOqMvmK8QVel1joyd
 8CEV8CVECvt+MFNCBJcTadoinlhPQna0g2g1nrstLPmtJIr455gzkzRypmCV9B8rETZoEXNfY
 1z5nxwm6pGQnVhXnFp0Yr0Cd6d3hNvKD44krUUJY01Nd755RLkFhxhqCvGzkJKiw5scFO535M
 uMVWYWk+XOOLio/3tTIDw5e1zNmBjAEgAxZti0j4RUxWLCTcSXrI5My1GVkOlk8KYlnQ4rO9h
 97sIj3SE1fy9Oj23fFOA+mQf5IAPfXEQTksjatXZJx+N8qbViuRoU/iz2UJcgrbY5iJIdzCa8
 97PR7Zdd3U8Aeuk+awgIE4iJ9mT/xLODM4275+jkAa88sZJNkM47JbSW+tZQAAVcmKMdUoqb4
 /F9CI4wisYcKrG+bn8BdqKEOcflP3vokO9ynia/qu1/KMp7lSl3fAWkju4juCUurOlGLPGYlk
 cwmTEZW/FLEaOETJAQWAGbjfNngcILx/iyOHoOC4vlnerT2ibb1jqeR/ZDDZ+bAr4wl/+bG1P
 LJtMWfFpi+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-108526342-1553870909=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 27 Mar 2019, Johannes Schindelin wrote:

> On Tue, 26 Mar 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> > On Mon, Mar 25 2019, Johannes Schindelin via GitGitGadget wrote:
> >
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > >
> > > Since 7ded055401 (build: do not install git-remote-testgit, 2013-06-=
07),
> > > we do not install it. Therefore it makes no sense to document it,
> > > either.
> > >
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> > >  Documentation/git-remote-testgit.txt | 30 -------------------------=
---
> > >  Documentation/gitremote-helpers.txt  |  2 --
> > >  2 files changed, 32 deletions(-)
> > >  delete mode 100644 Documentation/git-remote-testgit.txt
> > >
> > > diff --git a/Documentation/git-remote-testgit.txt b/Documentation/gi=
t-remote-testgit.txt
> > > deleted file mode 100644
> > > index b45bfebba5..0000000000
> > > --- a/Documentation/git-remote-testgit.txt
> > > +++ /dev/null
> > > @@ -1,30 +0,0 @@
> > > -git-remote-testgit(1)
> > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > -
> > > -NAME
> > > -----
> > > -git-remote-testgit - Example remote-helper
> > > -
> > > -
> > > -SYNOPSIS
> > > ---------
> > > -[verse]
> > > -git clone testgit::<source-repo> [<destination>]
> > > -
> > > -DESCRIPTION
> > > ------------
> > > -
> > > -This command is a simple remote-helper, that is used both as a
> > > -testcase for the remote-helper functionality, and as an example to
> > > -show remote-helper authors one possible implementation.
> > > -
> > > -The best way to learn more is to read the comments and source code =
in
> > > -'git-remote-testgit'.
> > > -
> > > -SEE ALSO
> > > ---------
> > > -linkgit:gitremote-helpers[7]
> > > -
> > > -GIT
> > > ----
> > > -Part of the linkgit:git[1] suite
> > > diff --git a/Documentation/gitremote-helpers.txt b/Documentation/git=
remote-helpers.txt
> > > index 34a3e60d08..2fc4007525 100644
> > > --- a/Documentation/gitremote-helpers.txt
> > > +++ b/Documentation/gitremote-helpers.txt
> > > @@ -513,8 +513,6 @@ linkgit:git-remote-ext[1]
> > >
> > >  linkgit:git-remote-fd[1]
> > >
> > > -linkgit:git-remote-testgit[1]
> > > -
> > >  linkgit:git-fast-import[1]
> >
> > I wonder if it should be moved into e.g. t/helper or somesuch at this
> > point...
>
> Sure.
>
> One thing to keep in mind is that we cannot change the actual name of th=
e
> executable, as it needs to have the format `git-remote-*`, and cannot
> require a first argument `testgit`, to be able to perform its purpose.
>
> We do have a precedent for that kind of scenario: `test-fake-ssh`. It is
> also not folded into `test-tool`, and it is copied while changing the na=
me
> to `ssh`, as required to fulfill its mission.
>
> I am not totally enthusiastic about this because this is what prevents
> Git's test suite from running in a RAM disk on Windows, IIRC: I have not
> been able to convince my RAM disk provider to allow executables stored o=
n
> it to be executed.

Oh you know what? `git-remote-testgit` is a *shell script*.

So that one was easy...

Now, the question is really, should I just add this patch *here*, or to
the non-Windows-related docs fixes I have lined up?

Decisions, decisions.

Ciao,
Dscho

--8323328-108526342-1553870909=:41--
