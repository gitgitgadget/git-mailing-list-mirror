Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E47A11F744
	for <e@80x24.org>; Thu, 30 Jun 2016 08:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbcF3Il1 (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 04:41:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:51835 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932133AbcF3IlV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 04:41:21 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MTBLi-1arYlN0b7W-00S5f9; Thu, 30 Jun 2016 10:41:03
 +0200
Date:	Thu, 30 Jun 2016 10:41:00 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Eric Sunshine <sunshine@sunshineco.com>
cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] Report bugs consistently
In-Reply-To: <CAPig+cSHy=2VaNP5gpwqKN4vuCBrOUy39L0i9xcda8m3zx+GPA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1606301040470.12947@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <8615dc276828a3f99a27ff2eda9909548a7d435e.1467199553.git.johannes.schindelin@gmx.de> <CAPig+cSHy=2VaNP5gpwqKN4vuCBrOUy39L0i9xcda8m3zx+GPA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sjl6MuWLwdqR3+V0KMYVIbiji0NsLnYvbkwxV6g02e0uY/pHYQh
 FXWjgDDbp1sk2/dkvztlD4dMe4ZxqG4OVB9nRBz8YQYXCq9FG1WRDK7jRYpZRQUvTcmqDvF
 kkD8NtKqHMTCuF6NTRpqIpe/tCi28ZIY7+1BIzfHmxCDBCu1uj9K5lH5psU2Ey8Vae97DZ0
 90JMA3qPt2svgkIbPkt4Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:QNfOucHHPZk=:vy9mY3s+FnSmO9dBevOxjk
 8dnBSur24G6JmiACdSdt4xFN21bWRP0DD6Yq3MAz5w0oo7uauSe47uSG1dJx8v/u8kA3R5KsT
 wxjbX2zpZIyzWXftEyvq1XtWwxn08mn2X7b5NMo1qkd6zDJo3f700ZrE+A8df6C5AIx4J7XDC
 9hqmDnbnEuFWYH+FiTqIPz2O0GXWyMOEBnh0Co2D2JvJrWaZ3E6+G3ylDLRPE5DMgqJCZ9W19
 Y8LLQLWRd4VN4toiWj6Yc3bygFLN+lBD4TkSr+yR2va0FuFrGsip+Sil1ULD3MnfuCtBoAwgk
 uG37qCeARGg1iWXOX+zc0sbGPc+N+9GmMDI1fjWdFo/zi2GHIxXeRg4vxDmeNnJoqh9OWRH9T
 s9Zq5sUpTcxV2EfHzXkJdn2ocG/43+ByNlgUeZ7cVCVAHajH6fgT6x+wrdJJZJSPEnR9a8iSK
 MvoNZt8E+m4q2N3Jkpn5gtneCEuiylJdIWUfgbTQhShn3wwm5jrBwft1QYlZDKqfoqRGEOITh
 wyO2Uy+niVXAljaPs6RYQYx27J/eXRBYGidbHlnMvDq6UY8GSTYkTrrt1kEeVppdNF1d4oYHS
 zE617apjzk/KUPq2HeQqauSLTfwKM59NWOxzk/h31+BAHOFNmeD3Hj4nNiJVtY/yhzZtItgxf
 p11nhy5CQJ6RR83QXMuR9zgpv8tpSDyOknZA6XmumoGnRpWiCg+kvcIeNRdQi+cIwGYX9DGXx
 9NuqQ6QxDGArnFJ2pHXBnhgpwzo5QFIVFaD2gMg9q86g2NcR5LGlYkRzP6Ox1aDwhFgAqgHJY
 G49hu/7
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Eric,

On Wed, 29 Jun 2016, Eric Sunshine wrote:

> On Wed, Jun 29, 2016 at 7:36 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > The vast majority of error messages in Git's source code which report a
> > bug use the convention to prefix the message with "BUG:".
> > [...]
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > @@ -1853,7 +1852,7 @@ int merge_trees(struct merge_options *o,
> > -                               die(_("Unprocessed path??? %s"),
> > +                               die(_("BUG: unprocessed path??? %s"),
> 
> This and others downcase the first word (which is consistent with
> modern practice)...
> 
> > diff --git a/sha1_file.c b/sha1_file.c
> > @@ -795,7 +795,7 @@ void close_all_packs(void)
> > -                       die("BUG! Want to close pack marked 'do-not-close'");
> > +                       die("BUG: Want to close pack marked 'do-not-close'");
> 
> ...but this one neglects to.

Thanks! Will be fixed as part of v2.

Ciao,
Dscho
