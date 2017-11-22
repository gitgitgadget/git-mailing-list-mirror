Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 489142036D
	for <e@80x24.org>; Wed, 22 Nov 2017 00:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbdKVAyn (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 19:54:43 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56140 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751408AbdKVAym (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2017 19:54:42 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7CBB86046D;
        Wed, 22 Nov 2017 00:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1511312079;
        bh=0QUQZ2DSoG8YngQgy19BEanp9nre0aw4p+gD9vA3QJo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Tc+TSAu8FHYDjDnx4NWjMIKsotmBNSXPznMi/gxJ9otxiCWDTwX1m3HkukKwCxIs2
         a9vodImACqYim/n/yf9LO/N+uoTm0EA0ONvFVfKfFDQM+uVPCNti+SrUaIHOHQNT4/
         Nt9Kwubxv8DQ8Jo1dWsbNX1v5Lmr5bFairDSzhq6U99kRLbLRFTmuX9EME89osnxnG
         3JV1g1I2SgCLGGqsBmsT4VUKPSWLJaJYbp5udxPVMx3JrH5ecYLmoOExnCJSm1RHPD
         7FaH87SzipThQmC1UzC0tutS2obJ3XnBwpuckojC99B6W5uAJISxef9Ss3JV4I3wEp
         qNWfSEx956Pj+w8mDe9iAcGyt6ei9BkkeD7RPgYSRdwJifXPezSRTIrX7e5zyEr8gX
         +cvyDDNeHxC4TbYkbwGSB/MyRS32kHOK2AEwultrDvSrwI6OI52ksJsQ1zLBIkFr5W
         2SuTghgg6JNGsAc6C+0D4l01uJxaLu7u9gALCLfBaQnG8fNTYaZ
Date:   Wed, 22 Nov 2017 00:54:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Anders Kaseorg <andersk@mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Documentation: allow overriding timestamps of
 generated asciidoc
Message-ID: <20171122005433.kwv4bin6y65xuxm5@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Anders Kaseorg <andersk@mit.edu>,
        Junio C Hamano <gitster@pobox.com>
References: <20171121232935.GM3429@aiede.mtv.corp.google.com>
 <20171121233432.GN3429@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2kw3aa46jsznkwsz"
Content-Disposition: inline
In-Reply-To: <20171121233432.GN3429@aiede.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.12.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2kw3aa46jsznkwsz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2017 at 03:34:32PM -0800, Jonathan Nieder wrote:
> From: Anders Kaseorg <andersk@mit.edu>
> Date: Wed, 30 Nov 2016 22:21:15 -0500
>=20
> Allow overriding the timestamp in generated documentation by setting
> SOURCE_DATE_EPOCH to the number of seconds since 1970-01-01 00:00:00
> UTC to use.
>=20
> This makes the generated documentation reproducible from the source
> code as long as that variable is set, without losing the last-modified
> dates in the default build.

Thanks for this.  I had planned on either submitting this patch myself,
or working on a similar one, but I ran into the issue I'll mention
below and hadn't finished looking at it.

My research on this determined that Asciidoctor 1.5.5 and newer handle
this properly, because they honor SOURCE_BUILD_EPOCH.  It's only with
AsciiDoc that this is an issue.

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 2ab65561af..dfec29f36f 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -410,6 +410,7 @@ $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
>  howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
>  	$(QUIET_GEN)$(RM) $@+ $@ && \
>  	'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(wildcard howto/*.txt)) >$@=
+ && \
> +	$(if $(SOURCE_DATE_EPOCH),touch -d '@$(SOURCE_DATE_EPOCH)' $@+ &&) \

touch -d @SECONDS isn't POSIX compliant, and non-Linux systems don't
provide it.  POSIX only allows certain fixed format, and I assume that
non-Linux parties (maybe OpenBSD) will want to have reproducible builds
as well.

It's unfortunate for shell users that this variable is in seconds from
the epoch, since there's no portable way to format such a time in shell.
(POSIX doesn't allow date(1) to format anything but the current time.)

My proposed solution was to use Perl to do so, and simply require that
if you wanted a reproducible build, then you had to have Perl.  That
would, of course, require a separate variable in the Makefile holding
the formatted date.

Maybe something like the following in the Makefile:

ifndef NO_PERL
SOURCE_DATE_TIMESTAMP=3D$(shell perl -MPOSIX -e 'print strftime("%FT%TZ", g=
mtime($ENV{SOURCE_DATE_EPOCH}));')
endif

and then:

+	$(if $(SOURCE_DATE_TIMESTAMP),touch -d '$(SOURCE_DATE_TIMESTAMP)' $@+ &&)=
 \
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--2kw3aa46jsznkwsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.2 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAloUyskACgkQv1NdgR9S
9ovB/Q/+Neo23p9bMumLpuMCuoILs0yLFkw08DQAMCGaC5KMO7XyGkySidGhotr4
p9Mui18mSs6KO8ynxiOtiBT5XhAJdkNmSclLBVtoedm93oouyUHm0SYWtHT71LG9
QQegXRi7a87jfJsZoBB4zIrDrtXTTyhtEVtPMIUNetgwE/RZHYmv+Lod8TAgHN+6
rnpYSObw7RJp4sCcJNlrwY4NaNVM+9VNuCOIQmh3TryW55VgR+GVNGyiEMTtwPOS
tDTNmhs6/gZQzcyTypNcH54HjiYajABHY5BDehrod+pQLOimUvvvhJ/cxtfRruoh
7dvPrFBf8j84PYTWKJgjgR8S5E8pZUbeb/IZ5tkOaiyQHh/4F7p9Xk3nPe50rQMU
VRmfEZ3J7fNs8pWTsw/NWc5rmV2rl31HMYc/vN6dJYe3FxyAD9H7OBgz4jSvS/Y/
DsFrIFPjQBMkBJAvBmHrp9RPQzrM56pYC0iSsrR+Q697h8BG3NV9EUdlbA4cnJ4G
sNwXjBWkoRO8gVKt9H0e5SerZHtNnBPw9MB1GQjorJAXInPbG4lqRugSd03QZJ2J
0gl2EuHEAQOJU0gg6CTmLeau8KwR1elQ18gd8G0R0k1iiWY/z9sJT7+ThjPRs0BN
tTl4Gok/jTnZ66+26MVjueCN5VPHDsSAIde3VKuW8no0HA1TPq4=
=zdkL
-----END PGP SIGNATURE-----

--2kw3aa46jsznkwsz--
