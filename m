Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8D091F667
	for <e@80x24.org>; Wed, 16 Aug 2017 22:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbdHPW7H (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 18:59:07 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:54322 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752339AbdHPW7G (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Aug 2017 18:59:06 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D498C280AD;
        Wed, 16 Aug 2017 22:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1502924345;
        bh=IWXdG/eYCN25u/R8k1YXz1DTr0JI6nSh2e6/8LcHot4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l4hieuXdhJu0PZ22Ic+fyrQfG+7nGmokI5vJcsUTj5wFChvi4iSLKWoli0M7xYtyT
         ab5qOrq1nrM1P05vujbTW1KnJ4dZNmMAtoCng93qD8jI7TQ/xvHm3pTOaWO0fQfaH9
         +cvu3BzC3Pl6kYAv/P0lihbF9gF+IUIGw4HhAZRuZlMmlluNMiZyX5nGdnEL9pQ/LA
         crMHZWdN2v08ueLnYV/dpFYC/luxRHqSP3d6Qf20R0G+FMc9KD2zGOB4heuAm8LX9p
         2CSnW3dfCCH41C7r9xbDjaA+IF9Y/PHqxmg0VhwzNPCKbADUvUE6LprjlZzGjuBhXp
         uSv6qvd7CgjdFCkGrhieSH/2PrGGi304xLyCmRCtMOhOX/P1EeuD17LRq0otjWIUwY
         2xfSJTefx/XQozotYAPMed92kUcXgfxHeiuNX9nh6PWRGz8X9MFGiEL8vQDgn2+XLo
         m/QOlZwQ9pt14yukgCNv1T2xwQku5NP4hPHB+vf8hpgK8WmSY0i
Date:   Wed, 16 Aug 2017 22:59:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] commit: replace the raw buffer with strbuf in
 read_graft_line
Message-ID: <20170816225901.dbpzvsie2zgetunu@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patryk Obara <patryk.obara@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1502796628.git.patryk.obara@gmail.com>
 <b5633a5425c623f3d2204325e99332b5bb511582.1502796628.git.patryk.obara@gmail.com>
 <CAGZ79kaCtbuDEUJqJ+nVUW78ksLMyHZ2xhnbunUqzjkGRuYg+A@mail.gmail.com>
 <CAJfL8+QreNvRqVZ0t1Sw=+o4nFK6WuvuOWix_C0MNFik6Cc+rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mp5g4xz6mhnsqghs"
Content-Disposition: inline
In-Reply-To: <CAJfL8+QreNvRqVZ0t1Sw=+o4nFK6WuvuOWix_C0MNFik6Cc+rA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mp5g4xz6mhnsqghs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2017 at 02:24:27PM +0200, Patryk Obara wrote:
> On Tue, Aug 15, 2017 at 7:02 PM, Stefan Beller <sbeller@google.com> wrote:
> >>         const int entry_size =3D GIT_SHA1_HEXSZ + 1;
> >
> > outside the scope of this patch:
> > Is GIT_SHA1_HEXSZ or GIT_MAX_HEXSZ the right call here?
>=20
> I think neither one. In my opinion, this code should not be so closely
> coupled to hash parsing code - it should be tasked with parsing
> whitespace separated list of commit ids without relying on specific
> commit id length or format.

What I had intended, although maybe I have not explained this well, was
that we would have one binary that set up hash functionality as part of
early setup.  GIT_SHA1_RAWSZ and GIT_SHA1_HEXSZ would turn into
something like current_hash->rawsz and current_hash->hexsz at that
point.  The reason I introduced the GIT_MAX constants was to allocate
memory suitable for whatever hash we picked.

However, this is only what I had considered for design, and others might
have different views going forward.  I have, however, based my patches
on that assumption, and responded to others' comments with those
statements.

I agree that ideally we should make as much of the code as possible
ignorant of the hash size, because that will generally result in more
robust, less brittle code.  I've noticed in this series the use of
parse_oid_hex, and I agree that's one tool we can use to accomplish that
goal.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--mp5g4xz6mhnsqghs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.23 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlmUzjUACgkQv1NdgR9S
9osumRAAlfsf03ORWRHm5fzX1qQpSnhkE8N62SC/26hLFjNXZeEG1Rms2dD5e+S6
LrTXM0ODJhfpYMQU+n6ZZSm2SjvsYoOPbG6kujEzOYdy/xiuYvVE9al3efMPDTD2
jlJy8vWZORhVjaqKizQB7mp4WxY/vaRQL+qwQ08LzXB3/6rRGAubGzMGY92dR65R
FqzybTGpG1PLTjEHFOjOnffhMh6HprNhE3MrlyLwWxrk1ZTdtoVv+I6q6lglaeQo
14+CWSI0eHQhPp5yLwpGF4FQno5UCjjHzGz/5sL2PTPdalZ5Kz7RxXZ7BVs44hSR
X7G2+BZU5qh418mS8wsdxuyXYAUl52g7rv6HGQUpxHKILUoRyzVsNfn5wwQfB4tc
R628LG98pRiSBoWwGZ95ouTHfa/jtf+9zcSKPPfohdhoaPM2jY1Opw/ChVZm98aa
fgxhRsDsosQBJBUngr0cwsQMhQHNIBHZTLg03e50ypvCm23ygR9CFH/iGbfEUZj3
ntpinbQtwxvJDlNVBnE/FXYIEmnqtzIrdhsMX2h73HMlISqlWidtw/gc+jKpa/hJ
R/67NlmZL60mFOghdO1Kx85z/xeu7d533ec8CS6Hq9VGxUUrSq1U1BtBmqLLoRrw
/qHZkGjXtp9VxAUwVfS2sRyKmNCR8nXaD15iBp6BFM8YG4CcWTo=
=9nCU
-----END PGP SIGNATURE-----

--mp5g4xz6mhnsqghs--
