Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A8051F424
	for <e@80x24.org>; Fri, 20 Apr 2018 07:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753685AbeDTHFP (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 03:05:15 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:34521 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753541AbeDTHFP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 03:05:15 -0400
Received: from localhost (localhost [::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Fri, 20 Apr 2018 09:05:32 +0200
  id 0000000000000019.000000005AD9913C.0000721F
Date:   Fri, 20 Apr 2018 09:05:12 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH/RFC 0/5] Keep all info in command-list.txt in git binary
Message-ID: <20180420070512.GA13462@ruderich.org>
References: <20180326165520.802-1-pclouds@gmail.com>
 <20180419103725.GB19591@ruderich.org>
 <CAM0VKjkJJv2qLu_8Lx3pY7S1Hu8GCzYbsEw-8wXvBK6XC=KewQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjkJJv2qLu_8Lx3pY7S1Hu8GCzYbsEw-8wXvBK6XC=KewQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 19, 2018 at 01:26:18PM +0200, SZEDER Gábor wrote:
> On Thu, Apr 19, 2018 at 12:37 PM, Simon Ruderich wrote:
>> This doesn't occur on a non-parallel build.
>
> It does occur in non-parallel builds, too.
>
> See:
>
>   https://public-inbox.org/git/CAM0VKjkns+AsVyMSe2fxzT8a8oqYdNX3qO8mnw2juOgFC7LHYA@mail.gmail.com/

Thanks for the correction. I noticed it at the beginning of make
-j run and incorrectly assummed it would occur quickly in the
non-parallel run as well.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
