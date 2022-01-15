Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6562BC433EF
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 00:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiAOAIJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 19:08:09 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:47342 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230283AbiAOAII (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 19:08:08 -0500
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1n8Wc1-000CSn-5U;
        Sat, 15 Jan 2022 00:08:06 +0000
Message-ID: <6b626f9d-05d6-1903-0b38-e3566e357472@iee.email>
Date:   Sat, 15 Jan 2022 00:08:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] README.md: add CodingGuidelines and a link for
 Translators
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1115.git.1642182615339.gitgitgadget@gmail.com>
 <xmqq7db2avij.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqq7db2avij.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/01/2022 20:54, Junio C Hamano wrote:
> "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Philip Oakley <philipoakley@iee.email>
>>
>> Also space out the list joining instructions and clarify the subscription
> the instructions to join the list?
Correct.
>
>>  requests, comments and patches to git@vger.kernel.org (read
>> -[Documentation/SubmittingPatches][] for instructions on patch submission).
>> +[Documentation/SubmittingPatches][] for instructions on patch submission
>> +and [Documentation/CodingGuidelines]() ).
> Remind me the significance of using [] and () after [File Reference]?
The [] is the original method used by the unchanged text, while the ()
appears to be the method required now.
 
>
>> +Those wishing to help with error message translation (localization L10)
>> +should see [po/README.md]()
> Same here.
>
> https://docs.github.com/en/github/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#links
>
> seems to indicate () is to enclose URL the text goes to, and if
> there is no URL to go to, perhaps it does the right thing, but the
> current page (which has "[Documentation/SubmittingPatches][]" and
> all other reference into in-tree files with that format) seems to
> render correctly with links that work, so...

Unfortunately it `[]` is not working for me for the new additions.
GitHub magic?
>
>> +(a `po` file is a portable object file for the translations).
>> +
>>  To subscribe to the list, send an email with just "subscribe git" in
>> -the body to majordomo@vger.kernel.org. The mailing list archives are
>> -available at <https://lore.kernel.org/git/>,
>> +the body to majordomo@vger.kernel.org (not the list). The mailing list
>> +archives are available at <https://lore.kernel.org/git/>,
>>  <http://marc.info/?l=git> and other archival sites.
>>  
>>  Issues which are security relevant should be disclosed privately to
>>
>> base-commit: 1ffcbaa1a5f10c9f706314d77f88de20a4a498c2

