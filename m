Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76DD0200B9
	for <e@80x24.org>; Mon,  7 May 2018 23:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753504AbeEGXo5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 19:44:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41994 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753271AbeEGXo4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 May 2018 19:44:56 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 79BF760444;
        Mon,  7 May 2018 23:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525736695;
        bh=SW1rYUZR4DU+e3i58xROqlkogRHanp3pZz7sQB93kAA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QIRnFR6AUdftobVaq3r/8BtsgAxgG6A8K4KshUWYoSBThGXAsk+KqyKQ1sX3mq0Z8
         8R9GBlFsIMlhd1Ga6qgTNFrBkzC+Z2E/ufrdWRsgfADSd7hDoXW6z76ANLQsCp1OQK
         BsL/S1oMfgeYF0DwXcXSRvEsMrfuZQOxA2JT2HVjdVcUpNSnARJvoBDykMx2LPf1JY
         vTP7gitguJu28Xtam4WQXQQGjJXz4l1VDa/hRsZLEqFXBtx6xwhSTypvzkmK98xeas
         Op/1EG5vdaZ/y7TQygC21bpwAxz/BuKlV0V/mGyp40KwcSgeDeDQmfxlZ/rqBc9yWz
         r7JjoYMTLdugNyCGOZbGVWbSPE3S8OUj+HXQ8lbzbZZMggLmoc5gE4AyW4uw8zYq3p
         Np0MF6WXVE5Q/5iQ6x86Xpe8vZmCCWcr7yEutn+Shi3eZ+sTPBzAi1uPHvC5egGrZx
         qesAqgK+HATK6SANfB8MZ8aCVfYbcPT0GYwz1fX0+P7Zk3x+jgI
Date:   Mon, 7 May 2018 23:44:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] mailmap: update brian m. carlson's email address
Message-ID: <20180507234451.GK953644@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20180506232421.975789-1-sandals@crustytoothpaste.net>
 <xmqqa7tcqgpq.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RD6GsZsdEJvsf78O"
Content-Disposition: inline
In-Reply-To: <xmqqa7tcqgpq.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--RD6GsZsdEJvsf78O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2018 at 12:37:05PM +0900, Junio C Hamano wrote:
> I initially reacted to "was reversed" with "yikes, did we break the
> mailmap reader and we need to update the file?", but apparently that
> is not what this patch is about.  I think what is happening here is
> that cdb6b5ac (".mailmap: Combine more (name, email) to individual
> persons", 2013-08-12) removed
>=20
> -Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
>=20
> and then added these two lines
>=20
> +brian m. carlson <sandals@crustytoothpaste.ath.cx> Brian M. Carlson <san=
dals@crustytoothpaste.ath.cx>
> +brian m. carlson <sandals@crustytoothpaste.ath.cx> <sandals@crustytoothp=
aste.net>
>=20
> where *.net address did not come from any other entry for you in the
> file.  I guess the author of the patch saw that you were sending
> your messages from the .net address and tried to help by unifying
> the two addresses, without knowing your preference and recorded two
> reversed entries.
>=20
> Will queue as-is for now, but if you want to update the log message
> I do not mind taking a reroll.

I can reroll with a less alarming commit message, sure.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--RD6GsZsdEJvsf78O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrw5PMACgkQv1NdgR9S
9ou8iBAAg7ElZqKUluDlK2S1tVbhNf/KqmiTnV3H/PGsJdnDBUdaRD48Z5zonoxi
xUNHjB4AQJC45T8WcOIzdHBnoOqGjD8GiaHxi/0sLuwlz6Or5aOluy8HbQ+THbLR
ZVGTz3m596jDRkWov3LIUObB3n2b376LjBwo/3phAqclZCdOfLfN0VfC4LnQJUQx
9v0KauhkImtGT0aaEWdiVoj2t9l5t6B5edj+xSIX+YvAr3quE/mH3wEjmzsLhYnO
vMRJDjZhpaKtTxKEv+7IKm9z6hE86TBOdSzR5nPiv1qBnMWHciNT87YPCjNmZ0KP
waHREu88KurzouyFuZQfjJLIE2BNU6+my0JLdxU7CWM1TXZS4UdBzzyTBJV04z8c
tsRa3cFoQ4ekqMSfaD0M5ONxrbVg6Xi+I/eMtCLZAPZUws+uXxGs0qdoLGo5YXwy
juIKWiZqbOysgh1K77kL28nZWNPrgvcsBZao7rePv/4pRuCNO2jbbHlxA6dg+KWa
E1lhqPgAfdaOEaZO8sK9tJ9FLGE2FqDVyluT6p6YXRDQbHrunBtCZteYxo8/HHir
TzNng3fFzdQHmQQUGU2rsM+aeRDf3lbZfP4QhpRc5f71XaO2WIvPtA/Qt6QegJHb
AhchfQl23WKyfoVtWjAgApyFkC9d/C8LOtDedN6NiFLwUmhMEuM=
=tNIy
-----END PGP SIGNATURE-----

--RD6GsZsdEJvsf78O--
