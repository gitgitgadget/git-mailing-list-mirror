Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98D821F4C1
	for <e@80x24.org>; Wed, 23 Oct 2019 10:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390978AbfJWKGP (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 06:06:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45134 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390892AbfJWKGP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 06:06:15 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 3A58F1F4C0;
        Wed, 23 Oct 2019 10:06:15 +0000 (UTC)
Date:   Wed, 23 Oct 2019 10:06:14 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [RFC/WIP] range-diff: show old/new blob OIDs in comments
Message-ID: <20191023100614.GA2645@dcvr>
References: <20191017121045.GA15364@dcvr>
 <nycvar.QRO.7.76.6.1910222111430.46@tvgsbejvaqbjf.bet>
 <20191023015629.GA15495@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191023015629.GA15495@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > I guess your patch won't hurt.
> 
> Cool, will update tests and resend.

Turns out the t3206 "trivial reordering" case is way too noisy.
I might need to change diff.c to support this case; will update
in a few days or week.
