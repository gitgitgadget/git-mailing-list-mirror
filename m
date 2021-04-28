Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102D3C433ED
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 22:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D33B86143D
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 22:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbhD1WqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 18:46:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43858 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229488AbhD1WqO (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Apr 2021 18:46:14 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0725D6042C;
        Wed, 28 Apr 2021 22:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1619649898;
        bh=lMW40EQlE4+wnOL3DpsnXoIrt4TJBJilVb7ESB7EoT8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=s1M9nj/T4D5PX6LlGai7aKPQn34oH4K/JBffKoYIlpIXaz3p+lxFePRxqwGXwBlDb
         C6Rdnn/yLjprE81V0HvkRCKPFws6KPs3trQSmcEHgKqnClws7M/RslvrEKVV+ljrZj
         128dZQHH/bDNkGH0TnhmdiFrVOab2kQkmddxMHBVxjmzDRnYcRgXmEzDVpfrrkEPWc
         aeOoMYkWu9ATKY7ktcOEVRO6q3ZyJftb1xrHmUrIJb3e77AhOiWZ7o/OX+SL3GgcEp
         1OfaYSpH4D/6/HT7Ir1b4qJFqxJX5Nuh4fIGPaO9fCKOm/8KbeAdBKN4rRn/zgeHbL
         vjY/mk/6Dhf/YOIDhQGZebs7Ej/zB5FkLxgVi8snVOktUS8z/v9PHlz6rvC1xgnSP8
         kT1LXse6LVNxpSFk6zIEMCHfQTE4OndLj0WwBzLo3Jbf311RVc1qROl4ZDk8g6EIFe
         f2/4uA0sVk/V0gL92lUTqHI+UlJUiN6kuK9ZDj2n2UC6JBANJ7z
Date:   Wed, 28 Apr 2021 22:44:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Wong <e@80x24.org>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Raxel Gutierrez <raxelgutierrez09@gmail.com>,
        mricon@kernel.org, patchwork@lists.ozlabs.org,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: Pain points in Git's patch flow
Message-ID: <YInlZStiucEn4Km9@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        git@vger.kernel.org, Raxel Gutierrez <raxelgutierrez09@gmail.com>,
        mricon@kernel.org, patchwork@lists.ozlabs.org,
        Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <YHaIBvl6Mf7ztJB3@google.com>
 <YIYfsMsz0Uz48GaI@camp.crustytoothpaste.net>
 <20210428075927.GC13114@dcvr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z4QrVcBR+Ozv7Rzd"
Content-Disposition: inline
In-Reply-To: <20210428075927.GC13114@dcvr>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Z4QrVcBR+Ozv7Rzd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-28 at 07:59:27, Eric Wong wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
> > I have tooling to automatically generate the proper range for
> > range-diffs in cover letters, but that tooling requires some sort of
> > manual timestamp, which means I need to go search for my previous series
> > to find the date and generate the range diff, or if I'm in a rush, I
> > just have to omit it.  This can take some time, having to guess what I
> > named the cover letter the last time and search for it in a mailbox with
> > a 6-digit quantity of mails[0].
> >=20
> > In general, I have trouble keeping track of the patch mails I've sent.
> > I do definitely need to refer to them later, but I don't generally keep
> > them around on my system since they tend to duplicate my repository, so
> > I end up needing to find them in my mailbox, which as mentioned, is
> > slow and error prone.
>=20
> Along the lines of what Ted said about Fcc, I've always Bcc-ed
> myself on every message I send to verify deliverability and
> check/train my spam filter.
>=20
> What search tool do you use?  mairix can handle the 6-digit
> quantity of the git list fairly well.  The following finds all
> threads with "sandals" in From/To/Cc:
>=20
> 	mairix -t a:sandals d:YYYYMMDD-YYYYMMDD

I simply use mutt to read my mailbox and search.  Nothing fancy.  I
should point out that it's not local; it's on a Dovecot IMAP server
located on a VPS in New York City.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--Z4QrVcBR+Ozv7Rzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYInlZAAKCRB8DEliiIei
gVIMAQCeMHR0IEHGPzaCjB99akSDaTVQLAY6gc++6LUDJY6ZiwD9HBWC7oFolb8B
fzssQIiRwkoS+ZSbXqWhJxgb04traAM=
=Nyuy
-----END PGP SIGNATURE-----

--Z4QrVcBR+Ozv7Rzd--
