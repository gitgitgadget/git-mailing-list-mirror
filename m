Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECBDC202AF
	for <e@80x24.org>; Thu, 16 Nov 2017 11:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934108AbdKPLKa (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 06:10:30 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:57046 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932744AbdKPLK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 06:10:28 -0500
Received: by mail-pf0-f196.google.com with SMTP id q4so11242507pfg.13
        for <git@vger.kernel.org>; Thu, 16 Nov 2017 03:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6bUniDoJCQdg5r6nil4T9PrMBD5r5kwoJROPgMEbT40=;
        b=qOLh00SqdQ6M5NAoDp8gF4byLY7r3OpQIWREGrm5DMv0N99RgUGGyB38JBdTEfgg69
         hYVvsOxKxBu+mnEqCMNR+ZBbsGpraIQF4ma15j0Lx+fRtQiVhaL2x/27OjicvC+RGqcz
         dgbx1SDM65ZyE4qoFqizILPoqCTceiPa3x2ufKNre/WdiQFqqKwew3x5Yon7hSNCR6ev
         x0XCSSnJrZk2x/unBlXMjppOHnBMtE//cNG5UEj0o4AlZulQkC5YHPxb023EG85EVgWv
         FdA1coUZvZgOzWByvZsK62aOFyEu03Kv63NdOTliSAoufHTZn1ciYeoTLFG2soRD+LLT
         N0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6bUniDoJCQdg5r6nil4T9PrMBD5r5kwoJROPgMEbT40=;
        b=Hru/Sz3q2yVpHFQos7C9bVTVY6xOAz9Yh83RqL72VYKs1ahK638vt6HXbO9JVnpUV6
         HHV8r47es6ks36kwnbMtqzpr7qMN6gvFdF06dIdHTTmDyOtLyP8iQsP+gxIauKFQf4oU
         657fG8iPbdaWxfHBMSfVAhe+WYZcfh2VlGHesrDpFgY6dV9u2+dZQ05Z4TpW09sJJ1E8
         VfOyrUr/KJANuWj7FStK6yuG/LO1AUHlMUP1BYSmjcf7G+JVWupjsMWttupGIH6OLdtI
         crZBk7UPRCzi+xXbEzuNmdz7jJoaaHqubW0jJfhTcDXFAuDCO1Y7CGmSaHu9DaiOJnIC
         pOag==
X-Gm-Message-State: AJaThX6uKqjGfWX7H45A3PogvdplAWq5po0oypU2kEz23sG3IGKjPD4E
        WqTqpa6bYxKGB0qgLkpLbztjgCgo
X-Google-Smtp-Source: AGs4zMYIWanHxN1VHN8Q199woiVkcwDNb6DcjbKSAP8Mn/YA4VsNedzeCsd8zoL50eaSHzIQ2KwtvA==
X-Received: by 10.99.110.3 with SMTP id j3mr1342179pgc.70.1510830627888;
        Thu, 16 Nov 2017 03:10:27 -0800 (PST)
Received: from ?IPv6:2405:204:72c0:fc36:f2a4:a5ab:70fc:f807? ([2405:204:72c0:fc36:f2a4:a5ab:70fc:f807])
        by smtp.gmail.com with ESMTPSA id n129sm2501054pfn.1.2017.11.16.03.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Nov 2017 03:10:26 -0800 (PST)
Subject: Re: [PATCH] branch doc: remove --set-upstream from synopsis
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20171116074643.19614-1-tmz@pobox.com>
 <CAN0heSpUm=U7aGVtRoUoGZCvNsOZ04wLqTOx8kMvZEa8GQUiLQ@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <493127ce-2596-fb93-993d-042097ca19bc@gmail.com>
Date:   Thu, 16 Nov 2017 16:40:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSpUm=U7aGVtRoUoGZCvNsOZ04wLqTOx8kMvZEa8GQUiLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 16 November 2017 04:19 PM, Martin Ågren wrote:
> On 16 November 2017 at 08:46, Todd Zullinger <tmz@pobox.com> wrote:
>> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
>> index d6587c5e96..159ca388f1 100644
>> --- a/Documentation/git-branch.txt
>> +++ b/Documentation/git-branch.txt
>> @@ -14,7 +14,7 @@ SYNOPSIS
>>          [(--merged | --no-merged) [<commit>]]
>>          [--contains [<commit]] [--no-contains [<commit>]]
>>          [--points-at <object>] [--format=<format>] [<pattern>...]
>> -'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
>> +'git branch' [--track | --no-track] [-l] [-f] <branchname> [<start-point>]
> 
> Personally, I think this is an improvement.
>

I didn't remove it as there wasn't a "strong" consensus that this should 
go off the "Synopsis" at that time. If removing it from the synopsis 
seems to be better than leaving it, then lets do it. Further, I think we 
should make this some kind of "guideline" in this project to remain 
consistent. Something like,


     * If you deprecate an option of a command to an extent that it's not
       usable at all, remove that option from the "Synopsis" of the
       concerned "Documentation".


possibly to "Documentation/SubmittingPatches" or at least keep this as 
some form of undocumented guideline if this might make 
"Documentation/SubmittingPatches" unnecessarily clumsy. I dunno, was 
just thinking out loud.


>>   'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
>>   'git branch' --unset-upstream [<branchname>]
>>   'git branch' (-m | -M) [<oldbranch>] <newbranch>
>> @@ -86,7 +86,7 @@ OPTIONS
>>   --delete::
>>          Delete a branch. The branch must be fully merged in its
>>          upstream branch, or in `HEAD` if no upstream was set with
>> -       `--track` or `--set-upstream`.
>> +       `--track` or `--set-upstream-to`.
> 
> Good catch.
> 

Yep. Thanks for catching this.


---
Kaartic
