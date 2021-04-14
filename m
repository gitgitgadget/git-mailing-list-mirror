Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D619FC433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 11:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADC3E613C0
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 11:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbhDNLto (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 07:49:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33004 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233595AbhDNLtm (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Apr 2021 07:49:42 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 81D266042C;
        Wed, 14 Apr 2021 11:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618400958;
        bh=SKJu2G3pMbBK86qJ8ZdgaVxw4eXu24Kv4/HkB+IWO9k=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=yqUD5sFvhLfevplrvWPdAgjt2uTA6e+Z7wywZGzxmcNxe4TYdKRYHgTZ2wjjMQC1E
         h5s37b3hkpxwc37erGFsRONQKadEhn6dYp9BdviKoJfXK+lkHEvahDN8f2q2sQ9L8F
         mx3IoFL/TLM+nMmAoaIo7x478K7ySd9nDk9EY1WfSQnhhvwZpXqoTZtjQJ5VI9kAy0
         9xfnSN8lNtnXenx9AprKMGtoaage6CpV1lHwMABs9u1i+oT/1ViwlG4rjWgE0voGMt
         pEero2cMZ41w5QRNhO1Y4wLUBeDZHAScWsePeVBufp3eSORkCW3TpSsF1TcUZoS1iT
         GwTrS1Msh87C66unXWkX2OHi1K1CcEjPaUJEoebjeUNNT5yKkORllUhKSTkX1e/7OY
         /uRD2d2G4PTttDU8tH2JnL+CaanEozROPecT6v0aOg7fDT38CLyg2Ttq1FQSFLuUN4
         XeZfLWGboTMy8gzXfHlqDzl1lhwdhxLZzoS5r6xOcljdE500LBM
Date:   Wed, 14 Apr 2021 11:49:10 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Vitaly VS <strikervitaly@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git via MITM transparent proxy with HTTPS Interception
Message-ID: <YHbWtlJDSyuAO+vf@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Vitaly VS <strikervitaly@gmail.com>, git@vger.kernel.org
References: <CAEaE=iyUGiPK-HX850mEgC=X6atEhbjJ0dCK0dci0nOCahPhgQ@mail.gmail.com>
 <YHYxtvKgKz+Uv2xO@camp.crustytoothpaste.net>
 <CAEaE=izSNyxRcvMd5bArHnmi0F2G83nouge9e_qxiQmA0AsWog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t8x62wLvzUoQqfX6"
Content-Disposition: inline
In-Reply-To: <CAEaE=izSNyxRcvMd5bArHnmi0F2G83nouge9e_qxiQmA0AsWog@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--t8x62wLvzUoQqfX6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-14 at 09:35:48, Vitaly VS wrote:
> Thank you for the fast response.
>=20
> About our network environment
> We are Cisco WSA(Servers SW, ASA, ISR) that proxies http/https
> traffic. Client requests a website, network device redirects traffic
> to WSA using WCCPv2, then WSA proxies the request to Cisco ASA
> Firewall and internet.
>=20
> Yes, that our transparent proxy is not completely transparent because
> HTTPS Interception.
> If network guys turning off HTTPS Interception for github.com "git
> clone" work well through the transparent proxy...

Yes, that's because you're tampering with the data.  The output you're
getting clearly indicates something is modifying the data.  TLS normally
protects the data from accidental as well as intentional errors, so
there's no situation in which this could be an accident but for your
proxy.

Git will work in this case if and only if your proxy does the things I
told you, which your proxy doesn't.  It isn't a transparent proxy, since
that by definition requires that requests and responses are not
modified.

I do appreciate you mentioning the proxy you're using so we can include
it as a known broken proxy in future versions of the Git FAQ.

> Disabled https interception for github is a security issue for
> us(corporate risks, code leak, etc). That's why I asked about can the
> git client working with https interception.

Many major companies manage to avoid these risks without introducing
security holes into their network and breaking common applications that
speak standard protocols by avoiding using TLS-intercepting proxies.  In
fact, I've worked at a company which was very diligent about these
matters and had strict policies on them, and in no situation did we
intercept TLS traffic.

> Proxy didn't alter any of the contents of the stream(that says to me
> our SecOps), but I've not received decrypted traffic yet to be sure.
> HTTPS traffic caching but we are also disabled this feature for github.
>
> Common downloads with curl or browser from the same sources from
> github or gitlab working well.

Git sends data that is compressed but not using a normal compressed
archive format.  Thus, if you do anything that inspects the data to see
if it is "malicious" or "inappropriate," your technology will likely
flag data that just happens to have a byte sequence that collides with
something that you think is bad.  For example, if you flag the text
"sex" because you think it is inappropriate, then the probably is about
1 in 2^24 that sequence will appear in the stream and you will break the
protocol, since compressed data often appears random.

This is, I suspect, why Git tends to break in situations where other
programs do not.

If you want Git to work reliably, you can never modify the data of the
stream, no matter what.  You also can't buffer the stream (for
example, try to turn chunked encoding to non-chunked).  This is
something you're going to have to accept; bargaining isn't going to work
here, no matter how much you want it to.

I can't force you to listen to me here, but I strongly recommend that if
you don't, you clearly communicate to your users using Git what you're
doing and that you know this will break Git so other parties don't have
to.  I'm sure that the support teams for GitHub and GitLab will tell you
that it's your proxy and that you have to remove or disable it just as I
am here.

> Brian, really thank you for pdf but we haven't Client-end TLS
> interception on our clients.

Here are some articles covering hardware middleboxes as well:

https://blog.cloudflare.com/monsters-in-the-middleboxes/
https://jhalderm.com/pub/papers/interception-ndss17.pdf

I should point out that this problem is so pervasive that TLS 1.3
includes intentional countermeasures against some of the worst practices
of TLS middleboxes.  I'm certain that most of the TLS working group
would prevent TLS middleboxes from working at all if they could find a
way to do so, and many of those people are at the vanguard of Internet
security.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--t8x62wLvzUoQqfX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYHbWtQAKCRB8DEliiIei
gdbSAQCzWx/x1vPl/32AFMHNPjF2O2kopGjFOWhEmK+eDSvHfQD8Dj7je3+sLas1
K7QPhzw8VYrhErgNBq23t7TNlb4vngc=
=xAcg
-----END PGP SIGNATURE-----

--t8x62wLvzUoQqfX6--
