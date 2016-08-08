Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 497F91F859
	for <e@80x24.org>; Mon,  8 Aug 2016 08:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbcHHIjY (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 04:39:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:59676 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752513AbcHHIjW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 04:39:22 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LpcBS-1b3gOe1B5y-00fTZw; Mon, 08 Aug 2016 10:39:10
 +0200
Date:	Mon, 8 Aug 2016 10:39:08 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: use string_list_split() in add_strategies()
In-Reply-To: <57A4FEAF.3040208@web.de>
Message-ID: <alpine.DEB.2.20.1608081034250.5786@virtualbox>
References: <57A4FEAF.3040208@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-661579933-1470645550=:5786"
X-Provags-ID: V03:K0:FHEwMk8C/LZaxHQE/VvUO6tCDe0OaPMN6gsCfDzozs3B7QS7iiX
 G+lVrugq1IH4Mb7BV/LH71ulAGb6+jM+NeBSC9utBe6LFS9eSp3lxSfiMPw5yYEV5qWCwPw
 xJ+QejHkUozu+H5NIV7oWxp4Jsjwfk4hUAYUceNNvNjZ9s9qW50vgaeVmQTd1LQz7zqIiyW
 /9TezDDOyYT0hI5S/LtIQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:WagEvVFa9Hc=:1mc58gMWkCHz9F9VLbn/O3
 51UfpdonlvAS48QECQP98xa5RYfrMFih9CUMLyoDdOqs3SK3eyqZAETekYarGKWKwriMXTbH8
 hoKVz4e2VdYNe8GSbiDRnevFKmeKYbICOUowPLxTvPF4+DL5SyWpfpv4NBk0+EPIRgoDP1B/4
 uLyMtK4oqnwPAkTAY72jBAzIF/xAFquK8Uv2lBBcfsYiuztCcI5z8XN7S7LXP8wDELiRIn3V4
 kLPu0MoBCX76S8TQDvE5zBoWkb0JqqzxxoHwMoq/DyGUbrAXYYFjuPZmZQaL0PqlisyMkP94p
 uuaAs1+qLJhZptM4HF33jWVvBk0J0zNZC92RNtZAEPGxjwUU1XoMFS5o/1sOvGIohfAUrfC6E
 M9nZ/Y+lrNnSdMqVYaSURF15kL+n5+XbGsDj6oeXMuHd+mgrFEpgZl3rvFPo1AphwcHjP0G+E
 TkAWquy4XnjG/mVJKYYtTkIOJ9M6y3yTF8nxfifZanA4DSMVV4v3jkF2XANH00EKee3Ksg3gh
 n1nex4LGJI36dLnvo9CZW5DT/BOKCQTQ7mqLE+eA0KQap4v5a8oUFv+7kECfCIiMZ8eXGh5Bn
 OQN12/5v7tW9yHNjx8XjNJvEGfrxDQ/R5dyoWlby+Yz7kBtb2jeiVhXLQq/Pk1LmNeyS3vbJx
 TtQoD4a9doAP5H83hC+p7d//RZagvXsNJcyEvIeyyvTBjtmv+IVjbFzTBYEcgLMo4PrFzcOt9
 rMWUosIWSCPYApMDW/yZIZ5Ym2mUKTtNOe7CYfrUYyl82IjfiJWC2sNGxjbwRfBXLPKpwGjU5
 X8dMPQl
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-661579933-1470645550=:5786
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Fri, 5 Aug 2016, Ren=C3=A9 Scharfe wrote:

>  static void add_strategies(const char *string, unsigned attr)
>  {
> -=09struct strategy *list =3D NULL;
> -=09int list_alloc =3D 0, list_nr =3D 0, i;
> -
> -=09memset(&list, 0, sizeof(list));
> -=09split_merge_strategies(string, &list, &list_nr, &list_alloc);
> -=09if (list) {
> -=09=09for (i =3D 0; i < list_nr; i++)
> -=09=09=09append_strategy(get_strategy(list[i].name));
> +=09int i;
> +
> +=09if (string) {
> +=09=09struct string_list list =3D STRING_LIST_INIT_DUP;
> +=09=09struct string_list_item *item;
> +=09=09string_list_split(&list, string, ' ', -1);
> +=09=09for_each_string_list_item(item, &list)
> +=09=09=09append_strategy(get_strategy(item->string));
> +=09=09string_list_clear(&list, 0);
>  =09=09return;
>  =09}

A nice code reduction!

I wonder, however, if we could somhow turn things around by introducing
something like

=09split_and_do_for_each(item_p, length, string, delimiter)
=09=09... <do something with item_p and length> ...

that both string_list_split() *and* add_strategies() could use? We would
then be able to avoid allocating the list and duplicating the items in the
latter case.

Ciao,
Dscho
--8323329-661579933-1470645550=:5786--
