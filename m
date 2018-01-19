Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94E3B1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 23:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754267AbeASXOr (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 18:14:47 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58142 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752190AbeASXOp (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jan 2018 18:14:45 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 25B706052F;
        Fri, 19 Jan 2018 23:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1516403683;
        bh=Eked4yuoqSF5qQu7VeQoeQsmmi+zLvPvyXhtT4+JwJI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=B7Xql2shEIYI8FBW9pz1YUIKx3Wi1EUHSklT8DthwB+MWlwWvATQ/8u/HEryliFCY
         zbZXnbYYO/OZtY/SVvyoBHRXHnUNJCyYzo0/d21aglqKvWAzpXL/X5A/PZYTiEboOS
         ceGVLtccTqBlVq+FYr5y1cAJXaRm+Z/IjEBau+nZk9wjGtx/VDq8UPlGDuYpn3Emy5
         +K6yRMkIXUfJjSB9BoH0Oe389cFuUWvdj3hK3CyuId//K1uJzm/6Whijbl4acE/EFj
         Tn8dUvqZWZFqr0dr4T/Tw8eOVdZyjhgQe85Hu0NmT6E7mmqK6bd06wgxUPI7ggklyM
         3b1llmGDwdR93WCdJGuWiE6t1Blbg/UkOw3nxBW4kjkUtUKfvMhMJYTcq74pxb3sIz
         3MwiKc4wvPFm+5A+4r89zM/SU5uo+myxCXNqHcEcJWwZhlP0toZT+jPHKV7VN+oDZ/
         Iqvgq7q/tJWG2lGCJwF+HA1nVYYjJHsVkkrlKZ5YQpUR3njixQv
Date:   Fri, 19 Jan 2018 23:14:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>
Subject: Re: [PATCH] repository: pre-initialize hash algo pointer
Message-ID: <20180119231438.GE222163@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= <aleks.bulaev@gmail.com>
References: <CAPig+cSbbzKV0GttLjHCyY3CNcJO0bdP3Mp4pT+3waUTMAQ8kg@mail.gmail.com>
 <20180119041825.727904-1-sandals@crustytoothpaste.net>
 <CAPig+cTOw5NsSmLHYcBEidDzNyiidJ0Dw1dF227KWDL9JrASvw@mail.gmail.com>
 <xmqqr2qlps7r.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vv4Sf/kQfcwinyKX"
Content-Disposition: inline
In-Reply-To: <xmqqr2qlps7r.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.14.0-3-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2018 at 11:24:24AM -0800, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > Now that we know (due to Duy's excellent detective work[1]) that the
> > trigger is files with names differing only in case on case-insensitive
> > filesystems, the commit message can be updated appropriately.
>=20
> Thanks.  Let me apply the following and do a 2.16.1, hopefully by
> the end of day or mid tomorrow at the latest.  Test to protect the
> fix can come as a separate follow-up patch.

This looks good with Eric's suggested changes.

Again, my apologies for the breakage and the inconvenience involved.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--vv4Sf/kQfcwinyKX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlpie94ACgkQv1NdgR9S
9ouqWA/9EB7nrWcDaUa9qjp64Rn6AZgM27wNRBsRIGUr3aOT8K+f5fRM+8DVnJWS
mg7QSUBnwKUYIYqi5V9Qa+gGVI5Nd+JmJJCW5MzklE6qwd88ZHmbL1CX0HX89Qez
c3kRxLaYNAu3JmRgQTm3kQQlQuw0VgA+BAt9X/0Pp50jI3uH5Z98WLt43kX3PSjA
X68p8yc1wYiRqFiafC5DozHRXPcyG7C7kPK85eZjVf4rdUelelagOCTVLDk8dzgQ
brOMInWB8EacyW0gH37YR66E1xtE+0bGOXbk7TVXyGobnP/0V8QDYzC3NxtDWxwq
KgTAqcqDNBe23PC70QYgxGdtHLGD4bapYtzxnTF/7ARUmSWhkyevUIszD9r8c6st
Yja7KeykshpuXtLMf0LwmhsFf+0HnSya7KzStbkUkJnKRDNMl3sev3GOhVWYvnfV
ALnP1xZXyDCreOgdIEfPxGpkwYy+8VVEhsiC2TYVop3R34P52WnhzAWw4FrxCs3U
FbKgmuPEZZJPWAGWDsK0GsjUACtUr4LlTMAngmi3PERykA6cBo635P7qMSNeg7ws
r9AaWaTynVpmFX1KNKsMK7OUNBMLJiuM67RcXM4nsbQSpcopCje0IY9Tq2qztMdv
mR6Hco2BcOSJOBH6DXRBGo4N9+6mwmdkswO30RxRUF7IGu+w8sc=
=MI7Y
-----END PGP SIGNATURE-----

--vv4Sf/kQfcwinyKX--
