Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FEBC20209
	for <e@80x24.org>; Fri, 30 Jun 2017 07:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbdF3H0N (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 03:26:13 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:41951 "EHLO
        zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751818AbdF3H0N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 03:26:13 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Fri, 30 Jun 2017 09:26:12 +0200
  id 000000000000002C.000000005955FD14.00006FE6
Date:   Fri, 30 Jun 2017 09:26:11 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 25/25] diff: document the new --color-moved setting
Message-ID: <20170630072611.q733inuxdvjmhjgw@ruderich.org>
References: <20170630000710.10601-1-sbeller@google.com>
 <20170630000710.10601-26-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20170630000710.10601-26-sbeller@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 29, 2017 at 05:07:10PM -0700, Stefan Beller wrote:
> +	Small blocks of 3 moved lines or fewer are skipped.

If I read the commit messages correctly, this "skipping" process
applies to the move detection in general for those smaller blocks
and therefore doesn't mean a malicious move can hide smaller
changes, correct? If so, I find this sentence misleading. Maybe
something like:

    Small blocks of 3 moved lines or fewer are excluded from move
    detection and colored as regular diff.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
