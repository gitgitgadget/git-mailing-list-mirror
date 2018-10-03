Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F24C1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 20:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeJDDEW (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 23:04:22 -0400
Received: from mout.gmx.net ([212.227.15.18]:33043 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbeJDDEW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 23:04:22 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MDhGw-1fwF5C1CbW-00H9Ch; Wed, 03
 Oct 2018 22:14:24 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MDhGw-1fwF5C1CbW-00H9Ch; Wed, 03
 Oct 2018 22:14:24 +0200
Date:   Wed, 3 Oct 2018 22:14:28 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sequencer: use return value of oidset_insert()
In-Reply-To: <18bf2384-694c-f98b-1c31-3c80c07bde2a@web.de>
Message-ID: <nycvar.QRO.7.76.6.1810032213330.73@tvgsbejvaqbjf.bet>
References: <18bf2384-694c-f98b-1c31-3c80c07bde2a@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-825261742-1538597668=:73"
X-Provags-ID: V03:K1:bRbQXOW1BI9+t6jLg+LfcwYaJlQqppp2acvo+2CULqtdEsnL3tO
 0ZyxqbO5B1+TOtWjdAHyxAhNEB7tAsjNKh/Wefb4bwXkvRTUOltKkhjubJ7/q1XX/52SlEY
 9HqStYZV+n4QUvM224m9hM0EjSMdVRNFtsqXHZok0TbFKSMI9Aty9egpn2VDEmayPw4vvr+
 9kRU96hHTltqBQP+5ynLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ajGzWgzomEc=:LzGt9GIa+T70o8gGlF5zGQ
 xrsZ9OiAXLrSjrRDuO7rJUHs4irJfuVfwgqZoOl2w/fAdwZDjxo15bMVAiWVqVoRj8A9XWSEH
 AtztAbI5qualS8fe1jy7G0l8RyJelEkWUH6Tt8tuYMpMHuci1W51UqX3QnRNRAAXPRDuCc5FC
 NkNZFRMCIz9c/0hjehG0ZG+pmYAjxhwvELl2Hk9GCfV3ww2LwXs5aSXQ0t3qAHU4Gu/gWdQ+S
 7E2VuUwf5WR+dYXNGJCh5RrE8rZM6r6sfkrRZYoaj3Aw+VqRqIBnyH5eJzBNYePEPlgohylh3
 J5JNUN+l3Ux0SioRrRVQpo0HadBJX1SsB1GQmhe5XyO4H1loQJPQap453AqZ/4YE+DvelVUMI
 h9FRQmgJk3G4sFaQ5U3oJETKxQyaETscRcgOpKDPkODGkonHw/XxUh3HeyzdwyN8GCvKOaZVi
 dCSVR6U2vWGzCRredUmd8KUn3QmBwSedArHOAdwy9l+6LYCU4tmz0abf6b0I4Fftge+OH78+9
 CkzMNTeskthtd40REt2cjjHCBArbF+O5oEKnIS77mezazyk4g1Bn5gD1I2as8pIJ4FHsZBqeu
 IS3rMw9rAGw0+BKN+PO3T2800asb1d1m1RAxFSHplJ2ovaHanUYKLNqHQj5sxcmZbX2FHmHY2
 vQcZATcxgV9ySw1AZJVGnXruT210YOo1VkMqpNq/hnw2NICw/Nuwwc/GK0aqP8n2rJIDNluLM
 4457eN8TWpB5QPXKSPH2yCVdq4mO+r/kKIs/nE4E2z2kszOuqMamdj+ncDWl5YmI9QZMnC+8b
 zV1PyAnyH13ClgveKP6Y2Wsth/qcZvgK2N49Z4dvlz0m/2/P9E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-825261742-1538597668=:73
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Wed, 3 Oct 2018, Ren=C3=A9 Scharfe wrote:

> oidset_insert() returns 1 if the object ID is already in the set and
> doesn't add it again, or 0 if it hadn't been present.  Make use of that
> fact instead of checking with an extra oidset_contains() call.
>=20
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---

ACK!

Thanks,
Dscho

>  sequencer.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/sequencer.c b/sequencer.c
> index ddb41a62d9..6387c9ee6e 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4146,9 +4146,7 @@ static int make_script_with_merges(struct pretty_pr=
int_context *pp,
>  =09=09=09struct object_id *oid =3D &parent->item->object.oid;
>  =09=09=09if (!oidset_contains(&interesting, oid))
>  =09=09=09=09continue;
> -=09=09=09if (!oidset_contains(&child_seen, oid))
> -=09=09=09=09oidset_insert(&child_seen, oid);
> -=09=09=09else
> +=09=09=09if (oidset_insert(&child_seen, oid))
>  =09=09=09=09label_oid(oid, "branch-point", &state);
>  =09=09}
> =20
> --=20
> 2.19.0
>=20
--8323328-825261742-1538597668=:73--
