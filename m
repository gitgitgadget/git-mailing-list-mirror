Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44D281FE90
	for <e@80x24.org>; Tue, 18 Apr 2017 10:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755050AbdDRKoT (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 06:44:19 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:35526 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754489AbdDRKoR (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 18 Apr 2017 06:44:17 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id BBA03280AD;
        Tue, 18 Apr 2017 10:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492512255;
        bh=pYQQFxDEeMdAvkwQEDKyCnlKPezbiBT9okhz4p6m/vA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PvKV3N1osaFD0S8jFgGxOWktZxnU2OEZ/EBwSakj2cmu2Ad2Uk3PB05SkZIb3dQx1
         2wmaYLpWIovDQAtuVsyTgjRYrmRYhFmt9DPjAi5a1WGSmf5IMP3cVDGB1rQ3j/qIew
         wnvfp98kK5kcKSJvVEi9onZmo95r3m+Senv2VVJNSElkaGxOKxOZDQdLxP0jAc6DF5
         P9p+uqlQB2yasP/o1bhosT/nzHU1/4+i1P1yDrzq8TfpbWq6BNV7NubSrXWNXWzbm8
         MQ1SKX6Pp4+sK6brmMPZ33sYDcSz3F6ATgD2TgTxx8qnFuB4cjpvCJIaQAA/RL7uPB
         H0CS7zDIRTnPmw16UuUhKSXy446hMFWEdAB9+m4scyrHREf1ow8NfNRyDOed27fyxs
         YVEuuRpZ2B5qN0Wsxau7l6MUYN5GwrGHDgF0fJx9zklgVKs5jgpPST+gDL34F48FPv
         WEMcvLPSp0UFaGyTE2MwEDXJyFNEwvj+Ky4f/9hqY98JYDrWTks
Date:   Tue, 18 Apr 2017 10:44:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v1 0/3] travis-ci: build docs with asciidoctor
Message-ID: <20170418104411.hdkzh3psvej63tqw@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20170411083309.58315-1-larsxschneider@gmail.com>
 <xmqq37dcorr7.fsf@gitster.mtv.corp.google.com>
 <63CA5B3A-8AEA-473B-9F4C-86C2BBB0530F@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fhnu3dbgi2uxhuuk"
Content-Disposition: inline
In-Reply-To: <63CA5B3A-8AEA-473B-9F4C-86C2BBB0530F@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fhnu3dbgi2uxhuuk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2017 at 10:32:59AM +0200, Lars Schneider wrote:
>=20
> > On 14. Apr 2017, at 00:41, Junio C Hamano <gitster@pobox.com> wrote:
> > Having said that, I wonder if we get some interesting results out of
> > building the documentation twice, though.  By looking at the Travis
> > log with timestamps, we probably can see how long each build takes,
> > but that is much less interesting than learning if new versions of
> > text used mark-up that does not format correctly on one or the other
> > (i.e. catch documentation breakage early in each CI run), for
> > example.  I have an impression that neither AsciiDoc nor AsciiDoctor
> > "fails" in an obvious way that "make" can notice (i.e. they often
> > just silently produce nonsense output when fed a malformed input
> > instead).
>=20
> True! But wouldn't we get a syntax check here? Wouldn't asciidoc / ascido=
ctor bark if we use wrong/unsupported elements?

Asciidoctor isn't very strict about questionable items.  If you want
that behavior, you'd want to check for output to standard error during
the make process, as Asciidoctor uses Ruby's warn function.

One of the things I've wanted to do is to make it able to be strict, but
that requires a lot of refactoring work that I just haven't gotten
around to.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--fhnu3dbgi2uxhuuk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlj17fsACgkQv1NdgR9S
9otqbg//YwLHgoRxs4uIdfhSXb3dyy+/G3IbPleQUT3MdABvthLC6+6NzS5huWHC
HyVfNtDAn9+CJY4OtHmRnwEozjs6HoPFQjYlZm+Ib85FHtTpd7QPLdSD7QP9nR1y
RMMnVdnBsjoPw0ib11MujDfiDCzN6++jJUAWzEu+irdsxn0zVoHm1+PNUXTPBohn
U7hnlGZtlFKuAO3mQnPITRbRaz/Yshlq0DlnHc9kKeasjLNMj5BDk6Fuh5IzMdBO
bXJLQCiYE4qHjr68511+igZb8zPeHUnkr7lDGeQwO0r86wGyZ7svlSm2IqC1amc1
JQ2MCDz2+IkUkJpoiyb51DwSbq3z7kzLoZVl8Sp7xSBEwEzfjrQXcs4d/J2xAB8E
iN2QXXPyuJw+6/uhoUct7fAdBmMTa9Qj16s9ip9oS3h5Vz71hCvtikkw8+FTHrdZ
+ndNBm1MMH/3xvPM/UCGbeEnwKrb553OsrwwUsJboVDg7gP6pl5d5DyWkrafa3Hf
48PPsdyzrqYeqcfeiEkGiDZnEXEoI4yLymjluuosls/Q2KhRsclOm4TSoHRpGYLQ
wlGd4ZaubZJ/gAJ1ATxJ/PM3Cd0yw6srURziSGO5z5ibh5E8IAtm2pHKqmQ08XLp
t0TZmNvM3Zmkp60ttAdB1gg1yT5ofO2EphUmvaZ7uLcJeU0qFg4=
=pOuU
-----END PGP SIGNATURE-----

--fhnu3dbgi2uxhuuk--
