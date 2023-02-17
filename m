Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEEFC636D6
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 21:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjBQVVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 16:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBQVVr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 16:21:47 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E32C644CB
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 13:21:42 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 17C5D5A1E1;
        Fri, 17 Feb 2023 21:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1676668902;
        bh=Ji9ZyCwE2tXmCvTeBsMd3goVi98lPZ/iEnq8L5Ot0iI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ONGxaWQ4DZqpiXLgD+FuQddazu0QVsDI81qYeng9fcAu7bcuIXqMljYgAyo74cLFT
         BQiO/i9/hfxl/JAwNXxVjUgtJ0INHLd6WfI0lZ9QGi2accb1yUTpSOYYzEtI12m0jR
         Wqi3aUtOl/14WtYmnbMMmLoqsRguSPrg8LJw/J/LMg/iiJFWIHfxsZ/lyeqnHM4usx
         KsY8Ti4MIh2HqfENEK+eCufLSpWqHo2/uDCx/OTauCmEZazpnrkvOgrSgDGzcq0S7P
         d6C1Ipw7kAVI0kGkk+QLr0s0Fg6a61/46WHgHQcbrF/26H54ZnbzXfQ58lcnOATgBm
         pLNsfd/OfslylU5lJoJoeFrayeg98sZqQjyZznoKoOIRxDBjhkrjbJkK9418bwqVz2
         J2KKJfdoC9Fhvyh4b9KByn5FR+QcdCA8BZMxgesCjQVdwXTtaaoxJ0fAubIm4gjqJG
         /3VjNvLOqS/A6RYMmjsF9WfVD/RJDbeMuLaSMK9rZFFjLD/jUxi
Date:   Fri, 17 Feb 2023 21:21:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     Git List <git@vger.kernel.org>, Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
Message-ID: <Y+/v15TyCbSYzlVg@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emily Shaffer <nasamuffin@google.com>,
        Git List <git@vger.kernel.org>, Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x4qWekkrs3923sIH"
Content-Disposition: inline
In-Reply-To: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--x4qWekkrs3923sIH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-02-17 at 21:12:23, Emily Shaffer wrote:
> Hi folks,

Hey,

> I'm looking forward to the discussion!

While I'm not personally interested in the VFS work, I think it's a
great idea to turn more of the code into libraries (or at least make it
more library-like), and so I'm fully in support of this approach.  When
I send patches in the future, I'll try to make sure that they're
friendly to this goal.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--x4qWekkrs3923sIH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY+/v5AAKCRB8DEliiIei
gdS0AQD3j6+2fC6Y5EIEIuvYcpDqV+PfECQdJdVA9vLtMqdyywEAicqfV3ZlN3++
UO1jl4n5FG48l9v8vvUHKIDJ8SWrPg4=
=Tpps
-----END PGP SIGNATURE-----

--x4qWekkrs3923sIH--
