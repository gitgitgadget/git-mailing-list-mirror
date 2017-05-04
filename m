Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3052207F8
	for <e@80x24.org>; Thu,  4 May 2017 00:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752516AbdEDAuo (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 20:50:44 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:36878 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752525AbdEDAum (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 3 May 2017 20:50:42 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2EFF6280AD;
        Thu,  4 May 2017 00:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493859041;
        bh=pLcZpXw3zcY4CJeCTNyU9Fe9BRua8HAR/TEmTTbnVe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L4EUfRI7zDrkY/9WZcuZw5FK7kRyW0glMyZT0fmnaaKve5OsidJDPIqM/OhbSIWLB
         J4e1okZqLQ/JC/5w31lllKF60DJiGlca8rdVZy/SHhFu9/73lUKP7UCgwwui6SSRB7
         bNqgNEwnAy5iwTygfIBYsudoec5RenJdxu0DxrcsYUNLSDA7kFeIgW2jprZihXGP/t
         ty99+p0VOnWHoGMlduOJjHLZGC/IG3MuV03a17AHFtYzovsI1J5AM8Sp08L+bynujN
         2EpBgVeICU0PV+J2xKwY4CH3jAwuv911KTmllPb4rwWplItgnQ4zcLady3A9ZE+9Xl
         4O0Qut0XD1G0qBsZnBDLjuJvF19BnJo0Gm/OC9eIPksUEZQ2eSlnwb+UiXCSTLciGR
         mDw5GfiSqjnBl0Rip0wiZ+nT/DOXP+cBlAB3erMU9syQ5QpUEHFKC6xcqwHR1w/+oN
         KreyQmrn7FS1wWom83yvGCR4YzRR5qRr2zfsOAt7waDwxt2WtLm
Date:   Thu, 4 May 2017 00:50:35 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/53] object_id part 8
Message-ID: <20170504005035.zzqeetnvbsvfk6u2@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hpvxwqwhg5vm6qjq"
Content-Disposition: inline
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hpvxwqwhg5vm6qjq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 01, 2017 at 02:28:53AM +0000, brian m. carlson wrote:
> This is the eighth series of patches to convert unsigned char [20] to
> struct object_id.  This series converts lookup_commit, lookup_blob,
> lookup_tree, lookup_tag, and finally parse_object to struct object_id.

I've made the changes suggested by reviewers and will be sending out a
reroll soon (probably tomorrow, since running the testsuite for 53
patches is slow).
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--hpvxwqwhg5vm6qjq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlkKetsACgkQv1NdgR9S
9ouYhxAApntPHY2FnCaoWx8oIjtaN/mRE8kkHsy1EEecNoAn9KzuBCPMrzACYQ1Y
dwOrNHTAZgTcj92oy4+M/cau0e5MLF+o+aR5TDlmO4LFmOsIBQVdmKOa82sESCak
4QIIvaadPUajEUCrg3GkcQHr1RbWt8KTBgbs+3u7Il57t1N1BNWo9HXYhsssiKeq
zBsdm6NTf1Xt9KIWR1Gn5F7ZDX+udunA3Rd07sVB0q73+BKF5RZzDRx7Qbvf+cdg
PdbX4hWhOkQD0y4/dtB3Tv+ph1EC9Fz4DuSGKy8ZzKZUrtKnBLexzINWgPZcjhEi
PFeMP3Pk8g9A8iQ/w6UQ5rVlFgWbrlGjLUcC5GAY599KCzJOxtgRAPzahWSrvL2H
JVSBW66O4TeL27kapSy3THOfQl0J6ed9ovE2dNpoxodGmau2vx0IghV5vHQ90EJq
dNuyRRlDK9YCnomZb+ot/uTq/g/IRKNE8a0/qbb+r0GzbkR171Dpj8TGwaMsp4Xn
IVmdqUB48IwC1Tsca0E9HS0y8HG/zzGzOOBHO/fwMdsu2NDPTqoQuUSghRqeeWzy
FZhYgY/J3nsKuKfOFeqCClB7ib5JW7oFQ2tG/KOdMecXMtXmXkPuCDGNgrczlZto
OM0ChfG97KmsIHY9EtTqwsXP4dG8Sx/hRNQnrS3uaI9NlmfA9A8=
=nA9N
-----END PGP SIGNATURE-----

--hpvxwqwhg5vm6qjq--
