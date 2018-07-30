Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 677B01F597
	for <e@80x24.org>; Mon, 30 Jul 2018 15:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeG3RfL (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 13:35:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:56325 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbeG3RfL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 13:35:11 -0400
Received: from [192.168.0.129] ([37.201.193.26]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MF5C3-1flVE30zwx-00GLUe; Mon, 30
 Jul 2018 17:59:28 +0200
Date:   Mon, 30 Jul 2018 17:59:27 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 01/21] linear-assignment: a function to solve least-cost
 assignment problems
In-Reply-To: <20180728084652.GB2734@hank.intra.tgummerer.com>
Message-ID: <nycvar.QRO.7.76.6.1807301756170.10478@tvgsbejvaqbjf.bet>
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com> <f7e70689efcbeb8341c19fa3940c818142a2cddf.1532210683.git.gitgitgadget@gmail.com> <20180728084652.GB2734@hank.intra.tgummerer.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xvl8QBDUka9felA44u/VwOQW9rKenVja7Yg26qI6g2UOiCLAKuL
 /ELLR7YyvQhnhLh5qnocItCMLwc1UtClQeVvNG5Iy9LGvG05lZ2AgR3J3Y54V4bwrHE+P1p
 BdXJL48ubw8eyIa9BoTpy4E75XcukWYMyiXrVuip99scfr4ps79CQJ30945FonScwYdwQNt
 JozXtkzkH62Zv4BAD8CPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zD3tdDWz95s=:9W6Od3ff3UZgYzWqQf9oMw
 yl6PpGrEEoL+2wPl+mHxBeqJHclcftPpPjBQ5z5fupbhXw1+zv94SPI1BZl+088Rc0IIEJ1v2
 G99oeYbMCnDFL07xFodr5jUDP4Die3LGzrUK2WtZeVxYK+zjxuW5kX4G4a3ZDIdgB0jAqyMGT
 8hi/tOaXm+rPUIP+rNGS5kap65CGuimxayH/6SLyFAjUcHLqMEEc6qCvBNVy+GhbC/EJ6jXjA
 ewAsr3JEyjm0Jd9dCW5tE/qz9ZCZJ0DTbmBumoYA0LaNSYeXA2gmU+/n2X+yMcJeFzD0L24m1
 4hJJ4f0jpaXZ5ti1JGWxV1DbJPPQwSzosdj+4Da5nIQ4Uxe0xejPrTt0QxhYRm2KHHH/Gb7PT
 ezn/EcZb1grfYSC/dNhsW3mgaLIrFYAt4hac5MiOlmDTu5pe5Dz+BtrbhGGeKQ4bdMmrruooa
 3wt8QgGrNbXCzjB285fCzow/RIj3sX8u6AQ2nSqFUhpqS515i4TeOuoa+v9vmuuqkeDvHU+v2
 HDKHwc5SxImLtxJprWyHD6fm2sz/TbzHGRGY62oIIbgnmsPY5OIge5BX9iOv+SYwaQkt9zGGf
 wmzg4wgGMDAJp0oD+vJVTjHGpIeZi7ZgFT3ahY8JYF7Wx6PWaApNqB4ZBdvO6Vuh/RvRjNZEG
 HWJ36Oa7Ss+3oDJTsb24vJj1m+SccZVmooNccFmfsr49Jm0wd/1nVhDqZhKCb3gQBGSFGMDz6
 TW2eqebq8l8hED2azUdzlLmhezoUJ/fuArlGxRqyjbmP4GDnNLCm9sdGeHUIPDdS9qqAynHX5
 TW7msi6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Sat, 28 Jul 2018, Thomas Gummerer wrote:

> On 07/21, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > The problem solved by the code introduced in this commit goes like this:
> > given two sets of items, and a cost matrix which says how much it
> > "costs" to assign any given item of the first set to any given item of
> > the second, assign all items (except when the sets have different size)
> > in the cheapest way.
> > 
> > We use the Jonker-Volgenant algorithm to solve the assignment problem to
> > answer questions such as: given two different versions of a topic branch
> > (or iterations of a patch series), what is the best pairing of
> > commits/patches between the different versions?
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  Makefile            |   1 +
> >  linear-assignment.c | 201 ++++++++++++++++++++++++++++++++++++++++++++
> >  linear-assignment.h |  22 +++++
> >  3 files changed, 224 insertions(+)
> >  create mode 100644 linear-assignment.c
> >  create mode 100644 linear-assignment.h
> >
> > [...]
> > 
> > diff --git a/linear-assignment.h b/linear-assignment.h
> > new file mode 100644
> > index 000000000..fc4c502c8
> > --- /dev/null
> > +++ b/linear-assignment.h
> > @@ -0,0 +1,22 @@
> > +#ifndef HUNGARIAN_H
> > +#define HUNGARIAN_H
> 
> nit: maybe s/HUNGARIAN/LINEAR_ASSIGNMENT/ in the two lines above.

Makes sense.

Ciao,
Dscho

> 
> > +
> > +/*
> > + * Compute an assignment of columns -> rows (and vice versa) such that every
> > + * column is assigned to at most one row (and vice versa) minimizing the
> > + * overall cost.
> > + *
> > + * The parameter `cost` is the cost matrix: the cost to assign column j to row
> > + * i is `cost[j + column_count * i].
> > + *
> > + * The arrays column2row and row2column will be populated with the respective
> > + * assignments (-1 for unassigned, which can happen only if column_count !=
> > + * row_count).
> > + */
> > +void compute_assignment(int column_count, int row_count, int *cost,
> > +			int *column2row, int *row2column);
> > +
> > +/* The maximal cost in the cost matrix (to prevent integer overflows). */
> > +#define COST_MAX (1<<16)
> > +
> > +#endif
> > -- 
> > gitgitgadget
> > 
> 
