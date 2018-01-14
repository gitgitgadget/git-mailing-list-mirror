Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B52371F406
	for <e@80x24.org>; Sun, 14 Jan 2018 09:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751306AbeANJhn (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jan 2018 04:37:43 -0500
Received: from zucker2.schokokeks.org ([178.63.68.90]:55919 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeANJhn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jan 2018 04:37:43 -0500
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Sun, 14 Jan 2018 10:38:46 +0100
  id 0000000000000019.000000005A5B2526.000071EC
Date:   Sun, 14 Jan 2018 10:37:41 +0100
From:   Simon Ruderich <simon@ruderich.org>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] diff: add --compact-summary option to complement
 --stat
Message-ID: <20180114093535.GA2518@ruderich.org>
References: <20180113132211.13350-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180113132211.13350-1-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 13, 2018 at 08:22:11PM +0700, Nguyễn Thái Ngọc Duy wrote:
> [snip]
>
> For mode changes, executable bit is denoted as "(+x)" or "(-x)" when
> it's added or removed respectively. The same for when a regular file is
> replaced with a symlink "(+l)" or the other way "(-l)". This also
> applies to new files. New regulare files are "A", while new executable
> files or symlinks are "A+x" or "A+l".

I like the short summary. However I find the use of parentheses
inconsistent. Why not use them either always (also for "(A+l)")
or never? Was there a specific reason why you added them just in
one place?

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
