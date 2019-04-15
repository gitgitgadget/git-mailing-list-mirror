Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2432420248
	for <e@80x24.org>; Mon, 15 Apr 2019 13:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfDONBt (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 09:01:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:35421 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbfDONBt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 09:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555333301;
        bh=4UKGfdwcFk1TEXoHsO5dZzeEuOQkf1k5lQpufoiaV+4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hwt1JOVUvMivDZCdSCJW1F2+hYWQ6TDIF463RUSXD8zxU4w7WP2hX9Mx1ZQjGsdRS
         NA8qFOoGyj3D9P6YgFeHDxzn+kDgpENKOH5iAs2ZoP1msaklCdQ9pvBFrDejky0s50
         6ImeK1/fZZ7biKIzVISxWazmXAVdAhyfV6NxwJdA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MDm4o-1h4XIx2d70-00H6mr; Mon, 15
 Apr 2019 15:01:41 +0200
Date:   Mon, 15 Apr 2019 15:01:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 3/4] range-diff: add section header instead of diff
 header
In-Reply-To: <CAPig+cTJyYLGAfHM_PrZd9DDaZBcVUetcWFcANGCYPvaMh2qxA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904151457310.44@tvgsbejvaqbjf.bet>
References: <20190411220532.GG32487@hank.intra.tgummerer.com> <20190414210933.20875-1-t.gummerer@gmail.com> <20190414210933.20875-4-t.gummerer@gmail.com> <CAPig+cTJyYLGAfHM_PrZd9DDaZBcVUetcWFcANGCYPvaMh2qxA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:U9/muHAydROKRdlA7/7I1RXSCSUv/VoRGO3l+U9rE5u0pjYyCbg
 +pGGmkYQ/ZUn2IFwlHrozVCK7gibEMgMnlPPBUMRIHDFvqtHJF8+tniGYRkXevKfmv0c1EC
 +NSCpeOVB6DZB8KSJK5OHi+4pLm16OrVME45HAGOJn6uSgGPCF+LKUvNUnB8Y13ZtScxuIC
 4aY3jovPv+jCvh5M7TEPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:arRlBwJnxXE=:eUGCn34SbtMOat+P/jueQ0
 Gu6cSpiL8G0pu8xSItRc5Lg+KRv0g/SRrM0AVYxuxwG38trKi6hz1VIwTKMMaknAcnXe7AlpO
 Ig/C09nMR8tf+MJ6JQ5FOyln9r05+juXzvriSk6bEFfneEVIBvT2OVCfg+dBWutY2TIRifiTo
 JRVRbCo+vPxkpWFfT6Jn/V/rJ01bK52n8C3sloJTEvoZQwZzMc6mYy8Q/LE/kbwkYPgV9P6yh
 FuRqaWSBQgiNodRWzF1IYasaOktFecMGs9wqtllFSTqkNQBYGz5mCCBGTHyI5D+blKK/xgpwn
 ydBlE/7X1BA8FwvNdZLpQRFFdq1vxUWl0jeNqTkyVLD7yxiy8LnqcMPLqOtUNcEnxTEDeoQB2
 MrAIQ5ID6EaGnxde6jyfwZW2mfZITyH/ToBt7mztrpSG+39EwaBqjWpdM4RpnduYwzm9B+bY1
 gdq8KtoJqG2dBsoSv2Re8++ymvgxW5OUSeseT9u/nuOqIuL27AeqIcd4elezRLoYcgUn7nRAa
 WF53juj7ke0xvEC2GDGPk8q38AK9iLI4sBntectsO4rjeTaw///AtKKpEZWSKYRxZa8DOQb2f
 6IrU/y1Bqp0CH/EjM4c3Nkso+PvD59bJR4Hx/K+GRlEzO5+6rpM4sPf7+d/o/ueqH8ex10vXr
 1y5AYKm4fYtjeKHNSHUcguvPfZgXgjqtX1/faEuya2+3RGj/aEWFka9IUTZut/5sIXGI180Fa
 ly7yVl/d5pJvRtmuzeMVOIYTy1DXm6ILpSJyO7PN0kWyOaTjpZxk1Isi0Mktv0AqXfzVVXgWk
 Jks4wa32Zop00CwlywG3IBh/4PRejIJBDVxwMPVsBulpJEbiBH85aSof8o6QXhf0OkS20laaN
 6XwSL6tcPYCNNroI2s8j5Tsu1R80630zb6jM+qRzkXEq5HD9RGUoE4WI3XI8KMwBeClPSZGcP
 6oENRD3LYzw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Sun, 14 Apr 2019, Eric Sunshine wrote:

> On Sun, Apr 14, 2019 at 5:10 PM Thomas Gummerer <t.gummerer@gmail.com> w=
rote:
> > [...]
> > Introduce a new range diff hunk header, that's enclosed by "##",
> > similar to how line numbers in diff hunks are enclosed by "@@", and
> > give human readable information of what exactly happened to the file,
> > including the file name.
> > [...]
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> > diff --git a/range-diff.c b/range-diff.c
> > @@ -90,8 +91,37 @@ static int read_patches(const char *range, struct s=
tring_list *list)
> > +               } else if (starts_with(line.buf, "--- ")) {
> > +                       if (!strcmp(line.buf, "--- /dev/null"))
> > +                               strbuf_remove(&line, 0, 4);
> > +                       else
> > +                               strbuf_remove(&line, 0, 6);
> > +                       strbuf_rtrim(&line);
> > +                       strbuf_reset(&filename_a);
> > +                       strbuf_addbuf(&filename_a, &line);
> > +               } else if (starts_with(line.buf, "+++ ")) {
>
> At this point, we know that line.buf starts with "+++"...
>
> > +                       strbuf_addstr(&buf, " ## ");
> > +                       if (!strcmp(line.buf, "--- /dev/null"))
>
> so, it seems unlikely that it's ever going to match "--- /dev/null".
>
> > +                               strbuf_remove(&line, 0, 4);
> > +                       if (!strcmp(filename_a.buf, "/dev/null")) {
> > +                               strbuf_addstr(&buf, "new file ");
> > +                               strbuf_addbuf(&buf, &line);
> > +                       } else if (!strcmp(line.buf, "/dev/null")) {
> > +                               strbuf_addstr(&buf, "removed file ");
> > +                               strbuf_addbuf(&buf, &line);
> > +                       } else if (strbuf_cmp(&filename_a, &line)) {
> > +                               strbuf_addstr(&buf, "renamed file ");
> > +                               strbuf_addbuf(&buf, &filename_a);
> > +                               strbuf_addstr(&buf, " -> ");
> > +                               strbuf_addbuf(&buf, &line);
> > +                       } else {
> > +                               strbuf_addstr(&buf, "modified file ");
> > +                               strbuf_addbuf(&buf, &line);
> > +                       }
>
> All of these disposition strings end with "file", which seems
> redundant. Short and sweet "new", "removed", "renamed", "modified"
> provide just as much useful information.
>
> Also, should these strings be localizable?

I'd rather not.

> Alternately, rather than using prose to describe the disposition,
> perhaps do so symbolically (thus universally), say with "+", "-", "->",
> "*" (or ""), respectively?

Or maybe streamline the common case (modified) by *not* saying anything,
then? I.e.

	@@ Documentation/Makefile

for a modified file,

	@@ builtin/psuh.c (new)

for a new file,

	@@ git-add--interactive.perl (deleted)

for a removed one, and

	@@ builtin/serve.c -> t/helper/test-serve-v2.c

for a renamed one.

That should also give us a bit of wiggle room to append the function name
part of the inner hunk header, if any.

Ciao,
Dscho
