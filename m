Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4179D1F954
	for <e@80x24.org>; Sat, 18 Aug 2018 07:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbeHRKbe (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 06:31:34 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:34143 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeHRKbe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 06:31:34 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Sat, 18 Aug 2018 09:24:51 +0200
  id 00000000000000A2.000000005B77C9C3.00007D7B
Date:   Sat, 18 Aug 2018 09:24:51 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] commit: add short option for --amend
Message-ID: <20180818072450.GA17850@ruderich.org>
References: <20180816183117.13716-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180816183117.13716-1-pclouds@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 08:31:17PM +0200, Nguyễn Thái Ngọc Duy wrote:
> I just realized how often I type "git ci --amend". Looking back at my
> ~/.bash_history (only 10k lines) this is the second most often git
> command I type which may justify a short option for it (assuming that
> other people use this option often too, of course).

Why not add another alias? As you're already using the ci alias,
maybe cia? Personally I have the following aliases for
committing:

        c   = commit --verbose
        ca  = commit --verbose --amend
        cad = commit --verbose --amend --date=now

Besides the obvious g=git alias in the shell. I really like one
character aliases for often used commands/subcommands.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
