Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D1B81F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 17:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933378AbcI1RDg (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 13:03:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933018AbcI1RDe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 13:03:34 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E87A9E60C
        for <git@vger.kernel.org>; Wed, 28 Sep 2016 17:03:33 +0000 (UTC)
Received: from [10.34.4.182] (unused-4-182.brq.redhat.com [10.34.4.182])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u8SH3V3p023182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <git@vger.kernel.org>; Wed, 28 Sep 2016 13:03:32 -0400
Subject: Re: [PATCH] http: Control GSSAPI credential delegation.
References: <1475078752-31195-1-git-send-email-pstodulk@redhat.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Petr Stodulka <pstodulk@redhat.com>
Message-ID: <a4d9efd9-8cce-dafe-f2f7-0cdbc5d7ddae@redhat.com>
Date:   Wed, 28 Sep 2016 19:03:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1475078752-31195-1-git-send-email-pstodulk@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3durrFCNHMfm5ot565xWbsN4jAQuSMdAp"
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 28 Sep 2016 17:03:33 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3durrFCNHMfm5ot565xWbsN4jAQuSMdAp
Content-Type: multipart/mixed; boundary="DqAFPPkTgkDE2qoCaBsm6D3CKvKqgSelv";
 protected-headers="v1"
From: Petr Stodulka <pstodulk@redhat.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <a4d9efd9-8cce-dafe-f2f7-0cdbc5d7ddae@redhat.com>
Subject: Re: [PATCH] http: Control GSSAPI credential delegation.
References: <1475078752-31195-1-git-send-email-pstodulk@redhat.com>
In-Reply-To: <1475078752-31195-1-git-send-email-pstodulk@redhat.com>

--DqAFPPkTgkDE2qoCaBsm6D3CKvKqgSelv
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 28.9.2016 18:05, Petr Stodulka wrote:
> Delegation of credentials is disabled by default in libcurl since
> version 7.21.7 due to security vulnerability CVE-2011-2192. Which
> makes troubles with GSS/kerberos authentication where delegation
> of credentials is required. This can be changed with option
> CURLOPT_GSSAPI_DELEGATION in libcurl with set expected parameter
> since libcurl version 7.22.0.

Correction:
  Which makes troubles with GSS/kerberos authentication when delegation
  of credentials is required.


--DqAFPPkTgkDE2qoCaBsm6D3CKvKqgSelv--

--3durrFCNHMfm5ot565xWbsN4jAQuSMdAp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX6/fbAAoJEPiGu5hNgNqPdl4QALiHLrZt7yap7qt7N6w2i42a
NftRS3HtjOqxHTiSooEh7u09nP+DEeYpMUBcVpmilgZjD+7c5As8BXbLOvVr1kUl
JlGIktsNvQMEBMgfIfJ5DF2atuJeeL70G0VqggWonWPM9YSkOOc4IW1EO10is0ZU
YFCqldoIZ8ggeTR4kn4tMcaXTR4mdHUr1RvioaQ9haeNyQgrvdY+VVYQGiZenQNw
IYtCxXhsWCSXRdMYyQC6IEjb3EecKPQCo7pTEbH1TlVcUEOp/epjVuRCEypYfqdI
bzh0TT/p6MY/zesXvLKekTNWwro5knx+1quYkEb7Wah3ioQyIFtDREf7OJ0KWq6S
H7nqR9s12iQ6y1eJaxsYvO6aDm7POM2UzGRzdeYcrVITCajZ/lGgaTmBmF7ADu5+
KJJZVJvWTrTsejOtCZ/op9X5BvaC9H5WQ34MJuKDbui/AGBg0Pyyyu52ihvWULsM
QhWcBoUptEaruQ4TBZMi66+Y0bepxZXzueXI61W7n8PUVMjy00LqPnRYeVw97v9Q
Gltnxspz1G6QCBm4fvWgr4ZMyvbkx16FnqgB7UnvlqYJgl1NyVgop2f8pTC4y4HA
/FSZEypSSy7SMsNU7t5dBRS2P0tVIUtym2j5Lsj/E6D54WDnHv6398PQIx2eIIpD
gqACEjYE3adZFwLOhG/4
=TEhg
-----END PGP SIGNATURE-----

--3durrFCNHMfm5ot565xWbsN4jAQuSMdAp--
