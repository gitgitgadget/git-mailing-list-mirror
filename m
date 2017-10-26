Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23B09202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 17:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932346AbdJZRED (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 13:04:03 -0400
Received: from mout.web.de ([212.227.17.12]:63318 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932137AbdJZREC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 13:04:02 -0400
Received: from [192.168.178.36] ([91.20.60.28]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M4I6Z-1dGu0C3TYh-00rmbQ; Thu, 26
 Oct 2017 19:03:59 +0200
Subject: Re: [PATCH 2/4] xdiff-interface: export comparing and hashing strings
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
References: <20171024185917.20515-1-sbeller@google.com>
 <20171024185917.20515-3-sbeller@google.com>
 <9f5c5cd5-9491-3163-60d4-ad36d75981ce@web.de>
 <CAGZ79kbJS68qL0=WTZVBfmSDXCii0HT60TGxx2MSiH_cK_tBCw@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <347a9bca-29f3-9847-2f51-1682d7a6da53@web.de>
Date:   Thu, 26 Oct 2017 19:03:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbJS68qL0=WTZVBfmSDXCii0HT60TGxx2MSiH_cK_tBCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:SfTYvYUUa+3eKImpgoaniNnY/BS9ExNdhtjd1aL7LLubRY6XMbW
 vtQmNPva6fbpxDkLYmd3oYm7FmNRhtun/wo/w/lO16IpBM6hSo8K25yEl0aL9csNfVSRh1v
 PNxgO5GFCXwlI7f0+5p8cYKUgk+FOqSU0rhX9TjNh5l9Wor8Ma6hAad583dpVusWQqX/371
 OKp1O1chpBQSXj23j26QQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1v/M7/wNIaM=:vt5TA7jbpabJEB0GzLFoO8
 usFAlPnlLj+gcX7h8uk9aN3/1oM+BiUMS+DnW7ROxIbAvipVlRiEp0RUFGBFLnMoOjW2IUfCG
 BfER8SOWpcrckv/FDT08ao/xmAtgRKWbndeyp9xhUJ/8pI6o9SgTiCh/TsVTeNtolKWH4YqrN
 NnpEwpIWh+24JlGQxocW6nkTnkDgs3ekxLRNQ6OKGqWxx9TDhwrQ2Wp2w/tV/r9vWdjoTAmLA
 p0CF6jpADir24+H4+sy99InIwJqQ4cJWzwhCStcal4EkSkQXeqdvixvZ6bPNBMykH6HpkGXP9
 Wf3q1UhAPD3YoBPGLbPnheg5QuH0zTUiRBrCRxxnALOjGZkf61Q5wg2trB08E60O2wczcF18m
 sfLu4cjk4Tgnr1AO/f60ISI2wAOgDpb4oUCZtKV+FFNpiy4eqeXGwYYHPHCubufYdDC+QPaRf
 56BlqMoj6PFGs0h03QIiZmTbm2r3MK4RAWsmBZLSu638oHZ3OecSghnBE8AzOfBVTw/POaC9D
 hRt2HxgKqeZ4jRta+n24gChgurK6Trefx9A0PBVHlU5bj0JpAXJ6E7CCoHrTQ7W+47wqfPXqH
 ce/dBn0n5gsyiRz9Ivl/MLpGVl3n0fF5ePty46BLv8JeUbXlM+/5hFuK6MNDT/vVevArml7WI
 ujj/+2EyAdi7RR2rOeZB45A60wAYBcOVggPu8t53SAr16Uj9JN+Ydd0M4Tv+Ls8SHjdP4gdEI
 MDUVq1Cq1TLWx5F4v91ugxHxQaB1kFyLzP9B2EUUkApWf5hApXlx2gRbGPeuQ5B4phTdA2bjR
 BFQqc1DblTF3Mt/2pmOljI/pX9fea+1MIYvXrMw99e04C+dWyA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.10.2017 um 22:42 schrieb Stefan Beller:
> On Tue, Oct 24, 2017 at 1:23 PM, René Scharfe <l.s.r@web.de> wrote:
> 
>> xdl_recmatch() is already exported; why not use it without this
>> wrapper?
> 
> It is exported in xdiff/xutils.h, to be used by various xdiff/*.c files, but
> not outside of xdiff/. This one makes it available to the outside, too.

Ah, right, somehow I mixed that up with xdiff/xdiff.h, which is already
included by two builtins.

René
