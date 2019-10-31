Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C5421F454
	for <e@80x24.org>; Thu, 31 Oct 2019 20:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfJaUUW (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 16:20:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57478 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726741AbfJaUUW (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 31 Oct 2019 16:20:22 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5B28B60458;
        Thu, 31 Oct 2019 20:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572553220;
        bh=eFGXgTePMwFz5lG49rbyEVWJl9Yn2qLKANz+QCFBj8I=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Xo2kx9FZ1ZnL0xBavByCaG1AV92VAVN6GCzqdLi9p//EEV/CePULcLdyfyYrW/jJS
         svYhRA/lhsmQeGs4Sahnkvpiw5kf8YWMVPWmU2Eo9VrBawChhBjpUeIM/a9NtRoafk
         o3rfENNxmByLcntTOYggS3wifuqSFm/Nyl781qKk8yh++T5lDRrGqTG283DMB4tims
         AX0VC/bZMGVX3qYAmTQ++JbEeY1pVnHepBokVurR5Xyi/TRPj037KhiOsBFFFumuHk
         3XJLAYecGgHgw8AsBDx3thhDDKbyFORhwCG17I0TtPs+AtZgx76DmRBoesS+5yDm7Z
         e6f10cU1okvvylq0Eq0G8SXkN8cHcY+gX9tmPb4xWKecv5aOMbZzFLQbxGoW6JOjWG
         OAChR/ZQX/XuR/5EAqCpIneVrdEHsMmnzuxsR7frU1dXefAuC2fEioOwoa6xAtGEs1
         CyJrbKyiD92lH0JaJk9P8diOqOuNzaWVAT3ghPOuZm1visjQ3rb
Date:   Thu, 31 Oct 2019 20:20:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Arkadij Chistyj <arkdchst@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Question - .git subdirectories
Message-ID: <20191031202015.u5l3wzvn64zypnad@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Arkadij Chistyj <arkdchst@gmail.com>, git@vger.kernel.org
References: <CABf25VhaqrbtRTpL5ZNRy59o4JSsiKpF3pk3+54sDCkvzdgAmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ec3cad3d3fbwiiuy"
Content-Disposition: inline
In-Reply-To: <CABf25VhaqrbtRTpL5ZNRy59o4JSsiKpF3pk3+54sDCkvzdgAmw@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-1-amd64)
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ec3cad3d3fbwiiuy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-29 at 12:26:23, Arkadij Chistyj wrote:
> Hello. I'm not sure it's correctly to write to this email address.
> Sorry if it doesn't.
> Copy of my home directory stores on external disk under git control. I
> have devel/ directory that contains some of my old projects with git
> repositories. But main git repository in root of disk is not tracking
> and storing their contents. I don't want to use submodules or crutches
> such as renaming all .git/ in subdirectories. I just want that git
> treats my .git/ subdirs as plain dirs with any other names.
> It was already described here:
> https://stackoverflow.com/questions/2317652/nested-git-repositories-witho=
ut-submodules.
> It's very simple functionality but I can't find any simple and right solu=
tion.
> I just want to know is this possible or not? If not possible, then why?

This is not possible.  You can't add a non-bare repository as a part of
a parent repository without using submodules.  Git uses the .git
directory to find the working tree and for safety reasons doesn't allow
files or directories named that to be checked in.  Allowing users to
check in .git directories would allow configuration and hooks to be
stored as part of the repository, which would allow the execution of
arbitrary code if someone cloned it and then changed into the
subrepository.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ec3cad3d3fbwiiuy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAEBCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl27Qf8ACgkQv1NdgR9S
9ov1tQ/+KnAN3j3Ct3Bh9AKl+xp9ZSJKMDkw7NBPveljWnS9gataKNVDOBhjS6g8
iqX3WIQWBiuTVm2rfKEkS1MyqMqMl7uIItcrY8IvKk1XmzI2wOdkTBJ8gjr1sykF
X9Dk9jqMgjM16GY3B02yf0JoHtc3nTehDdwZLOb7YfJjhGsWnJgOMhJtdKwmRYx8
3/1mgY3n7eU2HLXDX30ihrbk0nkBRrvj0h8Ug2P0bI9qAw4FlKx5eVqjWoL4RfOA
stOdf7KuAaetREjMe8QJBVy/BFW92sTzHAW3PGSw+Yqigy4LFYKaDCMnm5ylssM2
LVgOvqXwPws3Qez77f4e3u1u/+qGKwi3q50WtAx1lOX0A3W4rpAsKh2qJeoANNI6
u83hK+sxuJ0souL43Uq8A0vRAVnIhlXnrEQK9ZvcINkEczMFJDy68+XYunrB3S45
6xXxDc5N7HUd0C4Et54j2j1MyjWD5Q0gR92FVyzmVlDCRGOlvC0ujp5UMG5RHA3A
oBslHEC+V/M8LDRnWVimmTI36PYV/p3t4EsNh+zODq6fJ4esjFoQkCP3wEjzjSC+
Iz5tnNFs75A6uWGYnInVRG2KcSBH+a+AGNGhh3vZNT6JAtSCBoG928mBbo2Xo0D0
hnfaPM2xwiicHaTxnAIv2VvmIT/bJa9Fcfe9gjmKhOH9lPA5yHw=
=XDUT
-----END PGP SIGNATURE-----

--ec3cad3d3fbwiiuy--
