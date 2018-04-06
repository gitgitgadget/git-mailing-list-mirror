Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D564E1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 14:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756225AbeDFObO (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 10:31:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:35925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756269AbeDFObN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 10:31:13 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lfppu-1ek24l0SPy-00pKQZ; Fri, 06
 Apr 2018 16:31:01 +0200
Date:   Fri, 6 Apr 2018 16:30:44 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Joseph Mingrone <jrm@ftfl.ca>, garga@FreeBSD.org,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH] git-svn: avoid warning on undef readline()
In-Reply-To: <20180406131514.740-1-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804061630110.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <86h8oobl36.fsf@phe.ftfl.ca> <20180406131514.740-1-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-671554682-1523025061=:55"
X-Provags-ID: V03:K1:Xqfzi93fShe8QgcdFd1NgXKvQAwnnKke9/SvPi0OZD+GHq9uPjW
 Az4pQCxEpCmsex9X/SEwAV1sTaY7I1jzsmqkk2HrJqeLcJSkFRoAWLxJkr6Unb9qObBlQBj
 HFM2bBstO7en3VTw+KxgQNxg6x8ijzkqfwQksB0Sf3OQLy2g4fT2YBPxajI4ya6PlrzzfFM
 fLiuABHAT885A6pj5MLuQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X2WNrnzZwR4=:azXz0ZZBY9+ZnRMZclLuPT
 iULmRh0zWyufRI4v2eMqvjN+tSIFhW5fpPcVFFZGP9TLH4cdWLWTPwS3rCCSBoAh4XqxOCsIF
 ABDM8wlFHhDE+7nxT3LUmXagbDSDqCtADVvATFpMZwIIKTkXUbaOPPyOoXeR3+mKDa6mj73CU
 MhCCYZiK9NlCN9mZpnv/TL8hIAEy1r9h1NBRfmq72VUNjeM9NEmwzvpduD57AqCWCI5OZESYa
 wNrnj0jBZl8fi0AguS+W1v+511KPUKQwF8nRAutGfQV4D/BT4F+QJ36L1Uc97AKIo/bKfjPL8
 eMl0QQ4WeG2X3yU9pppXa7152+GTXppal9kGdU91SxVHVgjl3Zo+xdZuf+bR5UtohsvwNkJ5K
 t2290rl4n0mhaRleDvSxZ713iX1capE4uxp1A12LhAuvcvtjL7++l2tWXRH9D0Hn3okAiAR/T
 iDlEFdzdEkK2ib9jc7i0OVGRs4IF0B67qIqI0T0RIHP2aodO3bfQVGFnA7KL+04bvoIJMubT3
 5e5TkVSCVoTaSiSwdMiyVRLBnCk3qebN50KHEFUnyobJHp5MtL8SQlx6HKIR5/S3aEM6orYLj
 6x2vSzHumM1+xk0vWydn/k8XLMwnEGAq43Squ5AlKwPa03lS7BYbqJj/I3nq9Hto2JP9RPfZC
 EomXEQAzm7mZDM3cd3Im7T9BDSpn/o0hXkZISE5a7MzvVmEMSgL9WWSVm2G/ASmBCyzQenk+W
 pBc+Jnlx7YTz1gYwSHRYnP99+SlTdNUMJSMWdh+T3Skwi7NzKk8jcAwsirH2iiPrkt/EoHcde
 aGxLwecoaV+V+dFMEOtHPIyQxn7izn4tEpe8CI9f3W++S/xBwZKUxD/zC8V4s6sSHHwCL1j
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-671554682-1523025061=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Fri, 6 Apr 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Change code in Git.pm that sometimes calls chomp() on undef to only do
> so the value is defined.
>=20
> This code has been chomping undef values ever since it was added in
> b26098fc2f ("git-svn: reduce scope of input record separator change",
> 2016-10-14), but started warning due to the introduction of "use
> warnings" to Git.pm in my f0e19cb7ce ("Git.pm: add the "use warnings"
> pragma", 2018-02-25) released with 2.17.0.
>=20
> Since this function will return undef in those cases it's still
> possible that the code using it will warn if it does a chomp of its
> own, as the code added in b26098fc2f ("git-svn: reduce scope of input
> record separator change", 2016-10-14) might do, but since git-svn has
> "use warnings" already that's clearly not a codepath that's going to
> warn.
>=20
> See https://public-inbox.org/git/86h8oobl36.fsf@phe.ftfl.ca/ for the
> original report.
>=20
> Reported-by: Joseph Mingrone <jrm@ftfl.ca>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  perl/Git.pm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/perl/Git.pm b/perl/Git.pm
> index 16ebcc612c..6b6079c456 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -554,7 +554,7 @@ sub get_record {
>  =09my ($fh, $rs) =3D @_;
>  =09local $/ =3D $rs;
>  =09my $rec =3D <$fh>;
> -=09chomp $rec if defined $rs;
> +=09chomp $rec if defined $rs and defined $rec;
>  =09$rec;
>  }

The explanation as well as the patch make a total lot of sense to me.

Ciao,
Dscho
--8323329-671554682-1523025061=:55--
