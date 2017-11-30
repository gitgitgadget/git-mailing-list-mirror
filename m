Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C59920A40
	for <e@80x24.org>; Thu, 30 Nov 2017 01:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752838AbdK3BvO (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 20:51:14 -0500
Received: from mout.gmx.net ([212.227.15.18]:63662 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752734AbdK3BvN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 20:51:13 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2cYX-1f9iGG1f4n-00sRZR; Thu, 30
 Nov 2017 02:51:09 +0100
Date:   Thu, 30 Nov 2017 02:51:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Robert Abel <rabel@robertabel.eu>, git@vger.kernel.org
Subject: Re: [PATCH] git-prompt: fix reading files with windows line
 endings
In-Reply-To: <20171130010811.17369-1-szeder.dev@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1711300250320.6482@virtualbox>
References: <20171130010811.17369-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-779927207-1512006669=:6482"
X-Provags-ID: V03:K0:WWLsTXJxIRMjyxR32QFG3YgUT7+IIdrmjDaJ/4F9DZIwy0th1aM
 QVnJP+JF5iUXqn7FUzSj2O+ru92xZzGllR+zsa8hDBZLL+pwZtTlPt7bWQE1zi50Rvmxubh
 lgHwFRkfA9LVmOe2igEvRYAEjbroG814eNJ6L3Lemj933SkNtDExiYZgUjyQVLKvqGGJ677
 9PsOJThbOL5WzKkWGkD1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bwlh69azIJY=:q8drBVJ5Pb8pqY6GauAvDo
 2ANgMd0eFvX/4ZwmwCWW8fghSHQC0i6SfGyLobQm7TUVypdJ5Up91MlfDSpRJmNFozkp/KiX9
 3qq8utTGP4Mdio1Z9VjqOffZOMyeI4OM/rhLp1iIq25EkR6JNeVYLh/qG4v4In/P/ntLlKmih
 d7IX1LlO62hzdEPASxIpfstqVyBQDbqqqc6jfw3qGFBK5cWNvZBPzu2DiJzQIPOpnNKYPpuC+
 WOXgtMV66JawbELVt1/5zKRSITT5Bv1t5KoBuK4B69zPHoZWNS5NyPraFPsvtEVxccNEwySfi
 2/WGVw3x2FFT/vHCEinhe+iJCnMk7r9LIQXgJdOyCXknD5NA/q5yGrlm3Ig6HKQnm8bhTOeOZ
 cutpm+C3aDVvDKFpE7F67SlaTPI+hpZP0lo7W5twcIhjwSInfWZjYlRI3K/4K4yQAwT4MnWR1
 0X7JMX3j5EFz/alG3dfwNknMY26VVXXV2MSjI0XMlUdZVGNGoDLDL9cBoBRxoTcumK9BU1Yap
 nyzi7nQGuPRPWQ8eFINxqoVpO7wx+9rhjfNCbjXLib5AyQPtEG5nBfQfUGrqVsLm0br/i29JH
 R23dcMmx0Mzlk6Ivl3IhC23Du79SehxlA4Vt1J0KTJDQojx7g7Y0fONORHsD85GIo4dAAmji5
 pPL9h1te3SPmEIuDdHdXgsKJ7X0J8GNtSu+YwwrFXzIXj9htFGLwQQ2AcVy553nEUYt2n/W0k
 bBn72GY4JADwzaFEjkgLvmoF995CBGn1EtZxaHmn7WrL/DNrt9X+YQUI3UjgVH7yOKWVremxU
 adhSAq3eGX4iK2cqbl5vRYeqXZtjWtbADnEWS7p7wP9YZSZgjE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-779927207-1512006669=:6482
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi G=C3=A1bor,

On Thu, 30 Nov 2017, SZEDER G=C3=A1bor wrote:

> > > diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/gi=
t-prompt.sh
> > > index c6cbef38c2..71a64e7959 100644
> > > --- a/contrib/completion/git-prompt.sh
> > > +++ b/contrib/completion/git-prompt.sh
> > > @@ -282,7 +282,7 @@ __git_eread ()
> > >  {
> > >  =09local f=3D"$1"
> > >  =09shift
> > > -=09test -r "$f" && read "$@" <"$f"
> > > +=09test -r "$f" && read "$@" <"$f" && export $@=3D"${!@%$'\r'}"
>=20
> I don't think that export is necessary here.
>=20
> > As far as I understand, $'\r' is a Bash-only construct, and this file
> > (git-prompt.sh) is targeting other Unix shells, too.
>=20
> The only other shell the prompt (and completion) script is targeting
> is ZSH, and ZSH understands this construct.  We already use this
> construct to set IFS in several places in both scripts for a long
> time, so it should be fine here, too.

That's good to know! I should have `git grep`ped...

Sorry for the noise,
Johannes
--8323329-779927207-1512006669=:6482--
