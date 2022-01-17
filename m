Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D648C433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 18:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242207AbiAQSIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 13:08:49 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:36451 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232426AbiAQSIt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 13:08:49 -0500
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1n9WQx-0008cu-EL;
        Mon, 17 Jan 2022 18:08:48 +0000
Message-ID: <a3f3eb72-5671-71c0-a6fb-89aa901632a7@iee.email>
Date:   Mon, 17 Jan 2022 18:08:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] README.md: add CodingGuidelines and a link for
 Translators
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1115.git.1642182615339.gitgitgadget@gmail.com>
 <pull.1115.v2.git.1642349490723.gitgitgadget@gmail.com>
 <xmqq5yqjz4a6.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqq5yqjz4a6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/01/2022 22:47, Junio C Hamano wrote:
> "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Philip Oakley <philipoakley@iee.email>
>>
>> The README.md does not use the GitHub Markdown URL links [1] of
>> [txt](url), rather the reference method [2] of trailing empty square
>> brackets. The references themselves are listed at the foot of the
>> document. Those footers are not shown by GitHub/GitLab rendering.
> Thanks for tracking down the differences.
I found an additional GitHub link for the reference method (not easy to
find), which I have added.
>
> The above only describes what we could do (i.e. use links instead of
> reference), and how the current document is rendered (i.e. footers
> are not shown).  No changes come from the above description.
>
>> Also space out the list joining instructions and clarify that
>> subscription is via the majordomo address.
> So, seeing "Also" immediately after a paragraph that explains the
> status quo confused me a lot.
>
> "Spell out the instructions to join the list, and clarify that the
> subscription is via the majordomo address" is indeed a part of what
> this patch does.  Perhaps we need a separate paragraph _before_ this
> "Also".
>
> So taking all together
>
>     Before being told how to submit patches, new contributors need
>     to be told how to code for, or how to contribute translation to,
>     the project.  Add references to the CodingGuidelines and the
>     README document on localization.
>
>     Also, spell out the instructions to join the list and ...
>     
>     We use GitHub Markdown reference [2] with trailing empty square
>     brackets, to match existing text in the file.  On GitHub/GitLab
>     pages, these references are not shown on the page, but it is OK
>     because they are empty.  We could switch to using [text](url)
>     form [1] if we wanted to, but that is not done as part of this
>     patch.
>
> would be the presentation order that I would expect to be the most
> readable.  I moved the discussion between URL link and reference, as
> it is merely a hint for future and not the core thing that needs to
> be explained to understand the changes in this commit.
I've taken your suggestions and added a small clarification about the
awkward empty square bracket links, which are repeated in the README's
footer, but not shown on the Github rendered web page.. I also took
Bagas' text changes for the readme itself

GGG V3 to follow,...

Thank you
>
> Thanks.
>
>
>> [1] https://docs.github.com/en/github/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#links
>> [2] https://gist.github.com/ChrisTollefson/a3af6d902a74a0afd1c2d79aadc9bb3f#reference-links
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.email>
>> ---
>>     README.md: add CodingGuidelines and a link for Translators
>>     
>>     Also space out the list joining instructions and clarify the
>>     subscription via the majordomo address.
>>     
>>     
>>     Signed-off-by: Philip Oakley philipoakley@iee.email
>>     ===================================================
>>     
>>     cc: Philip Oakley philipoakley@iee.email cc: Junio C Hamano
>>     gitster@pobox.com cc: Jiang Xin worldhello.net@gmail.com
>>     
>>     changes since v1:
>>     
>>      * Used reference style links, rather than lnk [url] style.
>>     
>>      * added Jianf as L10 coordinator.
>>     
>>      * note: Patch is a response to a user question on the "Git for Human
>>        Beings" git-users list
>>        https://groups.google.com/d/msgid/git-users/aa68b9c8-4cf4-4193-8af3-79d7e3feafbbn%40googlegroups.com
>>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1115%2FPhilipOakley%2FReadme-v2
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1115/PhilipOakley/Readme-v2
>> Pull-Request: https://github.com/gitgitgadget/git/pull/1115
>>
>> Range-diff vs v1:
>>
>>  1:  ac6d0abbdde ! 1:  48cc30b7cc8 README.md: add CodingGuidelines and a link for Translators
>>      @@ Metadata
>>        ## Commit message ##
>>           README.md: add CodingGuidelines and a link for Translators
>>       
>>      -    Also space out the list joining instructions and clarify the subscription
>>      -    via the majordomo address.
>>      +    The README.md does not use the GitHub Markdown URL links [1] of
>>      +    [txt](url), rather the reference method [2] of trailing empty square
>>      +    brackets. The references themselves are listed at the foot of the
>>      +    document. Those footers are not shown by GitHub/GitLab rendering.
>>      +
>>      +    Also space out the list joining instructions and clarify that
>>      +    subscription is via the majordomo address.
>>      +
>>      +    [1] https://docs.github.com/en/github/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#links
>>      +    [2] https://gist.github.com/ChrisTollefson/a3af6d902a74a0afd1c2d79aadc9bb3f#reference-links
>>       
>>           Signed-off-by: Philip Oakley <philipoakley@iee.email>
>>       
>>      @@ README.md: installed).
>>        requests, comments and patches to git@vger.kernel.org (read
>>       -[Documentation/SubmittingPatches][] for instructions on patch submission).
>>       +[Documentation/SubmittingPatches][] for instructions on patch submission
>>      -+and [Documentation/CodingGuidelines]() ).
>>      ++and [Documentation/CodingGuidelines][]).
>>       +
>>       +Those wishing to help with error message translation (localization L10)
>>      -+should see [po/README.md]()
>>      -+(a `po` file is a portable object file for the translations).
>>      ++should see [po/README.md][] (a `po` file is a Portable Object file that
>>      ++holds the translations).
>>       +
>>        To subscribe to the list, send an email with just "subscribe git" in
>>       -the body to majordomo@vger.kernel.org. The mailing list archives are
>>       -available at <https://lore.kernel.org/git/>,
>>      -+the body to majordomo@vger.kernel.org (not the list). The mailing list
>>      -+archives are available at <https://lore.kernel.org/git/>,
>>      ++the body to majordomo@vger.kernel.org (not the Git list). The mailing
>>      ++list archives are available at <https://lore.kernel.org/git/>,
>>        <http://marc.info/?l=git> and other archival sites.
>>        
>>        Issues which are security relevant should be disclosed privately to
>>      +@@ README.md: and the name as (depending on your mood):
>>      + [Documentation/giteveryday.txt]: Documentation/giteveryday.txt
>>      + [Documentation/gitcvs-migration.txt]: Documentation/gitcvs-migration.txt
>>      + [Documentation/SubmittingPatches]: Documentation/SubmittingPatches
>>      ++[Documentation/CodingGuidelines]: Documentation/CodingGuidelines
>>      ++[po/README.md]: po/README.md
>>      + \ No newline at end of file
>>
>>
>>  README.md | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/README.md b/README.md
>> index f6f43e78deb..d2b061e3998 100644
>> --- a/README.md
>> +++ b/README.md
>> @@ -32,10 +32,16 @@ installed).
>>  The user discussion and development of Git take place on the Git
>>  mailing list -- everyone is welcome to post bug reports, feature
>>  requests, comments and patches to git@vger.kernel.org (read
>> -[Documentation/SubmittingPatches][] for instructions on patch submission).
>> +[Documentation/SubmittingPatches][] for instructions on patch submission
>> +and [Documentation/CodingGuidelines][]).
>> +
>> +Those wishing to help with error message translation (localization L10)
>> +should see [po/README.md][] (a `po` file is a Portable Object file that
>> +holds the translations).
>> +
>>  To subscribe to the list, send an email with just "subscribe git" in
>> -the body to majordomo@vger.kernel.org. The mailing list archives are
>> -available at <https://lore.kernel.org/git/>,
>> +the body to majordomo@vger.kernel.org (not the Git list). The mailing
>> +list archives are available at <https://lore.kernel.org/git/>,
>>  <http://marc.info/?l=git> and other archival sites.
>>  
>>  Issues which are security relevant should be disclosed privately to
>> @@ -64,3 +70,5 @@ and the name as (depending on your mood):
>>  [Documentation/giteveryday.txt]: Documentation/giteveryday.txt
>>  [Documentation/gitcvs-migration.txt]: Documentation/gitcvs-migration.txt
>>  [Documentation/SubmittingPatches]: Documentation/SubmittingPatches
>> +[Documentation/CodingGuidelines]: Documentation/CodingGuidelines
>> +[po/README.md]: po/README.md
>> \ No newline at end of file
>>
>> base-commit: 1ffcbaa1a5f10c9f706314d77f88de20a4a498c2

