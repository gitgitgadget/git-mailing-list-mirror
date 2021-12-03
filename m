Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE70C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 22:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383349AbhLCWSs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 17:18:48 -0500
Received: from mout.gmx.net ([212.227.15.19]:35607 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240628AbhLCWSr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 17:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638569713;
        bh=MF1+Go56aR7WChGVMl/hLYdQ1AXXEYCwrDrUolPFFrM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jvkSWjEt84YOHRQozuVRzZdRWm+fdXbNkn/YuvgQ0GPoAU5WgEnt/AM7f5s3s6ZOC
         WCztVNuVnXmmmfJGQLpAU7FARditcplyBm5LH4e+f1omgQuRiFd8X6LihgB8QALv0q
         pHstXdhAHVHLr3F2K5WRs0K1p91DaOqYexbR1do8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.223]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mr9Bk-1mG5zD1ove-00oHSs; Fri, 03
 Dec 2021 23:15:13 +0100
Date:   Fri, 3 Dec 2021 23:15:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>,
        git <git@vger.kernel.org>
Subject: =?UTF-8?Q?Re=3A_patch=3A_change_=E2=80=9CEverything_up-to-date=E2?=
 =?UTF-8?Q?=80=9D_to_=E2=80=9CAlready_up_to_date=2E=E2=80=9D_?=
 =?UTF-8?Q?=28No-op_messages_for_git-push_and_git-pull=29?=
In-Reply-To: <CAPig+cRRxYmFqYimTHSi9uzmWU0FRXQ2hGXJK6jYLJcsFce_Rw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2112032310300.63@tvgsbejvaqbjf.bet>
References: <VUYC3R.9YCVE0AMVVIF@anselmschueler.com> <CAPig+cRRxYmFqYimTHSi9uzmWU0FRXQ2hGXJK6jYLJcsFce_Rw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1029731150-1638569713=:63"
X-Provags-ID: V03:K1:uHYoNCkoi5bhJR0tjtUkxE0t8Af/kmvUDVtqJlCxeARhZegXRCg
 /3k4nimvk6EcYK38OSo4Uc4l5wh1vUagpRfBJk+XdCe8ecmZZ654Zz+Qg5+oxVuFTSh/n72
 CJR45d+sq64rqA9meiFf6ruRK2ysmKjc0Mc21N81rNyS5idSxmhAj+sAt1wh9QEBE2ki/io
 LNeElMBnFVFD5t+yN4aoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9ZoCotHz4PY=:ge+sjCiC+Ssmb2kWYgQ4d0
 9REhN1A8U2XCkfag1I0oKTKvGqyl8HHl0f7/jXaNP+mAokM7/x1/VFRjWWMg0S/ciydUDkNXx
 T/Lry/EXQapAZAlTeBP4JRUH1hD75SGr2RT1/E8ihJEqjtgcWjpB5f/GkLJGzaN2oT4GUxkVg
 HV4Rpqydq6oy+0uioNArnQxlYbmExYS3GGLDCCZPFq5qM0DiR4Qgi+fpuir8+zdjeDtk0fp/1
 u2bm62An4POVT3D6ksUFq8vDT4aP4uWyxbgOjxxUUhTk7MF/Q/cRc0NLgHQKgHbwfQvEafRuS
 Lp5yrrm9p8zJHz/bT5KXO4FLOurxALgFxfZQmQwWuIHTcQojAyHzMRUp7h6CiruTYIZliQC82
 mq2tzJE6hXV59928zdhPP5yXqkAPrIT3z3jzRXMKXrhzImiSmr24G3V9REC6Ew8lrgnM9RKpt
 qvXdnyPj2bjIDqbFtcSRNKTVQQWWDuw6q7UiJ02NInddMCeJmO4bVtTgePDGmbtHLas6rqt1Y
 NBGcTKtauINzIyCzQJdoND328UNw0ffVaAtiRAFPBIkRaM77yyXydPhn6nxFI04X302v6FdmQ
 IIqSHtJn+hy2jkudSsT1d7C1+yaG75DhUBB442ui1+krtOHjmPgMxtM6lttBr4NBXyqqei3MG
 BROSgGggoHJzih0NIZs54Z5rGz77+boFHPIR19wAeLZfGA34t2tW6MBIjQ6RGOgLy7Ld9B4Vp
 BMTV2i+FBYyiLM7p55Vykuu/y0fg7qNTZMXe/Ha78CrQu3I3d5aWdyAyHSUTnFaAIZI6VMMJx
 BIQHYxomE+J4EWN+CCdMPCaEJQ7+K0Lf50YiIluDjlz1c5tVMl2pI8SKcu77yF45ZRav9y2k+
 S10N1LEI4kBRdK9UJm3Yo9IL+HT0BcB2MOPz3zFDoxffKh0EYiGhNDnsWPce74eQiVGFnSIYr
 hArBnz+MaUEUD/rUXUk0T1m1sNdQMlWCzTXHvFSZLh4ymCbUa06YbvrIv7MUqLfNGpD8azux6
 dZCLSmbTnZNymLLUaM7PpIsKbLa66AudPo3Ik/ntaEUdqfNJImEM6lwDXn87MnmZSGWkx0sam
 WkqiskfnrWxPos=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1029731150-1638569713=:63
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 29 Nov 2021, Eric Sunshine wrote:

> On Mon, Nov 29, 2021 at 7:04 PM Anselm Sch=C3=BCler <mail@anselmschueler=
.com> wrote:
> > Why are the no-op messages for git-push and git-pull (i.e. when remote
> > and local are identical) so different, while describing something very
> > similar? IMO the messages should be either identical or very similar.
> > git-pull results in =E2=80=9CAlready up to date.=E2=80=9D, while git-p=
ush results
> > in =E2=80=9CEverything up-to-date=E2=80=9D.
> >
> > It should be considered that other messages reading =E2=80=9CAlready u=
p to
> > date.=E2=80=9D seem to use a translation system, it might be better to=
 use
> > that system here, too. Unfortunately, I don=E2=80=99t know how to do t=
hat
> > (currently). At any rate, this patch could serve as a temporary
> > =E2=80=9Cfix=E2=80=9D.
>
> This question/issue is raised from time to time, and the short answer
> is that send-pack is plumbing, thus there likely will be resistance to
> an arbitrary change of text. Denton goes into a bit more detail in his
> reply[1].
>
> [1]: https://lore.kernel.org/git/20191122180433.GA57478@generichostname/

As an additional data point: changing the `git pull` message (actually,
the message comes from `merge-recursive.c`, I believe) from "up-to-date"
to "up to date" in 7560f547e61 (treewide: correct several "up-to-date" to
"up to date", 2017-08-23) broke applications parsing that message (IIRC
Visual Studio was one of those who had to scramble to adjust their code
accordingly).

So yes, we are pretty reluctant to change such central messages.
Sometimes, correct grammar ain't worth the cost it incurs.

Ciao,
Johannes

--8323328-1029731150-1638569713=:63--
