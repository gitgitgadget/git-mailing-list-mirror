Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6953F1F404
	for <e@80x24.org>; Sun, 16 Sep 2018 12:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbeIPRYG (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Sep 2018 13:24:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58334 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728183AbeIPRYG (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Sep 2018 13:24:06 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:ace9:16cb:2872:156])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4C80760735;
        Sun, 16 Sep 2018 12:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1537099279;
        bh=5UrBiNovNlY3euODVZYmhCyE0Pl47sOaO7CcITo64J4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=VrfOJE8gvl7Ftc99zEyXk88EA8QZyX7zLosjEfXIZSTUR8Fvyl7kWJpPZAXTODlsZ
         wdVUf+fAo2FIvKRWi5zQRBTaTbf1nIUETsTEdF3xUqtMsUztKj6oYUQ7I7SDRXW2tN
         UGlAl+SZ7LstrnRff21kkJRG3zRpD8y1fd2Gv0Fyq1KC3l8ujSYodQeb687hNQ+ilj
         K2Oqigrm2K+Y7m0azuAFR0PuwD/4Hh/eOkHqY8rVbWyWKsHZeisk5mNwcu+my+no/Q
         E16ju8s4BbGyj/TlKExTClUPaAWDfLubHP+ETxKnqEzBXRJXW3kGCRKfIk8/R99Ken
         yNHIVHbMHcd8w3mS5f0NuXMap07n8if5RR136r6VOe0pfGBrWhBVm0WNnbH6Ktpij4
         T+5x1kZb4yGXALAXQJY1o/50G/Lh9enNvwNqQgjwofGhNv+0MQdpZ9At4GQ/lD49bH
         uyiasAIrG/Nt/IhJgyn49vcdWQ63D8ajchd3A/kQAQWcJ3ZHgzR
Date:   Sun, 16 Sep 2018 12:01:14 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2018, #03; Fri, 14)
Message-ID: <20180916120114.GV432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqy3c3agkr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vDpQvD79HZx/5O2q"
Content-Disposition: inline
In-Reply-To: <xmqqy3c3agkr.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vDpQvD79HZx/5O2q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 14, 2018 at 02:56:36PM -0700, Junio C Hamano wrote:
> * bc/hash-independent-tests (2018-09-13) 12 commits
>  - t5318: use test_oid for HASH_LEN
>  - t1407: make hash size independent
>  - t1406: make hash-size independent
>  - t1405: make hash size independent
>  - t1400: switch hard-coded object ID to variable
>  - t1006: make hash size independent
>  - t0064: make hash size independent
>  - t0027: make hash size independent

Could you drop this particular patch (the t0027 fix)?  I found an issue
with it that I'd like to address, and it would be easier for me to just
send a completely fixed version in the future since it doesn't have any
dependencies with the rest of the series.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--vDpQvD79HZx/5O2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlueRgoACgkQv1NdgR9S
9osR1Q//VrqjBBZ+LrF820xLUXUKC1izMA5bZqtj8PXIzay22mr86r662ucYdOb1
7wmB0IYHEV4ZMGSz+yRXxvYLJoQASzGyObrDNau0/ZvVCEgUs/jamxoH7l8NRRCO
7jurIYutT47Fr4bPDUl2waJMiu+iJNvivy6+IsfoUaEh3CgUwCL3njPO2SRDvp83
5T/yv7DRC9tKF1umfssFTC5VuvdZW6J3h1UUJXAtIJLqKn6BsIAYKL4XUy12ZyQg
bjypvtAozetSQECkoeW0amh0YDQOG/giTnMjhsSlaTp2JlClks1VVrcZOCbTes7a
BLXaJzwvX4t4t2CD6OiRp4lDox0TCscR5EflSvsaGK29s6g7ehmfN3BP6LkdYuHf
/zUxv55WuFjcJzBFHcwgH+61fu7oJaPP1IQYQ1297pbiB7EeTEFAAFEUosSqxUFS
qFzl88uSohuqaKISbcr/X6fdqZEU5wfSeUzVz/W7HyRqpZAhrAVKgnJi4iPYusI/
FC+Yv4ujMT7uAOI43mhVVGpqSOWUbHcXEa0WzcPq3fsw4R2xbVdLzxz7V+pJr+L2
jrnwd9ClelUOGRsD7FL+mnTAOh1U3Jx4sdYvDX+muzeKVkFCMjVMEpF9jQ7ixtkB
cxN/evhiMRNwo008jyXSv1i56QAzhgxEW9fON0pkxsl2T5fbwRM=
=VKOX
-----END PGP SIGNATURE-----

--vDpQvD79HZx/5O2q--
