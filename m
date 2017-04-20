Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD4561FE90
	for <e@80x24.org>; Thu, 20 Apr 2017 00:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967202AbdDTAoC (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 20:44:02 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:35970 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936095AbdDTAoB (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 Apr 2017 20:44:01 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 5E601280AD;
        Thu, 20 Apr 2017 00:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492649039;
        bh=BkjxGT/jKYrmH3CrpOBF6+lyTm9Y+Cx0JwhEPCZ5VfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MsDepl7Adncv8CwgtUEE54ijIeqUitWv6dNeAWd/u3ne4/h5fc8F6Ij4Qb9Y0Vhpk
         ZRoxRLCA0FB9LCSqd/Kh+4q+St8WcN8NjVDxggoZhf2gcQskyewK2Jqs0gB5g8lYcm
         nvDlMaar64jgsr34qvBQHi8AD4VKzQas5OPILYx11FrNhO+7YyGuOL6uiJ3/NAebBE
         BIKu/wsdR17Zy5qyE6F2VtXiz9JaE2zN4/Ez9/09BNLZ8SIbApBdBRDXT0IBu1OJfb
         JOEvcCZFByFz9lAXuSKNzCPtRHo/s03edXGd0y1VPOLZlqF3JjNeowROFl1tKBOMjp
         32F68R1itzJl7el5v5Vs0PFQlZOF4K5RiUFaD3RxEXhOnNnzK8dO9+WUynfF2mqqbV
         B8bHwIOQ0b4fOA7MVYoPQR1wUH5Anu/VtPHirZa2rE3dsimHYKH2LIrNbekTXCwrrQ
         dEXgVpuKmjUZaVVNnJTy8jts6LkDOisQiv3zc3IjpZ39kmMMV0I
Date:   Thu, 20 Apr 2017 00:43:55 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [bug?] docs in Documentation/technical/ do not seem to be
 distributed
Message-ID: <20170420004355.wlojjb4miudun4ur@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Samuel Lijin <sxlijin@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <CAJZjrdWNQFkWwAO_hmHMzVGNNMfynxsvbWufGvRWX8bZD19Epw@mail.gmail.com>
 <20170419170509.GC28740@aiede.svl.corp.google.com>
 <CAJZjrdWey6atV0rQUborVH0mnev5j8q3Qsny1dgr9hj8_Hz5uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ogbu5ijgunup5ps6"
Content-Disposition: inline
In-Reply-To: <CAJZjrdWey6atV0rQUborVH0mnev5j8q3Qsny1dgr9hj8_Hz5uw@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ogbu5ijgunup5ps6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 01:03:09PM -0500, Samuel Lijin wrote:
> On Wed, Apr 19, 2017 at 12:05 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> > This sounds like a packaging bug in Arch Linux and Ubuntu.
> >
> > That said, at least in Ubuntu, I am not able to reproduce it.  Do
> > you have the git-doc (or git-all, which depends on git-doc) package
> > installed?
>=20
> That was the answer on the Ubuntu machine. Doesn't apply to Arch,
> though, so I guess I'll reach out upstream there. I've also opened
> #994 on the git/git-scm.com repo for this.
>=20
> Out of curiosity, do you know why it's distributed like that?

I expect the answer for Ubuntu is that it's the way that Debian does it.

Debian traditionally distributes documentation in a separate package
because it's architecture independent, and the binaries are not.
Therefore, including it in the main package would bloat the archive
substantially by including a copy of identical data for each
architecture.

Doing it this way also allows people to not install documentation that
they don't need, say, on a server.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--ogbu5ijgunup5ps6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlj4BEsACgkQv1NdgR9S
9oteAw//bLIwl4O4Pr0M9CHyHjHWnHfLRUJGA5FX0bZJ/RN26nUBMAjHPNQ+2uw4
kOqsh7fOmp7Vw+pgJR13iYjSyahnNy4whpi72kbbPNvetkjDCd63pSO6T9FpqecC
8X6DKYmr+Sb5kCVS0kWc5Sa5nIZKeJsgyM78UfC3gRHr8P7rC148mxMm/9ceCu4/
D8P6sjCm2xBMKNvmcrndF2mWGgmq6Kr7O67mLYAR+89Hk950J1yMjAJIG8M/oAh0
bQMn95YatjNHn2x9+tTgTX3IaXc9Ww++q1YY5SairqugGDHeA3pME+We5lwvWGhB
nNmaQmV2u+8wUdZZ6pFcuK2P75DlEXxSaklY697DwY0pDVygRWnvdp6MI/m5wLBK
fXV77z7NRmC5LTCdvUMvyY2oUz30M/dce+6VlG2B9smtWG/5vahUTCj4H+v9duEy
vsiIIoy0AMDTNsMl4szGybF1sQdN9CBkgksUan0yg9SaSoAWLa1jYxruNms7lItU
6+6FwNzYuKq31OFf+oO7EYv3OQebstnbg+a2IEduiOaTo1NJhWEK8NfYhm70/Pnr
sIPiDDmKMNMd//BRTxgy24uFB9yStJrONsm9LvbbIuKnJRgl79acRIdSCKFtwm4O
1n01CaVGMlUVwQ5JADqKFVUq16zlaVXbDR+GjCKxGAW4859JVEo=
=wwcC
-----END PGP SIGNATURE-----

--ogbu5ijgunup5ps6--
