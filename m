Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB807C433F5
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 23:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD42B60EE0
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 23:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhKNXna (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 18:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbhKNXnF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 18:43:05 -0500
X-Greylist: delayed 16961 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 14 Nov 2021 15:40:10 PST
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBFAC061746
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 15:40:10 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 4E7F35B466;
        Sun, 14 Nov 2021 23:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1636933209;
        bh=OEtOh2/quIY93ZRNFOSCOL9boif9V9utxFXO3J7A9e8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ZlAAQRuLaPk88SvsHJ+jQf59b9PCit0i8tPnAVUt4elaBP092ouhR07+lmpkG6BaH
         9aRjE1mLYMhRe5MaaIjCjW5b0OUbSixznXSoACWpYeOvV0q+8ES1T4N95gur6Z3Mn4
         KikULcwmg3zT3MPbZreZ+9ZEbEBNsIzK/knxCC+0fso3G0rI4zhQpbe+Vlh6/59uIn
         pmkK4mdm4sOg3hsvEtk8OObhGqv2rxYmAm4W60HLRh2ncNE6y5g6V23eotnApz3dwm
         s66vBrEoVnMhXxGlU61xdBJILQqXZSbHC9WK1wxYytHFkVho/xxWXT6/Dnhtggn8+3
         f9zU+QqQIIuEVUXYDZzBO5dPM70YXKLwMRDhTAVKrs3xPWlMZH0wOZIogiPOyOaG7H
         UKwzRCakD11minLDSEC9orzD6e5ag9iyzeHry1vlpucL2f+5qb/r4jU8+59TiQq3ga
         kos5DPxc3KpqXVBbBuoIg3xGbJhfNbEjGpsLcH/SmIBWCroxxLB
Date:   Sun, 14 Nov 2021 23:40:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 3/3] gitfaq: add entry about syncing working trees
Message-ID: <YZGeVtdshoip34AP@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20211107225525.431138-1-sandals@crustytoothpaste.net>
 <20211107225525.431138-4-sandals@crustytoothpaste.net>
 <CAPig+cRtOpaPd_HCQAW=33-vxhP4Knijo3g0dUA9HVb4_=JH4w@mail.gmail.com>
 <xmqqmtmes3ix.fsf@gitster.g>
 <xmqqtugm42aq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gseDLTDYSs4BPr7j"
Content-Disposition: inline
In-Reply-To: <xmqqtugm42aq.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gseDLTDYSs4BPr7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-11-09 at 00:10:05, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Doesn't rsync work the same per-file fashion, and the only reason
> > why it is a better fit is because it is not continuous, not
> > attempting to "sync" while the repository is in use, until the user
> > explicitly says "OK, I am ready to go home, so let's stop working
> > here and send everything over to home with rsync"?
>=20
> OK, so not "per-file" but "continuous" is the root problem, and
> "cloud" would be a good word because all the popular ones share that
> "continuous" trait.
>=20
> This part of the proposed patch text may need rethinking a bit.
>=20
> > +or added files, broken refs, and a wide variety of other corruption.  =
These
> > +services tend to sync file by file and don't understand the structure =
of a Git
> > +repository.  This is especially bad if they sync the repository in the=
 middle of
>=20
> That is, "file by file" is not a problem per-se, "don't understand
> the structure" is a huge problem, and "continuous" may contribute to
> the problem further.

"File by file" is not a problem per se, but it is a problem if you don't
snapshot the repository or it's in use.  For example, if you used an LVM
snapshot on an in-use repository and then synced that, we'd guarantee
that the repository was fully consistent.  Practically nobody does that,
though.

But to clarify: the goal of this type of software is to sync single,
independent documents.  As such, these tools don't necessarily consider
that it's important to sync other files in the same directory at the
same time.  You can end up with cases where some parts of your
repository get synced, then some other files in other directories, then
other parts of the repository, resulting in different states over
different times.  There's just no guarantee about how they behave with
all of the files in a given repository because they aren't considered a
relevant unit.  That's why I mention that they sync file by file.  If
they did syncing directory by directory, we'd likely have a lot fewer
problems.

> I wonder if you let the "cloud" services to continuously sync your
> repository, then go quiescent for a while and then start touching
> the destination, it would be sufficient, though.  The refs with
> funny "2" suffixes and the like are the symptom of two sides
> simultanously mucking with the same file (e.g ".git/refs/main") and
> the "cloud sync" could not decide what the right final outcome is,
> right?

I think this is very risky.  Yes, usually the duplicate files are caused
by competing changes on both sides, but having seen users with this
problem before, I'm not sure if we can safely guarantee this is the only
case.

> I also wonder if we add a way to transfer reflog entries, that imply
> the object reachability, say "git push --with-reflog", over the
> wire, it would be sufficient to do everything with Git.

Yes, please.  I'd love to see this.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--gseDLTDYSs4BPr7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYZGeVQAKCRB8DEliiIei
gWwNAQDpCIugK4Mb1D0vQk58S4vjR55fo2aDKT3IF1M/nBEkFAD+NLbK5ZMV5A6j
u7H9ocWgUjZeELY/IQpcWtkGMwwvFg8=
=Iakd
-----END PGP SIGNATURE-----

--gseDLTDYSs4BPr7j--
