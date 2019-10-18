Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A56A1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 19:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440349AbfJRT6P (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 15:58:15 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:49040 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730242AbfJRT6O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 15:58:14 -0400
Received: from [92.30.121.54] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iLYO4-0001KX-Bf; Fri, 18 Oct 2019 20:58:13 +0100
Subject: Re: [PATCH v3] Doc: Bundle file usage
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     GitList <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
References: <20191016210957.GA28981@sigill.intra.peff.net>
 <20191018151555.2277-1-philipoakley@iee.email>
 <20191018181526.6py52lp2oqkcqyp2@yadavpratyush.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <68ef6ca5-0baf-fa30-ce0d-138a41620da6@iee.email>
Date:   Fri, 18 Oct 2019 20:58:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018181526.6py52lp2oqkcqyp2@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/10/2019 19:15, Pratyush Yadav wrote:
> On 18/10/19 04:15PM, Philip Oakley wrote:
>> From: Philip Oakley <philipoakley@iee.org>
>>
>> Improve the command description, including paragraph spacing.
>>
>> Git URLs can accept bundle files for fetch, pull and clone, include
>> in that section. Include git clone in the bundle usage description.
>> Correct the quoting of <git-rev-list-args>.
>>
>> Detail the <git-rev-list-args> options for cloning a complete repo.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.email>
> Reminder: The email in your signoff and From are different [0].
>
> [0] https://public-inbox.org/git/59958c50-cbcb-ae9b-614f-ba28221f41ed@iee.email/
>
Yes, sigh.
I was going to complain it was all the git-gui's fault ;-) because it 
doesn't show the current author, but then `git log` and `git show` don't 
either.

I just need to revisit the man page for --amend with some form of 
--reset-author to my new email.

Philip
[1] note to self: add a 'todo' to get git gui to show (somewhere) the 
author/committer that is in use for a commit or amend
