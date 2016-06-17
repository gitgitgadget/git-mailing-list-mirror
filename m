Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID,
	T_TVD_MIME_EPI shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DA5420179
	for <e@80x24.org>; Fri, 17 Jun 2016 12:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbcFQMcX (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 08:32:23 -0400
Received: from kitenet.net ([66.228.36.95]:42620 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932183AbcFQMcW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 08:32:22 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=aLNZwLWn;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466166729; bh=eYJlWH7rM0I3m5YiyxtaOfG3ziV0CkU2kmQ7dqJie/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aLNZwLWnkjggucOjuE58YdwqDtG1vOhzh/UdpFexaZ59LUCxYUse2rHeCQI0Tx3Mv
	 3DWJQNKlV4nqMsk4YRMA9OcoEhPXX5VvC8id4U/51iCUSzY4ZD3/LAdprOSLE8dBdZ
	 Wa0gOonSzxy5HfYi+n0WRY44rB5V1U5SXmptevJ4=
Date:	Fri, 17 Jun 2016 08:32:09 -0400
From:	Joey Hess <id@joeyh.name>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/4] clarify %f documentation
Message-ID: <20160617123209.GA24025@kitenet.net>
References: <20160616203259.5886-1-joeyh@joeyh.name>
 <20160616203259.5886-2-joeyh@joeyh.name>
 <xmqq8ty44y4t.fsf@gitster.mtv.corp.google.com>
 <20160617024803.GB17088@kitenet.net>
 <xmqqfusc33aa.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <xmqqfusc33aa.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> "tracked by Git" is not all that interesting, compared to the fact
> that your filter needs to give contents relevant to that path
> because that is what the command line argument Git gives you with
> '%f' means.  It is not a random filename "tracked by Git".  Among 47
> other files tracked by Git, the single one being given is the one
> the code that drives the filter is WORKING ON, and I think that
> needs to be written in the description, hence "the path that is
> being worked on" was my suggestion.

Ah, "being worked on" does clarify it well, I think:

+ Note that "%f" is the name of the path that is being worked on. Depending
+ on the version that is being filtered, the corresponding file on disk may
+ not exist, or may have different contents. So, smudge and clean commands
+ should not try to access the file on disk, but only act as filters on the
+ content provided to them on standard input.

--=20
see shy jo

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBV2Ptx8kQ2SIlEuPHAQLrHRAAja3Yw6R2CgMaWbOKeR7h9IYUN0y0lrfh
hjYb2W/eiVDGHyzQJx3dTd98ac8fOGzFVTJd3yoFk8RXFXc6OC4/Iezhts9dK//O
rKYcKULRAfvUrXUgf1ImGfEPOAzKzesCwVWdVzZogS1ZURLMh2qt1IDiiwwKQlfO
OUgdOZbfER+IfIi8gf1xH8m+P0xaZuI3G37KdAo09kIsOiqVRH0gHqi5YNpOi7Ml
uojEEMK+XkJG8XhZ07tHwCYIfyfJNvfeIzx10KZ8wltVfENc5XBlLyC6bv76a5l1
BHN0tGF/v6edEGf8ohrC3ochr3x+6aMAw/SBoreZe63yDEXPgSjNZ/BwT1oxrGDq
juzlCnx8LChLsYmOCOz+sPI6djyzlpWoUAXHEgdLut3SabENSnL4DbHu2QOIK2Lk
nsns0MJbN4r5ir0ukkd1k0d3RHcy5OyX4MF2iRAior8VoauaNlwLJd1GvNyTAOis
M0QtKfl/97gkziDmrpHRiWxEAwCWMhdRrrqhA6UMQ3hEunK6YvsaOY8s1d6gFnl9
ANltF0KWn1VgtoaZrtiN1OfgAXyoUHpQU7xspHrfN5y5cPQlwr88ysm5j6rEP8ED
8JTscekpoP8gZopBlS5i0y6bPxNhEwpNMvfwOvPi5mG/tWDv7J8v2bhtZvornIZ9
DfCj5V1PMrg=
=aDGZ
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
