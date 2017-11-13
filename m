Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DCE81F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 22:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbdKMWRO (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 17:17:14 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37511 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbdKMWRN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 17:17:13 -0500
Received: by mail-wm0-f48.google.com with SMTP id v186so9248298wma.2
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 14:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=omYXc9w0d2qNhC62T07u0H6K/51wy8eKr3q059Rpe2U=;
        b=Mhs7nEzqKf9pTKM3t/cz3OjPTIxPKHMf8K9Q+yZjkvyZpq6u0vWAaXehpPVppEnum5
         2HaB/2zPTPD94ucOlqDChC3W2Pqezz2HmNtF2Ey16pceYNVTKSQM6QNaQMGK6V7Htr7g
         SzCzg11s/nCCTUz4y74qLpsMFiVfzIIVDqAXZqFMzu2qwNWjriqiqY5wN6/OL4y2ty5o
         bMInX1gFzDRAfTRlupUwp6ukcoA3EkEQOl6qqNTNNJotd9uNnwF4DixQYmwW5Cm/ixhI
         aqA0OGH2mdNbv/OAb6Gey0dxE+0MsWlMCYV022svSkpaseHgcXEfLanqjFbBfTuGnAS/
         GERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=omYXc9w0d2qNhC62T07u0H6K/51wy8eKr3q059Rpe2U=;
        b=gX3YshlbXNXNvpEnngBnIGmDvRqvXfMg2CMOzWks93kKcXns6i9+FmrSKStoop5pQd
         Ry/u+fj8uNcUjjYbxw9w/KEH5oQCPHiMPe4NGxrkFUoCp1okR14TLatDHcMUtIUBfvZv
         WV2C/gDhhwdpcS216Lk7b/ZxOnEI+Mc2fY8h6lkXgum4SGsJSFHrEgtLuqUe/TZfGuuC
         fLZsNmgaMYW/PqFHRDh5nzEbPJjUlwEurXSeLgTeKXjvX3yGe7+DF/IvT3CYNIM0jnb+
         DqMejIZNpMJW7R0wA8gRjlDDS+GSpLgXX1zJQDZ9NQzhcwbJAX+u8ok3HvNxr9JBj8eS
         3YCA==
X-Gm-Message-State: AJaThX5w8KynZZRoDQN9mCHPUuSiFXCVwQM/zJPTw/yk2quo2gPa4trc
        yqUv6yPocLkNxHFai6GfNiIHCw==
X-Google-Smtp-Source: AGs4zMbEXtRdUb7QNqs2wZ6r1s49OPF4AeZPv07ErPQeMRO18vgM9mpF1dR+SXoS8kHneIRV+520IA==
X-Received: by 10.80.159.168 with SMTP id c37mr14556646edf.46.1510611432301;
        Mon, 13 Nov 2017 14:17:12 -0800 (PST)
Received: from LykOS.localdomain (cpe-67-245-44-149.nyc.res.rr.com. [67.245.44.149])
        by smtp.gmail.com with ESMTPSA id f27sm13403478edj.82.2017.11.13.14.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Nov 2017 14:17:11 -0800 (PST)
Date:   Mon, 13 Nov 2017 17:18:24 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/lib-gpg: fix gpgconf stderr redirect to /dev/null
Message-ID: <20171113221823.jzt7jfhxeuyivbcn@LykOS.localdomain>
References: <20171113210745.24638-1-tmz@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ebrdc6moxv6utuhk"
Content-Disposition: inline
In-Reply-To: <20171113210745.24638-1-tmz@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ebrdc6moxv6utuhk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=20
> Of course, beyond getting stderr to /dev/null, there is the fact that on
> versions of gnupg < 2.1, gpgconf --kill is not available.  I noticed this=
 with
> gnupg-2.0.14 on CentOS 6.  It also occurs on CentOS 7, which provides
> gnupg-2.0.22.
>=20
> I don't know if there's much value in trying to better handle older gnupg=
-2.0
> systems.=20

Hi Todd.

Thanks for catching the redirection issue! I agree that the other fixes feel
like overkill. Are you certain that switching to gpgconf --reload will have=
 the
same effect as --kill? (I know that this is the case for scdaemon only).

Thanks again!
-Santiago.

--ebrdc6moxv6utuhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAloKGi8ACgkQRo8SLOgW
IpUoIw//Qxdk6uWHG6k3UI3w4jo7PaSLo9COIDMQcfAHACSosXIR5Dcb3uH4eztD
Agg/SFq033E3XbPsYEwAXA4KQdEbHv2oCA0IP4DFItLHGOatdKuHZOR/eboMmih5
g/Kf6AQwF+YAGkTfkISPNt8dwZirl8pyZmBkrmT5S0owlJoF+jZsBdqGT1R+6ZKK
cDU3Q9MHy/b2m4TpgrymH7P4lrnKUjz8mZFgcJJbt3Upn4lJOCINoIG8aZ7kMTky
heHy91B5Z9/TbFrSHZdEPBdsI8wFsyTFF93+s4AlT3jAWFt2m75r4pJ13tWsO+I0
wP7KC0exX1BilJ7/iOYHeq8BdJVCq8aI+TW5NqaHcqTWKcw5KdtBus0Stxx9h3pQ
81FzaRuB0T4fi/gG/Zvf+7gZy6zwCKF+ampHgxLLBDVRXYwXiRvFSEtcvxH8Nh66
WEEib5WRA2kNu+T38GkuvK8HCpxZkx1fHntZQOZlDAmTPEMbMnUI7otS/wjqY2OM
aUUnDjFwb/Pqpyk6S5Eyw0NSREdWSf8XW/KlJQ0fCCSZZBiaqQ9kTsw5OE3GKjpB
po+FGnZt/x7GmwZVGmYnEcSgEeYWqTxUcEpnNX09whZFrJXVy7b4sp8Dw3EOVabz
dFqVOwLhL9RfBAEaSbPLLRDlFTmC1BOADTEFsYCL9xaWHp19O1o=
=/KSA
-----END PGP SIGNATURE-----

--ebrdc6moxv6utuhk--
