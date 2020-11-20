Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EBEC2D0E4
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 21:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF5122403
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 21:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgKTVmX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 16:42:23 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:36467 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgKTVmW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 16:42:22 -0500
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kgEAb-0007yd-CL; Fri, 20 Nov 2020 21:42:18 +0000
Subject: Re: [PATCH] myFirstContribition: answering questions is not the end
 of the story
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
References: <xmqq3613vrtx.fsf@gitster.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <33e4b940-2560-83b7-1015-100c16c71345@iee.email>
Date:   Fri, 20 Nov 2020 21:42:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <xmqq3613vrtx.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/11/2020 17:52, Junio C Hamano wrote:
> A review exchange may begin with a reviewer asking "what did you
> mean by this phrase in your log message (or here in the doc)?", the
> author answering what was meant, and then the reviewer saying "ah,
> that is what you meant---then the flow of the logic makes sense".
>
> But that is not the happy end of the story.  New contributors often
> forget that the material that has been reviewed in the above exchange
> is still unclear in the same way to the next person who reads it,
> until it gets updated.

Yes!

> While we are in the vicinity, rephrase the verb "request" used to
> refer to comments by reviewers to "suggest"---this matches the
> contrast between "original" and "suggested" that appears later in
> the same paragraph, and more importantly makes it clearer that it is
> not like authors are to please reviewers' wishes but rather
> reviewers are merely helping authors to polish their commits.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * Something along this line, in a more condensed form, may also
>    want to be in SubmittingPatches, but let's start with a longer
>    form that is easier to discuss the intent of the addition to see
>    if it is a good idea.  I've seen a patch that got reviewed
>    falling thru the cracks without producing a v2 too many times.
>
>  Documentation/MyFirstContribution.txt | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git c/Documentation/MyFirstContribution.txt w/Documentation/MyFirstContribution.txt
> index 60eed5edcd..bac4997e39 100644
> --- c/Documentation/MyFirstContribution.txt
> +++ w/Documentation/MyFirstContribution.txt
> @@ -1143,11 +1143,24 @@ After a few days, you will hopefully receive a reply to your patchset with some
>  comments. Woohoo! Now you can get back to work.
>  
>  It's good manners to reply to each comment, notifying the reviewer that you have
> -made the change requested, feel the original is better, or that the comment
> +made the change suggested, feel the original is better, or that the comment
>  inspired you to do something a new way which is superior to both the original
>  and the suggested change. This way reviewers don't need to inspect your v2 to
>  figure out whether you implemented their comment or not.
>  
> +Reviewers may ask you about what you wrote in the patchset, either in
> +the proposed commit log message or in the changes themselves.  You
> +should answer these questions in your response messages, but often the
> +reason why reviewers asked these questions to understand what you meant
> +to write is because your patchset needed clarification to be understood.

Perhaps a paragraph break here?
> +Do not be satisfied by just answering their questions in your response
> +and hear them say that they now understand what you wanted to say.
> +Update your patches to clarify the points reviewers had trouble with,
> +and prepare your v2; the words you used to explain your v1 to answer
> +reviewers' questions may be useful thing to use.  Your goal is to make
> +your v2 clear enough so that it becomes unnecessary for you to give the
> +same explanation to the next person who reads it.
> +
>  If you are going to push back on a comment, be polite and explain why you feel
>  your original is better; be prepared that the reviewer may still disagree with
>  you, and the rest of the community may weigh in on one side or the other. As

Is this also worth mentioning in SubmittingPatches?

With or without the paragraph split

Reviewed-by: Philip Oakley <philipoakley@iee.email>



