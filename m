Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0B172055E
	for <e@80x24.org>; Thu,  2 Nov 2017 10:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755295AbdKBKUd (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 06:20:33 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:48817 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755215AbdKBKUc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 06:20:32 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Thu, 02 Nov 2017 11:20:30 +0100
  id 0000000000000039.0000000059FAF16E.000065DB
Date:   Thu, 2 Nov 2017 11:20:31 +0100
From:   Simon Ruderich <simon@ruderich.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] wrapper.c: consistently quote filenames in error
 messages
Message-ID: <20171102102031.v266n6nf6vftglu6@ruderich.org>
References: <22afeefa-cdd5-cd32-0a7c-6bad4de79f05@web.de>
 <32c515d01d4257c1532004d0bf21b2c330f6b81b.1509547231.git.simon@ruderich.org>
 <xmqqvaitqon6.fsf@gitster.mtv.corp.google.com>
 <xmqqlgjpqmyj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <xmqqlgjpqmyj.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 02, 2017 at 02:16:52PM +0900, Junio C Hamano wrote:
> Junio C Hamano writes:
>> This patch is incomplete without adjusting a handful of tests to
>> expect the updated messages, no?
>
> I'll squash these in while queuing, but there might be more that I
> didn't notice.

Sorry, didn't think about the tests.

I've re-checked and I think those are the only affected tests.
The test suite passes with your squashed changes.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
