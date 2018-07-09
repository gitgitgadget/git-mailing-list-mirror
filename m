Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE9C91F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 23:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932881AbeGIXkA (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 19:40:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55038 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932828AbeGIXj7 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Jul 2018 19:39:59 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 007CA6047B;
        Mon,  9 Jul 2018 23:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531179597;
        bh=iCQUEwVHXyTvtG1hGQbZ3y9HogjUziOs2JQ8/skWH84=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=cG2aXXlLASbikKajIXcng6NWm3mWM0e5waq0GKI+AO2u5xhkRMbM12hNIE+5umwFp
         fZ+cXk+msaQxflTlWo1sHc+RCwbQFY+WBdHpFPYDMIejkeSr0jsUwrdhicS2pH2ext
         LKh9gPfbnN6M6wLg3FJslIMF1XZ8LdYOgpxCygQckKGdYVZDkdmq31rkNSrHw95o0d
         x9XFXXbDk2tlTA9eBoIgalt1AjVbm96wpOgrfaNMdd5v9wECYfI6cQuq1CBNiq4Vj2
         9c2DfJJXCKNioqIYWnuQ2aZu0LcZuEyizPUKQ8nnZqgerqs3eZ+OXdXQZpDJG0roWx
         AIABM8X9obum+1nrEI7d8qTiS5FClbi/G4qK0oawuCYGs1thmMWsr5FuNMR+z/2Exp
         GsHsHPpV/wCCUaXWpf61oOVO60YNh+LNw5YfXcDIQSViuTAiryP1K7xS0bm+Q6DVfn
         vp1rfqj984vaTe2x0rQndKJaET31IKSxUk7YEcjK1EhUiz/9Lxn
Date:   Mon, 9 Jul 2018 23:39:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 07/17] commit: increase commit message buffer size
Message-ID: <20180709233952.GB535220@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
 <20180708233638.520172-8-sandals@crustytoothpaste.net>
 <4eb44f33-ac9c-7ce2-0e53-ec6fcb4560fd@gmail.com>
 <xmqqva9oe20y.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
In-Reply-To: <xmqqva9oe20y.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2018 at 10:45:33AM -0700, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>=20
> > On 7/8/2018 7:36 PM, brian m. carlson wrote:
> >> diff --git a/refs/files-backend.c b/refs/files-backend.c
> >> index a9a066dcfb..252f835bae 100644
> >> --- a/refs/files-backend.c
> >> +++ b/refs/files-backend.c
> >> @@ -1587,7 +1587,7 @@ static int log_ref_write_fd(int fd, const struct=
 object_id *old_oid,
> >>   	char *logrec;
> >>     	msglen =3D msg ? strlen(msg) : 0;
> >> -	maxlen =3D strlen(committer) + msglen + 100;
> >> +	maxlen =3D strlen(committer) + msglen + 200;
> >>   	logrec =3D xmalloc(maxlen);
> >>   	len =3D xsnprintf(logrec, maxlen, "%s %s %s\n",
> >>   			oid_to_hex(old_oid),
> >
> > nit: 100 is not enough anymore, but wasn't a very descriptive
> > value. 200 may be enough now, but I'm not sure why.

200 is definitely enough.  Suppose we had a message consisting entirely
of SHA-1 hashes (5, at 20 bytes a piece).  If our new hash is 32 bytes
long, then it would require at most 160 bytes.

I only noticed this because the old code segfaulted.  My approach to
using a 32-byte hash was to set it up, do some basic tests, find out
what crashed, and fix it.  Most of this series is the basics necessary
to get the most rudimentary functionality out of a 32-byte Git,
excluding the index pieces, which are necessarily inelegant.

I didn't include them because there are other ways to implement the
changes which are more elegant in some ways and less elegant in other
ways, and I want to think more about it before I send them in.

> As Brandon alludes to downthread, we probably should use strbuf for
> things like this these days, so a preliminary clean-up to do so is
> probably a welcome change to sneak in and rebase this series on top
> of.

Sure, I agree that would be a better change, and I'm happy to reroll
with that.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltD8kcACgkQv1NdgR9S
9oteiBAApmwJpzjklmyztKF8g1HUygTaecHCZ5cO3tpaxjoK4RkkuYoLNFs0ht5m
kzYrFloRc7m0W2Ne679dMCRloERSliC9FFeknFc2jVy9COgQvWIlZXHCAvoI/jjs
cqLggf/h+3SAZjr20hKFPWKZxec1RNaj8uFdR89a0rwxid++zq3A/q5mxiFRBfZm
AOSCMxMo9zTdQbPQJWLk3ZYwwsb4fYo+p1v0EhZLNGUx1bRF1k8sN3UhPCTup1oZ
1OhaPTQm83MDU7aj3CqCsxyZ5oBUI/+0Loyo7ipADUstywUmwt/z1gzwaRt4zlMu
pwS+dEFwBxW0zUVxUYhzy9av5/wOZ4O3/NzN2x7RlUmsutdbAk07Jge1NDd1MojV
iiVZZqRkshUOqMEjbLDu6+sW9DQvdkGBICDlg4rHEYReSj6r6MJPMA1hVghfwcSS
Pc64WlOJeI4Z0KWzqX4jjaB355Uw2t65UJnj24cqvEmNxgfq8yWB2bPHKvp5T5Qp
7M7JYjwCli3FOkzarLOKxKky/NJjpQXHzdZrpRAJT1pXitkYIlWt/MTxnlgFR4Lh
YDyXilB/Xs85hr9Gl29cT0pAI7rEBdyDhr6lc1DGkCBWrG4dxENFsgCHBub8nNUu
r9ibr1xQ/h2S1DosxvUhHKSgf1CFdwtexn/En1uu1qRnQydn7+U=
=DArK
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
