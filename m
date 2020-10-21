Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CDDC4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CD402145D
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506854AbgJUWlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 18:41:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54330 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2506722AbgJUWlC (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Oct 2020 18:41:02 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8D7116044F;
        Wed, 21 Oct 2020 22:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1603320060;
        bh=n5Vdgrqb5fSMXgGf+fIuHMbb5ewRaTJo05JYSa8dTWk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0o6jjb263/B5DjHe+mk/98wtc3SqjrfM71nObyMupvv/tFEkPlOE0Lq0l2nZloBRj
         FHJd8tXNhtCsMjEKA+o5xLIvIa8DasCwVrjHFdWR4JLpLfraUhS2Xlz+1214Qyz+Ko
         ZDXewjvwZhuLTcijFjvcAuu+AV3DFDLHRETCyJxLTLQYnIKs73UNnEInUkzzueCcBw
         sfrHe2hzT27GPV/nOZMvgRRRJmGTXayAcQU95/FDVk9vKQWHbLlH+48Duy93gir6ud
         OTNwO7d52aE7cdnDrmtDN+WQvYeGxDyY31QwTE04Xl0Y2gfF4TsBKYzkjIu5GRSBmz
         14RWmFhvxUbVrfEHoXSbvMr2uFgd0Ka6/4wF+RPL6w8abW3tpJd8dNMjy96ecWbxnm
         cFxvsrm4IrbnRxorQDvmg97IFX9hcbxzNnopwfoMEWExG6cQ0cAN6AxL68JN7XfR7g
         0gISnEqdITJcJcEggpXufTj8Vy4nmOV4olObW4nZQMNni7g//Yj
Date:   Wed, 21 Oct 2020 22:40:55 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeremiah Rose <jrose0323@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Launchpad Stable Release Archive not updated
Message-ID: <20201021224055.GL490427@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeremiah Rose <jrose0323@gmail.com>, git@vger.kernel.org
References: <00ef01d6a7b4$87ad1ef0$97075cd0$@gmail.com>
 <00f601d6a7b4$a8c03910$fa40ab30$@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E6lVPAHcXg6biC3t"
Content-Disposition: inline
In-Reply-To: <00f601d6a7b4$a8c03910$fa40ab30$@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--E6lVPAHcXg6biC3t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-10-21 at 14:15:41, Jeremiah Rose wrote:
> Good morning,

Hey,

> Git 2.29 does not seem to be updated on the Launchpad ppa for stable rele=
ase
> for Ubuntu, but still shows under the RC archive. Is this intended?

The Git project doesn't maintain any binary releases of Git whatever;
those are all maintained by separate and independent parties.  If you
have a question about the PPA releases, you should contact the folks
responsible for the PPA.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--E6lVPAHcXg6biC3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX5C49gAKCRB8DEliiIei
gWSGAQDgLZwweR+QRdzNl8O1VQgoVBHr8ej6lgh78pThpJEt8QD/aHMdT22JIsMR
n4zLdx3ShsLl3eO1aIrCyPxTrhVkbwo=
=KI3y
-----END PGP SIGNATURE-----

--E6lVPAHcXg6biC3t--
