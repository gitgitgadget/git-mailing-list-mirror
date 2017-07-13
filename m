Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0B122027C
	for <e@80x24.org>; Thu, 13 Jul 2017 23:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbdGMXdA (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 19:33:00 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32849 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbdGMXdA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 19:33:00 -0400
Received: by mail-wr0-f194.google.com with SMTP id g46so139167wrd.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 16:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mJAmszMEvTLuG4A1nyB/yXFQMy6jZLphZFUduo2Mn9I=;
        b=EkgHGK8CzeSbxxKnGFH1EKi9hx5BnTuXRT5quSHK0a5JoITF+KJ7UHRr1fxD/MZklw
         pNZ4cSoH8vHWj2R7nhmRkSbjyo1QUNkAIonTKqkaOPVerWL9urQ3L6jqJ/t9M0wxq6nC
         DS27NHRGc+B1WRJAwLnFjeGmASv5oHhjNUGsECNlfWX02GfGo6xoN+JNc/ZJmiyCe7cA
         tMjBwYbZUFdyl+BCbKyW3EOaGQkHUjWiLScYKnP4eYoQbbswX6lxzkpCtcwP/mtv9vM2
         iezCK1nHz8X2lRVhK6jX8WoSOkTaZO68xi9HHkHN+LZD8aMgiImxhq/PNmvGHtEYSrHi
         xMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mJAmszMEvTLuG4A1nyB/yXFQMy6jZLphZFUduo2Mn9I=;
        b=V9rcdj4DfSc4n1iRiGS3B8N9USre4TEltIol/3SfAzM5hSAJG/CAqlhROyQWlhOYYT
         iICpn7fPTtJHNcvKuvYdlEqZ/7WWWtonJNUr28tOABOFTUJ1vsYbzqQAGBuW5tpk/TB9
         Chg4yknSHz8Vhbm5oRc/uHCoQIL245zDOe8G628gVWtLU/1W2Gh+LRZ9F3ion6ZYh3fl
         XFibwrmkV8v3cQDDwI4S5lATOh492w3Q+8tNOzJ0Vp7YaTRtr7z/YQSnv27WQn3xoMCK
         r1rOcbcjo6s1oWBJb4oU/dE9XTW+btMS2Lz68Cs0RUGmVrqNTAPxT2rd1nXjJ3fKN+FV
         iV/g==
X-Gm-Message-State: AIVw111HEG/nFieEyk/OootJOFJOUfHWOhDHiJOt9vnLUCD5E/IWp8MJ
        Zv62KsrjHGS8EnCzqH11Aw==
X-Received: by 10.223.132.163 with SMTP id 32mr3236586wrg.204.1499988778374;
        Thu, 13 Jul 2017 16:32:58 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-63-71.dynamic.sbb.rs. [24.135.63.71])
        by smtp.gmail.com with ESMTPSA id j190sm847183wmd.22.2017.07.13.16.32.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jul 2017 16:32:57 -0700 (PDT)
Subject: Re: "groups of files" in Git?
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Nikolay Shustov <nikolay.shustov@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
 <CAGZ79kZaf7=uwCPJoPoDiAO9QS21bchaKZvDzWJi=ewPZw9PXQ@mail.gmail.com>
 <xmqqiniwxkmj.fsf@gitster.mtv.corp.google.com>
 <CAEcERAxJRnB55Ardhs7LDW8M8EG-y+YE-He8hiiQv3wDqtVD3g@mail.gmail.com>
 <xmqqzic8t4oi.fsf@gitster.mtv.corp.google.com>
 <27a3c650-5843-d446-1f59-64fabe5434a3@gmail.com>
Message-ID: <40292f8e-e8a9-8b7a-112f-ef4b183a6b35@gmail.com>
Date:   Fri, 14 Jul 2017 01:32:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <27a3c650-5843-d446-1f59-64fabe5434a3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just a small update/fixup:

On 14/07/2017 00:39, Igor Djordjevic wrote:
> I guess it would be a kind of alias to doing:
> 
>     $ git checkout featureA
>     $ git add ...
>     $ git commit
>     $ git checkout master
>     $ git reset --hard HEAD^
>     $ git merge featureA featureB
> 

This should, in fact, be:    
    
    $ git checkout featureA
    $ git commit
    $ git checkout master
    $ git reset --hard HEAD^
    $ git merge <HEAD@{1} parents>
    
(removed "git add" step, as that is needed for proposed single step 
solution as well, as a usual step preceding the commit; also replaced 
concrete branch names in the last step with a more generic 
description, better communicating real intent)

> In the same manner, it should be possible to drop a commit from the 
> feature branch in a single step, for example returning to the state 
> as shown in (1), or even "port" it from one branch to the other, like
> this (without a need for it to be the last commit, even):
> 
> (3)      o---o---o---\ (featureA)
>         /             \
>     ---o---o---o-------M' (master, HEAD)
>         \             /
>          o---o---A'--o (featureB)

Here, the diagram should look like this:

(3)      o---o---o---\ (featureA)
        /             \
    ---o---o---o-------M'' (master, HEAD)
        \             /
         o---o---A''-o (featureB)

(replaced leftover M' from the previous diagram with M'' to show it`s 
yet another (updated) merge commit, different from both M and M' in 
terms of SHA1, yet the contents would probably, but not necessarily, 
be the same for all three; same for leftover A', replaced with A'')

Regards,
Buga
