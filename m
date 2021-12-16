Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC649C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 02:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhLPCTx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 21:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbhLPCTw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 21:19:52 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB83C061574
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 18:19:51 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 079D95D49A;
        Thu, 16 Dec 2021 02:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1639621191;
        bh=U5/d0QtYengWjzr+1YLVtwfKtsacjjDssqdzgSMc4oI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=aVOUbptalcvljxlvCaZ4180LTa9PkgvnMInt0u/AZPx8APRDbGuooSAuFBXLnxT3c
         FY0Kcl4AYOpyJV1XaSei0OHXwnvOQU3SqT1pHk7deDDhKURRrVmxWsbMVx6JIHMb89
         SOZ/ytVx4cDkDc+naePqJp5H8GVJPi5sRrgEq+0oBMxxRVYk40i77+NIwSJ545quKe
         7cJksaV+YEDE+Rd6o2KFKsSCTkX8pWOcj2/jidSshxW6Yri6fhHw1erfk2/qMpdy2I
         47dHUMH3BQlp48+Usfxbdw3YRSihRSQdas1hAz6yQLT+d2XjsxS+K2LSMphhkHzvVw
         P8KJtb53GTfSSowmEwjMx2CMK5lLQ6Sod9TlScbP+lIK3ZL+NG4ePOPgEMYDnEmLR1
         3BQHTO6u5Z09Dh6YHWycJ71NnHHBj1GXszf7qbBTWbq6xQFsN5u4SxxbJN9FKLCpL1
         RU4G3zaxL3bxdtFtU3OlzIttxSWGWHo9P7YIkLLmq2Md/dq3MxY
Date:   Thu, 16 Dec 2021 02:19:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?Sm/Do28=?= Victor Bonfim 
        <JoaoVictorBonfim@protonmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Fw: Curiosity
Message-ID: <YbqiQ1B9ezF/RPOn@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Sm/Do28=?= Victor Bonfim <JoaoVictorBonfim@protonmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <Wlh_w2gSCDQ2ieJnIY7TStWrzxbwP98SNRIFMTYpva7SRFipqk63HEYFVF7wFn1oSHOkQNsjWGOa5L49vyRlvSLbuZqpmvOaDOHmFkdt2zw=@protonmail.com>
 <wVwq9WVLpVt7MNLmIYOWCFKVSf8l532MD_vu4yTA8hl1fCARnW8nOUJjxYmKSzFw1SnPp5iYRD-aW4gAT2HnyQbC5aLBOvyT6npn88lxwNQ=@protonmail.com>
 <xmqq8rwl91yf.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kMv/u8zSJmQB3eST"
Content-Disposition: inline
In-Reply-To: <xmqq8rwl91yf.fsf@gitster.g>
User-Agent: Mutt/2.1.3 (2021-09-10)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kMv/u8zSJmQB3eST
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-12-15 at 18:07:20, Junio C Hamano wrote:
> Jo=C3=A3o Victor Bonfim  <JoaoVictorBonfim@protonmail.com> writes:
> > Since Git is almost used for everything at this point, is there
> > any intent on providing better support for non textual file types?
> > Why do I say this? Take this game mod which I follow as example ->
> > https://github.com/SolariusScorch/XComFiles <- whenever I clone it
> > Git takes a significant forever amount of time to download 452 MB
> > of files whose some part, from my perspective, isn't being delta
> > compressed like the text files are (since, whenever reading a log
> > of what changes were made, git creates and undoes modes for all
> > binary files, some of which only changed by a pixel from one
> > colour to another).
>=20
> Our delta compression does not care whether the contents are text or
> binary, so if it is not compressed well, so it can be a sign that
> the contents are not compressible to begin with, at least with the
> xdelta binary-diff-patch engine we use.  Improvement designs,
> algorithms and patches are always welcome ;-)

To expand on this, if what you're storing is already compressed, like
Ogg Vorbis files or PNGs, like are found in that repository, then
generally they will not delta well.  This is also true of things like
Microsoft Office or OpenOffice documents, because they're essentially
Zip files.

The delta algorithm looks for similarities between files to compress
them.  If a file is already compressed using something like Deflate,
used in PNGs and Zip files, then even very similar files will generally
look very different, so deltification will generally be ineffective.

There are two main solutions to this.  One is to store your data
uncompressed in the repository and compress it as part of a build step.
This makes your checkouts larger, but it makes your repository smaller.

The other is to store them outside of the repository proper.  Some folks
use Git LFS for this, but you could also just store a manifest with file
names and secure hashes, plus a download location for a public server.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--kMv/u8zSJmQB3eST
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYbqiQwAKCRB8DEliiIei
gbhkAQDxrlikG+m6Ngk4PZPy3bvg/8LFXRMOywhIkJK767nobAEAqh3Ck47Rawc3
Y3jVVvngPMw+7ec0S68OkLxBKehQYws=
=tzab
-----END PGP SIGNATURE-----

--kMv/u8zSJmQB3eST--
