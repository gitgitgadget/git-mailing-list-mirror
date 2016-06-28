Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2A9C2018B
	for <e@80x24.org>; Tue, 28 Jun 2016 16:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbcF1QhR (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 12:37:17 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33369 "EHLO
	mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbcF1QhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 12:37:16 -0400
Received: by mail-qk0-f195.google.com with SMTP id n132so4541908qka.0
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 09:37:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=7q0/5/UuBjgeIrlbaZRXjZI/gYzhm0P4PAKzd1sjNec=;
        b=OyCT5C4Rfu8Uw+f/9twOKOepUOPpKZXIXtGm+QLJdNT9WPq9QdyY5Wip9v2p2CjfRg
         Lv4OMUcyQYiwEqd8dRk+2/DoM+masLnilYvR0GZZpsWBygzcj4l9iIlGrGfrtetDKNQV
         TkQZv19mBhS0N5tskBrJGyWWJ7d81WtnmFfrjxusaURTazCCuHy/ijTFwHQIiDsPXIfZ
         I7fzkOFvlwa2qVfcZxklWUM31EkvuaPRnEyimDEty9lTAH4IBmatPyepfm/PliQ5p5WM
         99fzRK1j5oA4DEX5+5R/41wD3HfxxgeHV/atQCIKRQeiQ7ygxSnNw2ChO4DGEDwLKvMO
         cyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=7q0/5/UuBjgeIrlbaZRXjZI/gYzhm0P4PAKzd1sjNec=;
        b=Z8GwdavfoiP43R0rt2wv6Xvq9G2X1O+4XyH7BDQEWQOQGX/gFwphOzspfOUeBY5OKV
         lCMilR7NDhctSeUsEUpUKGKzANNgo2qyNEzMztvidCnTgT/Elu2d+BvOQ3BHMG5ViEJd
         onnV+p3I+d4fs4KOWbO9lM9PuS4n9Is2/+KuRm/06Xgemx2y5lZRrxY1ZlgJByp5FvME
         qp3iljG/iSFHK9Q6Hq+iSp01JI8V+KsMNATV/TbBg4pbWzThpSwY8RQkyc7tO0TPbWDU
         jApw6mAu35XDjDBozCXkWFEajMNSWwvcXdghStz3Oi3+yj4aBvfsh+IMFg+UYLpvcEVX
         WD+Q==
X-Gm-Message-State: ALyK8tI2ii56nMKIeGub+WIRH65e9lkt/TGpHuufBwHOe2p7p0/Vfpmu9TL4X6tQjn4yejeLTEwXbBj8O+tYIQ==
X-Received: by 10.37.118.198 with SMTP id r189mr1251582ybc.80.1467131830265;
 Tue, 28 Jun 2016 09:37:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.251.71 with HTTP; Tue, 28 Jun 2016 09:36:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1606281822240.12947@virtualbox>
References: <16f3d3edb03c2cb9a6c11b745eda9fb2274af182.1467108142.git.johannes.schindelin@gmx.de>
 <xmqqinwt9v6e.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1606281822240.12947@virtualbox>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Tue, 28 Jun 2016 09:36:50 -0700
X-Google-Sender-Auth: GIUDr41yYLOTQIUeq1hFuKDorlE
Message-ID: <CAPc5daXVxNtx1HTYBToSds92X37Ns4yd3w2hxH08ocJLre8LrA@mail.gmail.com>
Subject: Re: [PATCH] Remove obsolete comment from color.h
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>, Karsten Blees <blees@dcon.de>,
	Stepan Kasal <kasal@ucw.cz>, Jeff King <peff@peff.net>,
	Lukas Fleischer <lfleischer@lfos.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 28, 2016 at 9:24 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Tue, 28 Jun 2016, Junio C Hamano wrote:
>>
>> So as long as we write via stdio to stdout/stderr, you can show
>> colors?  Or is it now stronger, in that as long as we do anything
>> that ends up writing to file descriptors 1 or 2, you can show
>> colors?
>
> Essentially, the caveat in color.h that one should use fprintf() and
> printf() when outputting color sequences to a terminal no longer holds
> true. fwrite() or write() work just as well.

In short, the answer is "the latter"? That is a great news. It means that
Lukas can use write(2) in the recv_sideband() patch to ensure atomicity,
without having to rely on the observed behaviour of fprintf(stderr, "%s", ...)
that as long as the output is within reasonable size the call seems to
result in a single write(2).

Thanks for a clarification.
