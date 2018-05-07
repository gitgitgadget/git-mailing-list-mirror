Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E432200B9
	for <e@80x24.org>; Mon,  7 May 2018 01:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbeEGByu (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 21:54:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:45603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751444AbeEGByt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 21:54:49 -0400
Received: from [10.40.94.26] ([209.226.201.248]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0McmS9-1exhMO22kb-00I0eJ; Mon, 07
 May 2018 03:54:41 +0200
Date:   Sun, 6 May 2018 21:54:36 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 07/18] branch-diff: indent the diffs just like
 tbdiff
In-Reply-To: <CAN0heSoLD0O9owCDEU5ZHje3zNDLAS_43atb75Te7KOFoS_dtA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805062154030.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <c856c460a47dbe885bbb82babc6be6848d31ed32.1525448066.git.johannes.schindelin@gmx.de>
 <CAN0heSoLD0O9owCDEU5ZHje3zNDLAS_43atb75Te7KOFoS_dtA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1995257847-1525658081=:77"
X-Provags-ID: V03:K1:vLFcF9QWyNL6+VgTmb5TKhJCbyFRHvMGDdOgQU1s5OLkd28saJb
 T2OCK0lPJy0m6WZkGBBgw5d5Yl2osWGmdWaZ/ByRYPqtYxIGkcd4eaEfKr/Rdffu+XG27ZN
 WVsaHoj1PX3z9bENDPa1PHhxeqRk2Z4W5OLpN0svjTDoR+216IpZZmEmoqu2n5umE3s3FCm
 MPA04AK2/OtV9ovgDzoQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5BnjlxG0ayY=:E6h+bmwq8IMZj+EJaLYkta
 ScPf7HxLfI/J5F/oS0U5K51jq9QPajBJ6NRtORRzBuF/34fP9Ww1ZB3xxv2BQzoblqvOvP2DD
 1AdLqhEESX6rvcGfCFFYFBC4Pa3TrenlDJ6NSsifdiOoTlbZMQQtyeBXQWFTrZXv7nYkD7VkV
 zfROzsqjz78aBHv45IxzaLpUhDdjCbLUrU0y/SiFmVMrVKDYi/JHhvhH4xWZ/6vNx8IUpnJcP
 EQPM0qpojel/Cv6tEMyCJ5qxAG4xYdykajHIuGREJw/OOzswQvSwh9HAmQZLFUN8WuKEoQq8V
 DV+AtJkeDGMWbjA1a//V5Ygpz9wXiOi1SYd7uIjYGFg7WujYkC+0M5/DJqPZPlVAI72gXzIT1
 QtIRaPi4v2YLcY2tOEfaHsYxUa61F47CXXPJQwgAthH5lCJ2cdTQ0hxzu8rsFd9S4ZVOio7MU
 bUzSvX8DXqqkr9ffPR2C64jBuLjHLsx9kRp72gPOsu2Aa3ht9VlKGCaWZUDYb7acIInGi3Q8M
 YgZOsMGL+Y4uG87u8jLhGkzoTjIIYnuXyXiSuc4WFCRtbXbDIYYE4SqqPLbFdobVMNW6H8Q6j
 iStGD7yPgf6Rxn0L1m+qzxxQpQswEtv4S6yWYmH5I577piOQnNocqAUUvrRz4fmdii1Mdp4nE
 3SeyHv834vL+HyVtLKHtr1Tl/p4HpO1yBPahoKJtKqCB8B+mPtiV/5DHp2R0LE0SEy99gAQsM
 uyb9VZ0vrVU5briip4Zs7/lns5n60G3qJV9w4Sg54QJXpNIrmTQLKz54lqSkhKYaiPcQ7ldzM
 27EHnJe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1995257847-1525658081=:77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Martin,

On Sun, 6 May 2018, Martin =C3=85gren wrote:

> On 4 May 2018 at 17:34, Johannes Schindelin <johannes.schindelin@gmx.de> =
wrote:
> > @@ -353,6 +358,7 @@ static void output(struct string_list *a, struct st=
ring_list *b,
> >  int cmd_branch_diff(int argc, const char **argv, const char *prefix)
> >  {
> >         struct diff_options diffopt =3D { NULL };
> > +       struct strbuf four_spaces =3D STRBUF_INIT;
> >         double creation_weight =3D 0.6;
> >         struct option options[] =3D {
> >                 OPT_SET_INT(0, "no-patches", &diffopt.output_format,
> > @@ -371,6 +377,9 @@ int cmd_branch_diff(int argc, const char **argv, co=
nst char *prefix)
> >
> >         diff_setup(&diffopt);
> >         diffopt.output_format =3D DIFF_FORMAT_PATCH;
> > +       diffopt.output_prefix =3D output_prefix_cb;
> > +       strbuf_addstr(&four_spaces, "    ");
> > +       diffopt.output_prefix_data =3D &four_spaces;
> >
> >         argc =3D parse_options(argc, argv, NULL, options,
> >                         builtin_branch_diff_usage, PARSE_OPT_KEEP_UNKNO=
WN);
>=20
> You end up leaking the buffer of `four_spaces`. Granted, that's not a
> big memory leak, but still. ;-) This was the only leak that
> LeakSanitizer found in v2 when running the new test-script and playing
> around with this a bit. This looks really good!

Good point. Fixed.
Dscho
--8323328-1995257847-1525658081=:77--
