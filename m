Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D54C32771
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 01:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31BB20715
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 01:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="sZwn3oIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgAGBeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 20:34:08 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60662 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727250AbgAGBeI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Jan 2020 20:34:08 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E487F60787;
        Tue,  7 Jan 2020 01:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578360846;
        bh=gUuzfPksqvp5I67dGUt4m/MFInqh86lHYzBTvAnhuS0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=sZwn3oISk/+ZONg+Ki+2qGv2G6j5DjDlFHMBEuFKkCvnm9UUdQctY7/vRgNqJTxnb
         hGAiP8zq29dvf6hqB7RQLWg/grtTTYZrjJ5XwK4u72mtAb9rl6A5i4TJnZYScnFQj3
         qKZKwx2K5C3F85KTaykLWQjN3iF6yx5q6wuW0/Y8zTSSxLRCe8PH740jF4eqTgOfzG
         zmOP3YjJvvnR+r4JaIJLQdr7VrcePGxhfCD/YbhUqam+YMgVAhCQJBCTZ5QXHyvVyd
         d9+EK/LL1HZdKX5SsgFt7zRYVWEr9RkuHk82S2nPHVxRcz2JFsGvCs/DPje2ZaujJn
         wPsDodSlW6I2GGkgb2n17Yd4JQ/eZJp+wAiQ7wWsrXyegQCkVaCtc0+ALMWLJjoL/H
         BaLwKokzYEbBL4LlhuqCzYbNot1xYZihWcw/IVv2P0UFvvj9Q4Wdq/LSkHZGDfmj1y
         yQAhWsPbK1e45ln65G/IcPUlY2b8TMDyv3cELOmW+qQsz+pGY7g
Date:   Tue, 7 Jan 2020 01:34:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Mike Rappazzo <rappazzo@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Rappazzo via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] sequencer: comment out the 'squash!' line
Message-ID: <20200107013401.GI6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Mike Rappazzo <rappazzo@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Rappazzo via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
References: <pull.511.git.1578326648.gitgitgadget@gmail.com>
 <xmqq7e24a3t0.fsf@gitster-ct.c.googlers.com>
 <CANoM8SV=pT3sFrfnEqWc2xBn_c2rES0qSMsdptF0DgcxgYL94w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BOmey7/79ja+7F5w"
Content-Disposition: inline
In-Reply-To: <CANoM8SV=pT3sFrfnEqWc2xBn_c2rES0qSMsdptF0DgcxgYL94w@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--BOmey7/79ja+7F5w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-06 at 19:20:09, Mike Rappazzo wrote:
> On Mon, Jan 6, 2020 at 12:34 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > "Michael Rappazzo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > Since this change what the expected post-rebase commit comment would =
look
> > > like, related test expectations are adjusted to reflect the the new
> > > expectation. A new test is added for the new expectation.
> >
> > Doesn't that mean automated tools people may have written require
> > similar adjustment to continue working correctly if this change is
> > applied?
> >
> > Can you tell us more about your expected use case?  I am imagining
> > that most people use the log messages from both/all commits being
> > squashed when manually editing to perfect the final log message (as
> > opposed to mechanically processing the concatenated message), so it
> > shouldn't matter if the squash! title is untouched or commented out
> > to them, and those (probably minority) who are mechanical processing
> > will be hurt with this change, so I do not quite see the point of
> > this patch.
>=20
> This change isn't removing the subject line from the commit message
> during the edit phase, it is only commenting it out.  With the subject be=
ing
> commented out, it can minimize the effort to edit during the squash.
>=20
> Furthermore, it can help to eliminate accidental inclusion in the final
> message.  Ultimately, the accidental inclusion is my motivation for
> submitting this.

I think this series would be useful.  I've occasionally included the
"squash!" line in my commit even after I've edited the rest of the
commit message.  It's not super frequent, but it is a hassle to have to
delete it, and it does happen occasionally.  Usually I catch it before I
send out the series for review.

I can see the argument that this makes it a little harder for mechanical
processing across versions, but I suspect most of that looks something
like "sed -i -e '/^squash! /d' COMMIT_EDITMSG" and it probably won't be
affected.  We do make occasional slightly incompatible changes across
versions in order to improve user experience, and I think a lot of folks
who use squash commits will find this a pleasant improvement.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--BOmey7/79ja+7F5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4T4AkACgkQv1NdgR9S
9otJzRAAvJc7xDKmrn4QVfjQIXS0+x4M7saz89AtS0BuBSvQzDXCEO7w22duljsn
Q06ZHUn7XvBOv1rbccryAhi+zEyvUxQz+cCJROhVmnhaDETP7Sa859qvOkEsy0ju
AG8qpDDqzXRJMtD9ATTVPDtR9SoDcJWUQ/BiAtGx6SEbEHqbyuCWj4PDsqKh86RD
N0nw56sIZk1T7oFbmZiQO2BRujx6nERhYMKBeGcmjV0d0NKp/LGHX1NZVgsyNRKy
bd+lY/G/LQtDdmLixSwgkJS9zfEZNzU861Ax0CYW5BwWO7WpxAswpEUgFzYF/SvD
e2vb4mYuxsuvBItawslbqAS636qgT7zi7vzm7Ulq2eGuVWn3L0rcfsAnsJrj0Hiy
Qv9DTB5K4cLKltoPXBUQUDBPGe4blmVWhOk1NfOVMNJKr1CrgtlEPB2bMPkdJCwi
EZj+8EWYpct+50lm2GARt0vWMb7+CCFunxP3FYtaIEktWPAZ8/VH+8haJp13rs6f
GqjgzA7K5yCWfCeo+PMMH/z4Jtkw/Xk9hvAn1ovc4UfkBPuA6LRN6CUfqxXSbnU9
6ba0QBt8oshxyUApkFjagI8fBMam+2uzjZI9NFvUAQMwSGRuSY8OrBwXXklu9DlN
Ds91HOvZ/9GpFmDjKdDQV1HB71cLxeBs/DhDgFQ1yzLKdROwZv8=
=5Ebh
-----END PGP SIGNATURE-----

--BOmey7/79ja+7F5w--
