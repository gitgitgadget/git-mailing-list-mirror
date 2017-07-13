Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5073F2027C
	for <e@80x24.org>; Thu, 13 Jul 2017 23:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbdGMXkg (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 19:40:36 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34406 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbdGMXkf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 19:40:35 -0400
Received: by mail-wm0-f68.google.com with SMTP id p204so7921311wmg.1
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 16:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5bW4Hrb8Pa1PW8rtl9T5UsQYmVm39HER+dDREGILoQ4=;
        b=fl8SLHCWTDoWC2wnoF60++hcLWeVOGKpBvOBSSGo2hkmAqq9rbLQ+W37ex2QmAIBg6
         z9VHskXt8/t8CeLJX3N/GWH8F1LsYGQAEhWjcCoTDXbV25PJ/r//elyS6EgA3rTIp+p6
         c4lAldeg/8eGOsuhCcTAo5yCD1xxE1/ptXih2+CUZOHVKvzNXFTUU9/J7DrXXD+ZC8Ah
         yUxO1DLNX75HNGNQ4K8GibgqWXLVs9AG3++S6tesABUwHjp0nVEkTetm6J/mkzZGnT++
         BZSOSoACySUuNu0yc1/6GJB2K9xnZSO656tCW0C5f7hHjACW8U3JBEKWmRIO6+o+xwuM
         s6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5bW4Hrb8Pa1PW8rtl9T5UsQYmVm39HER+dDREGILoQ4=;
        b=b15gsMonjUwlC1DLPxdM1x0F4FkiXqM7fD+b4NCfFsJm/+39q/xzHJZMV1Ld+CoLKe
         JQzVRXwpGczghuFOoJhYtFjkCOdKnzp+zZzLnm33c0kqKEQ8bIjPg+rcts5eXYtsGuwa
         wUu+5UPO9fAHpe2/u6UGyUJH/3xIDJLu5X5iB1pNzdIm1SQlkpt9s064PQn2allkeJ+G
         YrU6RMwKK+5kpCWKupqZOOQhd/Z+M8BQedW9pyL1hmZoNY6XYOX9fRsQvC0XSm+nwGJW
         T7SVHKcdoQ1Nl6C9z5fVEJIkm/86V8FzkVEKLLkN98Xiv9FF9h5t051Hpvh1bxIT93UT
         +pHw==
X-Gm-Message-State: AIVw113mMOKM+XIC/uKN3SV44PN+QZw0Pmg1J3LO8mZxSjuHHuyXhLU+
        rczBRi9JgFNnkK2y++EmFg==
X-Received: by 10.28.66.208 with SMTP id k77mr551684wmi.89.1499989233848;
        Thu, 13 Jul 2017 16:40:33 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-63-71.dynamic.sbb.rs. [24.135.63.71])
        by smtp.gmail.com with ESMTPSA id o6sm6821132wrc.48.2017.07.13.16.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jul 2017 16:40:33 -0700 (PDT)
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
 <40292f8e-e8a9-8b7a-112f-ef4b183a6b35@gmail.com>
Message-ID: <d91f420b-8737-0c94-5a67-f3cb24c2ba22@gmail.com>
Date:   Fri, 14 Jul 2017 01:40:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <40292f8e-e8a9-8b7a-112f-ef4b183a6b35@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eh, yet another one, sorry:

On 14/07/2017 01:32, Igor Djordjevic wrote:
>     
>     $ git checkout featureA
>     $ git commit
>     $ git checkout master
>     $ git reset --hard HEAD^
>     $ git merge <HEAD@{1} parents>

The last line should stress <HEAD@{1} *parent branches*>, as we`re 
not merging exact parent commits the previous merge commit was made 
of, but updated tips of the branches the previous merge commit was 
made of... or something along those lines :)
