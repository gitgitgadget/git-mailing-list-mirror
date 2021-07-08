Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5075C07E95
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 01:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B297261CC4
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 01:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhGHBR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 21:17:28 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33310 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230106AbhGHBR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 21:17:27 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id B5E621F8C6;
        Thu,  8 Jul 2021 01:14:46 +0000 (UTC)
Date:   Thu, 8 Jul 2021 01:14:46 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 1/5] speed up alt_odb_usable() with many alternates
Message-ID: <20210708011446.GA15899@dcvr>
References: <20210629205305.7100-1-e@80x24.org>
 <20210707231019.14738-2-e@80x24.org>
 <xmqq8s2hd5ay.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8s2hd5ay.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> > v3: Introduce and use fspatheq and fspathhash functions;
> >     avoid unnecessary checks for allocation failures already
> >     handled by our own *alloc wrappers.
> 
> The last one does not belong to the commit log message, as "git log"
> readers do not care about and will not have access to v2 and earlier.

Oops :x  Are you going to remove that on your end or do you want a resend?
Looking at "git log", it looks like I've done it a bit over the years :x
