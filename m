Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6483D215FF
	for <e@80x24.org>; Wed, 18 Jan 2017 20:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbdARUQr (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 15:16:47 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:46058 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750890AbdARUQp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 15:16:45 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 3E9311F89C;
        Wed, 18 Jan 2017 20:16:44 +0000 (UTC)
Date:   Wed, 18 Jan 2017 20:16:44 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Santiago Torres <santiago@nyu.edu>, meta@public-inbox.org,
        git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v6 4/6] builtin/tag: add --format argument for tag -v
Message-ID: <20170118201644.GA13758@starla>
References: <20170117233723.23897-1-santiago@nyu.edu>
 <20170117233723.23897-5-santiago@nyu.edu>
 <xmqqmvepb4oj.fsf@gitster.mtv.corp.google.com>
 <xmqqh94wb4y0.fsf@gitster.mtv.corp.google.com>
 <20170118182831.pkhqu2np3bh2puei@LykOS.localdomain>
 <xmqq4m0wb43w.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4m0wb43w.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Santiago Torres <santiago@nyu.edu> writes:
> 
> <<nothing>>???
> 
> Eric, I've noticed that this message
> 
>   http://public-inbox.org/git/20170118182831.pkhqu2np3bh2puei@LykOS.localdomain/
> 
> and all messages from Santiago appear empty when they come via
> public-inbox.org; the reason I suspect we haven't heard much
> complaints is because nobody else around here sends multipart/signed
> disposition inline other than Santiago.

Eeep!  This looks like a regression I introduced when working
around Richard Hansen's S/MIME mails the other week on git@vger:

  https://public-inbox.org/meta/20170110222235.GB27356@dcvr/T/#u

Worse is they now corrupted on the way in into the git repo
because of search indexing.  Will fix ASAP.  Thanks for the
heads up.
