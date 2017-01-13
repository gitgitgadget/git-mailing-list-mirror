Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF64B20756
	for <e@80x24.org>; Fri, 13 Jan 2017 21:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbdAMVbP (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 16:31:15 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:21409 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751019AbdAMVbO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 16:31:14 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3v0bR438kgz5tlQ;
        Fri, 13 Jan 2017 22:31:12 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 64E1E3B6;
        Fri, 13 Jan 2017 22:31:11 +0100 (CET)
Subject: Re: [PATCH 5/5] describe: teach describe negative pattern matches
To:     Jacob Keller <jacob.keller@gmail.com>
References: <20170112001721.2534-1-jacob.e.keller@intel.com>
 <20170112001721.2534-6-jacob.e.keller@intel.com>
 <5f723a0d-623f-bf97-00de-29d430484fed@kdbg.org>
 <CA+P7+xrmAmCPOzuaKcm+WxceXnowkM4gKz05tSpdC=CDwpCEug@mail.gmail.com>
 <5c8401ef-9609-f235-9228-be980a13edf1@kdbg.org>
 <CA+P7+xq1LMkRG_aSyamrsPUQE+rDv4A9Qd19tDMgx-_a5OHsqQ@mail.gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <97d4105c-0fa6-41c5-e456-30cebd93dc36@kdbg.org>
Date:   Fri, 13 Jan 2017 22:31:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <CA+P7+xq1LMkRG_aSyamrsPUQE+rDv4A9Qd19tDMgx-_a5OHsqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.01.2017 um 07:57 schrieb Jacob Keller:
> On Thu, Jan 12, 2017 at 10:43 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>>  When you write
>>
>>   git log --branches --exclude=origin/* --remotes
>>
>> --exclude=origin/* applies only to --remotes, but not to --branches.
>
> Well for describe I don't think the order matters.

That is certainly true today. But I would value consistency more. We 
would lose it if some time in the future 'describe' accepts --branches 
and --remotes in addition to --tags and --all.

-- Hannes

