Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BFCC1F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 01:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754631AbcHSBs4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 21:48:56 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:12111 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754424AbcHSBsj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 21:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1471571310; l=660;
        s=domk; d=aepfle.de;
        h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Subject:Cc:To:From:Date;
        bh=eq/28uiD/qGK36fYZNlZYGYHXoj463SvB5DmvRZCRRw=;
        b=J8UHzD4/v5dJQgY86dWVNx0WyJ6c+3t0mLaa6IAn/kqbOTi3eHT02dSrKU2Wox9t8md
        2ljNFNpvsVO6qlZcOotbYYFdLqV5i98TSk8CDxXSl1+HL2/wFQ5jlNndLQltThzMPwTvX
        SsRoLynkE0sv4BvBFHwIJHP62FJxImCLaEE=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi5z/J1IL7CYRxLEwpkY2XtLzyRUcY=
X-RZG-CLASS-ID: mo00
Received: from aepfle.de (nat.nue.novell.com [IPv6:2620:113:80c0:5::2222])
        by smtp.strato.de (RZmta 38.13 AUTH)
        with ESMTPSA id a07f67s7IFmF6cK
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 18 Aug 2016 17:48:15 +0200 (CEST)
Date:   Thu, 18 Aug 2016 17:48:13 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Jeff King <peff@peff.net>
Cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
Subject: Re: git format-patch --break-rewrites broken in 2.9.3
Message-ID: <20160818154813.GB9062@aepfle.de>
References: <20160818144421.GA9062@aepfle.de>
 <20160818150522.56gdx2mhgo7qwvru@sigill.intra.peff.net>
 <vpqa8gayumw.fsf@anie.imag.fr>
 <20160818154022.5mp4cr5jq57doh3d@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <20160818154022.5mp4cr5jq57doh3d@sigill.intra.peff.net>
User-Agent: Mutt/1.6.2 (6759)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, Aug 18, Jeff King wrote:

> Olaf, what version of patch are you using?

Mostly 2.7.x, but also add 2.5.x to the mix.
So far I did not try what the tools dealing with the resulting patch
file would actually do with such a stripped down variant.

Olaf

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAle12LoACgkQXUKg+qaYNn66cQCgnsW5WjvwiZJBi82iTJ9XMybt
eNQAoI57U72QzB14W/gJ8dhn2irJ3ip3
=nJFs
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
