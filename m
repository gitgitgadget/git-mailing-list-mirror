Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7F6C433EF
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 21:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242566AbiBFVek (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 16:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242531AbiBFVef (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 16:34:35 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEFEC061355
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 13:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644183271;
        bh=Tcb6DESfXddtjuhSCOeEaNYqbhbQ4cKYxWSdPrNntaU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GbsTg97OAbrVDzxo8Ew4fzgQwSMVaSGx2UT+pdTEWLi/9jdfKbMB0kxvm/UryDu+R
         c0Q34FTZrUvZJffjAvtx9aCmydwcC7Ablpwr4cHAoYAGIqGdHQdytW1KkuDxRIcv+v
         /JdUe/ODz6K1AXdn9BoPGRHDroREI6KSoju1PDq8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.212.206]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0Fxf-1oE82412WN-00xKaB; Sun, 06
 Feb 2022 22:34:31 +0100
Date:   Sun, 6 Feb 2022 22:34:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Taylor Blau <me@ttaylorr.com>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/5] Implement `scalar diagnose`
In-Reply-To: <YfHJHbMKA1u+A9LF@nand.local>
Message-ID: <nycvar.QRO.7.76.6.2202062225460.347@tvgsbejvaqbjf.bet>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com> <ce85506e7a4313a4ae21ef712b84d8396ac45cdc.1643186507.git.gitgitgadget@gmail.com> <f48cdebb-ff49-24b0-973f-b3e7954e11c8@web.de> <YfHJHbMKA1u+A9LF@nand.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1112833765-1644183271=:347"
X-Provags-ID: V03:K1:YxVyNDoGG2JLxwPnGtqnVX8fUmiyXLrJAzkEujb8Iy6XbdVyJR/
 4HfQ7KXjY6alw/w6Hp4TdaJELBlz5RxbPl9YKSNNhTbP1LtaFHFiRnH87IfxuGRR5/TFxiD
 fuTCB4XL4IyvF2ZPeDBO4txQ824aHqx6nLal6Kbl1nYnX867pwA+Yp6JwGwQQUrzAw0cJPB
 Eqmnvc/JMU3sVCpInkoWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:trS4V/7CcJQ=:g3wWk4mFqwrOSpckXTpFP4
 qP8R2gyA28aivnoawl5GlallRCG0CiGODRAacpB3ND4leif+oISvo/rCCFWgIfwbuDhw3gaYs
 nkwaawTSzYsKD25gUO54GurRrpZyk2LGmt6oqITDtLd1xwqs3PvrcI7A+WWBCpa3y2bwjVAaw
 BjUyszGIf9b78yvo9RE/2/WmD3WCtN2+KSn1+GELpg2WtQAh2N2WlQMTNd+o8MVCS34SJmNeN
 47nl39WllH+79b/Hi9CVF0ohY1ratDeh8QmAn5z7Nd+2pqQDXhRKCJFvNAkTQ/QSxY8vFs9AE
 G96do3puWOqzqQNodk22UpxT5pyX/oqoYBIw4omDxvvuYSFg6YQd57DWeEkfeMM3NFNeH8jSB
 ni/ySk/fCRqxM3nrBOEjydRZJc4hPqxeQNR2FS0eJq+r16C/EPc8QEe4brGg5pPgU8UItSk1X
 E0X4TSeiHaPB4SYt238gjlAJcwfrqLfLFhL3KPEvtSgJiW0Tx2xkRznuoXMUkaPrlkCryigzP
 4hNEsCjFyYeYxz116DMDHU/e+tzE4SvBIkeHKG4+GNi0Wg0l7GPluEJ4MvEdI3s0NGO1yj8eR
 jQSpWrO6pqTMnwek5efDRcisUF1+sjQCpneHjHvShJI0MKFBBTtFzzlbwP/3Q9RwJp4IoZQOS
 aSk24LVaF+yjYyGezipNsvZYbjnX+3OyN0tIl5hVjku8tpqMWEsJcN1eyVwuOcWyMjwaSB77m
 LTsk7TOosoMInPBBAL+jGtDzfH2f78i0DyrJ2kPMTICjRj8jfZapgfOFgLTrS57Hnmu2jiG4J
 IWH6iMF3+DXsLwv0dDoCWkX7oKLf2CM8E0nGOtMS1UhwJubr4fb/LEe7vZ1l84P7p5LTzJgA8
 mphWidzbz5Oz3977xPQaNyuauasrmLHLe3m9fF9L8Arly4p4vmEPOkuzfVTX0Px0VH9g57CgM
 eA3C4EREnDhDFsA1lOfvDbQNN9mEBhQtAltl9VWpIPK6M63UmKBJILEAtBjXwsFRMY/XMLBiu
 DTJehEk6LjdJ0IBnde7bAhfpkSJTLdPoNmmWzgD82dQ/TcfEy2v7GmxWFpC/d9Wm/9Rq8VP+/
 v2rya6XZ9XV6Ck=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1112833765-1644183271=:347
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9 & Taylor,

On Wed, 26 Jan 2022, Taylor Blau wrote:

> On Wed, Jan 26, 2022 at 10:34:04AM +0100, Ren=C3=A9 Scharfe wrote:
> > Am 26.01.22 um 09:41 schrieb Johannes Schindelin via GitGitGadget:
> > > Note: originally, Scalar was implemented in C# using the .NET API, w=
here
> > > we had the luxury of a comprehensive standard library that includes
> > > basic functionality such as writing a `.zip` file. In the C version,=
 we
> > > lack such a commodity. Rather than introducing a dependency on, say,
> > > libzip, we slightly abuse Git's `archive` command: Instead of writin=
g
> > > the `.zip` file directly, we stage the file contents in a Git index =
of a
> > > temporary, bare repository, only to let `git archive` have at it, an=
d
> > > finally removing the temporary repository.
> >
> > git archive allows you to include untracked files in an archive with i=
ts
> > option --add-file.  You can see an example in Git's Makefile; search f=
or
> > GIT_ARCHIVE_EXTRA_FILES.  It still requires a tree argument, but the
> > empty tree object should suffice if you don't want to include any
> > tracked files.  It doesn't currently support streaming, though, i.e.
> > files are fully read into memory, so it's impractical for huge ones.

That's a good point.

I did not want to invent any `fast-import`-like streaming protocol just
for the sake of supporting the "funny" use case of `scalar diagnose`, so I
invented a new option `--add-file-with-content=3D<path>:<content>` (with t=
he
obvious limitation that the `<path>` cannot contain any colon, if that is
desired, users will still need to write out untracked files).

> Using `--add-file` would likely be preferable to setting up a temporary
> repository just to invoke `git archive` in it. Johannes would be the
> expert to ask whether or not big files are going to be a problem here
> (based on a cursory scan of the new functions in scalar.c, I don't
> expect this to be the case).

Indeed, it is unlikely that any large files are included.

> The new stage_directory() function _could_ add `--add-file` arguments in
> a loop around readdir(), but it might also be nice to add a new
> `--add-directory` function to `git archive` which would do the "heavy"
> lifting for us.

I went one step further and used `write_archive()` to do the
heavy-lifting. That way, we truly avoid spawning any separate process let
alone creating any throw-away repository.

Ciao,
Dscho

--8323328-1112833765-1644183271=:347--
