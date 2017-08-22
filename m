Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,WEIRD_PORT shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96F0D1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 14:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932975AbdHVOu7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 10:50:59 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35941 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932523AbdHVOu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 10:50:58 -0400
Received: by mail-qk0-f175.google.com with SMTP id o63so33470087qkb.3
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 07:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w28vDPrdr6HTZCpuNPoPzE8mXemuCljM88TyHWlcACg=;
        b=CnIK68frb69j3YqkmKjB93Mzc/zz5OH5NCoQwAgd64wYdHDJnKEFwKxJoHvyGO3/4f
         w8jlELeUH1SZrxhDhCjFkctmdx/u0wa5vn0+SZZsrwreu5UKCu3dtEDXj3kvlcTCtc2v
         njLW/zWfR395AGy9Jln1V+JaQokgyiEazVAwq+F5+AmIrkUJzv44ElPcpp0jmsQKcjWD
         stBWdQQLqp4oBndVd2ytYl0rxnLKcG98YKjZu80YrbTrOONmdZqvzQaEOCRV9EgG90Fs
         NgK4wAKsjO/v+S/jYC6iun73emRdaXBOKVUUOk3fjxrr8JCEbBA7ivjXlN+fJrRR4UV2
         2pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w28vDPrdr6HTZCpuNPoPzE8mXemuCljM88TyHWlcACg=;
        b=sHNbPJt/VLmGqkUTO/pYw7J8trSOSjy6MCZpcptZj5VUs8GMfK0djufThr23IcKlQW
         GYIsdupnZOyQ/2PDeQC1ojx7XUVIcEvQYMh+R6HtWOk/7iam+Xn/8PnCGz7x5kGbBtYV
         pZvJRtnwqPyBfbSigKPAmFEFmJFUy5f5dT3zhEk6vWM9GZcibNqkcO7q64OL0t+jRuwX
         6z6ZmEUJGHj7LzROMFbRgDHwQ2WctbrVvoo4PVJIoZK7AqGTsGvWtxXco0lGDnuU8cl6
         AYFedjg5v40uLsEhTE4tZIzZiUwJ+4SsQTWZX/vWNNnIdOHv58T0j5d6S1ZFxGMARV1k
         t0SQ==
X-Gm-Message-State: AHYfb5izTyQ0Ete2loM2QE8wye8OkIG47anra1RrEdfjmlMQbhl1ZEJ/
        Nkw4j9d/bdyGAdsw
X-Received: by 10.55.134.2 with SMTP id i2mr1248483qkd.273.1503413457796;
        Tue, 22 Aug 2017 07:50:57 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-02.NATPOOL.NYU.EDU. [216.165.95.73])
        by smtp.gmail.com with ESMTPSA id u22sm10473209qth.43.2017.08.22.07.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Aug 2017 07:50:57 -0700 (PDT)
Date:   Tue, 22 Aug 2017 10:51:13 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Subject: Re: t5551 hangs ?
Message-ID: <20170822145112.cr5lz5lgbpo4x66o@LykOS.localdomain>
References: <20170822051059.GA26331@tor.lan>
 <20170822052625.wzlhckjm6gwr2q6f@LykOS.localdomain>
 <20170822144357.GA5304@tor.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d2jbf2q5vgi22whm"
Content-Disposition: inline
In-Reply-To: <20170822144357.GA5304@tor.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--d2jbf2q5vgi22whm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> No concurrency.
> That's what I do: ./t5551-http-fetch-smart.sh

Oh ok! I was just trying to weed out what could out of place. Just to
make sure, your old compute is also running debian 8 latest?=20
>=20
> > - You probably want to see the version of apache this is running/etc.
>=20
> The one that comes with Debian -
> I am not an expert here, what is it that is interesting ?

I'm not sure, but sometimes it's helpful to look at changelogs between
versions of packages to get a poiner as to what could be wrong. I wonder
if it's apache the one that's failing on this case. Probably a paste of
dpkg-query --show apache would help me try to reproduce..

>=20
> > - What happens if you kill the apache processes?=20
>=20
> I am left with these processes:
> /home/blabla/pu/git -C too-many-refs fetch -q --tags
> /home/blabla/pu/git-remote-http origin http://127.0.0.1:5551/smart/repo.g=
it
>=20

So it's probably not an issue with apache, as the socket should be
hopefully closed gracefully.

> >=20
> > I can't reproduce on my side, but let me see if I can dig a little into
> > it.
>=20
> Thanks, more tips or things I can do are welcome.
> t5551 seems to be flaky - from time to time.
> It seems that I have it reproducable unstable, so if someone has more
> ideas, please.

I'm still unable to reproduce. Do you think you can enable GIT_TRACE,
GIT_TRACE_PACK and GIT_TRACE_CURL and pastebin/paste what you see?

Cheers!
-Santiago.

--d2jbf2q5vgi22whm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlmcRN0ACgkQRo8SLOgW
IpX3dQ//ZWCpvt17Y/8b2f996lGafqgRVBFV137FZJ1lajJ7Qg1Xl5YyaaPwr62g
m9Mmx4GMZK2J/GDfF0XYZsA/q+j+/2RkAGDbxQtvoM9UoE2SEjkpPK82yH8wlDCQ
kAJsil2AbIA2p16ImFF9TZR8ocGNXWflJ0yDqmvBtgTHBmXfuKH1KmdZtTzqlEPt
prWgu8j48Om73DPk32uBMIvBiWEelhi87TNHiHGZI7SSNXupo3Xai1DqtDTOGS/n
TfDZYUnWuAaJ8xdzdtRoQc3yx1EPul16Yw6Cl/APKolsp0Et8jhv8ReJxISEAGLZ
6KYw3xY+zfHOrqzm0Da8CVMO2FMzeSNSiTfNSlBhI2ZyyUG8M2ZJNbxrGl4VTcM+
6lKFkXrAfKnEQLr4Wn6stmJaAi5ooSH5kV8nGA3SkMnkOOZpMsmk6a6D+VPDIxVP
KA2dV1dsrHPH0mabJ+xKI7oI4EhHlmrggGye1rLh60ZRZON5uzzTyECZCzq1qHeo
5HP9RQajqZ/j9ZCD5dgl8obWZL0IO9bXf+3Z3DGqangtmaDduxB6QM7ZCnhizUA8
hQY4YZCEMhGbaTcsIz8MSyXVXdD3qz/bO3CHcFNFS1WdWWBOih3ZxC+1ASebXjEk
Q7dv9MTcTgfGsqWV7QhJ4hpeX18HIIY9Wjws/i7nliZQvyF0SWY=
=jET9
-----END PGP SIGNATURE-----

--d2jbf2q5vgi22whm--
