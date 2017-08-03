Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 155831F991
	for <e@80x24.org>; Thu,  3 Aug 2017 20:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751904AbdHCU0c (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 16:26:32 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:34869 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751743AbdHCU0b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 16:26:31 -0400
Received: by mail-qt0-f182.google.com with SMTP id p3so14412697qtg.2
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 13:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yORJFNEoitsTt/HmuGWd0DWy5kanRWXEMxaxfVdWmlc=;
        b=PWtYnaNRb4fdkeal6834fVBY1/Vbcw4rquTm3/GlXkM2dCstpoZs4kFihAoEEQoReM
         R6s7n/G167jL4gErRSrZvKzJsN56vx2jDqGJzCfye7oMXLCNsDLv67iYDaR6PBPiMJ8H
         RY3BEJTpITnaxFSpy/+SxiAKpfNLYpVSl4VRCcdPm4jEseZElelhrvrnNdfR0uuBZdMi
         i1l/dtziF/NAdkO4P19MhOHOmXfsnCYxGdi8nyJMEyAqtQP6V2DnrwA80GB9j5vfwK9Z
         LozE/rVSya2Nm3a+tijeMY4uRh0aHdeT3oXfeRTUncCa+xa50n4PH0CWjZZqIdBXyFM1
         VO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yORJFNEoitsTt/HmuGWd0DWy5kanRWXEMxaxfVdWmlc=;
        b=P/YvTrtgWyPI4CJcjtXtO8UMRiQKWK3hhXHaoNc+5oWzXHjoeBnAIVMO7vAxytB953
         bYnKh4/Bdkk261o1FSbddt4Q9veknQIgAEPHNeP9THOLYcOyiNyEckG1YM4KcaDjlkZQ
         8+tF1+SUIygjbxuv70R9qR+6ZyB/kBeRagU5+ldc+ufLzCuFff75YYmKvw9J8nU+sLCC
         qna199sP37eNFcdvtDF6xvfUadhmSIrg0y/u4s6bTDLYnvUPnS45pgmNFijsMKZ/Y8Xa
         rMWd0gTAR3RZWIOGIABL0BwKkGvC3ybwAqVtGu37Qhqmw8GUaXc9rO8VRfpZGHaEriby
         P2Dg==
X-Gm-Message-State: AHYfb5jF690odXZmKG1HflFlWWgcIiy9mW8rQMekgyMaweHKVulKK3KF
        fKiUiGvlkPq6nJpXbscbcUz4N+vj2w==
X-Received: by 10.200.48.25 with SMTP id f25mr32012qte.257.1501791990613; Thu,
 03 Aug 2017 13:26:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.39.194 with HTTP; Thu, 3 Aug 2017 13:26:10 -0700 (PDT)
In-Reply-To: <232547ab-3b87-debc-36a4-d2285ec10a06@ramsayjones.plus.com>
References: <xmqqfudcgryb.fsf@gitster.mtv.corp.google.com> <232547ab-3b87-debc-36a4-d2285ec10a06@ramsayjones.plus.com>
From:   Sahil Dua <sahildua2305@gmail.com>
Date:   Thu, 3 Aug 2017 22:26:10 +0200
Message-ID: <CALiud+nm9wu4rBY6zBXmenJj_0Mn7xeU_FAvSdn4fdH+q--Jag@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2017, #09; Mon, 31)
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ah! I had skipped this reply from Ramsay earlier.

On Tue, Aug 1, 2017 at 1:36 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 31/07/17 23:30, Junio C Hamano wrote:
> [snip]
>>
>> * sd/branch-copy (2017-06-18) 3 commits
>>   (merged to 'next' on 2017-07-18 at 5e3b9357ea)
>>  + branch: add a --copy (-c) option to go with --move (-m)
>>  + branch: add test for -m renaming multiple config sections
>>  + config: create a function to format section headers
>>
>>  "git branch" learned "-c/-C" to create and switch to a new branch
>>  by copying an existing one.
>>
>>  Will cook in 'next'.
>>
>>  I personally do not think "branch --copy master backup" while on
>>  "master" that switches to "backup" is a good UI, and I *will* say
>>  "I told you so" when users complain after we merge this down to
>>  'master'.
>
> I wouldn't normally comment on an issue like this because I am
> not very good at specifying, designing and evaluating UIs (so
> who in their right mind would listen to me). ;-)
>
> FWIW, I suspect that I would not like using this interface either
> and would, therefore, not use it.

Does that mean you'd use it when "branch --copy feature-branch
new-feature-branch" in the case when you would want to start working
on a new branch (to modify or experiment with your current feature
branch) on top of a branch keeping intact all the configuration and
logs?

I think it's really a matter of how this feature is seen from the
end-user point of view. If we consider example "branch --copy master
backup" - obviously, switching to backup isn't the ideal situation.
However, if we consider the example above, switching makes sense. None
of them is going to be correct in 100% cases. :)

> However, I guess the worst that
> would happen, is that it would gain another 'wort' (--option) to
> turn off the "switches to backup" branch. :-D
>
> I didn't want you to think that the lack of comments on this was
> because everybody agreed that it was a good idea.
>
> ATB,
> Ramsay Jones
>
>
