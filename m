Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE9FC433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 23:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbiEJXpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 19:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiEJXpj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 19:45:39 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4FA5BE6B
        for <git@vger.kernel.org>; Tue, 10 May 2022 16:45:38 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id c8so804290qvh.10
        for <git@vger.kernel.org>; Tue, 10 May 2022 16:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2oLFudd1ID2U12ZY/K5VZYCknL+3a8qUT6pJbkOoz4A=;
        b=TpSVf97Irk46z9/fJ59PhwxROvJspekCqfbQFno+a/JUhEC0VZzNIY3HDL9yk7VAAV
         mzeICJ0VtqIRcLq045aTBbCoaF06Te16sX+1ZjYVmndxMDImx7ZubK38+DicfVOO22SX
         9vUa2bmAIZ6DZFt7cQ9mQZP0wxOjZBhlcZv+pE0rCkgTwV+8ljKobpwHR8EZvXUhgMeS
         7gHDocyAQJlZzCavmpldScb90Q0Z4/fk0rZ9LyM9wpknVbiZELE+Tw6GtXaXOGi0v5dU
         8sRzPKwhGq1bEENFs9+lf8W/3fk3YCnGu4DUQgRfXBTk3IcdwxKp85EHswjSPkWQLy1x
         SwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2oLFudd1ID2U12ZY/K5VZYCknL+3a8qUT6pJbkOoz4A=;
        b=qiInGJ+g2ExxKMJ9J8LOT2Fr7E1pMMNt1YKii6JhWNzamkrcNwdbg/VPT4vNz776xy
         xABaeae0uGU/RzyNjgeHZnbuuah1W4UcteMFvQu4KkhS5XfotR3HxkNAgZSSHAcShWI2
         iojrm8eWm4w5pb9yCFBw6T8Aqa+fexHLGpF3xC3riIoPRw8nA3ZjPR5liKFnvizP8YST
         VbCJKjU0h0+gBlHKHuRegz5PMeW37fNGjZQVcKCfFWckmnPEqXTAe5+yMQ4G3GnLmP4r
         nOQuVQzO+Lpmkb9LdyBqXXJa+7t+9aHBIyFPXKCZ61OHKlvrTg8s3LTijbCXOhTb1U7u
         Xirw==
X-Gm-Message-State: AOAM530Of4RuaUGn0noYQpIdb9cLLDuGH0qQ492vKM4sTSKWZnFkkC95
        dSMAHMxWakUWpqMZoaNH9hA=
X-Google-Smtp-Source: ABdhPJxvbCTDUY4BwQ5C8AeOqzIIbaKnJhRUBUENifcdCzk0p1UKWszBYTw8j1y6QfFKMsmqyv6G4g==
X-Received: by 2002:a05:6214:1cc5:b0:443:6a15:5894 with SMTP id g5-20020a0562141cc500b004436a155894mr19713279qvd.59.1652226337886;
        Tue, 10 May 2022 16:45:37 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id i8-20020a05622a08c800b002f3ad89629dsm284893qte.2.2022.05.10.16.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 16:45:37 -0700 (PDT)
Subject: Re: [PATCH 2/3] MyFirstContribution: also explain cover letter in
 GitGitGadget section
To:     Victoria Dye <vdye@github.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
 <afb80b8e9ee022cba9373f2191ee1619e5897b09.1651086288.git.gitgitgadget@gmail.com>
 <ed4a0e46-a45c-0b05-fc35-f82e377ea231@github.com>
 <c7030c98-bd65-7d0e-89ac-ae291e22b10d@gmail.com>
 <f7f64135-7d57-5926-501b-13e83411b4fd@github.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <875578c1-c3a9-bccb-40a7-b390b6a123ef@gmail.com>
Date:   Tue, 10 May 2022 19:45:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f7f64135-7d57-5926-501b-13e83411b4fd@github.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria,

Le 2022-04-29 à 12:27, Victoria Dye a écrit :
> Philippe Blain wrote:
>> Hi Victoria,
>>
>> Le 2022-04-27 à 16:43, Victoria Dye a écrit :
>>> Philippe Blain via GitGitGadget wrote:
>>
>>>> +----
>>>> +Adding the 'psuh' command
>>>
>>> Typically I see patch series titles follow the same "imperative mood" as
>>> commit titles/messages (see 'Documentation/SubmittingPatches.txt'). I'm not
>>> sure whether that's a rule written down somewhere or just convention, but
>>> for the sake of consistency you might want to do something like:
>>>
>>> 	"Add the 'psuh' command"
>>>
>>
>> I fully agree. I just copied the existing patch series title from 
>> the git-send-email section further down. I think it would make sense
>> to change this to also using the imperative mood just like commit messages
>> in a preparatory commit. I'll do that.
>>
>>>> +----
>>>> +
>>>> +Your PR's description will used as the body of the cover letter.
>>>
>>> Including the line "Your PR's description..." is somewhat confusing to me as
>>> a first-time reader, since I was interpreting this section to be the
>>> *verbatim* text of the pull request title & description. If this *is* meant
>>> to be that description, then the note about the PR description can be
>>> removed. That point is also mentioned above, so it's probably not needed
>>> here anyway.
>>
>> I'm not exactly sure what you mean. I meant that the description of the PR
>> will be used as the body of the cover letter...
>>
> 
> Sorry for being unclear. What I meant was that, the way this part of the
> document reads (to me) right now, it looks like the recommendation is to
> create a pull request with the title & description:
> 
> Title: 
> 	Adding the 'psuh' command
> Description:
> 	Your PR's description will [be] used as the body of the cover
> 	letter. <insert content from MyFirstContribution-coverletter.txt>
> 
> That is, the line "Your PR description will..." is the first line of the
> description (which I don't think was your intention).
> 
> That said, upon a more holistic re-read, I've found a few more things that
> are confusing/oddly phrased. I'll try re-reviewing (part of) the patch
> below, with (hopefully) more direct/concrete feedback this time:
> 
>> -Review the PR's title and description, as it's used by GitGitGadget as the cover
>> -letter for your change. When you're happy, submit your pull request.
>> +Review the PR's title and description, as they're used by GitGitGadget as the
>> +cover letter for your change. The cover letter describes your proposed
>> +contribution as a whole and is ideal to mention any context that might be
> 
> s/is ideal to/should(?)
> 
>> +useful for reviewers. The title of your PR should be something which
>> +succinctly covers the purpose of your entire topic branch, for example:
>> +
>> +----
>> +Adding the 'psuh' command
>> +----
> 
> Other than the "Adding" -> "Add" change, this is good - the example title
> will be formatted as a monospaced block, clearly separating it from the
> advice/context preceding it.
> 
>> +
>> +Your PR's description will used as the body of the cover letter.
>> +include::MyFirstContribution-coverletter.txt[]
>> +
> 
> Conversely, this section has no visible separation between the context
> ("Your PR's description...") and the example
> ("include::MyFirstContribution-coverletter.txt[]"), hence my confusion
> earlier. 
> 
> To parallel the title example, maybe you could use similar monospace
> formatting for the example? E.g.:
> 
> +
> +Your PR's description will used as the body of the cover letter.
> + 
> +----
> +include::MyFirstContribution-coverletter.txt[]
> +----
> +
> 
> One thing I noticed on my re-read is that the context you provide for the
> title ("The title of your PR should be something...") isn't quite paralleled
> in the context for the description ("Your PR's description..."). The former
> talks about *how* you should write your cover letter title, whereas the
> latter simply states that the PR description will become the cover letter's
> content. For added context, then, you might want to describe how the cover
> letter content should be written, e.g.:
> 
> +
> +Your PR's description will be used as the body of the cover letter and
> +should explain the purpose of the series, for example:
> + 
> +----
> +include::MyFirstContribution-coverletter.txt[]
> +----
> +
> 
> (note the s/will used/will be used)
> 
> Apologies for all the picky grammar comments - this series includes a lot of
> really helpful information for new contributors, and I really appreciate
> your work here! Hopefully my feedback is a bit more clear this time (and is
> relatively straightforward to implement).

Thanks for your feedback. I'll send an updated and expanded version soon
and I think I've adressed the different things you noted.

Cheers,

Philippe.

