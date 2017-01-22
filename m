Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC2B41F89C
	for <e@80x24.org>; Sun, 22 Jan 2017 01:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbdAVBfj (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 20:35:39 -0500
Received: from sunbase.org ([178.79.142.16]:40660 "EHLO sunbase.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750889AbdAVBfi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2017 20:35:38 -0500
Received: from sunny by sunbase.org with local (Exim 4.84_2)
        (envelope-from <sunny@sunbase.org>)
        id 1cV6ZQ-0002Do-13; Sun, 22 Jan 2017 01:03:48 +0000
Date:   Sun, 22 Jan 2017 02:03:47 +0100
From:   =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/7] Documentation: move dblatex arguments into variable
Message-ID: <20170122010346.iywz4rqqzewfmhkn@sunbase.org>
Mail-Followup-To: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
References: <20170121215912.246691-1-sandals@crustytoothpaste.net>
 <20170121215912.246691-7-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kubu4mgcnzkoqrk6"
Content-Disposition: inline
In-Reply-To: <20170121215912.246691-7-sandals@crustytoothpaste.net>
OpenPGP: id=94A506E5; url=http://www.sunbase.org/pubkey.asc
X-Request-PGP: http://www.sunbase.org/pubkey.asc
User-Agent: NeoMutt/20170113-14-7f1397 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kubu4mgcnzkoqrk6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2017-01-21 21:59:11, brian m. carlson wrote:
> Our dblatex invocation uses several style components from the AsciiDoc
> distribution, but those components are not available when building with
> Asciidoctor.  Move the command line arguments into a variable so it can
> be overridden by the user or makefile configuration options.
> [...]
> -	$(DBLATEX) -o $@+ -p $(ASCIIDOC_DBLATEX_DIR)/asciidoc-dblatex.xsl -s $(=
ASCIIDOC_DBLATEX_DIR)/asciidoc-dblatex.sty $< && \
> +	$(DBLATEX) $-o $@+ (DBLATEX_COMMON) $< && \

It looks as the dollar sign is in the wrong place, should be in front of=20
(DBLATEX_COMMON).

Regards,
=C3=98yvind

+-| =C3=98yvind A. Holm <sunny@sunbase.org> - N 60.37604=C2=B0 E 5.33339=C2=
=B0 |-+
| OpenPGP: 0xFB0CBEE894A506E5 - http://www.sunbase.org/pubkey.asc |
| Fingerprint: A006 05D6 E676 B319 55E2  E77E FB0C BEE8 94A5 06E5 |
+------------| 61815930-e03e-11e6-b4f4-db5caa6d21d3 |-------------+

--kubu4mgcnzkoqrk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliEBPIACgkQ+wy+6JSlBuV4KACdGCS+HswFSRoV/N/hbz3O/yCD
c7gAn0qErmRzZVSqJXRA4cX/FlKILtQi
=K6m8
-----END PGP SIGNATURE-----

--kubu4mgcnzkoqrk6--
