Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34DDB201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbdF3UbU (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:31:20 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:42577 "EHLO
        zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbdF3UbT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:31:19 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Fri, 30 Jun 2017 22:31:18 +0200
  id 0000000000000096.000000005956B516.00004EC0
Date:   Fri, 30 Jun 2017 22:31:17 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 25/25] diff: document the new --color-moved setting
Message-ID: <20170630203117.ktobhqnvgxgjujzi@ruderich.org>
References: <20170630000710.10601-1-sbeller@google.com>
 <20170630000710.10601-26-sbeller@google.com>
 <20170630072611.q733inuxdvjmhjgw@ruderich.org>
 <CAGZ79kYONNMrB7L65WjwZjSuKOf3rAOWPwjb1bH26MU0owTJ4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <CAGZ79kYONNMrB7L65WjwZjSuKOf3rAOWPwjb1bH26MU0owTJ4w@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 30, 2017 at 09:04:50AM -0700, Stefan Beller wrote:
> [snip]
>
> However
>
>     context
>   + moved line, block A or B
>   + moved line, block A or B
>     context
>
> is omitted, because the number of lines
> here is fewer than 3 ignoring the block
> type.
>
> Maybe
>
>   If there are fewer than 3 adjacent lines of
>   moved code, they are skipped.

My issue with "skipped" is that it's not clear what exactly is
skipped. Move detection? Inclusion in the diff? Something else?
That's why I tried to add the "excluded from move detection" to
make it clear that the change is still shown to the user, just
not handled by move detection and using the usual diff colors.

In your example above, what exactly is "omitted"? The complete
hunk from the output or the special coloring? That's what
confuses me and what might confuse a future reader of the
documentation.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
