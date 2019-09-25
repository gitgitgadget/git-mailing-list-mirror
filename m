Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86E501F463
	for <e@80x24.org>; Wed, 25 Sep 2019 10:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbfIYKJe (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 06:09:34 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:35473 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfIYKJe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 06:09:34 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iD4Em-0007r4-3b; Wed, 25 Sep 2019 11:09:32 +0100
Subject: Re: git-gui: failure to distinguish 3-way common ancestors in hunk
 markers (#2340)
To:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>
References: <b2f412e2-d95f-0f73-5341-73c19ee2c6f7@iee.email>
 <7baf2b10-56fa-1cb4-0571-cb3c6be8feb3@iee.email>
 <CAKPyHN2sORn_ivC33DDsGe5L5UbNDBc5W6m=h85KUCmBCFCdvw@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <64e38298-cd02-c81b-d686-f1120ee079ed@iee.email>
Date:   Wed, 25 Sep 2019 11:09:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKPyHN2sORn_ivC33DDsGe5L5UbNDBc5W6m=h85KUCmBCFCdvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/09/2019 07:33, Bert Wesarg wrote:
> Pratyush,
>
> once again, I had done this years ago. I may post an updated patch in
> the evening:
>
> https://github.com/bertwesarg/git-gui/commit/90ee4a8c260132a6b730040095929fd267cedd7b
>
> Bert
Thanks, I'll see if I can look at it (I'd also need to re-prepare my 
rerere cache [how to do /that/ ?] and the rebase)

>
> On Wed, Sep 25, 2019 at 12:05 AM Philip Oakley <philipoakley@iee.email> wrote:
>> Hi list,
>> cc Pratyush,
>>
>> [resend without attached png file]
>>
>> While rebasing an old series, I had a 3-way merge fall back that didn't
>> show the `||||||| merged common ancestors` very well in git-gui.
>>
>> That is, the conflict markers, and common ancestor lines, are treated as
>> being part of the current HEAD hunk, rather than being separated.
>>
>> I opened a Git for Windows issue
>> https://github.com/git-for-windows/git/issues/2340 which has the
>> screenshot of the git-gui markers.
>>
>> I've not had any chance to look at the underlying code, but thought it
>> worth reporting. I guess the issue has been there a while.
>>
>> Philip
>>
>>
>>

