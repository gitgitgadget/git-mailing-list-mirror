Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D4A3202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 17:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbdGMREy (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 13:04:54 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:37191 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752072AbdGMREy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 13:04:54 -0400
Received: by mail-it0-f49.google.com with SMTP id m84so52184137ita.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 10:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lDDg/zw2rtAi8lrzXNfs4rByHia9fDHiSrxVG2zVWPs=;
        b=iU1lRSjDHc+TPIZbbDZTRfA4V2jgVSdY1hPYYWWVOPnV9GkpdV6EV0mdpvRddctvbi
         yv8CEEPvTuJve9yD4WCRNdy/qr45vXykLOHL6dPuWzBpIZ35O6IeCaxlVQHcGDZ2Q2B0
         E9ZsPnNPbQiJ86c7sbYy+ovxKMfU+yP6pmwpgLqmVW+RLUqdDyduBySGaa8t6b/MLDqV
         L0mm/9MCvx1lAuL2TE4FtdtY2EXuybJElwt4IqphAosaVvHAARTEg6qmFH5DmGFg/F5X
         z0OWYLjs4NBwbHqYg5dHkqc4eLYa9Y6uavyk+Z/j81Otm8kVLeW1itYFEP5ycS0HR+mN
         d9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lDDg/zw2rtAi8lrzXNfs4rByHia9fDHiSrxVG2zVWPs=;
        b=Dt6p92yPK4Zd5nOxSSVVsyDVEEBwTZQIcmY/+oxB/kzcFOyi8M2NQ8peqiZtbkwIGA
         WBGAeLonPGDMNdpORtO10dOpoHNoTAAN+MmU+u8Da4KGlk0ldRbaigulz8s4Q48N4O8j
         M1lSHriG/VS+76DpB9RzxqFUJlXmnIQMrnGEG1HDUYCvIxQk1YDQzVEcyind9zMWxtWe
         ZAEiHyg380l1dYiz4NRMC0dz7no5HNpDBXopYkvQbwRGuPbmZvG0ENIXc08c4mOs+ocU
         3RQRoTPsNOSGbpWcbfQYD26axw2tiAxPWzOWFqLcJhK/N54EeqflaK02i4WM/MbLLIrZ
         iyOw==
X-Gm-Message-State: AIVw110wnkyiP/NsFLG5VMVleNU2vopwGQLlT8c5bQDHyccOuko25m8m
        HyU8Eq4Ho0rmHEqpA69fVYYUzqy7Jg==
X-Received: by 10.36.172.77 with SMTP id m13mr27328579iti.59.1499965493127;
 Thu, 13 Jul 2017 10:04:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.26.138 with HTTP; Thu, 13 Jul 2017 10:04:52 -0700 (PDT)
In-Reply-To: <0793138e-5971-d8f6-b25e-215ed5028dae@eclipso.at>
References: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
 <0793138e-5971-d8f6-b25e-215ed5028dae@eclipso.at>
From:   Nikolay Shustov <nikolay.shustov@gmail.com>
Date:   Thu, 13 Jul 2017 13:04:52 -0400
Message-ID: <CAEcERAy_OnwzVXPQftm8-TEXF-G0kC4haKCP+CFm31vS8A2XPQ@mail.gmail.com>
Subject: Re: "groups of files" in Git?
To:     astian <astian@eclipso.at>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you taking time to think about my issue (I am actually grateful
to everyone in this e-mail thread, who did). I looked into Mercurian
MQ and it doesn't seem to fit what I need - from what I understood, it
speaks about the committed changes and those are not amendable. This
is kinda not what I need.

On Tue, Jul 11, 2017 at 6:27 PM, astian <astian@eclipso.at> wrote:
> Nikolay Shustov wrote:
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
> I never used Perforce and I'm not even sure I understand your problem,
> but I thought I'd mention something that nobody else seems to have yet
> (unless I missed it):
>
> First, one thing that seems obvious to me from your description is that
> these "parallel features" you work on are obviously interdependent,
> therefore I would rather consider the whole thing as a single feature.
> Therefore, it makes sense to me to work in a single "topic branch".
>
> This doesn't preclude one from separating the changes in logically
> sensible pieces.  Indeed this is par for the course in Git and people do
> it all the time by dividing the bulk of changes into a carefully chosen
> series of commits.
>
> I think the most common way of doing this is to simply work on the whole
> thing and once you're happy with it you use "git rebase --interative" in
> order to "prettify" your history.
>
> But, and here comes the part I think nobody mentioned yet, if your
> feature work is considerably large or spans a considerably long time it
> may be undesirable to postpone all that work until the very end (perhaps
> by then you already forgot important information, or perhaps too many
> changes have accumulated so reviewing them all becomes significantly
> less efficient).  In that case, one solution is to use a "patch
> management system" which will let you do that work incrementally (going
> back and forth as needed).
>
> If you know mercurial, this is "hg mq".  I don't think Git has any such
> system built-in, but I know there are at least these external tools that
> integrate with Git:
> https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools#Patch-management_Interface_layers
>
> Feel free to ignore this if I totally misunderstood your use case.
>
> Cheers.
>
>
