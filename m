Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55F111F461
	for <e@80x24.org>; Fri, 21 Jun 2019 23:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfFUXbD (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 19:31:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56160 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726045AbfFUXbD (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 21 Jun 2019 19:31:03 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:8174:fea0:25b6:f16a])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D645A60443;
        Fri, 21 Jun 2019 23:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1561159861;
        bh=3dpVu0W5vFjHamBRgcuwAm4/P3tCxJOF7xMK0u9ijf4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=q1Wm+dvfS5IwUxVgIxjHQ3vL6GlpwNOGReLznCgpbNJJt67hyd0ysy5V4ewCs7Zzg
         fGksL7nGg5fBf9WuCyWnN0VCXZoafQTKb6dovwF3T7oZSQ5CyBsjU+lbvB32nUHcPb
         6zcJz7Qg4Re6EY7FtH1l1A47b1z2485grr+nzA48pLI8TA37VnH6rONYRrbWzq39nK
         03UOimAcNIPP/VZp58sNh+C++64rPBUzLpu8KTcz0LY6IH42Etr224oWIi1wafSPVP
         U8rYsS5IXKeUfgmmi8+ICpN9EFfuBwzEiL+niSqE7Z60lk9tXpfulzGTuhvtZhS3Lk
         JOeIp2RlTGo+avgpHHsTdz3voteY+PZoQ3cLI0WIe68wo23W/LbXFagRwy35Z1XCki
         iwc8RXpKNNt03RmQi+cnhPNXUBJdyH1L4Y58uX4jkR5on0VyC/3iFDJnBtypJRJNU+
         bUuYy5rRvLq/tJBiltm3F6n3ixI5WFm0KlhS6UmRvjqW54Hd1Uu
Date:   Fri, 21 Jun 2019 23:30:55 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/8] Add 'ls-files --json' to dump the index in json
Message-ID: <20190621233055.GB965782@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
References: <20190619095858.30124-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <20190619095858.30124-1-pclouds@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-06-19 at 09:58:50, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> This is probably just my itch. Every time I have to do something with
> the index, I need to add a little bit code here, a little bit there to
> get a better "view" of the index.
>=20
> This solves it for me. It allows me to see pretty much everything in the
> index (except really low detail stuff like pathname compression). It's
> readable by human, but also easy to parse if you need to do statistics
> and stuff. You could even do a "diff" between two indexes.
>=20
> I'm not really sure if anybody else finds this useful. Because if not,
> I guess there's not much point trying to merge it to git.git just for a
> single user. Maintaining off tree is still a pain for me, but I think
> I can manage it.

I'm generally in favor of this, but we need to document what this does
when it encounters paths that are not valid UTF-8. (Ideally, the answer
is, "die()", but I suspect the answer will be "silently produce invalid
output".) Those can of course occur on Unix systems, but also on
Windows, where unpaired surrogates can occur.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.16 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl0NaK8ACgkQv1NdgR9S
9oun0xAAx033fn97zHVn2bb6/XJnvAGRP7+ujn3yM6BWKpXMqIQRWt4+8CYOauC9
Epv2WPC5DLp8iQs6CEnyMjqQnqVKZol1wzS1641bv4rIW5Z5BSzzoMhbHdz2dYui
3t2rjmOc8lXTlSUguKrYgnjK+ECFIygSiF59NlFSDQf/rVX801VKR9xnV/Ifu5PZ
5AWkZtfPeEzqZOrhvjFXZnvdefvDnGRaJGAjbSNc/d22rtm72pPwQca8L+JLVBq2
kgta2EMtBqaESBHW1rtvaEGcqYnzR1gXJA8Jz3Yzzvr/EvGlbWIKSKZHR1qUbyvi
Pm5bgljkM+EA9sXtdD8AGEdP2VdBh1AIZ37Tid/YYC10moVcdq3YYrA1IyWuNHW0
sEVEw3WyCKvpHPhLQrzwKFarenA7P8wF844OvK31I2nxHfMxrsA+YB8S/9z1NMkk
j3VuOZQehZBpXqyqtRINQxBbH6SXOGGEYBBUK/6BEkN/ia3e+HrjY9dR0eK/9Y0T
wngde9kC60Bqxe3MNcK2p1E/SFGsN9pliAzBmDksvQhD8EmHyQYCfUdwXN6m04aO
0L6xFvDmHHBX2FTowtIOG3Z7BFru9rkRz/gyQPV5cAjecLGhSZafOD9N/uw+EPNd
LsKOQL1ocVWZKRFle031/k3TUf04BpHUfzxMP19S6YrH8AEAy+w=
=D7v6
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
