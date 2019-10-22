Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 334F11F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 23:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389817AbfJVXsu (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 19:48:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50176 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389811AbfJVXst (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 22 Oct 2019 19:48:49 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8718260459;
        Tue, 22 Oct 2019 23:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1571788128;
        bh=YP6tgq7MQxIyn9hh3k0Dt0Z0Q9V8CasyvyuRQdtQyE8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=P2agWNX4+oO4/rY+Ft0VdRxIX03bwIzbNmIhk+4egba4jk8MUOAyuseKEReGqa/jF
         y84lDgcxQpaPOoRbBhhpF7rs2Yiyw0BgAVCXRdu5tvhgUJ8BWacmE4Iw+1A+WuQklK
         +bhowRplkl0KtbIMKVg8AKclagUmduAhEroz8XeKuM4yKhNZf7wA1pA6UvUDS+7UU9
         VTT6PfG5pkeB6uOK1h5D4VPy0htQqKoBo7rIkUZqZDi9bTFbAa3LuTSAQWz4wHdvTt
         ZnnWGO59fXsfZ5sb+CFjdl84uDPLjBKQ63sDwK0Dzy3RLo9nBgoPW22mx2QOUKWfk+
         iEqIqCeMSrRuhZPqYJT7b9/jsCHOLsrMetKxTYdMR2wW4UhzCS9meZ7zOMnY4W99/1
         8v2AOf7Pb8vg97CvRec5ITeMXiLtYwe4nDzLhH3UVsoCVAlpEGGHkPW6nuuNiLAdVG
         LLSKlgiWCXyQKr7/+Cy7NhOWPyBqsNP/RHXEsj5xPGhA89pvE87
Date:   Tue, 22 Oct 2019 23:48:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pretty: Add "%aU"|"%au" option to output author's
 username
Message-ID: <20191022234822.f4ixqcpfytimiscn@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Prarit Bhargava <prarit@redhat.com>, git@vger.kernel.org
References: <20191022232847.5212-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h6gvtdt5i73fccvv"
Content-Disposition: inline
In-Reply-To: <20191022232847.5212-1-prarit@redhat.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.2.0-3-amd64)
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--h6gvtdt5i73fccvv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-22 at 23:28:47, Prarit Bhargava wrote:
> In many projects the number of contributors is low enough that users know
> each other and the full email address doesn't need to be displayed.
> Displaying only the author's username saves a lot of columns on the scree=
n.
> For example displaying "prarit" instead of "prarit@redhat.com" saves 11
> columns.
>=20
> Add a "%aU"|"%au" option that outputs the author's email username.

I have no position on whether or not this is a useful change.  I don't
think I'll end up using it, but I can imagine cases where it is useful,
such as certain corporate environments.  It would be interesting to see
what others think.

> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-form=
ats.txt
> index b87e2e83e6d0..479a15a8ab12 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -163,6 +163,9 @@ The placeholders are:
>  '%ae':: author email
>  '%aE':: author email (respecting .mailmap, see linkgit:git-shortlog[1]
>  	or linkgit:git-blame[1])
> +'%au':: author username
> +'%aU':: author username (respecting .mailmap, see linkgit:git-shortlog[1]
> +	or linkgit:git-blame[1])

I think we need to actually document what "username" means here.  I
expect you'll have people think that this magically means their
$HOSTING_PLATFORM username, which it is not.

> diff --git a/pretty.c b/pretty.c
> index b32f0369531c..2a5b93022050 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -706,6 +706,11 @@ static size_t format_person_part(struct strbuf *sb, =
char part,
>  		strbuf_add(sb, mail, maillen);
>  		return placeholder_len;
>  	}
> +	if (part =3D=3D 'u' || part =3D=3D 'U') {	/* username */
> +		maillen =3D strstr(s.mail_begin, "@") - s.mail_begin;
> +		strbuf_add(sb, mail, maillen);
> +		return placeholder_len;
> +	}

This branch doesn't appear to do anything different for the mailmap and
non-mailmap cases.  Perhaps adding an additional test that demonstrates
the difference would be a good idea.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--h6gvtdt5i73fccvv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAEBCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl2vlVsACgkQv1NdgR9S
9ou94xAAyiwmlPczFtsCrfo47jhtfS05y7ULBuIpHv3jUCAibobpTuWBU/XED+Ln
jn/s57VXDuL2cLmtMS2wUzHTZ05tmLQ8A0bW7Eh1lnlJdYi8nQOe40DQMwhGx4Zc
RTJU3twKT21yq/FWHbSICinXpe6lfO6RR1kM7GRwS9IvGCx9/rLeXI44d92ml3tw
qfE4GoUPb4njv7UpT3LsZAQBdayJCAlNnOjUjR8r7X1tavEm+ewbJww7A6DlD1Q0
c+qNhx8mcuWFbXTyuW7XfTvam/q1EfTgFaVW3Z2PZFrGGRTPJcZvk5YlR3HuinN9
HEqs194jWtnUatDXXHD7+aPSrWHaOqotw2Bcf3/o6ChU0NB2EN3Cdc+oUGWg85mc
0uKFrOmAERQec2lYbajyWSEYshX2aTW/GqHY8Put3UiMyUayY+a5OyMq8UiTN071
79ukHycnbeOFk+ts1rS9FV1nrXT5FOeuEQI7/lsOg2e03Ua14KWlwmRH1yESn+h/
njSsxSQWatAgkoZTvmUhD0TOXd1cJxFa84Q8oQmuXJ3+N0y33jTAewfN50ARshLg
BjlAgK35noFrdJobV4LS3QfJOKfFHCJ2/O56zgU9KvsDje+owFg0TQ9z2WYfIYgi
JLyX8Iwx5fxxNgVFX83NEqudaE+4d57A+bH2/1PbhdoMBCfXLHE=
=zygw
-----END PGP SIGNATURE-----

--h6gvtdt5i73fccvv--
