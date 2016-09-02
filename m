Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 011691FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 12:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbcIBMIW (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 08:08:22 -0400
Received: from mout.gmx.net ([212.227.15.19]:63710 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752248AbcIBMIV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 08:08:21 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LngRb-1bAJjb1tqp-00hykC; Fri, 02 Sep 2016 14:08:08
 +0200
Date:   Fri, 2 Sep 2016 14:08:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff King <peff@peff.net>, Git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t/Makefile: add a rule to re-run previously-failed
 tests
In-Reply-To: <CACBZZX56fjJZydnBrWUYtU6V3xyQyaLL4MYzVVF0yD4dRdducw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1609021406340.129229@virtualbox>
References: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de> <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de> <CACBZZX6iEmbb68tzRKNAryp5qmt=iU9FMuOe2ONV=2ojcazoEg@mail.gmail.com>
 <20160830205151.k6ufhfzl6gh4uuog@sigill.intra.peff.net> <CACBZZX4NyjkK0Nf1JVGFRhc0xnLYg2YX6ctO5OxK3Pi60r5KaA@mail.gmail.com> <alpine.DEB.2.20.1608311227150.129229@virtualbox> <CACBZZX6exynt_9_wVtEN19HQt_rPJdo5Ck3jujdQ-hLdMAGdmg@mail.gmail.com>
 <alpine.DEB.2.20.1608311702440.129229@virtualbox> <CACBZZX56fjJZydnBrWUYtU6V3xyQyaLL4MYzVVF0yD4dRdducw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1607746542-1472818088=:129229"
X-Provags-ID: V03:K0:kLTUhWlykKXWgz8diceKDuOVG5n8tltsYMj91H2rTKNLcC0sjXv
 3+bReCxj6/uefoT3Hzgta2cPjaHH40A06OxT/fBflqP9LZUWeZHUdh9txz4tfNIvbDLOupl
 zNM0gsizZKuwkxl+nGX0zST3CynRV+lCJVIY0xCoXmN5ZM6Oh/OFc9pyfK13jTulsHUauLG
 nAoNO4Z9JYZd3OvC6bZ6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7RsrhGFKEmY=:73iiPHJP4YoiML8Cq1Wdhm
 tx4j6kPPjWWajy41UT0LfJwW6GUNStZxBd40rm2jEPkN+H7+Lj83iXtbo03zvPg53PHCO8z3G
 MbFmo8wJDzzm973yTzmo9N47WMJ2v3SU9BvtJ2kes3GwjvLGunV39+sN9XY2bvtbQIdqmghQD
 G0U6Ndsd6ItQLhPV1HHj3/fO/+EuwThIi+UIOOSdAdXY14CinIquuk847PPBcVhTWe+rlKLZ1
 5cH5VNCcgtIciuW14K/TqNWCV1DzxDoxAxzjcdPGGcVeaS6h3uQPVLVfkjzVJ6w0YPzKBE2zn
 n/L22+1K3FfKhQsTKjT66Zin+N6G3f0meoW6f1FWKOz2OsiOiO5XNct+4xrXLfS8OUR5EPSHJ
 G3XpHHVGZTsNWBvWiiP99lJSkKBbKHbMhop66q3Vf3Pn44xsBSZWFU02PJuixSh1YpJ2gWXCR
 eK5q3Lqmqp7FMmv7UAqVZImQI9e/giEMeX4HCFbN6zLdf6pJPbAf97VdICtjvsfTJoL7UUULU
 CCD8rEnXddIiFoPW/FgJZm84BKvtyBfuGly7NsIGuchZjjtmpopvkcUMQ6QPoH9o2sDM3HMQD
 2CYHP7P3uKA8bD+tYxuxmyNUtu3wGEqxlBk+Wqf8AEcruOmOJwN/Z6JcISr0gU4+KZc70pdW+
 rI+gdOSwL+9dH0Rd61yCcfTmHOEoSdTDuwOdgxDq4tzjKFC7M8hO3fjm9xPYojQpYrxL3StzJ
 eRuhQJlhSklHNNG4/7ojyk0s3+ngxqv0zhPwaddIHoRruT83Pb7veoybEBMWwFwC98dOwJLGr
 blJUHk3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1607746542-1472818088=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Fri, 2 Sep 2016, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Aug 31, 2016 at 5:05 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > The biggest problem with Strawberry Perl is that it is virtually
> > impossible to build the Subversion-Perl bindings using the Git for
> > Windows SDK when using Strawberry Perl.
> >
> > Which pretty much precludes it from being used in Git for Windows.
> >
> > And then there are the path issues... Git's Perl scripts are pretty
> > certain that they live in a POSIX-y environment. Which MSYS2 Perl
> > provides. Strawberry Perl not.
>=20
> This might be me missing the point, and I'm really just trying to be
> helpful here and make "prove" work for you because it's awesome, but
> as far as just you running this for development purposes does any of
> this SVN stuff matter? I.e. you can build Git itself not with
> Strawberry, but just use Strawberry to get a working copy of "prove".

Yes, the SVN stuff matters, because of the many t9*svn* tests (which, BTW
take a substantial time to run). So if I run the test suite, I better do
it with a perl.exe in the PATH that can run the SVN tests. Otherwise I
might just as well not bother with running the entire test suite...

Ciao,
Dscho
--8323329-1607746542-1472818088=:129229--
