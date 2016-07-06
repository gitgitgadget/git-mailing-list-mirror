Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DFAB20705
	for <e@80x24.org>; Wed,  6 Jul 2016 07:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbcGFHGF (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 03:06:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:58405 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149AbcGFHGD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 03:06:03 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Meg8W-1awZP50POa-00OE6H; Wed, 06 Jul 2016 09:05:27
 +0200
Date:	Wed, 6 Jul 2016 09:01:30 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jacob Keller <jacob.keller@gmail.com>
cc:	Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revert: clarify seemingly bogus OPT_END repetition
In-Reply-To: <CA+P7+xqODaXn2NFY-=Ktr1stzR1mu6_ZO7Lfgj7AEzhzxhLAbw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607060857240.6426@virtualbox>
References: <5b424bad41ca027b39eea4b1fa9d87df0a489e0f.1467719888.git.johannes.schindelin@gmx.de> <20160705202820.GA14496@sigill.intra.peff.net> <20160705204447.GB14496@sigill.intra.peff.net>
 <CA+P7+xqODaXn2NFY-=Ktr1stzR1mu6_ZO7Lfgj7AEzhzxhLAbw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KF86+FyGrzaD057zEVffCMtWEc8lU0QdwsUOJBHuXxqX3p6Je2T
 CocA9zR+UVg86TIoTx04aXkqfeeZ45Js1asZl2Z/NrEbMiYn81OG0hO8xsSL6aTaqIFhWLP
 xLLgIgvVgotEg1l/jelGA2iSe25nSs5oeRat4skCyJ2yqe2TJDxkNzcW7VAdB4wf/sjl4IU
 q2MGY1q4FVpP7la2r9U3Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:RAbvzm+l86k=:fmVAa1iyzyavGEv7SerAFz
 jG40Ec+EBCPrlaDHtUOjVcyE+qqpYN++E+Ajh0k5wc4a7bW8h5kvqENpG+jksNp77AqS3h8oJ
 sXK9QC8QGVbubuFkHq7R3viBvhLJ7QnraERjeJcJfErk1Ev5LPsofUPPcsyOehxeLECoa5PFM
 cujFvCKa9YGHTnN6Is0SHf14v3HofcE/YI4WK3ODdEG+5JoAvL7CfuYYsraW1KhknMb1Pv89v
 CnzanVTlpdnkOeiudvZAkKVCKHY9DpUJ3V9kjzMldav1Qd2tR7MMsNzSfiiY2f6a8AS83fzTA
 1AwG5aM3sShhtqIrph/pmvqPU3dy+yC0XQ9Rf/b8G1MaGmjMhDIiYxKkvn1jxu3d9hLeGXXM9
 0arU1xy+AK19n3YlL+59flkQNlAD1M9fVrzhVgH96Ik8UM68Yfy3ouQRlGSMaddml0seWUbo0
 Qq5/BkTiWMt4DS7bRMW6q4PZvfvI8EDIoBiu71C4vvFDcULYEYK4jM78TKTPUywa3t+yA4EK6
 2EExOMwpSNwybdlKkEodFQywZ5fIB4AYiOGGRRNR9bevf5Hmaevgben3SPioQ7ndHM0AkNwUP
 YSCQujKEfabTvtUJTnkHynMKbTI1SQe8YrKzPLaxLwAQzo5Gr0Ll23LI2rvKE5QxwWEtKKmMe
 4LT+Vhl+OnmRlcvSrXJB6WHtC8aFHlKsGcowhdiSK8Q/M1MpfDrA2TKsdQ+oNN8jhpRw9Q7dY
 3ZWS86OHA148+SMb36RXxMJQRvrXm6/SwHEcnquNE3zhFPSyPtyELEV9fO3ijRYvJ6dGdzqNY
 qeAR53P
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff & Jacob,

On Tue, 5 Jul 2016, Jacob Keller wrote:

> On Tue, Jul 5, 2016 at 1:44 PM, Jeff King <peff@peff.net> wrote:
> > On Tue, Jul 05, 2016 at 04:28:20PM -0400, Jeff King wrote:
> >
> > Something like the patch below.
> >
> > I admit this isn't buggy _now_, so this is potentially just churn. It
> > does make further patches look nicer, though (they don't have to add
> > apparently meaningless OPT_END() slots).
> >
> > -- >8 --
> > Subject: [PATCH] parse_options: allocate a new array when concatenating
> >
> > In exactly one callers (builtin/revert.c), we build up the
> > options list dynamically from multiple arrays. We do so by
> > manually inserting "filler" entries into one array, and then
> > copying the other array into the allocated space.
> >
> > This is tedious and error-prone, as you have to adjust the
> > filler any time the second array is modified (although we do
> > at least check and die() when the counts do not match up).
> >
> > Instead, let's just allocate a new array.
> 
> This seems much preferable to me.

Yes, this is better than my patch.

BTW Jacob, would you terribly mind cutting the quoted parts properly (I
cut 112 lines)? It may not seem like much, but I seem to spend more and
more of my email time budget on skimming unaddressed remainders of quoted
mails, and I would much rather spend that time on something productive.

Thanks,
Johannes
