Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70F2C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 20:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9445661574
	for <git@archiver.kernel.org>; Fri, 14 May 2021 20:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhENUBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 16:01:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47232 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229659AbhENUBt (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 May 2021 16:01:49 -0400
Received: from camp.crustytoothpaste.net (unknown [138.237.15.37])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 42D9060456;
        Fri, 14 May 2021 20:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1621022437;
        bh=aavho9+L0PPSNkOUgIgWrAcxFLcNxYfA/fBKyNWnn+o=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=CR5un82V3dts3DT0+zqu+8g/5VUiyeHIie4ceX4tNQMEFhbAHLFVkxwsa5e0m6FxR
         zobHeSYjXrwKzFkZnBCIW0vhCYP444X29pbmUTsztzoqG0Yrny+kLI4krWdVl90FKl
         uiqLQPJtIwZJHSfbZnvCgX7XdXYZJ9XBWroqNjLxCub04cT/yhudNhiZkDtsrQBY9c
         Xo62slG8HNXZN1ZdFDSBxI/OT/n+Z+gfwLYwrOw7T9D+FyhNYf+e6lDM7zrWkPSCxc
         Zu8bJadxT9/l5kxFeFPeAtispfruzTH6PoUvFxWIq7+qZUTJkpgJEXCc7rGMDDPT5L
         BcK9JzvVal7lFM+CVZCnz+9TZL7oJ+2gbxkPPN+NFiV5DVsAupzUMIxgMxmYSZkJ1/
         UJmyosgL2cXhYPLT31EFS63eHsMcjXjhXw1HTrQi+Fukp/WMBQg5I0nmeabTKx3/Zj
         F6yda4J+bVodX0MWoBwdMFCesSnBiN1io57SdK6sVehstCskLih
Date:   Fri, 14 May 2021 20:00:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/2] Asciidoctor native manpage builds
Message-ID: <YJ7W4YrboXQhMh/B@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210514003104.94644-1-sandals@crustytoothpaste.net>
 <609eca5a42be2_43127208f2@natae.notmuch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7eTWbW7goPqcQLHx"
Content-Disposition: inline
In-Reply-To: <609eca5a42be2_43127208f2@natae.notmuch>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7eTWbW7goPqcQLHx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-14 at 19:07:06, Felipe Contreras wrote:
> brian m. carlson wrote:
> >     @@ Documentation/asciidoctor-extensions.rb: module Git
> >               elsif parent.document.basebackend? 'html'
> >                 %(<a href=3D"#{prefix}#{target}.html">#{target}(#{attrs=
[1]})</a>)
> >      +        elsif parent.document.basebackend? 'manpage'
> >     -+          %(\\fB#{target}\\fP\\fR(#{attrs[1]})\\fP)
> >     ++          %(\e\\fB#{target}\e\\fP\e\\fR(#{attrs[1]})\e\\fP)
> >               elsif parent.document.basebackend? 'docbook'
> >                 "<citerefentry>\n" \
> >                   "<refentrytitle>#{target}</refentrytitle>" \
>=20
> Huh? Didn't you say \e was not needed?

Yes, but I believe in that case my build was broken and I was incorrect.

> You are doing basically the same thing thing my patches now, except in a
> more convoluted way.

The way your patches do it, if someone adds a line like this:

  _abc linkgit:git-update-index[1] def_

the latter part (def) is not italicized.  In my version, it is, which is
the correct behavior.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--7eTWbW7goPqcQLHx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJ7W4QAKCRB8DEliiIei
gddHAP9tUJcpEUS1j0QznzsuL8cLbZOOlMfp0NiGl91XBVVElgD8CTL+hi1UD0/Y
q/m6EpV0xS8RMi0f2lGIJvuxG1sRKQg=
=RtaI
-----END PGP SIGNATURE-----

--7eTWbW7goPqcQLHx--
