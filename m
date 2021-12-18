Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8F1C433F5
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 01:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhLRBk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 20:40:27 -0500
Received: from mail-4324.protonmail.ch ([185.70.43.24]:38993 "EHLO
        mail-4324.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhLRBk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 20:40:27 -0500
X-Greylist: delayed 101977 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Dec 2021 20:40:27 EST
Date:   Sat, 18 Dec 2021 01:40:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1639791625;
        bh=b4cNq21bDmiAxPWRnde3JkPNK6nbeoAK28cJ3FDTx9Q=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=gkPSKVU8p/59JTh8qmokdS81IjgjZL8pYdAnBU/H58u0xj1hknuSEb9OwV8bXIEdT
         xcq4Hek+jIdEsthM7LNg/NBLuKyBJwrOjABq1nczcfvKwf3ImiOdtdwHtR7RyqN8NX
         66jkT+xoNLJmx+yOGESCFgzSsEHY/aBkFCpmXxq8h7mf55ivP2J9PXKdYp+Z66Yku2
         Cq1zc4CULbXzOIjB5cMxT0HLL/SXkDHF1cyoTs2l7gfpYeljuWKVAv4v5ZROWg7Hdb
         fzIgsM5fm2zVJw5X3+sAeB7yVvyfsQkov/DdMxgtquYtjoIprvyFUBaJ/dpYVQ4/KQ
         X5oiYRxyWSEnw==
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
From:   =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
        <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Reply-To: =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
          <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Subject: Re: Fw: Curiosity
Message-ID: <jwBqM0tKGX4kLwYY1KwT3FYojoznuAHTqQ2zZVw-JCyUUXHvcxPFWjBHYxUp-lxud3rpCw4huIOSIyWdL8SoNx-ETTpNrQm85t54jQLf5ZA=@protonmail.com>
In-Reply-To: <Yb06k5ob+bl/oE68@camp.crustytoothpaste.net>
References: <Wlh_w2gSCDQ2ieJnIY7TStWrzxbwP98SNRIFMTYpva7SRFipqk63HEYFVF7wFn1oSHOkQNsjWGOa5L49vyRlvSLbuZqpmvOaDOHmFkdt2zw=@protonmail.com> <wVwq9WVLpVt7MNLmIYOWCFKVSf8l532MD_vu4yTA8hl1fCARnW8nOUJjxYmKSzFw1SnPp5iYRD-aW4gAT2HnyQbC5aLBOvyT6npn88lxwNQ=@protonmail.com> <xmqq8rwl91yf.fsf@gitster.g> <YbqiQ1B9ezF/RPOn@camp.crustytoothpaste.net> <xndBIO9EtrXaA932eF-0YkvHCAOL1GOKQQlIigssmcwhtZWqGxhc6I_A-lXt7vMK-j1oDrQMHUIuExlpqFS4v88nWci32qx3W5Xi1_hPpUM=@protonmail.com> <54fe7ba20109f974b61a7e6c24ba8264@codeaurora.org> <1X3gQ48NK5aBDHcpYMlxESRjqubcCBKJUQu2K0dBOnTyvsXCXXoGDBg2Ff4KarK6WsZnzN3HgqHGOlCKKdF-wtZQ5tHsoAcfit2CTXMWqh4=@protonmail.com> <Yb06k5ob+bl/oE68@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

How does one make a release artifact?
o-o

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

Em sexta-feira, 17 de dezembro de 2021 =C3=A0s 22:34, brian m. carlson <san=
dals@crustytoothpaste.net> escreveu:

> On 2021-12-18 at 00:15:59, Jo=C3=A3o Victor Bonfim wrote:
>
> > > I suspect that for most algorithms and their implementations, this wo=
uld
> > >
> > > not result in repeatable "recompressed" results. Thus the checked-out
> > >
> > > files might be different every time you checked them out. :(
> >
> > How or why?
> >
> > Sincere question.
>
> A lossless compression algorithm has to produce an encoded value that,
>
> when decoded, must produce the original input. Ideally, it will also
>
> reduce the file size of the original input. Beyond that, there's a
>
> great deal of freedom to implement that.
>
> Just taking Deflate, which is used in zlib and gzip, as an example,
>
> there are different compression settings that control the size of the
>
> window to use that affect compression speed, quality of compression
>
> (resulting size), and memory usage. One might prefer using gzip -1 to
>
> get better performance or use less memory, or gzip -9 to reduce the file
>
> size as much as possible.
>
> Even when the same settings are used, the technique used can vary
>
> between versions of the software. For example, GitHub effectively uses
>
> git archive to generate archives, and one time when they upgraded their
>
> servers, the compression changed in the tarballs and zip files, and
>
> everybody who was relying on the archives being bit-for-bit identical[0]
>
> had a problem.
>
> So it would be nearly impossible to produce bit-for-bit repeatable
>
> results without specifying a specific, hard-coded implementation, and
>
> even in that case, the behavior might need to change for security
>
> reasons, so it would end up being difficult to achieve.
>
> [0] Neither Git nor GitHub provides this guarantee, so please do not
>
> make this mistake. If you need a fixed bit-for-bit tarball, save it as
>
> a release artifact.
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-------
>
> brian m. carlson (he/him or they/them)
>
> Toronto, Ontario, CA
