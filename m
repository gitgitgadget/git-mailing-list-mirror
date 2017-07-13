Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F28DF20365
	for <e@80x24.org>; Thu, 13 Jul 2017 23:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752298AbdGMXGx (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 19:06:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34410 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbdGMXGw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 19:06:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id p204so7829609wmg.1
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 16:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QIcGx9OsoyyJSCmAKGJCy5cfmC1WvT+Yl8MDRpMVk6A=;
        b=D0KG2OTTsMa7J/Ar+Nvs6aKL/w1ndZcUWx4oC+Sgg8x85tuGjSMxn6vdMOAchuvBe2
         qcuahfgReUJSvwnQwwrcBWOAA2HQCrgpzjbuVXMstTMjhbBZErvwo3gBMcp0AGQnCCdA
         TWf7zm57sBtvMXzB26d4hCRvgtHrwCcD3wurwwWitQGOOoqGcJI60R3AcU0ng5L7hgOM
         6OmUrwYPWLIgrcHrQGCrlL46MCYK39mbyebIrWJMBo2NQFOUDmuTb1fW4MFshGB1Mg9v
         sdTBSwrgJbWSecx9pZGM3HcG8V7GQGcxwiNMdB+SfJlf2dOXB6Davzu8Y8Lciz4lAk/8
         wT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QIcGx9OsoyyJSCmAKGJCy5cfmC1WvT+Yl8MDRpMVk6A=;
        b=O2Xkb5V+NiQpY8O58OoVYN1v3hr/yLWZI+TteyCnRd5cF7w5s5YDzZl9J3W6xoBKT3
         Z/cimjtVKsfwJrgDYW0UYSNs9P72Uyzu68sI7OVJC38sX4S6ScCHbml7qf1TfUuHjZyT
         jVNay8oCJTqpWT1eGoZGEE2T0xeemAoHTcMcDKr7pflD3N4qM/MOcQxiQAQBGKPWEev5
         VR9DUOzJWUgSi4UJ7cC9dd9ur8Td1kNLU2wzoG/+IT4Vq/q+OnbFmY9tNhFsJxx867hC
         GofSeLK1dX9167d6g+8cP/u9jQrJFrjbF5xnpCJ187w/3+xvLR+5fnkVchrUCZZI7ao9
         HOFQ==
X-Gm-Message-State: AIVw113pBs/d3ZcTH0O4d7Ku2reRMZ+o2kJJcS/mqfPuZvQ9Gr52bkp4
        dZTYHm9Epxa+5w==
X-Received: by 10.28.157.205 with SMTP id g196mr582342wme.84.1499987210927;
        Thu, 13 Jul 2017 16:06:50 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-63-71.dynamic.sbb.rs. [24.135.63.71])
        by smtp.gmail.com with ESMTPSA id 9sm829230wml.25.2017.07.13.16.06.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jul 2017 16:06:50 -0700 (PDT)
Subject: Re: "groups of files" in Git?
To:     astian <astian@eclipso.at>, git@vger.kernel.org
Cc:     Nikolay Shustov <nikolay.shustov@gmail.com>
References: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
 <0793138e-5971-d8f6-b25e-215ed5028dae@eclipso.at>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <ee79581c-d1ad-42c8-945a-505efad1037a@gmail.com>
Date:   Fri, 14 Jul 2017 01:06:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <0793138e-5971-d8f6-b25e-215ed5028dae@eclipso.at>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi astian,

On 12/07/2017 00:27, astian wrote:
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
> Cheers
This message actually creeped me out the first time I read it, after 
writing an e-mail reply of my own[1].

The tone it`s written in, the points you make, and even the 
conclusion about "hg mg" -- as if you were reading my mind.

Yours was sent a bit before mine, but I guess we were writing it at 
the same time as well... Just spooky, lol.

That said, I totally understand what you`re talking about, and I gave 
an example of the desired (yet missing?) Git work flow here[2] :)

[1] https://public-inbox.org/git/6e4096fd-cbab-68f0-7a23-654382cb810e@gmail.com/
[2] https://public-inbox.org/git/27a3c650-5843-d446-1f59-64fabe5434a3@gmail.com/

Regards,
Buga
