Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E800C10DCE
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 00:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0000C205C9
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 00:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Ozi4/nRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgCPANg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 20:13:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54762 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729065AbgCPANf (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Mar 2020 20:13:35 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9A6936077C;
        Mon, 16 Mar 2020 00:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1584317615;
        bh=PcZAiFv4LlO74BQf56P+/Kx5PClKdNmqGEZRXq7cypo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Ozi4/nROpbwA6G39m3d7mfEt3klX4ZKxZazOZqkIGk6J7M+NhkHrUp+udKgVLvWv2
         ptPcicIV63ia1YzxJW50XmVfwQ0sJg/nuzG4HudIfLPC7LLQRrMfJLOWkvXVCYfJOO
         TUHq/62NtQ+vY0fNH5uyG/DKzDfJAED1otEP3ehUOyp1ms37VXFoy5qREi8EELuDdT
         xFHfAcG71uTIDaltjAqYEduMrm01g4nbCwOppCtP+lOxG7OMqw2vzqpfNcZiAsu8Bf
         FZHeRMXCPKwpDCioc1zfHwRkewMrrS3ztW7zWMC8WsTg9lNn7yhqVxgWSGWX3TOVO/
         P+rPZeiwETB1s7XRRiyyQ+66sBA7f3F0OhGNG1F1e++elImjv5OQT6NCzsEu2vlRRi
         ZaeYAugGk+Xlqt7NkGjnvpOQUr8QLXUW1Q8oMQLTbWPZ8OH3oZ/VMaybH96u47Hyss
         tJjKhv/xyL33JjwRvV+n4+3GBqYkuuvgQXwgXl0AUTCgGjKNp5g
Date:   Mon, 16 Mar 2020 00:13:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/1] docs: add a FAQ
Message-ID: <20200316001329.GB6910@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20200315223923.170371-1-sandals@crustytoothpaste.net>
 <20200315223923.170371-2-sandals@crustytoothpaste.net>
 <xmqqa74h9oqd.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline
In-Reply-To: <xmqqa74h9oqd.fsf@gitster.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-15 at 23:34:34, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > Note that the long lines for certain questions are required, since
> > Asciidoctor does not permit broken lines there.
>=20
> I didn't see "long lines", but was puzzled by a few lines with
> ununiform indentation.

I'll fix all that.  Apparently somewhere along the line my editor got
confused and inserted two spaces (which is my typical AsciiDoc
configuration) instead of a tab (which is what I've configured for Git
files).

> > +Common Issues
> > +-------------
> > +
> > +[[last-commit-amend]]
> > +I've made a mistake in the last commit.  How do I change it?::
> > +	You can make the appropriate change to your working tree, run `git ad=
d <file>`
> > +	to stage it, and then `git commit --amend`.  Your change will be incl=
uded in
> > +	the commit, and you'll be prompted to edit the commit message again; =
if you
> > +	don't want to edit it, you can use the `--no-edit` option to `git com=
mit` in
> > +	addition, or just save and quit when your editor opens.
>=20
> When the undesired part of the last change was "I added a junk
> file", then instead of `git add`, `git rm [--cached]` would become
> necessary.

Good point.  I'll mention `git add` or `git rm` as appropriate.

> I personally would prefer to say "if you want to use the original
> commit message verbatim" instead of "you do not want to edit", but
> it may be just me.  I just find the document to give more positive
> attitude if it avoids phrasing end-users' wishes in terms of what
> they do not want to do.

Thanks.  This is great feedback.

> > +[[undo-previous-change]]
> > +I've made a change with a bug and it's been included in the main branc=
h.  How should I undo it?::
> > +	The usual way to deal with this is to use `git revert`.  This preserv=
es the
> > +	history that the original change was made and was a valuable contribu=
tion, but
> > +	also introduces a new commit that undoes those changes because the or=
iginal
> > +	had a problem.  The commit message of the revert indicates the commit=
 which
> > +	was reverted and can be edited to include an explanation as to why th=
e revert
> > +	was made.
>=20
> Can we phrase "and can be edited" in a bit more opinionated way?
> The users are encouraged to describe why and that is why we open an
> editor by default for them to do so.

Yes, I agree that we want to encourage a helpful commit message here.  Will=
 update.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXm7EqQAKCRB8DEliiIei
gdi8AQD9tfKuZxODKAD9Piebuz5aZsGZmUJvdWmuBhmIuEYhCwEAvthF9w+LQg7+
xmkQO8eUxXWAIsBuvaGOzsaYilOn4AY=
=FusI
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
