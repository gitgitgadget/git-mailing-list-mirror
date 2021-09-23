Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF454C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 13:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ABD860F24
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 13:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241424AbhIWNqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 09:46:20 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:30110 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232316AbhIWNqT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 09:46:19 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mTP1q-0009jh-8T; Thu, 23 Sep 2021 14:44:46 +0100
Subject: Re: [PATCH v2] MyFirstContribution: Document --range-diff option when
 writing v2
To:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
References: <20210913194816.51182-1-chooglen@google.com>
 <20210920223226.25877-1-chooglen@google.com>
 <77a8b8d9-4e13-8c5b-c313-512fc7c2c953@iee.email>
 <kl6lmto4345t.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <709d79f6-3396-368d-3194-1b6d668c2043@iee.email>
Date:   Thu, 23 Sep 2021 14:44:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <kl6lmto4345t.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/09/2021 18:34, Glen Choo wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> Do we need a line to cover/suggest how the V2 to V3 follow up to further
>> review commands are tweaked.
>>
>> This sort of follows from the discussion about keeping the branch `psuh`
>> as the working branch, and the `-v1`, -`v2`, `-v3` as the record of
>> former submissions. The range-diff is then tweaked to be `--range-diff
>> master..psuh-v<N>` where N is the last proper submission (just in case
>> one version was a not-submitted dud).
> While writing, it seemed pretty obvious to me that v2 -> v3 would just
> entail adding 1 to every numeral. Of course I'm biased though, so I'm
> happy to add a line if you think this isn't that obvious.
I'd been coming from thinking of the `range-diff` command where a second
range would be required, with a flipping of the grandfather - father -
son version references, part triggered by the (false) expectation that
the `master..` would also need tweaked.

It's is hard in ref manuals to decide the point at which one need to
either give guidance, or point out common conceptual errors.

Also, separately, it may be worth commenting (or just mentioning) about
whether to keep the fork-point (or --keep-base) or not, depending on the
complexity of the patch series and how it may clash with other series
(making it harder for the maintainer if the `rerere` database would need
to keep changing)....

All in all. I think we (I) are good with your wording.

Philip
