Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 645741F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752141AbeBFAnU (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:43:20 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58696 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751796AbeBFAnT (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Feb 2018 19:43:19 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D67EE6042C;
        Tue,  6 Feb 2018 00:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517877798;
        bh=QEK60E/GmW5884aSQPd5y+bU07fk2QhDgkbg68UHxFs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=jLT9ebMYhoIn1yaiLeZoEcVDmtPM5ba1Wjmsr1FakbBrGRiPyXeTaq4zOtggpt3/F
         a81+OWMYAOvoxT+DfRkuM+ebwR7/jvH7cmbacyzElKWITZJJBuOWnKmJea3UTTontp
         816gKGwByYtYXIk3i+mU5QnOl3v/2cNhr4Y9VixKGSc0hbIKunEhHJS5i4x9uGk9D9
         g9B5HLkrgNQP8esN8/nXtVAApYaiIh4/xSTsZyBEazR7tIcEoNc/VwfCTdpdT5gjiW
         iM2OThaHHmZ/77tX2bOyauxq4PCjNyH5Cidta7Sx+L7r3WKI/qA+mXjEe0usz0l6F/
         ZxnfWvBVhWab39J9LOKCR+3PJ0IQ5Nl6asgV2ZsypP+6qoDVimfyMEMSeQCZx5qAG1
         4NnjSGQr1kRFNbPotpQSS3Upn1bVslZ/703YvU3JzQkBDM782QN+iZmydGVMyuMVCA
         t/M0xqWXgPIP36OJX0n6+4BKhw/ACXAKqvah6/eK4VEv9IJDbic
Date:   Tue, 6 Feb 2018 00:43:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?Q?H=C3=A4cker?= <mhaecker@schwarz-online.org>
Cc:     git@vger.kernel.org
Subject: Re: Missing git options
Message-ID: <20180206004313.GC7904@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?Q?H=C3=A4cker?= <mhaecker@schwarz-online.org>,
        git@vger.kernel.org
References: <AD196D8E-04DB-4274-ADEB-D914A79628B3@schwarz-online.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+KJYzRxRHjYqLGl5"
Content-Disposition: inline
In-Reply-To: <AD196D8E-04DB-4274-ADEB-D914A79628B3@schwarz-online.org>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+KJYzRxRHjYqLGl5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2018 at 10:12:05AM +0100, Martin H=C3=A4cker wrote:
> Hi there,
>=20
> I just recently learned that not all command line switches seem to automa=
tically correlate to options in the git configuration.
>=20
> This seems something that should be relatively easy to fix.
>=20
> What I=E2=80=99m most missing is
>=20
> =E2=80=94 snip =E2=80=94
> [log]
> 	graph =3D true
> 	patch =3D true
> =E2=80=94 snap =E2=80=94
>=20
> which would / should correspond to `git log =E2=80=94graph =E2=80=94patch=
`.
>=20
> What do you guys think?

I think this is likely to cause problems.  Many people use git log with
--pretty to format commit hashes or messages into other programs.  I'm
aware of multiple tools that will simply break if --graph or --patch
become the default.  Requiring people to retrofit their tools to use
--no-graph or --no-patch is likely to be a burden.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--+KJYzRxRHjYqLGl5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlp4+iEACgkQv1NdgR9S
9ou4HxAAytR49Xj41GS+88/tOSYW4y4pmk/lUsClmL4zOnqiwTEnlCBEKyCkaFwI
FSxcYNtRhh6Ti2VrFOXptT1LvA1YfUpJnHgU+4A/wnZbn9WCemp6z90ipml3Bt6R
OO5VnfdqOTUIJekazaqxKbJ2aDsEYP9/bJEzRtF/9OE8Ic0GkR4ps5GBp8VDpves
WmxINZ8RyRmpr44aA3c3Um7txg6wu8vHnW8ivic+sDfKS38cVBhx0WMY/oONOrcy
+m0kE7B3v0aljAnai/B8TylTyBxs3maRiXO5FlugxPtRLoMRgE6BFKNZRoKzDDaA
u66GaSmV4vPJgEnONfIVcz+KCUAJSqtPMIYRxTU4yiWrIDEa+Ku1IlNU8vmBtgOr
Js/wVQVFcv1JHDi8mSdAGEIy/PYbdO5v8Z27FXVLoFiI7KVN7ewMr+ExTpN2qpV4
ujHNzrEhP/jnY+Sm/shdA59php+DmrJi5MQyspbRM045wFURGJ19OXa/l6IRuBhL
htXWgXpRcVUgq54V3m6NcAB9ydDopQtPWHOoz28o+J2l+YAmrFdOpCjJTKCdBPAO
D/YtlnnYu0tA70h8DiD7PzEM5XscGyhVZMRhdrJ0B07btl2VpbCy/j1XVYLFGWPf
ZJTx0nUvDU/2hXNbQsGkuSJy1ZZhLR1gAmNqm6rvg0Lw8oaUtx4=
=eHqn
-----END PGP SIGNATURE-----

--+KJYzRxRHjYqLGl5--
