Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 785FB20A2A
	for <e@80x24.org>; Wed, 20 Sep 2017 17:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbdITRCY (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 13:02:24 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:56792 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbdITRCX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 13:02:23 -0400
Received: by mail-qk0-f169.google.com with SMTP id u7so3304411qku.13
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 10:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SX/en+0Jm5nZNMANKy/0LOUEnlFegNBstWIHdJ1wSGg=;
        b=BypmGuEK+6v5Lk0P3r2GFpPi+lyeALWIE61ZhHj4G9kfbpjOX/YG4i5uC6d6/p20Lq
         5tbFJQyp8THSs6ZqxXEyvuTSNWfresp7lEP5jul3DNR8S0ys3OWsN+7AlLb9zyZ15hIz
         nQf3CRecFNySlcBeOPnwUeNwg++QQxdG4tRqNC+lMC1Z2O6zTBoe6kk0FRWdmAFoH4mJ
         80c+uLYJkBnFSjx3hOIHdmJ5iXWWW+eIrwSh0/SiLTchMFHFj6Xudgy9Eezb4lLhkOz4
         IyK62oFA3IRdm2//ptu4ZttpXZSkYTm2HAfiIu9AWqprofAr7Y+8Xo7rDpQtmdy3OTqu
         WSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SX/en+0Jm5nZNMANKy/0LOUEnlFegNBstWIHdJ1wSGg=;
        b=TmXSUNjGQXztfmwGHx3eRukPXbC2QLBHLq3PcFlxFNm6Jmy8m3u6Bkl0TY/x6860tA
         vCsYOxftvi8Qih8lBC04od+X/youQxRlmWZnCqFPOkSbrS6Ntzk2n/HX/6EA55tOafit
         n8RRIPwDTw0O5q4T05tnH1o/1piesz5hgi07uOIqGJLxSeMWTeN26mWoXn1rYSYPOvjR
         b617ZWJDyg9e9z+O0BgoYnoA/mSpnRQ9UMAv68lUChYqchTboS0YagCOql5vdLCWUBOX
         W/4pUFXFpooJYRFniNhO6PaRb+Kl3ES1Hu97D7P/GP0IYTa6Fyq1vGK89zNAzSlDaXJR
         jAsA==
X-Gm-Message-State: AHPjjUjMtjrC9fUHog2ZsjOd6kOQUXo5/3MKkVyCMiW9BxivO3jkMZFz
        djhupXt+ixSMKCZNXKJqgIw=
X-Google-Smtp-Source: AOwi7QAc4PUrw5ca4bIMTQAgc+BuRZUllgt/Pd9odMXUYhWReBjzjy00fkRvooqlzQW3VLxhU6BZZQ==
X-Received: by 10.55.3.67 with SMTP id 64mr7687991qkd.307.1505926942147;
        Wed, 20 Sep 2017 10:02:22 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id u49sm1655394qta.85.2017.09.20.10.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Sep 2017 10:02:20 -0700 (PDT)
Subject: Re: [PATCH v7 05/12] fsmonitor: add documentation for the fsmonitor
 extension.
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     David.Turner@twosigma.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
References: <20170915192043.4516-1-benpeart@microsoft.com>
 <20170919192744.19224-1-benpeart@microsoft.com>
 <20170919192744.19224-6-benpeart@microsoft.com>
 <CAN0heSqFsm0BSUzufXjCKNv=JpRpUQzFA9GkKfA6nd_hPhW_qg@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <9cd0c22e-d044-b059-39d5-40b401b18b3e@gmail.com>
Date:   Wed, 20 Sep 2017 13:02:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSqFsm0BSUzufXjCKNv=JpRpUQzFA9GkKfA6nd_hPhW_qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review.  I'm not an English major so appreciate the 
feedback on my attempts to document the feature.

On 9/20/2017 6:00 AM, Martin Ågren wrote:
> On 19 September 2017 at 21:27, Ben Peart <benpeart@microsoft.com> wrote:
>> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
>> index e19eba62cd..95231dbfcb 100644
>> --- a/Documentation/git-update-index.txt
>> +++ b/Documentation/git-update-index.txt
>> @@ -16,9 +16,11 @@ SYNOPSIS
>>               [--chmod=(+|-)x]
>>               [--[no-]assume-unchanged]
>>               [--[no-]skip-worktree]
>> +            [--[no-]fsmonitor-valid]
>>               [--ignore-submodules]
>>               [--[no-]split-index]
>>               [--[no-|test-|force-]untracked-cache]
>> +            [--[no-]fsmonitor]
>>               [--really-refresh] [--unresolve] [--again | -g]
>>               [--info-only] [--index-info]
>>               [-z] [--stdin] [--index-version <n>]
>> @@ -111,6 +113,12 @@ you will need to handle the situation manually.
>>          set and unset the "skip-worktree" bit for the paths. See
>>          section "Skip-worktree bit" below for more information.
>>
>> +--[no-]fsmonitor-valid::
>> +       When one of these flags is specified, the object name recorded
>> +       for the paths are not updated. Instead, these options
>> +       set and unset the "fsmonitor valid" bit for the paths. See
>> +       section "File System Monitor" below for more information.
>> +
> 
> So --no-foo does not undo --foo, but there are three values: --foo,
> --no-foo and <nothing/default>. I find that unintuitive, but maybe it's
> just me. Maybe there are other such options in the codebase already. 

I understand the unintuitive comment but the other such options in the 
code base are just above the fsmonitor options as it is modeled on how 
'assume-unchanged' and 'skip-worktree' work.  Consistency is certainly 
helps the intuitiveness as once you have learned the model, it applies 
in other places.

How
> about --fsmonitor-valid=set, --fsmonitor-valid=unset, and
> --no-fsmonitor-valid (which would be the default, and which would forget
> any earlier --fsmonitor-valid=...)?
> 
>>   -g::
>>   --again::
>>          Runs 'git update-index' itself on the paths whose index
>> @@ -201,6 +209,15 @@ will remove the intended effect of the option.
>>          `--untracked-cache` used to imply `--test-untracked-cache` but
>>          this option would enable the extension unconditionally.
>>
>> +--fsmonitor::
>> +--no-fsmonitor::
> 
> Maybe "--[no-]fsmonitor" for symmetry with how you've done it above and
> later.
> 

For better and for worse, I choose to be consistent with how the options 
work (especially the untracked-cache option immediately above).  This is 
one weakness of reviewing patches via email - you don't see the patch in 
context with everything around it.

>> +When used in conjunction with the untracked cache, it can further improve
>> +performance by avoiding the cost of scaning the entire working directory
>> +looking for new files.
> 
> s/scaning/scanning/
> 

Thanks!

diff --git a/Documentation/git-update-index.txt 
b/Documentation/git-update-index.txt
index 95231dbfcb..7c2f880a22 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -476,7 +476,7 @@ inform it as to what files have been modified. This 
enables git to avoid
  having to lstat() every file to find modified files.

  When used in conjunction with the untracked cache, it can further improve
-performance by avoiding the cost of scaning the entire working directory
+performance by avoiding the cost of scanning the entire working directory
  looking for new files.

  If you want to enable (or disable) this feature, it is easier to use


>> +If you want to enable (or disable) this feature, it is easier to use
>> +the `core.fsmonitor` configuration variable (see
>> +linkgit:git-config[1]) than using the `--fsmonitor` option to
>> +`git update-index` in each repository, especially if you want to do so
>> +across all repositories you use, because you can set the configuration
>> +variable to `true` (or `false`) in your `$HOME/.gitconfig` just once
>> +and have it affect all repositories you touch.
> 
> This is a mouthful. Maybe you could split it a little, perhaps like so:
> 
>    If you want to enable (or disable) this feature, you will probably
>    want to use the `core.fsmonitor` configuration variable (see
>    linkgit:git-config[1]). By setting it to `true` (or `false`) in your
>    `$HOME/.gitconfig`, it will affect all repositories you touch. For a
>    more fine-grained control, you can set it per repository, or use the
>    `--fsmonitor` option with `git update-index` in each repository.
> 

I'm going to sound like a broken record here. :) The description favored 
consistency with the untracked cache feature immediate above this entry. 
  It is literally a copy/paste/edit.

This is based on the assumption that the text had already been reviewed 
and found to be acceptable.  This also means if you have figured it out 
for one option, when you read the next, you're understanding can carry 
forward speeding up your comprehension.

> The part about $HOME/.gitconfig vs per-repo config is perhaps generic
> enough that it doesn't belong here. So it'd only be about config vs.
> option. Where to place the config item and what implications that has is
> arguably orthogonal to knowing that the option exists and what it does.
> 
> Martin
> 
