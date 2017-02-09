Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA6B51FAF4
	for <e@80x24.org>; Thu,  9 Feb 2017 04:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751429AbdBIEwy (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 23:52:54 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:57842 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751420AbdBIEwx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 23:52:53 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 7B69F1FAF4;
        Thu,  9 Feb 2017 04:51:56 +0000 (UTC)
Date:   Thu, 9 Feb 2017 04:51:56 +0000
From:   Eric Wong <e@80x24.org>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, peff@peff.net, pclouds@gmail.com
Subject: Re: [PATCH] gc: ignore old gc.log files
Message-ID: <20170209045156.GA2567@dcvr.yhbt.net>
References: <20170209020222.23642-1-dturner@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170209020222.23642-1-dturner@twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twosigma.com> wrote:
> +	echo fleem> .git/gc.log &&

A minor nit:

	echo fleem >.git/gc.log &&

Otherwise, it's good to know there's attention paid to this
issue.  I've been ignoring cron mails from my mirrors for too
long :x  Thanks.
