Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9A901F829
	for <e@80x24.org>; Wed,  3 May 2017 15:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbdECPIA (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 11:08:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:54941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751243AbdECPH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 11:07:58 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMTZa-1d9mAc0BSg-008LwF; Wed, 03
 May 2017 17:07:48 +0200
Date:   Wed, 3 May 2017 17:07:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 04/21] wrapper.c: add warn_on_fopen_errors()
In-Reply-To: <20170503101706.9223-5-pclouds@gmail.com>
Message-ID: <alpine.DEB.2.20.1705031704400.3480@virtualbox>
References: <20170420112609.26089-1-pclouds@gmail.com> <20170503101706.9223-1-pclouds@gmail.com> <20170503101706.9223-5-pclouds@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-785956825-1493824068=:3480"
X-Provags-ID: V03:K0:smGsKSxory+t2H6xi6GMgubGvZr0PI0P5c6LNbgWZFTW8FD9tKS
 VutFnyaXRzIvHLOtDyvfb8ACWcDLn+32sJx6YC/5XvjsKVHe9MrKCU294c8Tcd4+oeBmQ7n
 azgSBPSu4afYgG+KMc85t7Ei3zGFYCT+Lz89iaP/a6SnA/H5ah+iLJC2MhEx62JR59M3hUZ
 4vMOAnd4Fk3ZGPsCnLabg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ptd2ma4z9Xg=:x4y8ahCwiJRIU2/inft9hs
 vJObLoQ5TUJandcT/TNORvWHwZ48+yP3Wni3t5NOruko6COcg+b1hv+OoRNeYV6s+oiYlALBy
 Kn8SDyIAAtF+EZe3va2CxOW37h/DRTB8tzR9RV1EfEh+mbh+jRvd3z4BwnWbUsmHe+dlCwJ0a
 Bq8iXElIM6YEw3aoUiKgbbpO+TW9ujMnn7zrLn0OzuZYl0heCNWpkg4ZdmAFCBzwipA9RsBD/
 eeuH+CGGRrNrFnCvsXEaH67Ee2LAi3QS/C+9G1SX2fWWjHovFX/oZgYWPIIUkQR/M0DAcRPRn
 BIt2GIzojzIRWg4arUn/px0hwkND1GPeAyA/XHjIV9hn5nNS6BVkArNIfW+3SgPsb7NTt6KAJ
 r0jlHE4HPuAzR3DzGqhkh9nwdE0L9YY5YAnXECBmb5EmMM8A97iurCns8KcGkBUAfB/18c4H5
 2STnNBVVdjqWfMcNZa2A9nj8ZnDWydoD5yMWLv6oiu633MXE9wyOPcOBsSOFWcrXehidpW4Yj
 H9wvTdd2PvwOcInWQW3XOvjhLcK0sz/AIUQDlqKnG8axekSdeyQvpvWQmWwC3VJ6UXWjo1s79
 b3tceCwc1GN39HB54QAqbJ2VB8KYtA0j6fgoO/M8ypjDrAgkI0IRLu7fPA5GoSaZqeVd74XVC
 tstHvb7Sf7VvaIsN9OTG1f7gqnNbwUgs+fKeIEJq36NlTT3FBhewxX8xzAqsmxLON9b+DYEaH
 9Hh3FNr06PrP1IqnlC/eN2lGtCsho7uJYnHjH3P77wJ0eW45aUJrURhZ7nMQqn8KyqOQzzPns
 dTbm1F1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-785956825-1493824068=:3480
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Wed, 3 May 2017, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>

This commit message is a bit empty. How about:

=09In many places, Git warns about an inaccessible file after a
=09fopen() failed. To discern these cases from other cases where we
=09want to warn about inaccessible files, introduce a new helper
=09specifically to test whether fopen() failed because the current
=09user lacks the permission to open file in question.

> diff --git a/dir.c b/dir.c
> index f451bfa48c..8218a24962 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -745,8 +745,7 @@ static int add_excludes(const char *fname, const char=
 *base, int baselen,
> =20
>  =09fd =3D open(fname, O_RDONLY);
>  =09if (fd < 0 || fstat(fd, &st) < 0) {
> -=09=09if (errno !=3D ENOENT)
> -=09=09=09warn_on_inaccessible(fname);
> +=09=09warn_on_fopen_errors(fname);
>  =09=09if (0 <=3D fd)
>  =09=09=09close(fd);

I see you already converted one location. Why not simply fold all of them
into this patch? It's not like it would be easier to review those changes
if you separate patches addressing this class of problems.

Ciao,
Dscho
--8323329-785956825-1493824068=:3480--
