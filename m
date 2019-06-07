Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C6931F462
	for <e@80x24.org>; Fri,  7 Jun 2019 10:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfFGKZO (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 06:25:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37302 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727402AbfFGKZN (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Jun 2019 06:25:13 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1504:7263:609b:f73f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 532E860734;
        Fri,  7 Jun 2019 10:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1559903110;
        bh=33feA9KsXFxjKmu/PoqiWxrm6NGklmk57vkQ7iUM8lw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HBoDAs36P9S+AO+MOwoCWhxOXdW2dDhnsEQfGarEMIW7eEO915UW2ArPqAwU2xAtl
         enFodJriwTTRpyXoV7Yt0L+txdbBJ4fIjLHh17LRfOQm1ttv0BhJ9oWgaecT0h0VrX
         dqMdsvw/XnJOtrhsGHsIiKabiFmYYI1YEQf4Xemo199Lr3kFQjBy0bO03D74UsgWo7
         p/cTam5eTRTT64IrmSXF41KKpw/PKRv6fLgHJ2xZGGETuCHUSsqLb4tKElxvcejGp9
         SJCs6hEUEcIcdRNgvltzOS7N/b9L1qqPgd/aApVUInZCpcthhymRx6kh9cqRLJBcbI
         9/xgeo30T5Th4WQ5SF6YU91FyypBxlA6Gj7Ll4+H1JK7QWzAxHLiy+abL7AOzKj3dR
         S6U2z5s1X1YqtJDi5PYfxuf0rWrEtW8h+nHoFeZXd6QoRJuf93JzIIvwOIgU23GUkB
         RG0eqjf6m5GZwYNz1xGHkYBPTEN3XmQzapYOokMCb2SVk1QpBLX
Date:   Fri, 7 Jun 2019 10:25:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Andres Llopis <allopis@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Centos7 compiling git
Message-ID: <20190607102505.GV8616@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andres Llopis <allopis@protonmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <_d10F4jbR7a1KdFnFMJF5IkXQ5YxZdCttXeYWn87WkJ3GwHgAgJ4M9KSedHDliZTv9Xt4EDTrWV1YxiHoosF_lqSY_6p8aV563WdG5qMhd4=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1RhGCd1AsoFHGRHc"
Content-Disposition: inline
In-Reply-To: <_d10F4jbR7a1KdFnFMJF5IkXQ5YxZdCttXeYWn87WkJ3GwHgAgJ4M9KSedHDliZTv9Xt4EDTrWV1YxiHoosF_lqSY_6p8aV563WdG5qMhd4=@protonmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--1RhGCd1AsoFHGRHc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-06-06 at 14:34:13, Andres Llopis wrote:
> Hello,
>=20
> I have a problem in my centos 7 machine. I am compiling git 2.18 from sou=
rce. When I use git svn  it works fine with the subversion that comes with =
the system. However, if I have a different subversion in my path:
>=20
> PATH=3D/home/tools/sw/subversion/svn-1.8.8/rhel7-x86_64/bin:$PATH
> LD_LIBRARY_PATH=3D/home/tools/sw/subversion/svn-1.8.8/rhel7-x86_64/lib:$L=
D_LIBRARY_PATH
> then I get the following error:
>=20
>     Can't load '/usr/lib64/perl5/vendor_perl/auto/SVN/_Core/_Core.so' for=
 module SVN::_Core: /usr/lib64/perl5/vendor_perl/auto/SVN/_Core/_Core.so: u=
ndefined symbol: svn_uri__is_child at /usr/lib64/perl5/DynaLoader.pm line 1=
90.
>      at /usr/lib64/perl5/vendor_perl/SVN/Base.pm line 59.
>     BEGIN failed--compilation aborted at /usr/lib64/perl5/vendor_perl/SVN=
/Core.pm line 5.
>     Compilation failed in require at /home/machine/.local/share/perl5/Git=
/SVN/Utils.pm line 6.
>     BEGIN failed--compilation aborted at /home/machine/.local/share/perl5=
/Git/SVN/Utils.pm line 6.
>     Compilation failed in require at /home/machine/.local/share/perl5/Git=
/SVN.pm line 32.
>     BEGIN failed--compilation aborted at /home/machine/.local/share/perl5=
/Git/SVN.pm line 32.
>     Compilation failed in require at /home/machine/.local/libexec/git-cor=
e/git-svn line 22.
>     BEGIN failed--compilation aborted at /home/machine/.local/libexec/git=
-core/git-svn line 22.
>=20
> Please help, thanks a lot!

It looks like you're using the system-provided Subversion Perl modules
instead of building your own. In general, this isn't going to work,
because those modules depend on internal features of the library.

You'd need to build appropriate Perl modules as part of the Subversion
build process and either install them in a suitable location for Git or
set PERL5LIB to point to the right set of modules.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--1RhGCd1AsoFHGRHc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlz6O4EACgkQv1NdgR9S
9otf5BAAiij/PyjadRgA6smDC3thB3HRemiBvUY8JWDwE3uXRcPLYSsWhTO9wWWN
H8FQkdLUHDcMZGm1fUIK5lFOaLlXPKnmPHR50Shdazqyzf699XqAAypuYTw47CZo
vLoaEVaW1VF1md0sFT0ZmXaip0+Ckz1o0YnpwzVkLeVpkuYPj3c3oekN2gqbMZCT
IX79eWEZ71aW7qoOiV73W6t6iP1crE7pBZTIY00/gjQBxjho0gDH99nXlDvPMdag
aol7Aj0os7m9t2ID64SLF4SctUyKEJhJf4TIisZxKW4gX6T8qqJTWHIZqxQ2Ir+u
jVCNyVZ3YJpuzGuhn5ImxD1R0m4LlE2o95kGlj5c0ZJ0pCT57GDurqLysUrggpQM
BhLZpFk+mKlo2tJlP6IiY/Ojgzx8MhZ8f9wy9EFpNtRVCCmvAD2F2sAgC731fb/C
DwvpoAWrh3Mm71VoQ4OZwqNTq1fGnuFPG+LIRmaecl7UvJCaiKK4MFSIyLwhXQhi
wtA6KAweGEU0MF3cpf1+iEoXdRko9WriWQgmSjUmbk8W74rMbuIYbtp7WSyuvmWw
s0/sl0rSUCKwiXb8WbnU2eicIb3l1vw6vIkzWohreWiHx677N1xhZukwXVwOMlI3
09Dvgbh8+SI0zOWbsKt3Z4pzSmXXBsfekMfCfxsBzzvK+A5/Hbk=
=iL00
-----END PGP SIGNATURE-----

--1RhGCd1AsoFHGRHc--
