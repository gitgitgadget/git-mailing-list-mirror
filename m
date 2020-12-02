Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E40C64E7C
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 12:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA4AE221FE
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 12:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgLBMeU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 07:34:20 -0500
Received: from mout.gmx.net ([212.227.17.22]:38637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgLBMeT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 07:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606912361;
        bh=ST4DkPwh8aLSkWju35ZhpqqdUCQNCxtsNJO1wDrrIr8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PUYPabJEZN8wkxkAJDoIob7f8iZI7DHA2DXmPyAg7g7pQbWcQBWj8fn0EFV/OH2YW
         0Llq+nhQ7M4e9ecxYdoK45VGgQx40KUrBJEv/vUyASB/QLbE+g5LzDVYHxU2mlwtvG
         HnQYov2Ivb+4/FxK4fDUceZHPQV72oop0TRzGB1w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([213.196.213.207]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDywu-1ksB4O3Nem-00A1LE; Wed, 02
 Dec 2020 13:32:40 +0100
Date:   Wed, 2 Dec 2020 11:57:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Han-Wen Nienhuys <hanwen@google.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/6] fixup! reftable: rest of library
In-Reply-To: <CAFQ2z_N=sZuYorZxNLn-OoWjb6y=1zrc7sCPuKzZHQODi08s+Q@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2012021149030.25979@tvgsbejvaqbjf.bet>
References: <pull.801.git.1606545878.gitgitgadget@gmail.com> <878bffcdfe5ca7657f839de8f7993d9098726636.1606545878.git.gitgitgadget@gmail.com> <CAFQ2z_N=sZuYorZxNLn-OoWjb6y=1zrc7sCPuKzZHQODi08s+Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+t892ZaNkPKxCyy0UvBTCLOTTB6jzZeKh3A2IPjyGm5xla6o0nJ
 1DPmv//UJEsJPB7QGXoAIUJ2HELuQqHvcIdwSetZyy46k6liAJ+CbUcgZtLoZBZhJq0HkOK
 z9rTLK/XF/SW0Wffr4buuuSJFsAGIJ6IJMbxinO3Bcqe0p/0P/4jtFZHwg+VHQj+fKwsnlY
 Do0x46DQUJtU2A3etvCiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VGz3IrEofdY=:sOWb7KiqrJgkyYUS3tHf5X
 moNXK7qp31/WGKKOAKu9wDap2Y//PQ4ruZ4VELUn9m0UrTfMKIf/hHrcRxt6lMCHcLcGaxRiY
 ku1nF7H7KqW3D+Z9LFgCVJRObfKey0a+xFEAlWO/Apou9MLU4RVXhUHs9obhW9rSBR5tBlRLV
 o5js7pzq2CkT3gr3gDh7zHo8iVT0Zaelha8J6y2P+Nh/A8LfsGLW9HXNwbtz3oydPloi6fk5z
 K+oh70NdWLtCKXaRBQ2zw5VTKQjpaNLtQhMD0Q8lIJoM/mgTuy7q8YZAVSxfnC024GOp2qLBj
 l05lvneFj6byKTgilwAxm3trctRTA6ijId7qVyMd3Psq5O2lFVMZ3KOR8XHzWyGikzulG4Mto
 MXzomSQVKFYX7naTf6Injm0ata+mIE09f+WYEVd4F2vAQ0IpPvbnV/7jXnIvK04tISPBYmDFL
 dF5+HtHYXwRc0RRYHl/6ZwMwRzeBnD46J/ZAzYifQnqbUwMo781g5qjCIL8M2n7/MFWvIGnNH
 Juay8qKqxPZ7OezSdiL5B7ir1WdyROrgcDdJ+0VIbz3gdgXe7H96QmaCQzq27nqDs3SXE52o2
 nm8syDtf8BI9+tRHNkDLb/LTuZa1XY2jhIQ2qoxtiwlSqTmCd2Pl5AK14/lqP4KeVttRSsOsb
 Smm2gRC6R+n6h9gcXjF900MZEZy5XIIXNgWVw3QBUQWWJ6jXxeDIgNXAJRvna+k0D9umIXGlg
 sF0Uu+7vy4vQicXkC2YoRHDFAtL1EhyT1+tXCaggjYUwi8Xx2m1dWlSwduLlkCR5/yKMjfLPL
 aB2OFQiWHrDqNOGiDuKdEIxVp3S7H9qjrpcaF5zjJH2eIdE0H+akRSHpxVN4zxtAjmcLZ0qbZ
 p0w0N5gaXL46T/fanYGvxdU+3RqB58tSrMLCXjbBs=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Han-Wen,

On Tue, 1 Dec 2020, Han-Wen Nienhuys wrote:

> On Sat, Nov 28, 2020 at 7:44 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Close the file descriptors to obsolete files before trying to delete o=
r
> > rename them. This is actually required on Windows.
> >
> > Note: this patch is just a band-aid to get the tests pass on Windows.
> > The fact that it is needed raises concerns about the overall resource
> > handling: are file descriptors closed properly whenever appropriate, o=
r
> > are they closed much later (which can lead to rename() problems on
> > Windows, and risks running into ulimits)?
> >
> > Also, a `reftable_stack_destroy()` call had to be moved in
> > `test_reftable_stack_uptodate()` to avoid the prompt complaining that =
a
> > `.ref` file could not be deleted on Windows. This raises the question
> > whether the code does the right thing when two concurrent processes wa=
nt
> > to access the reftable, and one wants to compact it. At the moment, it
> > does not appear to fail gracefully.
>
> Thanks for the report; I have to look more closely at these fixes; I
> fear they might be incorrect.

They might be incorrect, but less so than the previous state, as testified
by the previously failing PR build.

> The reftable spec doesn't treat this case in depth, and I think it was
> rather written for Unix-like semantics. In the Unix flavor, a process
> that wants to read can keep file descriptors open to keep reading from
> the ref DB at a consistent snapshot.

Thanks for the explanation. I actually knew that.

> What is the approach that the rest of Git on Windows takes in these
> circumstances?

The rest of Git (whether on Windows or not) treats this as a no-no. You
cannot keep a handle open to a file that is deleted.

> Consider processes P1 and P2, and the following sequence of actions
>
> P1 opens ref DB (ie. opens a set of *.ref files for read)
> P2 opens ref DB, executes a transaction. Post-transaction, it compacts
> the reftable stack.
> P2 exits
> P1 exits
>
> Currently, the compaction in P2 tries to delete the files obviated by
> the compaction. On Windows this currently fails, because you can't
> delete open files.

Indeed. So the design needs to be fixed, if it fails.

> There are several options:
>
> 1) P2 should fail the compaction. This is bad because it will lead to
> degraded performance over time, and it's not obvious if you can
> anticipate that the deletion doesn't work.
> 2) P2 should retry deleting until it succeeds. This is bad, because a
> reader can starve writers.
> 3) on exit, P1 should check if its *.ref files are still in use, and
> delete them. This smells bad, because P1 is a read-only process, yet
> it executes writes. Also, do we have good on-exit hooks in Git?
> 4) On exit, P1 does nothing. Stale *.ref files are left behind. Some
> sort of GC process cleans things up asynchronously.
> 5) The ref DB should not keep files open, and should rather open and
> close files as needed; this means P1 doesn't keep files open for long,
> and P2 can retry safely.
>
> I think 3) seems the cleanest to me (even though deleting in read
> process feels weird), but perhaps we could fallback to 5) on windows
> as well.

Traditionally, Git would fail gracefully (i.e. with a warning) to delete
the stale files, and try again at a later stage (during `git gc --auto`,
for example, or after the next compaction step).

> What errno code does deleting an in-use file on Windows produce?

I believe it would be `EACCES`. See
https://docs.microsoft.com/en-us/cpp/c-runtime-library/reference/unlink-wu=
nlink?view=3Dmsvc-160
for the documented behavior (I believe that an in-use file is treated the
same way as a read-only file in this instance).

Ciao,
Dscho
