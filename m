Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D780C433DF
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 13:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B905D206CB
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 13:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CHUQS04j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbgJINC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 09:02:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:56679 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388051AbgJINC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 09:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602248539;
        bh=fZmlBl+lNn5TpmcFS4ptgIjr3xO6EXVK9ZX1TPguxhg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CHUQS04jRb9VV96Bib8ZZj0afMnlorg3ln0cgle2fxGuEIz53e8BZkmJmm59UGlDn
         VNBufBCh9QCJt3U6KOMSQhnlqLehMXUIsz90P0tFSNQ7OhLuoly0WHIFcuBiuoq3it
         J4DHhDSGGNHo8fdSHps0rWFx6yEOieZ69QyTpbNo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.213.205]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N95iR-1kOTTo1mTv-0167iv; Fri, 09
 Oct 2020 15:02:19 +0200
Date:   Fri, 9 Oct 2020 12:44:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        tytso@mit.edu, Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] core.fsyncObjectFiles: make the docs less
 flippant
In-Reply-To: <87eem8hfrp.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010091219480.50@tvgsbejvaqbjf.bet>
References: <87sgbghdbp.fsf@evledraar.gmail.com> <20200917112830.26606-3-avarab@gmail.com> <xmqqv9gcs91k.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2010081012490.50@tvgsbejvaqbjf.bet> <87eem8hfrp.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1671604778-1602240278=:50"
X-Provags-ID: V03:K1:wdWnPyaEsATVpuSlL6/9AdbDM366ZdlXcGblcp3j3EAOf0DZUMQ
 E9JKWjSASdhwq2yczSynJ/SPAVkzjK4TlbY/sPXyLnCnh08PjdMIJL5IfZAle37PVCBuXYR
 6wQO+p6p2/kjUj9Udeg0WAcEo8RhJlgGiZWFxbchtbANBMvAvD65aA3zI4MlD23rZMFYkGb
 YDo02nIxiW3x27R9BBBpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y7kzDP1Bknw=:QCH9eFzF7eeg16I6LKy5pB
 Sc6UQ3nsOewusik2ZlFnze5zAUcAuXke6TLSmQj2p9I8BABSP1sKvTyppO3zoV6+Qxo8jCVB3
 qat35kznP3nzvTMFvhSDHRRmdnRuUmYPrNnWDOZXQQMWkHihO40tdI1tVGAIcq2pPpzvrLLnF
 19ePe3CTbRtz72UnIQAltS1QL8vqFCdAMkQqsib1P7hkZz2SBmp50QwdrFChFuseJsm3LJeDA
 AKNve4eJipgtUgLMd3L9T9QJp7aSPSqt6VV0hpRtLsGO8zv4cnyoGsQPoO8xqZQwHRCvwHvbn
 Z3GEE3qCX7l6gWS7R6EjMAmsXXVMF1KgJAfuGye30jlskgxF7Im56hlt1sHc3BP6wTxbmAana
 qTYVjUajrapYQjWaj4LxmJiTCz4xQ6zGvujE7CSuqcGVXRVixoeOVh8nyc8mhuwK9YtRHmMUc
 v0xLaFlj+Sem+FYmZlPgXp/rkQniMfph/JCKmp2vFD/rz87m0NNtSMRluLKA72axt/FRJ9qGt
 p+crc5sRbOGtjxgsLfkmI0O96egniM18c/8mThFPYzhhWxipdPXy65woT+XelxPx4s7wksdTT
 SNcgzipTfVU10qK9XdolCvTw4TNDnrFbCQE7nJKr+Dzw8hc1+L5HsFTJKAxjlZ4+BGsIzP5IQ
 rTFym/8D4l2746+AqWbegyPn1Nk7gdDLjg5XwPg/5Xy2TxoTHkvDBssuPKUBLjVt7QTEN5djU
 nPTdpqFo8K520Ei22V9WxYSmF+mRH0rIhOgGYWfdQ5eryZ1d/AayWXKsJnv3c/aeBljLd7E39
 LsI9N7DXrpkuABNX3OijU1lTjmaGCcNWckZP2cKJfkxRfj3QLVzhZfTAwv0LtFcr4OiitTWfx
 c3RIE1b4/oikDaqQx3lmc8KRASO2NW3VY6YzhHcy3KaaF87ymmtk1VEJHr0S/ZL6xNgbhdn4H
 q0NSdkUe67ZsHuJB9iA+q1aW9G0M265StPY+Zo0Ez2XDYHVdqnUzSjAHUwYwVh0r0nCS4KtY7
 u/JUKytozcHFE4x2X5LOvHvCNxOA5GrPmig62S2d7pRI9wI/g/f/QyscCAzMBraM2zbUiqX9Z
 u7eNIkCiyLJrelvJPW52qunS79mH31qHOxa+X7upn5I4rVRl+rKqzoLrM9KCfOhJ4bOfYHZFJ
 2d7bMoKwK1Yug0OAoYdnmDe3JELSbTF5QC9LCirK/05yqvaTLHwq1ggxPwwJuDaHp87jq1Vyx
 Xis1oA0rG45mNm4vlUFBSZddeAOxxreVCCoffJg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1671604778-1602240278=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 8 Oct 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Oct 08 2020, Johannes Schindelin wrote:
>
> > On Thu, 17 Sep 2020, Junio C Hamano wrote:
> >
> >> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
> >>
> >> > As amusing as Linus's original prose[1] is here it doesn't really e=
xplain
> >> > in any detail to the uninitiated why you would or wouldn't enable
> >> > this, and the counter-intuitive reason for why git wouldn't fsync y=
our
> >> > precious data.
> >> >
> >> > So elaborate (a lot) on why this may or may not be needed. This is =
my
> >> > best-effort attempt to summarize the various points raised in the l=
ast
> >> > ML[2] discussion about this.
> >> >
> >> > 1.  aafe9fbaf4 ("Add config option to enable 'fsync()' of object
> >> >     files", 2008-06-18)
> >> > 2. https://lore.kernel.org/git/20180117184828.31816-1-hch@lst.de/
> >> >
> >> > Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail=
.com>
> >> > ---
> >> >  Documentation/config/core.txt | 42 ++++++++++++++++++++++++++++++-=
----
> >> >  1 file changed, 36 insertions(+), 6 deletions(-)
> >>
> >> When I saw the subject in my mailbox, I expected to see that you
> >> would resurrect Christoph's updated text in [*1*], but you wrote a
> >> whole lot more ;-) And they are quite informative to help readers to
> >> understand what the option does.  I am not sure if the understanding
> >> directly help readers to decide if it is appropriate for their own
> >> repositories, though X-<.
> >
> > I agree that it is an improvement, and am therefore in favor of applyi=
ng
> > the patch.
>
> Just the improved docs, or flipping the default of core.fsyncObjectFiles
> to "true"?

I am actually also in favor of flipping the default. We carry
https://github.com/git-for-windows/git/commit/14dad078c28159b250be599c0890=
ece2d6f4d635
in Git for Windows for over three years. The commit message:

	mingw: change core.fsyncObjectFiles =3D 1 by default

	From the documentation of said setting:

		This boolean will enable fsync() when writing object files.

		This is a total waste of time and effort on a filesystem that
		orders data writes properly, but can be useful for filesystems
		that do not use journalling (traditional UNIX filesystems) or
		that only journal metadata and not file contents (OS X=E2=80=99s HFS+,
		or Linux ext3 with "data=3Dwriteback").

	The most common file system on Windows (NTFS) does not guarantee that
	order, therefore a sudden loss of power (or any other event causing an
	unclean shutdown) would cause corrupt files (i.e. files filled with
	NULs). Therefore we need to change the default.

	Note that the documentation makes it sound as if this causes really bad
	performance. In reality, writing loose objects is something that is done
	only rarely, and only a handful of files at a time.

	Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

The patch itself limits this change to Windows, but if this becomes a
platform-independent change, all the better for me!

> I've been meaning to re-roll this. I won't have time anytime soon to fix
> git's fsync() use, i.e. ensure that we run up & down modified
> directories and fsync()/fdatasync() file/dir fd's as appropriate but I
> think documenting it and changing the core.fsyncObjectFiles default
> makes sense and is at least a step in the right direction.

Agreed.

> I do think it makes more sense for a v2 to split most of this out into
> some section that generally discusses data integrity in the .git
> directory. I.e. that says that currently where we use fsync() (such as
> pack/commit-graph writes) we don't fsync() the corresponding
> director{y,ies), and ref updates don't fsync() at all.
>
> Where to put that though? gitrepository-layout(5)? Or a new page like
> gitrepository-integrity(5) (other suggestions welcome..).

I think `gitrepository-layout` is probably the best location for now.

> Looking at the code again it seems easier than I thought to make this
> right if we ignore .git/refs (which reftable can fix for us). Just:
>
> 1. Change fsync_or_die() and its callsites to also pass/sync the
>    containing directory, which is always created already
>    (e.g. .git/objects/pack/)...).
>
> 2. ..Or in the case where it's not created already such as
>    .git/objects/??/ (or .git/objects/pack/) itself) it's not N-deep like
>    the refs hierarchy, so "did we create it" state is pretty simple, or
>    we can just always do it unconditionally.
>
> 3. Without reftable the .git/refs/ case shouldn't be too hard if we're
>    OK with redundantly fsyncing all the way down, i.e. to make it
>    simpler by not tracking the state of exactly what was changed.
>
> 4. Now that I'm writing this there's also .git/{config,rr-cache} and any
>    number of other things we need to change for 100% coverage, but the
>    above 1-3 should be good enough for repo integrity where repo =3D ref=
s
>    & objects.

I fear that the changes to `fsync` also the directory need to be guarded
behind a preprocessor flag, though: if you try to `open()` a directory on
Windows, it fails (our emulated `open()` sets `errno =3D EISDIR`).

Ciao,
Dscho

--8323328-1671604778-1602240278=:50--
