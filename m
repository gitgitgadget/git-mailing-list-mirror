Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E502C6369E
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 02:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA13217A0
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 02:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgLCCBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 21:01:50 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64375 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgLCCBt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 21:01:49 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5EAEA1004D9;
        Wed,  2 Dec 2020 21:01:06 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=vxNFPGiKRzTszsiFKSMQT7renn0=; b=CjWkJZF
        /jE5Ea/sSz/jafmTim2en5ATXApPu2Sl3L31wV0D6CDXNu+Lipbz58qqOfWjjS5/
        7g90BaBuLIautWaCvjXxwYc2ntRY7KGsHMxp13szqNn2V8JcJW+g7MjZCv450VLG
        3XgJcBoqtSr3e6UiqhXoLclMzhu980RC6Lbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=fhHFyt57QCWqeerfP1kxXHb5iOnsDvfBb
        SgxXYz1+KnArYx8+7zbbS+6zyVFCGvXPsIrIp1hpwE1g3CrZxzWgbpig0CMrh4xy
        IC9nMkklACOcSK1ElzNXqMmeOK7xqQDXPbMIRN2tLzIxGPy/U3vBaOlxYNB2753Z
        6VLLkmdEsM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 574411004D7;
        Wed,  2 Dec 2020 21:01:06 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.178.181])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 86E901004D4;
        Wed,  2 Dec 2020 21:01:02 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Wed, 2 Dec 2020 21:00:59 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Arnout Engelen <arnout@bzzt.net>, git@vger.kernel.org,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] doc: make HTML manual reproducible
Message-ID: <20201203020059.GY748@pobox.com>
References: <20201201095037.20715-1-arnout@bzzt.net>
 <20201201154115.GP748@pobox.com>
 <X8bhdyu/OlscI1ME@camp.crustytoothpaste.net>
 <20201202160755.GX748@pobox.com>
 <X8gnItjchqX4wwmt@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LXsBfGm2MIDJcXyT"
Content-Disposition: inline
In-Reply-To: <X8gnItjchqX4wwmt@camp.crustytoothpaste.net>
X-Pobox-Relay-ID: 658466FA-350B-11EB-B6E3-D609E328BF65-09356542!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--LXsBfGm2MIDJcXyT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

brian m. carlson wrote:
> On 2020-12-02 at 16:07:55, Todd Zullinger wrote:
>> Indeed.  Is it worth mentioning this at all in INSTALL?
>> Something like:
>>=20
>>   -   The minimum supported version of docbook-xsl is 1.74.
>>   +   The minimum supported version of docbook-xsl is 1.74.  For consist=
ent
>>   +   IDs in the HTML version of the user-manual, 1.79.1 or newer is
>>   +   necessary.
>>=20
>> perhaps?
>=20
> I don't know that that's even necessary.  Anyone doing reproducible
> builds is already aware of the required versions in order to do a
> reproducible build, and I don't think the average user is going to be
> super interested.
>=20
> We can if you feel strongly about it, but I don't personally see it as a
> big deal.

Nah, I definitely don't feel strongly about it.  I debated
the same point you made -- that those most likely to care
about the feature would likely know the versions (perhaps
painfully) well.

This is a nice change that, conveniently, has all pros and
no cons, it seems.

I suppose we'd ideally look for a v2 with --stringparam
replaced with --param as you noted upthread?

And maybe an updated commit message to note that it requires
docbook-xsl 1.79.1 to be effective, but older versions
gracefully ignore the option?  That may be helpful to a
future reader who wonders why the requirement wasn't raised.

--=20
Todd

--LXsBfGm2MIDJcXyT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQFEBAEBCAAuBQJfyEbbJxhodHRwczovL3d3dy5wb2JveC5jb20vfnRtei9wZ3Av
dG16LmFzYwAKCRBDJZOLvq8M49meB/9GxPc25vxolC9TawVGITBrJHQQrv4PRcJJ
J2MDhgd8Rkdm7Ma46xbHoCmSfZeCtYYWrGk9nirZ7IpJ4Jfke0iu5dQyriW8hodr
H9FbKr9QA9m00X0/e1dfjSuhkJbxS6GHTMIAhhbU8QGih5KQUcjPlxzRQhtMxwBT
99Mi7ZcZhxzRq7sP0z4vwgAo7iRDI98O9KjQ7APyv17g0WBXrPHXPf/0znaPQF8f
94F+Bo4LLm/ZCDURCSYd2JrxpWzXbqxrYhC0Nffu82zg+I5qzewCyMNJIVJqGYhx
mGhQXIfI1bbMSsA421gvTJL2DQtbinQHA/BpT3WuzrC3G6TqozTM
=0WGD
-----END PGP SIGNATURE-----

--LXsBfGm2MIDJcXyT--
