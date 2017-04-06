Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF82E20966
	for <e@80x24.org>; Thu,  6 Apr 2017 00:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755451AbdDFAxS (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 20:53:18 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:60770 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752052AbdDFAxQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Apr 2017 20:53:16 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 72FFC280AD;
        Thu,  6 Apr 2017 00:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1491439985;
        bh=fzlLcBZPWWGNPJC6Xr4FP27mHLS+LRfFZHdfI8vLGQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hTV4HcFNhZdFp2cD55gu5ezfNeBVG3lvJ7uVlN70lnjpPFL+KZwNH3dJro3y6IaiE
         d0ret3BEX5wzIquE2d1qqa2zsirWWoRs/dFBuZW/ihIBbqv9kWcg5WBejhgJEN+N0s
         iB6Eh13w1hVmMz2C6+XEbtmXzau+Jugh6et6jPPUzWTFuDMSwsX42B2xkjdW4BZTli
         R4QUJqTKPLCogRr/FY3CaXBIOG+8e2ulXQCJbXgFITe3nUyAE4zRz8NmSixpK+/pQq
         jRau6lDZ3F06UctEIed5EaB2wspidVOvJo36znNrcVqNfCKAOh2yfe9JpFIRZpijTX
         tD5VkWaudDZSJwxpacy/O3Xgc89ZoNar9w/eiJG1UMeD7gwgM1ZmXAwNGqECiZZe4S
         KCTHQXWoGlPSlJm3P1hne3YRRAS57LB52p1/46kyeIUD6DhFGQRNzX12cH95QnSIkl
         6mtFWu3Ckj2feXng/gTGCGzfQ/hT5SyQEFfG7ARP+tQmWY+VBcH
Date:   Thu, 6 Apr 2017 00:53:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Tom G. Christensen" <tgc@jupiterrise.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [RFC] dropping support for ancient versions of curl
Message-ID: <20170406005301.4vmjkiu6qkj3g276@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Tom G. Christensen" <tgc@jupiterrise.com>,
        Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
 <d6ba17f0-3da9-8699-8d5c-5ebf1eaef00e@jupiterrise.com>
 <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ifhutcblddojzvoq"
Content-Disposition: inline
In-Reply-To: <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ifhutcblddojzvoq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 12:51:38PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> On Wed, Apr 5, 2017 at 11:33 AM, Tom G. Christensen <tgc@jupiterrise.com>=
 wrote:
> Whoah. So my assumption in
> <CACBZZX78oKU5HuBEqb9qLy7--wcwhC_mW6x7Q+tB4suxohSCsQ@mail.gmail.com>
> that nobody was compiling this & thus not reporting failures was
> false. Rather there's an entire community & distribution mechanism
> around patching git for older EL versions, but the patches aren't
> making it upstream.
>=20
> $ grep -h -e ^Subject -e ^Date *patch
> Date: Tue, 13 Oct 2009 11:34:11 +0200
> Subject: [PATCH 1/7] Make NO_PERL_MAKEMAKER behave more like
> Date: Fri, 13 Jun 2014 11:02:02 +0200
> Subject: [PATCH 2/7] Install man pages when NO_PERL_MAKEMAKER is used
> Date: Mon, 22 Sep 2014 13:42:50 +0200
> Subject: [PATCH 3/7] Allow svnrdump_sim.py to be used with Python 2.2
> Date: Tue, 8 Mar 2016 09:31:56 +0100
> Subject: [PATCH 4/7] Handle missing HTTP_CONNECTCODE in curl < 7.10.7
> Date: Tue, 23 Aug 2016 10:32:51 +0200
> Subject: [PATCH 5/7] Add support for gnupg < 1.4
> Date: Tue, 23 Aug 2016 18:15:13 +0200
> Subject: [PATCH 6/7] Handle missing CURLINFO_SSL_DATA_{IN,OUT}
> Date: Tue, 23 Aug 2016 18:26:54 +0200
> Subject: [PATCH 7/7] Do not use curl_easy_strerror with curl < 7.12.0
> Date: Wed, 2 Feb 2011 21:24:44 -0500
> Subject: [PATCH] Restore vc-git.el for basic compatibility on EL-5
> Date: Mon, 23 Mar 2009 00:03:36 -0400
> Subject: [PATCH] git-cvsimport: Ignore cvsps-2.2b1 Branches: output
>=20
> > Patches can be found in the src.rpm, though I can also post them here as
> > patch series, they cover more than just curl.
> >
> > I don't use the el3 and el4 versions much any more and el5 use will also
> > drop of now as I'm busy converting machines from el5 to el7.
>=20
> It would be great to have them on-list, as far as I can tell they were
> never submitted? Is there some time/administrative reason for why
> you're not submitting them? Some of these are many years old, it would
> be great to have them on-list for wider review & included so vanilla
> git works on these platforms.

I'm very opposed to accepting patches for operating systems that are no
longer security supported.  Having insecure systems directly or
indirectly connected to the Internet is a very bad thing, and we
shouldn't make it easier for people who want to do that.

CentOS 6 and 7 are still in use and security supported, and I think we
should support them.  CentOS 5 is EOL, although RHEL 5 is still
supported in some cases.  RHEL 4 and earlier are definitely out of
support and we shouldn't support or consider them further.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--ifhutcblddojzvoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAljlkWwACgkQv1NdgR9S
9ot+dxAAiuzxndUKVz42EeQEIL7dIPdJw40A971HFDVg5dCV3MxnhzU0JiyWTSb+
C/tS1GR+YDBLJeIzah6AbOKHVvWQTkK6Jgeru5OuTXbCgxlYiDBshndGcrHzi7Vr
8xN63YwAHyS+kLSfSA/AY2H0NfmjJCEXi22JrwGV1Cqqw2Ee6EBzMP5ma3U3G72U
bAw6ixfVHMIL6SL0uafq3sVKlMxYxvJ3GlN2t7FEU1PdSgaLeAbjXyBrtI0btEML
4LCerLEC7V7h0sUKcyXbzvo9rS8U4sEl9TvdNGN93+5KNvS7X7FKHW1mmMDWAwb3
8nR+ukA9v9AriRLOFdAzlaaw+wmX0s+enOaUx3ltfh2Y4VWhcoV44bWWMcPIM3Z9
TxRU5ANf51qJR679NPl/sUlIOsoVDHs9EhQ8il6r+Lpq9QSCAp+DXfgTabpE+Fjz
BrhwbtT6kZWczH4awhV1JyvtZti8ko48Wx8Z08PqrVxqiySpdF+/F8/Y+/AjCXEv
uwyNitEh2pxMHD/+8bKA6Jyjn2+XGdMKbzeVKFI/ubzYkyzpSWlHKC8KmojEybyR
gFKmqKAzf5BpyOAMEoc/y4e5seGeEMt8XD+bLTcCVoY8l77AuLBf4Y7cxqP4oGC0
qF3JwIfkYJV6o1jrmHyS5atdtClYRRuYRkmC3ZbqozESujsadEA=
=2meg
-----END PGP SIGNATURE-----

--ifhutcblddojzvoq--
