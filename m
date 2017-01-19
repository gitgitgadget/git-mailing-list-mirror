Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDD6C20C2E
	for <e@80x24.org>; Thu, 19 Jan 2017 00:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbdASAhr (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 19:37:47 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:33848 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751425AbdASAhq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 19:37:46 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 3227F1F89C;
        Thu, 19 Jan 2017 00:37:09 +0000 (UTC)
Date:   Thu, 19 Jan 2017 00:37:09 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Santiago Torres <santiago@nyu.edu>, meta@public-inbox.org,
        git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v6 4/6] builtin/tag: add --format argument for tag -v
Message-ID: <20170119003709.GA25782@dcvr>
References: <20170117233723.23897-1-santiago@nyu.edu>
 <20170117233723.23897-5-santiago@nyu.edu>
 <xmqqmvepb4oj.fsf@gitster.mtv.corp.google.com>
 <xmqqh94wb4y0.fsf@gitster.mtv.corp.google.com>
 <20170118182831.pkhqu2np3bh2puei@LykOS.localdomain>
 <xmqq4m0wb43w.fsf@gitster.mtv.corp.google.com>
 <20170118201644.GA13758@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170118201644.GA13758@starla>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > 
> >   http://public-inbox.org/git/20170118182831.pkhqu2np3bh2puei@LykOS.localdomain/
> 
> Eeep!  This looks like a regression I introduced when working
> around Richard Hansen's S/MIME mails the other week on git@vger:
>
>   https://public-inbox.org/meta/20170110222235.GB27356@dcvr/T/#u

Yep, I copied SUPER and used it improperly in a subclass.  Should be
fixed now, and reimported several messages from my Maildir.  NNTP
readers will see new article numbers for reimported Message-IDs.
