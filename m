Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A06D41F4C0
	for <e@80x24.org>; Sun, 20 Oct 2019 10:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfJTKtY (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Oct 2019 06:49:24 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:30165 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfJTKtY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Oct 2019 06:49:24 -0400
Received: from [92.30.121.54] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iM8m1-0000mD-8E; Sun, 20 Oct 2019 11:49:21 +0100
Subject: Re: [PATCH v4] Doc: Bundle file usage
To:     Jeff King <peff@peff.net>
Cc:     GitList <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Junio C Hamano <gitster@pobox.com>
References: <68ef6ca5-0baf-fa30-ce0d-138a41620da6@iee.email>
 <20191018203052.2451-1-philipoakley@iee.email>
 <20191020011020.GA2980@sigill.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <9e097bb2-ff3e-db5b-f0fd-0803e56b2cd6@iee.email>
Date:   Sun, 20 Oct 2019 11:49:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191020011020.GA2980@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/10/2019 02:10, Jeff King wrote:
> On Fri, Oct 18, 2019 at 09:30:52PM +0100, Philip Oakley wrote:
>
>> +`git clone` can use any bundle created without negative refspecs
>> +(e.g., `new`, but not `old..new`).
>> +If you want to match `git clone --mirror`, which would clone other
>> +refs such as `refs/remotes/*`, use `--all`.
>> +If you want to provide the same set of refs that a clone directly
>> +from the source repository would get, use `--branches --tags` for
>> +the `<git-rev-list-args>`.
> Since you swapped the order here of "--mirror" versus non-mirror, saying
> "other refs such as..." in the first part is confusing. We haven't
> introduced the thing they're "other" from.
>
> Maybe say "clone all refs (including ones which would be omitted by a
> non-mirror clone, like refs/remotes/*)" or something?
>
> Other than that, this version looks OK to me.
>
I had deliberately swapped the order because of the classic human 
fallibility of only remembering the beginning and end parts, so I'd 
buried' the --mirror/--all option, leaving that important bit to the end.

I'll probably simply just drop the word "other" (or maybe "include cloning")

Philip
