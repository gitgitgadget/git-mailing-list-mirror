Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E09951F829
	for <e@80x24.org>; Wed,  3 May 2017 16:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbdECQiv convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 3 May 2017 12:38:51 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:54137 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751796AbdECQit (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 12:38:49 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTPS id 5273820041F;
        Wed,  3 May 2017 18:38:46 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, worldhello.net@gmail.com
Subject: Re: [PATCH] i18n: remove i18n from tag reflog message
Date:   Wed, 03 May 2017 18:38:45 +0200
Message-ID: <2070499.EYhsb04HyH@cayenne>
User-Agent: KMail/5.2.3 (Linux/4.9.0-2-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <xmqqwpa1ic4e.fsf@gitster.mtv.corp.google.com>
References: <20170429100253.4710-1-jn.avila@free.fr> <xmqqwpa1ic4e.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le dimanche 30 avril 2017, 18:45:05 CEST Junio C Hamano a écrit :
> Jean-Noel Avila <jn.avila@free.fr> writes:
> > The building of the reflog message is using strbuf, which is not
> > friendly with internationalization frameworks. No other reflog
> > messages are translated right now and switching all the messages to
> > i18n would require a major rework of the way the messages are built.
> 
> Thanks for spotting.  Before we declare that reflog messages are for
> i18n, we'd need to either drop (or redesign the implementation of)
> the "checkout -" feature, which relies on the exact phrasing of how
> reflog entries from "git checkout" looks like.
> 
> Will queue and merge down to 'master' quickly.
> 

I didn't know this "side effect". Maybe adding a test against it would be 
requiered. Unfortunately, I don't know enough of it.
