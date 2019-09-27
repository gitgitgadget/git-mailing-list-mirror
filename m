Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 405471F463
	for <e@80x24.org>; Fri, 27 Sep 2019 09:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfI0JZr (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 05:25:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36693 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfI0JZr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Sep 2019 05:25:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so1903843wrd.3
        for <git@vger.kernel.org>; Fri, 27 Sep 2019 02:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=amNBGUETJxJnpE0ntoD9UTA2aCN5eC/sTPE6ctaWMLc=;
        b=TXklujKfGKKNAYT9C6Qgi4RVxpjEDS9sBnxJfOOH1xf3N/+CQWMwSbfOVlkN5YY6nJ
         TfkUOHj83xKub2mzhpPP3qqTXAM5ruSw/Rddv0fLwO0gUQ2xNJXO2YTDdWcMzBokHeKc
         mtYW7q7h/ce3zpeEAJLbVp2AHitD16ga5K0WOqUTWFNPZWXNuTVT1tl6ubo0F1JHuqsO
         ywapyXgaczldmg0O4dACqpq+awFmtToWXFYhr4rxhDaHbp8hVGES/EwWxr7ZUWiHuuei
         BSwvOUJV83oZh/kiYGjb00KZ3BTw9pzp43Oy5ZiIefXEmMyv7Vxi4Ou3x/IK1iCm6Saf
         OQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=amNBGUETJxJnpE0ntoD9UTA2aCN5eC/sTPE6ctaWMLc=;
        b=SsTZAimXs6yuKboUmpitV4+hIHml+PcCJfzterTlcXnLwtCRDqPa0kMcQoVFN3K7qg
         RrGuxoenI0ezkwvivT4MuRExEk2PAZaZDL/abLWoGXZl2xuIuvHf7Hih5ibRL6MAdfwg
         RfGaXIjx6MN0ec/aAb2ZmITG+GWkzf09E9xWu3vwafGE1/5dGrHs45n95ympSOhrc2zX
         tjIAddsRHFYnBf/YqtPpsPMWlaxOEC3C6d1RWKllFUkWIU3sD9Ntdp7oAr3k19IOOudP
         XdF74zEcFzAfiVpZHof7MQQKdno35hZkFPYz5yWceXS8rbhUEOv1dsXlvVgaUwMS01nL
         iseA==
X-Gm-Message-State: APjAAAWhl7k7xMDkZw1hhEl/QAf2YPFJAyGWQlgBFSTTa0IXsdMI1Rh7
        bDai1POYvVHs5HX2BVHhek4=
X-Google-Smtp-Source: APXvYqx+MK41ACxqq1uW+q83u7phjJaU29GV8SFe7gtEnSxxEm7EiHEISBMPHaMPS+zOdyoQZmoUOg==
X-Received: by 2002:a5d:4f11:: with SMTP id c17mr2284844wru.227.1569576344680;
        Fri, 27 Sep 2019 02:25:44 -0700 (PDT)
Received: from localhost ([2.31.128.161])
        by smtp.gmail.com with ESMTPSA id a192sm5669636wma.1.2019.09.27.02.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Sep 2019 02:25:43 -0700 (PDT)
Date:   Fri, 27 Sep 2019 10:25:43 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Beyondhorizon Zheng <byndhorizon@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [git issue] git am failed for patches of converting the format
 of source codes from dos to unix
Message-ID: <20190927092543.GE11444@cat>
References: <CAP2YDYhfA__VYe-Kt3FwjPMzJ1jVo8X9eQ-pHR4MhQWypkrkKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP2YDYhfA__VYe-Kt3FwjPMzJ1jVo8X9eQ-pHR4MhQWypkrkKQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27, Beyondhorizon Zheng wrote:
> [git issue] git am failed for patches of converting the file format of
> source codes from dos to unix
> 
> Git version: git version 2.23.0
> Host PC: ubuntu 16.04.10
> Reporter: Shuang Zheng
> 
> I have submitted a patch which convert the file format of source file
> from dos to unix with command:
> dos2unix misc/acrn-config/config_app/controller.py
> then submit a patch with this change:
>         git add controller.py
>         git commit -m “change file format”
>         git format-patch HEAD~1

Here you are preparing a patch of your last commit.  Good.

>         git am 0001-change-file-format.patch

Running this right after 'git format-patch' will try to apply the
patch, but your latest commit already includes those changes.  So
there is nothing to apply, and 'git am' fails.  Normally you would not
use 'format-patch' and then try to apply the patch again, but rather
send it to someone else, who could then apply your changes.

You could use 'git am -3 0001-change-file-format.patch', which falls
back to a three-way merge, which should tell you something like:

    No changes -- Patch already applied.

If you want to check that the patch applies correctly, you can use
'git reset --hard HEAD~1' (make sure you don't have any untracked
changes you don't want to loose first), and then use the 'git am'
command from above.

Hope that helps.

> errors as below:
> Applying: change file format
> error: patch failed: misc/acrn-config/config_app/controller.py:1
> error: misc/acrn-config/config_app/controller.py: patch does not apply
> Patch failed at 0001 fix format
> hint: Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
