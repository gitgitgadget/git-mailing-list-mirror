Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A4BF1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 19:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeDXTEd (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 15:04:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:42371 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751095AbeDXTEc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 15:04:32 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LhwAY-1efmoM0pSU-00nCR7; Tue, 24
 Apr 2018 21:04:24 +0200
Date:   Tue, 24 Apr 2018 21:04:17 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 05/11] replace: introduce --convert-graft-file
In-Reply-To: <CAPig+cTDbTtUeFYmkNtM773EBgE14Tpic4g4XEFuSVwSypdMjw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804242103590.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524262793.git.johannes.schindelin@gmx.de> <cover.1524303776.git.johannes.schindelin@gmx.de> <fd4ea54ad8da5e4e93fafd558e104b0a19f6268c.1524303776.git.johannes.schindelin@gmx.de>
 <CAPig+cTDbTtUeFYmkNtM773EBgE14Tpic4g4XEFuSVwSypdMjw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VDRrk6wkE/9X6S2+204Uh9cVlX9OsL27vtfcfm3syVAZdaBD9aJ
 Qcv+0sHVFn6S2Tpo5sFrBRjEWV/9b/Xn0QtECLXEg+uzol9rdoyyrWu+PImHAV6wE8vztf9
 O4H9GD/JB5jRg5Zj2SccgCRNRuuVhrHTbEPHCn25M2+laoHv3FH5brVRJicPSVqDDrHX2nh
 g9BZuSdLy6vp+04wyDd+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RSQyfvof4rk=:Jt+F5CRi5M0uMUgx4ybVWY
 1CL+9tc2JGJKWJYW1+b03/wBp7bGmPAgdG+RGPhUN1cnWOF3MAiSVNoNUgT0DxXUl43/unK74
 K9H4uSMKc6MgEn8EvAWtTBOHDHfqp5dZ/p7QFHc0x8AkPQ7m1BX36/L4p2fN657IgNwmZCUty
 ldCq92l3qIONU80mD/HJW5VwJT1c+vqJlvc3jxHwiLTW/brGNSAJ+6lIFrnyeePZ8L5JcEwRc
 zfm+mIXe+/27A0YkvaKDJEOFVUwKCnqp4Wpi4UZ4SGH39IRoHA6jz0u5ZJzwgKiGd0vrDcQGU
 okEWxYzKJhbG6qJ+iQCKdTpAOT0dUYDyjdVA0PESWxzd0ApEXrgKXx3CqUEwpVE0WIEZX5P5h
 HXUXcFW6Px2jWYdNBR7u2cl2us8pQjcxOamzL2AHWYdAmfxjvUY0uhpn8i3nxiH/RhNVyn6GY
 RquRofN2F/GV11OwfEKC7ximt0ZYW/z5pkxlti63I6nnZ8moEHSCppr2MhnsfDghnCfMc07MN
 WYmwGY5NMn0Yn+VfJLGl2cpPo1c+oEGEhFJEdc38HPzHqRwZEHv4G6cTcoN0DGACQVv+7f0EK
 Zrb9p1CtESrBlH8r8uQ9c+IUdy/NkkwyL3Mw/uk7XKdFbvpxD9+qUEeKVCC8b/IOh76VuzjSg
 fzxxuumq57KCYNb5/OSMuK+bxQKKMjx8DyJsSK3nckHVDJ4PoH4xir5bhEo98eFn6pIUABT+N
 ZEvK619VObQcShlq1rOoOrNtFsNp+hSH3ZJI8Lj3blvBjtNfg6gmnhSH6Lou1fr7AlvuAt9nZ
 186U546RE6T43R22yCHBD5mUpvvPZk+zFhppsfbVTjQ/N/xa2w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Sat, 21 Apr 2018, Eric Sunshine wrote:

> On Sat, Apr 21, 2018 at 5:48 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > This option is intended to help with the transition away from the
> > now-deprecated graft file.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/builtin/replace.c b/builtin/replace.c
> > @@ -454,6 +455,38 @@ static int create_graft(int argc, const char **argv, int force)
> > +static int convert_graft_file(int force)
> > +{
> > +       const char *graft_file = get_graft_file();
> > +       FILE *fp = fopen_or_warn(graft_file, "r");
> > +       struct strbuf buf = STRBUF_INIT, err = STRBUF_INIT;
> > +       struct argv_array args = ARGV_ARRAY_INIT;
> > +
> > +       if (!fp)
> > +               return -1;
> > +
> > +       while (strbuf_getline(&buf, fp) != EOF) {
> > +               if (*buf.buf == '#')
> > +                       continue;
> > +
> > +               argv_array_split(&args, buf.buf);
> > +               if (args.argc && create_graft(args.argc, args.argv, force))
> > +                       strbuf_addf(&err, "\n\t%s", buf.buf);
> > +               argv_array_clear(&args);
> > +       }
> > +
> > +       strbuf_release(&buf);
> > +       argv_array_clear(&args);
> 
> This argv_array_clear() is redundant, isn't it?

It sure is!

Thank you for the review,
Dscho
