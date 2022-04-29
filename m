Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC13C433F5
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 16:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379061AbiD2Qas (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 12:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379075AbiD2Qao (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 12:30:44 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F5AD95E1
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 09:27:25 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id i62so6904366pgd.6
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 09:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UqwURB8fcSpM2n79ZZeqmU3GZRdyzDF/lqFPknBOKHA=;
        b=gqlyLhlyyJx6plGGbWz2gj4vKoAP+JIlhnEedmHrXMsTzeq1XwgoBHpZvaEb6/iZ8x
         LTBNumP8Rk27aQNY1rxEQW881q2BaHPw9U67bnlwYtm/ErOho/ZNSFDomN+crmmmYAXW
         oLc4LAn853kqVbgQArLpW4ETxyeLsBSzKtlRo3KcxP27gcrfQEUfI7fmv57PCk7KJR9Y
         XfacfrQOw4FPk43ILu6wAGY8uAzl0SXPZWxDxy1o0TH+APNAYO+fI5yOh2I5N1VxLXTS
         WDGUnLqFIHz0OGqiOL5uCSg8MqU1hI/FE+QYVnt0qaMCG76K/exE8ScyJ9nJRdmgF1oG
         rxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UqwURB8fcSpM2n79ZZeqmU3GZRdyzDF/lqFPknBOKHA=;
        b=ZPuH5z4mbsafb7Ctq01ufh08szbAAvJ5GRo+l6zWlhVnLAqojfiGaP9b/vkf0caNjq
         9d90AEeZsk8oNViO0IMzSJNRYjz+jpEX5kKTJsxCz7HcedP5HfLJTY26pOLdc2jJQQsB
         I+JgAaC7Hy5NQXQNZLNC5LrHgsDkqyN/HjYEqVhx2Sjx13l5kbBCsORL8spynsDoYkFh
         NOG3la7W+1PzRA3ynGr35xS9dm1jvqOQmuIkTY+CrTz6IitKZxlzQrt8GtB43OLqr6tP
         amdBzC7uKVHfbAMEa5+mx68uY4oxH5Xf2OcRmd3OqoLlFvjujWhCqrWhaXTQ5z1AYIpX
         JTVw==
X-Gm-Message-State: AOAM5307L7OAc6VAHAequT/B7lFSiSounAH6uTu+ClszYNGh6NHK5HgG
        exdSEfuDmdZVRzzrpfdt/ZnCkr8CmVwI
X-Google-Smtp-Source: ABdhPJxOdn2/AzViau+B2oFCjV2UVE/oEz4XTJEt60fvOuaUvzuU4j77fQDxo7C+3b+gqFbxmUdLGw==
X-Received: by 2002:a63:1057:0:b0:3ab:a3fb:fb9e with SMTP id 23-20020a631057000000b003aba3fbfb9emr160820pgq.590.1651249644491;
        Fri, 29 Apr 2022 09:27:24 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id p34-20020a056a000a2200b004cd49fc15e5sm3934660pfh.59.2022.04.29.09.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 09:27:24 -0700 (PDT)
Message-ID: <f7f64135-7d57-5926-501b-13e83411b4fd@github.com>
Date:   Fri, 29 Apr 2022 09:27:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 2/3] MyFirstContribution: also explain cover letter in
 GitGitGadget section
Content-Language: en-US
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
 <afb80b8e9ee022cba9373f2191ee1619e5897b09.1651086288.git.gitgitgadget@gmail.com>
 <ed4a0e46-a45c-0b05-fc35-f82e377ea231@github.com>
 <c7030c98-bd65-7d0e-89ac-ae291e22b10d@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <c7030c98-bd65-7d0e-89ac-ae291e22b10d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain wrote:
> Hi Victoria,
> 
> Le 2022-04-27 à 16:43, Victoria Dye a écrit :
>> Philippe Blain via GitGitGadget wrote:
> 
>>> +----
>>> +Adding the 'psuh' command
>>
>> Typically I see patch series titles follow the same "imperative mood" as
>> commit titles/messages (see 'Documentation/SubmittingPatches.txt'). I'm not
>> sure whether that's a rule written down somewhere or just convention, but
>> for the sake of consistency you might want to do something like:
>>
>> 	"Add the 'psuh' command"
>>
> 
> I fully agree. I just copied the existing patch series title from 
> the git-send-email section further down. I think it would make sense
> to change this to also using the imperative mood just like commit messages
> in a preparatory commit. I'll do that.
> 
>>> +----
>>> +
>>> +Your PR's description will used as the body of the cover letter.
>>
>> Including the line "Your PR's description..." is somewhat confusing to me as
>> a first-time reader, since I was interpreting this section to be the
>> *verbatim* text of the pull request title & description. If this *is* meant
>> to be that description, then the note about the PR description can be
>> removed. That point is also mentioned above, so it's probably not needed
>> here anyway.
> 
> I'm not exactly sure what you mean. I meant that the description of the PR
> will be used as the body of the cover letter...
> 

Sorry for being unclear. What I meant was that, the way this part of the
document reads (to me) right now, it looks like the recommendation is to
create a pull request with the title & description:

Title: 
	Adding the 'psuh' command
Description:
	Your PR's description will [be] used as the body of the cover
	letter. <insert content from MyFirstContribution-coverletter.txt>

That is, the line "Your PR description will..." is the first line of the
description (which I don't think was your intention).

That said, upon a more holistic re-read, I've found a few more things that
are confusing/oddly phrased. I'll try re-reviewing (part of) the patch
below, with (hopefully) more direct/concrete feedback this time:

> -Review the PR's title and description, as it's used by GitGitGadget as the cover
> -letter for your change. When you're happy, submit your pull request.
> +Review the PR's title and description, as they're used by GitGitGadget as the
> +cover letter for your change. The cover letter describes your proposed
> +contribution as a whole and is ideal to mention any context that might be

s/is ideal to/should(?)

> +useful for reviewers. The title of your PR should be something which
> +succinctly covers the purpose of your entire topic branch, for example:
> +
> +----
> +Adding the 'psuh' command
> +----

Other than the "Adding" -> "Add" change, this is good - the example title
will be formatted as a monospaced block, clearly separating it from the
advice/context preceding it.

> +
> +Your PR's description will used as the body of the cover letter.
> +include::MyFirstContribution-coverletter.txt[]
> +

Conversely, this section has no visible separation between the context
("Your PR's description...") and the example
("include::MyFirstContribution-coverletter.txt[]"), hence my confusion
earlier. 

To parallel the title example, maybe you could use similar monospace
formatting for the example? E.g.:

+
+Your PR's description will used as the body of the cover letter.
+ 
+----
+include::MyFirstContribution-coverletter.txt[]
+----
+

One thing I noticed on my re-read is that the context you provide for the
title ("The title of your PR should be something...") isn't quite paralleled
in the context for the description ("Your PR's description..."). The former
talks about *how* you should write your cover letter title, whereas the
latter simply states that the PR description will become the cover letter's
content. For added context, then, you might want to describe how the cover
letter content should be written, e.g.:

+
+Your PR's description will be used as the body of the cover letter and
+should explain the purpose of the series, for example:
+ 
+----
+include::MyFirstContribution-coverletter.txt[]
+----
+

(note the s/will used/will be used)

Apologies for all the picky grammar comments - this series includes a lot of
really helpful information for new contributors, and I really appreciate
your work here! Hopefully my feedback is a bit more clear this time (and is
relatively straightforward to implement).

Thanks!


> Thanks for having a look!
> 
> Philippe.

