Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7667B1F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 22:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbdKMWn2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 17:43:28 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:50791 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752444AbdKMWn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 17:43:27 -0500
Received: by mail-qk0-f181.google.com with SMTP id p7so21828129qkd.7
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 14:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0u6VjKEdrbvhIOxvqkE/O/jtF39CHVaxEV4RnC1xk+o=;
        b=uqPHnWxTjdmQgp/2kcGbalVdQfOmHdjwtMWaxOGlvh20ZAVNz6lc7xnzpgJDBQH9BD
         CAFP2c3t0B0KBxbOb0OEwsex18J23xT45IEJvJasSOd08Kp4wXKGyayrL4/4bg8FobuZ
         C9UgHefeJdRtknVkAkGenAETTxVYNv/AZ069vKRFZ+L4FOZfRqCSD0ZPwlnPtAoCq8uT
         quQkpo2p+S1KDK7UO7LneN0u34NWY+juK08DR+4QPvMuWT8wCzVGONB+Vnq90FmxfKLd
         0wDit5LWVeqV87QIACcY1dziS1IEP7ysq7SaLvl3c45jTic/BoKTemLZ8/2sIsFiXJPX
         xp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0u6VjKEdrbvhIOxvqkE/O/jtF39CHVaxEV4RnC1xk+o=;
        b=i9D/B+EIT353J9s+aUknsDREglubt/UUhW5zGrfAY1y9ZB5cewkhtFPDAeQ8WhQQBB
         kJpljKxom4Orp5uDUKn7Exrw6EbGbxEoeTgUNPhnqsHaITv7pVnPxnQW8jrzFDhE01Bp
         +l/WW07iuNHvY5bnz4zvqn/uDni6DRwsjGjsS6BVyeEqWQALqGbTiZRmcKnHdPQn61pX
         QDdWwXBTS4vTkRRnXOFfTHyp1xihmrMhyW6K8hdb5QiQdn+Tm56oGh1ivqutODeIZzIi
         KEwm6MxraQow73SAOWyWmv3Tikpyt/Ju9LXhNJpZ4GvftQWeN/AEkJw12W/BEWQVnuFM
         mULQ==
X-Gm-Message-State: AJaThX5Rnu6WwplH4o+dNAZI/jzQUem17lqt3k8uBohlv2noKvnAxNEB
        IKzox7ariXYvQpfymgbLzC0=
X-Google-Smtp-Source: AGs4zMYsXS0Ue3BEUxk5zmznYheSTb6GpDfTIQ6pCOWaIK7Gn7hlv+Ep/f3pHOUOlgEjRROkphbtMA==
X-Received: by 10.55.137.198 with SMTP id l189mr17059485qkd.169.1510613006382;
        Mon, 13 Nov 2017 14:43:26 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id n145sm9508944qke.38.2017.11.13.14.43.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Nov 2017 14:43:25 -0800 (PST)
Date:   Mon, 13 Nov 2017 17:43:23 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/lib-gpg: fix gpgconf stderr redirect to /dev/null
Message-ID: <20171113224323.GR5144@zaya.teonanacatl.net>
References: <20171113210745.24638-1-tmz@pobox.com>
 <20171113221823.jzt7jfhxeuyivbcn@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Zpx5Rz5PkYgiNBE6"
Content-Disposition: inline
In-Reply-To: <20171113221823.jzt7jfhxeuyivbcn@LykOS.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Zpx5Rz5PkYgiNBE6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Santiago,

Santiago Torres wrote:
> Thanks for catching the redirection issue! I agree that the other=20
> fixes feel like overkill. Are you certain that switching to gpgconf=20
> --reload will have the same effect as --kill? (I know that this is=20
> the case for scdaemon only).

I am not at all certain whether reload would work to fix the issues=20
you fixed by killing the agent between runs. :)

Were the ENOENT errors you encountered in running the tests multiple=20
times easy to reproduce?  If so, I can certainly try to reproduce them=20
and then run the tests with --reload in place of --kill to gpgconf. =20
If that worked across the various gnupg 2.x releases, it would be a=20
simple enough change to make as a follow-up.

--=20
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Whatever it is that the government does, sensible Americans would
prefer that the government does it to somebody else. This is the idea
behind foreign policy.
    -- P.J. O'Rourke


--Zpx5Rz5PkYgiNBE6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQFEBAEBCAAuBQJaCiALJxhodHRwczovL3d3dy5wb2JveC5jb20vfnRtei9wZ3Av
dG16LmFzYwAKCRBDJZOLvq8M4zaVB/4y+ZDrioiJwuon3dbHkUafnfDGFEMyxDYp
0L8/gJAoHLjk6y9fiRa21/kG/cY4T+/I/DdZXAq0iVRCn1edu1P6mQ5hwyrOhQm/
dTty/5c2rj8HtGggLe0hDGmMFu9epTaUsxiNVh2v1/qoTt0dXMLN85/aa9mWmRM0
kekZdFyBx1Np0WUEO45FrF68ARpLde1x8DkSTCC7mDe63jqtt/VBlJM6/t6o32Xd
2jZKldicbmQjW96zk1HKMg7Ewz219zPJoJDQP1NiHtgZELWz1XCT2JQ1ktZyvhLM
ZX/psm8VZgmvKagCNmcYa/beq9u2vgC10G2SsqcM9F4vIG8fmwtB
=U8qP
-----END PGP SIGNATURE-----

--Zpx5Rz5PkYgiNBE6--
