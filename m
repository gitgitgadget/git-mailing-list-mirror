Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 881C4200B9
	for <e@80x24.org>; Tue,  8 May 2018 17:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755051AbeEHRFj (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 13:05:39 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:38985 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754903AbeEHRFi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 13:05:38 -0400
Received: by mail-qt0-f169.google.com with SMTP id f1-v6so41966397qtj.6
        for <git@vger.kernel.org>; Tue, 08 May 2018 10:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=O8z4X+/NFK0jKl7ljmHaLPkPJOQitw+9/jJKTAUmkDM=;
        b=We3yteEe3eszigu7/FcS9nHyek7tOtXr7d9YeiXh9WGzxfnc9jZSuveOj+F+M0fsXQ
         L8WS0+EzWHUUpnsOYiLYTbp6mSsMAFlGU0u8SL5XiMAnkpKZ4fd/sGp0HhMqFaLPVI/K
         P8Eitdc0eYseVTPUPU8/1cTiidqBnefI392h8PDW6IjLGwY4P7txwWnYynThP9vwPuVd
         +Yvru0/D9yBRPk1uYsjndUJT+LfFzifm8vzOebvzHp1ZGAM1ePa8yu/dp8P3Ldq+QxoU
         WlGM9oekvccHXIZkFV/WnZxO0zMa8sg5Shvvdc7yJ4dO1nRzgkwi07a/28UQCPmnv9kd
         gYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O8z4X+/NFK0jKl7ljmHaLPkPJOQitw+9/jJKTAUmkDM=;
        b=B/r0H/t+L4Pb4L2lgc3mwPLiL8zZ0UWpk4bfuv3e1FMnf1ZR5RKhulgGUDK4pezGwW
         TdrCYoytuF4ZOIa8MUxPjUpDc4nmTIyqOqrRCGG2YkFQzOTHicUGD3CzY9ayMei1vk9u
         QkgE+q72E9kdoBLzBA4t7o2qm03rNHhu9D9tor/z9a3oAhZjht5ArGORoVWOXb1C43ub
         mqsviEjpEpF85Sqzgmwmnb0kIFTijD9R2mGZRPWYBIxOBwq9F8LTUMb9lUJECtuaaw7w
         h9QmfrAVHAknUeFdQtiTb8KRobiB3HZHennbZRlqSn8X20YFVUst8y/rGhxA2nhMQZQ/
         gyGg==
X-Gm-Message-State: ALQs6tBqsmEi5Eax18u9pZdCTsOW84EYIR8wJi9qKhDPv8VPlkptXj9a
        N38+HswSYtxdTci4Lk04pn6yuk/s
X-Google-Smtp-Source: AB8JxZpKmZdRXp2Dx+l4p9B0IdjJPWebqt2tz8vwB6+BqOjBJ+1IhHQVwJ6qcH/hZdDNoQMEPY94LA==
X-Received: by 2002:ac8:1682:: with SMTP id r2-v6mr39165059qtj.40.1525799137326;
        Tue, 08 May 2018 10:05:37 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id x40-v6sm21751469qtb.40.2018.05.08.10.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 May 2018 10:05:36 -0700 (PDT)
Subject: Re: What's cooking in git.git (May 2018, #01; Mon, 7)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqa7tbpl5q.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <b58358de-3590-64b2-1db8-9cee9de92ed3@gmail.com>
Date:   Tue, 8 May 2018 13:05:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqa7tbpl5q.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/7/2018 10:58 AM, Junio C Hamano wrote:

> * bp/merge-rename-config (2018-05-04) 3 commits
>   - merge: pass aggressive when rename detection is turned off
>   - merge: add merge.renames config setting
>   - merge: update documentation for {merge,diff}.renameLimit
>   (this branch uses en/rename-directory-detection-reboot.)
> 

It isn't specifically called out here but is it safe to assume this is 
also headed to next behind en/rename-directory-detection-reboot?


