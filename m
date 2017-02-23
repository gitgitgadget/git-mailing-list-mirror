Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DF6B2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 04:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbdBWEUW (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 23:20:22 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40312 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751190AbdBWEUU (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Feb 2017 23:20:20 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 92D35280AD;
        Thu, 23 Feb 2017 04:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487823565;
        bh=KtWhCPNPQrhqnWvdWO1Z9x7gQQiEwrtdc0kQ73E4ALQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DPIvkQgDOs3WNoRMOUaO6l+I5CzGIPXFqY+9HVpu8zsF3DAcWWpMNs43nTbTRWFs3
         +vq8D+dmObj2ZG4M0JDS1QAb++91K24bK542KiEbBeiHOyN/f1N0ddP3TezT39evM/
         uCXlA7PF/rNXJUEratBrCj2+ojcjPs3jpmMaF4TtjEJxnIhu0J+gzM9tekA1D1QfNt
         6JHLYxgvbZJqJ7Mj3GYxUBxsWfRxLLX5yJQXTdTmEYP7bZH/rXwWNXxIOPo7slhmdw
         hAqAWbOU4FC1MJTqNzbqTbmOZ1yag0f6aWWq7VXZuiNsapKHN0DRf9vAs0POYFjRrB
         XJYWU8UEA9MwcPwR0NIR5FfxFwrHckYisE+ujDZ9ZuXpE6WvW+UB09f3G/sF6ceMJa
         02j59h8dgFGjpjcL0qoDbb3z18lMxbecyw9VeNSsZPH/kIxriRQXCksYeYrCrxtZZ4
         XoIa1hv26w/UF3fp/BKh7pGCEpXlzcXzloOIxyI4S3FS2J2rNcc
Date:   Thu, 23 Feb 2017 04:19:19 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     David Turner <David.Turner@twosigma.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] http(s): automatically try NTLM authentication first
Message-ID: <20170223041919.xwdux5rxpojvms7k@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        David Turner <David.Turner@twosigma.com>,
        'Junio C Hamano' <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>
References: <20170222173936.25016-1-dturner@twosigma.com>
 <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com>
 <97ab9a812f7b46d7b10d4d06f73259d8@exmbdft7.ad.twosigma.com>
 <20170222233419.q3fxqmrscosumbjm@genre.crustytoothpaste.net>
 <b152fad7e79046c5aa6cac9e21066c1c@exmbdft7.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j5cotu5npsygwtwz"
Content-Disposition: inline
In-Reply-To: <b152fad7e79046c5aa6cac9e21066c1c@exmbdft7.ad.twosigma.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--j5cotu5npsygwtwz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2017 at 01:03:39AM +0000, David Turner wrote:
> So, I guess, this patch might be considered a security risk. But on the=
=20
> other hand, even *without* this patch, and without http.allowempty at=20
> all, I think a config which simply uses a https://  url without the magic=
 :@
> would try SPNEGO.  As I understand it, the http.allowempty config just=20
> makes the traditional :@ urls work.=20

No, it's a bit different.  libcurl won't try to authenticate to a server
unless it has a username (and possibly password).  With the curl command
line client, you use a dummy value or -u: to force it to do auth anyway
(because you want, say, GSSAPI).  http.emptyAuth just sets that option
to =E2=80=9C:=E2=80=9D so libcurl will auth:

		if (curl_empty_auth)
			curl_easy_setopt(result, CURLOPT_USERPWD, ":");

I just use a dummy username for my URLs, but you can write :@ or any
other permutation to get it to work without emptyAuth.  As a
consequence, you have to opt-in to that on a per-URL (or per-domain)
basis, which is a bit more secure.

> Actually, though, I am not sure this is as bad as it seems, because gssapi
> might protect us.  When I locally tried a fake server, git (libcurl) refu=
sed to=20
> send my Kerberos credentials because "Server not found in Kerberos=20
> database".  I don't have a machine set up with NTLM authentication=20
> (because, apparently, that would be insane), so I don't know how to=20
> confirm that gssapi would operate off of a whitelist for NTLM as well.=20

Yup.  That's pretty much what I thought would happen, since the Kerberos
server has no HTTP/malicious.evil.tld@YOURREALM.TLD service ticket.
Again, I don't know how NTLM does things, or if it's wrapped in a
suitable ticket format somehow.

Last I base64-decoded an NTLM SPNEGO response, it did not contain the
OID required by GSSAPI as a prefix; it instead contained an =E2=80=9CNTLMSS=
P=E2=80=9D
header, which isn't a valid OID.  I didn't delve much further, since I
was pretty sure I didn't want to know more.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--j5cotu5npsygwtwz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAliuYscACgkQv1NdgR9S
9otIkw/8CmxTy2WR+uAYoqpFOAn40QKgfEzXJmYRxtDePJrrqtyWyYwDK0o+I1/E
DiG5QY06jSVSvShkBNP2DmrR9tcTlXgxtJSXhMPKlLiHMNN9YNIqVHjgtdgsknjE
tp6tF6EH1L1kfPxkiVRDLh5VJFHth68FxqlFV2QDyCTPXoKqFzfSoX6rg80wDwik
qHoMsJSfiac8z+gI8I+8phH/pJsGQbIn9ho+IOSyv3w9BzdlEb4F4E/mNYDlMoSi
yIrciL+z5a4YfYt3PxAV1ygnjVMzpg35MQliTQdA9MBJyutIVLa0HU3AxEJa4EjC
FvpE/jzXuJxagHQ9Rq73cwqe7TbCEMztN8ga8ejInxouJx1NCr4y8nDjUwmYhzt1
Jai7ASxZvpLiHT6oRRaOvFe+LREyPaTOALsmwNC3LTq1I9y9aWeBniU3j5DECjJ1
uLogn+IgVFSvzRWHetAXi0zB3bnqOOHZNHt/xxTETUaGwWL20FdknSVd7jT+3lzm
XPQpaqYcdcU6H5oDyIvHyUcEkrB1TbZ0GpsgvtvxMdLacI4zqpWZl+iDDnRAvKTb
XOJUEfaitwZxVv0p4n9JpXfFu3UBQsen/UKMYOOf8lfirs5UABeB0TqGBPr0BAXb
DfGP9NiUywTQP/OA1nVajpC5eW8EOFhrWXmBsr4/d2g9y8FNPzE=
=m56O
-----END PGP SIGNATURE-----

--j5cotu5npsygwtwz--
