Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83FA92035A
	for <e@80x24.org>; Tue, 11 Jul 2017 17:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756083AbdGKRzB (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 13:55:01 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:36975 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754615AbdGKRzA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 13:55:00 -0400
Received: by mail-it0-f54.google.com with SMTP id m84so29447499ita.0
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 10:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gt8r3/C3wWFIPwWQWbMebREdYQi+XXbb+EefslXYCOc=;
        b=E30aAjjwG2aSqOtJEJc4CJc+BZ1MBgAiiF9+xYMTR/RaNgGre0dJz+qgTWyCc9beFO
         AG8OTw4k+9Gr4jw1y4461ZS5PiXmUf2eq8YLUGAeJmY6BozjVVu+KbSkOSFVNswrnPsJ
         GzRndNkzTCYaIdW2lFiikSk1zqBpK7gnYfIg30djfyRmwWnM6TtdfDhzO/Uar7MNjDBk
         jU9T47tsLX920BhQVjAaWeahmVg1jabV3OcdruosiPslLqmQTZfH3Qw2WXZ3arRCfFd9
         DryUnq7xepO8mEQ9gFVRkPCc/0f0gBNT/Z2HYlCpOo5RTV94LCQSVZuF8+0t4dMIDfoM
         EGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gt8r3/C3wWFIPwWQWbMebREdYQi+XXbb+EefslXYCOc=;
        b=TKgIuTb9/FfKICmqxCXg+rBFoaCrIUVBcxXClDuVMeHYxZ0k5mXQQq4GqK/h49nQWH
         gsWCH9bXNVH/UdoBZQWxjut7NRbqC2qLf8C+pktQws/GfXbl1Ho3huwiIVceqtJmkTzv
         1eITTU3MTyXgt241wt/X4wUWxK1TqfqYyN2eoginctqwoNSnCKwz9P/uIWPCcpuPjpwu
         BKTyhGfp8wupFtwfIaesRHqyWB2b5qaVMvHWJQUfATPYjayxgGq81tvbtSR93O3XNa6V
         rqvDcTaKQrE7eAKPndjBKIIeopXbkXn49qYtFEGquexjjLf1/ktCKwpgeQsfDAqDdpOW
         z5BQ==
X-Gm-Message-State: AIVw111LLzscOUJpMMA+dr4awKXeCwbjR1S2IdoDtNlub1lRVXAA2NLY
        FleC3h2kbjMU54L3BfCg/EXLpFVv0g==
X-Received: by 10.36.61.1 with SMTP id n1mr4772115itn.32.1499795699853; Tue,
 11 Jul 2017 10:54:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.26.138 with HTTP; Tue, 11 Jul 2017 10:54:59 -0700 (PDT)
In-Reply-To: <B5FDF25C-ED5A-4CD1-AAD7-04BD8D705C59@gmail.com>
References: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
 <B5FDF25C-ED5A-4CD1-AAD7-04BD8D705C59@gmail.com>
From:   Nikolay Shustov <nikolay.shustov@gmail.com>
Date:   Tue, 11 Jul 2017 13:54:59 -0400
Message-ID: <CAEcERAxR_G-tVKsUZ7G97E5B8zCzBoqGqAK2U0fz-p5FvRwfUg@mail.gmail.com>
Subject: Re: "groups of files" in Git?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the idea, however I am having troubles with basically
maintaining the uncommitted groups of files: I would prefer the clear
distinction that "those files belong to feature A" and "these files
belong to feature B", before I commit anything. Committing separately
every change for feature A and for feature B would probably a good
option unless I have many changes and then cherry-picking the proper
commits to create a single changeset for the integration would become
a nightmare.

On Tue, Jul 11, 2017 at 1:39 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 11 Jul 2017, at 17:45, Nikolay Shustov <nikolay.shustov@gmail.com> wrote:
>>
>> Hi,
>> I have been recently struggling with migrating my development workflow
>> from Perforce to Git, all because of the following thing:
>>
>> I have to work on several features in the same code tree parallel, in
>> the same Perforce workspace. The major reason why I cannot work on one
>> feature then on another is just because I have to make sure that the
>> changes in the related areas of the product play together well.
>>
>> With Perforce, I can have multiple changelists opened, that group the
>> changed files as needed.
>>
>> With Git I cannot seem to finding the possibility to figure out how to
>> achieve the same result. And the problem is that putting change sets
>> on different Git branches (or workdirs, or whatever Git offers that
>> makes the changes to be NOT in the same source tree) is not a viable
>> option from me as I would have to re-build code as I re-integrate the
>> changes between the branches (or whatever changes separation Git
>> feature is used).
>> Build takes time and resources and considering that I have to do it on
>> multiple platforms (I do cross-platform development) it really
>> denominates the option of not having multiple changes in the same code
>> tree.
>>
>> Am I ignorant about some Git feature/way of using Git that would help?
>> Is it worth considering adding to Git a feature like "group of files"
>> that would offer some virtutal grouping of the locally changed files
>> in the checked-out branch?
>
> Interesting question that came up at my workplace, too.
>
> Here is what I suggested:
> 1. Keep working on a single branch and make commits for all features
> 2. If you make a commit, prefix the commit message with the feature name
> 3. After you are done with a feature create a new feature branch based on
>    your combined feature branch. Use `git rebase -i` [1] to remove all
>    commits that are not relevant for the feature. Alternatively you could
>    cherry pick the relevant commits [2] if this is faster.
>
> I wonder what others think about this solution. Maybe there is a better
> solution that I overlooked?
>
> - Lars
>
> [1] https://robots.thoughtbot.com/git-interactive-rebase-squash-amend-rewriting-history
> [2] http://think-like-a-git.net/sections/rebase-from-the-ground-up/cherry-picking-explained.html
>
