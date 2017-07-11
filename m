Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E50520357
	for <e@80x24.org>; Tue, 11 Jul 2017 00:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751004AbdGKAPd (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 20:15:33 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:57690 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750827AbdGKAPc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Jul 2017 20:15:32 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 61B7D280AD;
        Tue, 11 Jul 2017 00:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499732131;
        bh=mZJcIedlqKyRN8WF1nmK/wU3EonC2ZqYYc7RLWIWdrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YnFrldDCqG1pSG5dHon9SxJVSJcQDkz0lUUGfgxQcPFNGi2WZpnt+G9yFhMRKndym
         HahxRbm9s5kjLXEt9UfaWZretKVodxSJOreop7CvbzXImpBtoC/i+krQk4d4XvS4iF
         PtQj42u+q+TyIrZeeOJKRXwIpfk4xznNT8SWA/3PCjfywIwdDYdLd1OF4uL1M0cWR5
         BPF5AJyLvoX7D+o8p5JSMgdjL11Dp0E7LDxDm4MMPMYSSslY9r70dGTsp1yOXXdZtj
         dbYTa+zQsaEuBVTUBI8aKWIoRDHerMcI+Q64wFUxmqBCaeIYWhZ07487wuMXl1CO/v
         nQsV56/58/9j7wh1NWCkVWN/niduzVQGtftcN5RVfVDLmFWxk4k45I2bswQq592H13
         QkTwM/gn/HaKbZj867HazkqZTS1ARvjU9gIccKyfn6GdW7/g0mMdmJE2SstnkUCD+Q
         gv3kGxKMsmPti0Ty4m1Kinf+BSBlHPv+ZwJZR4fJV8LhtM6HQ3N
Date:   Tue, 11 Jul 2017 00:15:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: pre-rebase hook: capture documentation in a <<here document
Message-ID: <20170711001527.mh7rcdvhxeouzbw7@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, gitster@pobox.com,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
References: <20170710233525.11650-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zc6fyk3rh44u6zbo"
Content-Disposition: inline
In-Reply-To: <20170710233525.11650-1-sbeller@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zc6fyk3rh44u6zbo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2017 at 04:35:25PM -0700, Stefan Beller wrote:
> Junio wrote in "What's-cooking":
>=20
> > ... I do not know how well they are tested
> > in the field by people using 'master' in their everyday workflow.
> > Ideally, our release process wants to see more people using 'next'
> > in their everyday workflow to keep 'master' more stable than any
> > tagged release, but I do not have a good idea on how to encourage
> > it more than we currently do.
>=20
> Our internal release of git @ Google is debian experimental,
> which is basically the 'next' branch + this patch + another patch.
>=20
> AFAICT It is a resend of
> https://public-inbox.org/git/20120308122105.GA1562@burratino/
>=20
> As Jonathan is a Debian Developer, it is easy for us to base
> our internal version onto debian experimental, but long term we may
> want to base our internal version on the original next. :)
> To do so, upstream this one last meaningful patch.
>=20
> The 'another patch' from above is changing and hardcoding
> the version number, which we do not want to upstream.

Thanks for sending this in.  I had wanted to do so myself so I could
easily automate building Git packages based on the Debian packaging, but
I never got around to it.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--zc6fyk3rh44u6zbo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAllkGJ8ACgkQv1NdgR9S
9ovQaw/+OgxWJt58nM9XFQaQpqhLmRkX2n2d15DVgNwQPj9uEW8JjS3j7Bh/zUdt
ohxalB9kpLtBJCysuJn/w+m3jIipkbnmB5QTtaRCTaudImGPyGFp3qf/xboS2zax
ke3x6qzUo4E1Lzpdtpm/nm76RvfZbsB5tj1Ex8w0T0cwVQIz5nlPQ35xDENjJgb3
y+8Zz2fFocCFnwEcHP+0Bf6+aPfRcF5buAhi2vADjNmnorc8M6FdWP2riZdO4AJh
5Qw22/RkSveOyOupUC6XnRucMMBPkUC9MWHDRLNVi989EXCur+4C1YvRH3zbJN7x
N3+WdAy4mRHKPes7cW+aZ5Z5iXuZc/PHJ1Jlc/i7vXvtuu39UCTCnewyQEee/XiE
5s7FpnOLK873rKEssmRJ+RNnxEkbVWLYooucYR6jeVybbIaZ2H5wMgOk008CCzQh
JQ2OSJhkoXqDmR1zIU3QtJ1U5k46hRkYmzGZsTf77+7v0362tW0CX/+D2wvcEQlU
cM5NPPzsYZ21ez7VsVc9epcK2GHdgIOJZe1IhNfmdsI01DszdrjkTQG4L0b95Wud
p514pF2+teXvsUoe2yYU8Y3tphKLTMtN1x+7mMNW6C4jNknwWgqtr+bRFGw9I6o4
8sSZ3ZwZbkljQ4iXa6jYirXGU8uuZKjWlHTv1di36721ddX/jWU=
=pXOT
-----END PGP SIGNATURE-----

--zc6fyk3rh44u6zbo--
