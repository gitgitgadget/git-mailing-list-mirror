Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 592151FB2E
	for <e@80x24.org>; Mon, 30 Jan 2017 16:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932397AbdA3QEH (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 11:04:07 -0500
Received: from mout.gmx.net ([212.227.17.21]:62362 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932363AbdA3QED (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 11:04:03 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MWwp6-1d1qdc0dr2-00W0Nt; Mon, 30
 Jan 2017 17:03:16 +0100
Date:   Mon, 30 Jan 2017 17:03:15 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] use SWAP macro
In-Reply-To: <187c2b39-40cf-7e07-b489-d40cdf5f9145@web.de>
Message-ID: <alpine.DEB.2.20.1701301702120.3469@virtualbox>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de> <187c2b39-40cf-7e07-b489-d40cdf5f9145@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-837412749-1485792196=:3469"
X-Provags-ID: V03:K0:FJ5IBy0QcfUxKwruJAMXhcF7A2b2Mlph7+3QJ/QyOAAW9EPtlT6
 CW1Mn2ksFYkY5MSKBBLWtWJ3lN/bWuKyG5e4cZJz4KuhBawqdYtoWKo88EIbU3Lccyt1Go3
 IJ7XcW8upvfgdXFuOuhsUWzVQltyEvaSYINWRAimt4ZaZzAomxvrw2KPNpTxD2UzVGGiii9
 +b8XwwUqNguwCLDSw6/ew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q8NDGWTODRU=:Hhq367y2q72BJkMQbUTdP5
 sC746uz6W7b4IgGN8Ep9BBE9jEfYzK9whdZ/MMMSw8ffcLKBRYhok2Jitauzvl0echQhYMdM7
 5D/CUrOkHU6UtA+no2YTu0IoLZnL9hhvJc4RRwqv+RHnkLWqoB3Rx1XWgpjHzZm9DniyZf78w
 5JLGkRQo5dbzo69N88y/Aaln+26B0SE2IMTzwdVgPUhmjdsj4SdgY9dgwAGNgeXnrerD9ec+Z
 8WX4X+NYYAHTOyMrh5uMkKaHpW+qgY81dWSkcEPlBwyqK6AF+UXNtsoeRvkBUzrpcu3SBDoDt
 vEiHzSV8ZlIZOu+xAFR5qJZ+dUaqUssZfcQ3NoZYvnTkbc6KyFY6b2X2TTzBjnp7pCHD9rQ7r
 ri00Q3jmwCfsl0oa5wq92ro5Z0oCuNujE+rSnMl4vOK0L5AsnKbshoVHorxDQcsxzrUfCQ1/B
 858m9mhMRB7nrYvgLw2PUA/pDzExTDlBxXC+wkO3sSiy1Mq26X3jWbElj7/oBFhL6x9laUrx9
 LxXgFl6xnpDHsMZxhhHK5wUUNDshUZtKsHpky6utsWe3MeYS/wP6/01z9p+PLNDNbw5P+BSv/
 9gS1JrhiVhuWfnqVOuLxJSkhG4c7cg3zjdwoCn1vNYcckHvYNP/5Drt2uacg8kt70GEoEjU4P
 o5dkTf3RovZv6LUz1FfZkNu6xh/p+FQoc5eH/AUU8uv6DKHV8YneQ3N0O5pV/eQvCRT2UZh5T
 3tdCjTca2mhU9uHpN/VU/4s5n195bEF79jXzYqsXzpDFAnXEWJPa+ELEEIXQ5VGT0jUhIFs7e
 q1Zjpr1Ow0cmdc4yFqLC9VGT3WUFnajTcqBcFgzDAs5hovOc3JysxAt3q71cNzyy0+qPZM6/s
 1Z54yYlw4DCV5HKQk8w0Z8BHgYC/a96kaEGsFmOtmIoSnHypZZjfrEFqRSYrrbKCXKdGY7YQB
 RK/8wsYS/x3/oaxqbIWUZSOJAWjDOqTpDVVZl87FC+ro+feR1O9/tsoPnhcLAHdqSi6Rxjjll
 SjJsaqfADBcb6LTdCNWlFd6mBBt7zjAuVnKpJe5+OFHA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-837412749-1485792196=:3469
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Sat, 28 Jan 2017, Ren=C3=A9 Scharfe wrote:

> diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
> index 806dd7a885..8ce00480cd 100644
> --- a/builtin/diff-tree.c
> +++ b/builtin/diff-tree.c
> @@ -147,9 +147,7 @@ int cmd_diff_tree(int argc, const char **argv, const =
char *prefix)
>  =09=09tree1 =3D opt->pending.objects[0].item;
>  =09=09tree2 =3D opt->pending.objects[1].item;
>  =09=09if (tree2->flags & UNINTERESTING) {
> -=09=09=09struct object *tmp =3D tree2;
> -=09=09=09tree2 =3D tree1;
> -=09=09=09tree1 =3D tmp;
> +=09=09=09SWAP(tree2, tree1);
>  =09=09}

Is there a way to transform away the curly braces for blocks that become
single-line blocks, too?

Ciao,
Dscho
--8323329-837412749-1485792196=:3469--
