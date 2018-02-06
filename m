Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FA891F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752285AbeBFAeK (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:34:10 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58686 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751834AbeBFAeI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Feb 2018 19:34:08 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 850286042C;
        Tue,  6 Feb 2018 00:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517877246;
        bh=JQPf3PMyqoj0LJmVcPML8IEeuPZ+3F1Pq9CoUlS+5SM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=jhbGuhjc7ydOWFDxJU9H6dE4mh/Pd/RuNrNBrRkjh3oe/wbGtIVU3273lPaRjh86A
         UGk0Jt9Mdn++DylH17Pwj1cY2WFD6frRghTp3dmr5wxtQjk/OT4rNDma2SS6TMbL1V
         rjkDQhmOgTF6OOktsNVnxXy0MO5LE68/UuMT3Xng2tOzxj9iElh0qMJgx8NwiG7DT3
         mMyzANDKsXptBOeWW7IHAE3RUMGWESQcYEC7ba3q8Js+7VMEJhVenfU+0YIqO1Tya2
         nugZnhwg26JDH4CZSYshLVjEs/ciHsEFRbhO5xzFYXBR61655YlhjYO/lgpw77QG13
         SIBX95vDVhImqX3X9MYuaDlansYICUUscfqcG/AeaKQe7b8wnJKnjsIc7ZYjS/eupM
         kPDmyQQqiZAmS2y2t6r7TuKmE1bgfSiL/8/cUYnlbi+LcYw35sLsW6qNmEZJtXcfZ9
         /apGNiJNtVq2YOhCS0SjM8639MlTY3TGveEoeTYUIIINuwggvkP
Date:   Tue, 6 Feb 2018 00:34:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/12] object_id part 11 (the_hash_algo)
Message-ID: <20180206003359.GB7904@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Patryk Obara <patryk.obara@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180201021848.533188-1-sandals@crustytoothpaste.net>
 <xmqqinbfcgzo.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline
In-Reply-To: <xmqqinbfcgzo.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2018 at 11:46:03AM -0800, Junio C Hamano wrote:
> Thanks for working on this.  All changes looked sensible (even
> though I spotted one nit in the original, which was moved as-is,
> which does not count as a "change" ;-)).

I forgot to ask: do you want a reroll which fixes this, or just a
follow-up patch on top to fix the comment?
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlp49/cACgkQv1NdgR9S
9otgWA/9FwoSMW284GE+5Vxj1iySbzeyCdpPKctlekankgvsl9F6R00GKrmD3YCb
8WtfG5bkqfPoyyxy6Vb2aTa4/kFnmMxq+ei9JPEuuqjaHscVCURykK9V+WzBy32m
K5DNfx9OPMSKijDQYG0LbswfQhoDKS46h8ORgdR3QAGCNnba66ZC6oCagA8s6YfR
EpIZJVoZCGX0tbLgDiBUWGya6HrFx18kqWBjd3LTZHiR6+XzCHNhdRHF9POaNydv
nK7KGIeLIKBf1Jd/eE2o1+A1WEUhgR8LTikwyR0VnYByLJUyHVMpJwn9OOjAALxL
AKRGyh+MvRuk8onsf+Q6A1+MBYm/p9LvrZ5XfS41wkR4aDVBZEeQceYPOZ6+DnZ+
vnh410OFMLVQLO3kagD327LztsvaRGYQNpiJjC8V8YgYFwZT6MYEtWqR5qUil1QV
GOhtiiB8b6kTzc4ZbpNnaV7kiMOJ9pME9yfROsGE/JGU8g6sUn+lvCZZaVhu3Fvb
S0ujNuRdmh/qYQFXJIuLA+i/naapLQfjJIjQSidEXJKCm5oEKij7gvXrIdSz5XYq
pUt/HR5K3+F14f9QLEy2qP8JDheRrLpgqqA2j3XoXj/glBZjnEOcFC61HEnQqszG
2KczOgo45lHdRjhm6vus5hJ6Z7KLZj3taU0NfEKISN2MQjczYjY=
=eYhb
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
