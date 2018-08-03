Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 733A61F597
	for <e@80x24.org>; Fri,  3 Aug 2018 18:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbeHCUmo (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 16:42:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42494 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727843AbeHCUmo (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Aug 2018 16:42:44 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b423:857:b27f:2f08])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 182976046D;
        Fri,  3 Aug 2018 18:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1533321913;
        bh=Fwh28I3ekb5z92ylR/RE6Ohp7qwsGoYxwyHw3TXXknQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=kUHj46fzNbxEoBmBNfh0uyzQC3Y/y8bDk9tu2bzjlrjCr0Go/C7u+SF2279Kx2CpJ
         PTc/yOOVhyWzHOP7ce4JLwDJelZrPqSspekL80NHPb71b5GmISQh5dTEXSYpH+sJMH
         S+YHAg3r+KSc7ID+B3xqPJIs/VVzNRP/EI0dWzB+kko55Nbj+/WfD9sVHT8WygeHwG
         5Mnl4tH7WjReRwzNkmyCratn06fdGi/7qe44i5pBvPLIqyNZrfZZFHJCvp0L+L1EvC
         YPONzZga931EBI1r1iJG/pWql0UgnnIMSZ0YTQLnNC6amcRRozoptCZ28NprQv4DSJ
         9mowFffAF2jEAqLNUzmpeL74Pdnhe7ge/8ihB+Jq8kFGbm8s0lOzgNkZOh8TQ3BpUS
         0A0QZ2M/9sxDAi3QKdwQx1ujO0jyNeLb5plcbLKH6YzxWxoqiL/PqnP0F6sBGZPZOy
         tTmOXpK6PK4SeIiOLkISGi7vnMJzk8Qax2V87g3jLu2mrl7iD9i
Date:   Fri, 3 Aug 2018 18:45:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2018, #01; Thu, 2)
Message-ID: <20180803184508.GE106068@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq4lgcz81f.fsf@gitster-ct.c.googlers.com>
 <20180803180912.GD106068@genre.crustytoothpaste.net>
 <xmqqwot7wayf.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Content-Disposition: inline
In-Reply-To: <xmqqwot7wayf.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 03, 2018 at 11:40:08AM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > On Thu, Aug 02, 2018 at 04:02:36PM -0700, Junio C Hamano wrote:
> >> --------------------------------------------------
> >> [New Topics]
> >
> > I had expected to see
> > <20180729192803.1047050-1-sandals@crustytoothpaste.net> (the refspec @
> > handling) in this list, but I don't.  Were you expecting changes or
> > additional feedback before picking it up?
>=20
> Neither.  I just am not all that interested in seeing @ used for
> HEAD in the first place, as I find it quite confusing.

Okay.  Is that just in this case, or in general?  If nobody but me wants
this feature, I'm fine dropping it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltkorMACgkQv1NdgR9S
9ossMA/+P+qfuiVfc5UFIZ0AXrq4fMnycTMR81PdRh/Fl2HSTvp2ZE+d6BOE+/q6
W68m4+O14DcL8kbqjNNAVFGGq728dvQOfOKiSb9k4pKsLX2jrmtk1eUKytJs3jKA
RHN8i+i6p/Qg1UCMbzJE1vVSzystm2KSYdgpGmYeJUs7s6WGzNG++SAfgHFU8Wta
KueETu1rFMu2gguD0nQW6D+xmEud7whDfDlMrW1l8yhBaW9Vqc72F3iYmyuV4MFQ
rlLHJVDxggEWV05gj9xesF87ys3ekuwKe3O4eC13+cQXeTRzk5Hy64wCQzCwLqzp
Qhwzw+Lhh9WpF00SVRJfiUrkDxnrVdfzrUJzGGh6dZZV9QOF05yksyqnUS5beUQB
iD5gA/A92mlHuiwFFE8FlJGC0Gzxdgffi7TQ+JZbRiwbzB7LKIx82C0nWlGtsxws
s0I1bWFB5aHNn0u4gDBn4LX+FuhnUMk8I+pxlsA4xUcdV6FHsSrmz6/ukHGVOFoI
pX1lr1fqu556Jtr9uv1WptbcGzhwCpoJqhjJeDLkg1tMkU/PViDE3onL4ar7Kpgt
LRRIu9NV05XS47OLZDfSCBz3urmFOJ6uF9VJ56RGDY/2cLmS2se4pj+fIQxFgICa
8c8DaXswZg0h2ds2st1jIAlC092SOtPDj6t3E2z4LgnFZLM8PvY=
=P45e
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--
