Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CF2820248
	for <e@80x24.org>; Tue, 16 Apr 2019 15:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfDPP1q (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 11:27:46 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:43039 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfDPP1p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 11:27:45 -0400
Received: by mail-qt1-f173.google.com with SMTP id v32so23707852qtc.10
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 08:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=RirCq7udz4Mtgx1wCRWbqSAp/RZs+tq3ceJGITrxEDs=;
        b=NWa1urVffpqxxjgHygJtm6ExSgDr1QFjhob1xLlUFkNEqe6Yi37d2Dueu0bjuNYXPm
         VV/rkT735OWdMCxNIaAlWiUiLvORfKYZbMx+mSDPe6xg+m4BBsUJWnAqtAn+RcRS3YQo
         vBW5j3u8flDxGbBjjKWPwmVoFs1xO2MQ667dBEWUCO2LMvE0ljjJUcMGaMD8RJESgHg1
         QW5HI6dnPGW1YIUHjpbSQNInLKzK37m5B0pHOeqDc1S2sUZ4szqw/auX20icIIOyOUZ5
         jnc1pHo0w94XJyPfEOJNxZ0rI5ly1swa1ipAfp0ZyYYaMRoDN8F9/FXWBC2xp0GSvbOi
         QeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RirCq7udz4Mtgx1wCRWbqSAp/RZs+tq3ceJGITrxEDs=;
        b=HTRaFDDuXxd4HUkRrU6Voiy0jNFDRacnB2EtL3NrAdqjMi3OZ/KOxfqK958zqhpzf2
         SsdAXGC1voTn9PrhvhGC7zTEcXXpTFXdqdol72wMN420WLIhsHFj28twD9f34Pm4EnZn
         V7guxrRNRTmdOhgmrSIaoMF10Xrq6DqEUj/HSQ9Xlj97GzTRuv+iyM+mNjgOABxedgeg
         MQLcz9zJsRkte9n14OHHQtEAas1Vm6DTMKF0TeQyoMDDFx/NSRa77aMaGmehmywpmhcW
         UKo3nnd8j+qBpbtmnTLqfq5dkfmB1fYKM2TbQArxirJdl7NczM/d18cmvIx3DOHvV+Tc
         UmPg==
X-Gm-Message-State: APjAAAWXx5y8mV1MwmZa1EtLXxda9W2w7T6rkabEyx0IncJbS36tvObw
        LEmUWYddd4EH1hC5WCDvLEZczpf3
X-Google-Smtp-Source: APXvYqz8ykgZAfjIxKA849Ng/Ov2HlBap1Mif6xB+R8UETbOTE2RAPJ7lN59oygo4CceI4qUgoLo2Q==
X-Received: by 2002:a0c:b3c4:: with SMTP id b4mr68695324qvf.176.1555428464036;
        Tue, 16 Apr 2019 08:27:44 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id x2sm26843265qkj.59.2019.04.16.08.27.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 08:27:41 -0700 (PDT)
Subject: Re: What's cooking in git.git (Apr 2019, #03; Tue, 16)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <a65a261d-a8dd-7610-bcaf-47071df1d659@gmail.com>
Date:   Tue, 16 Apr 2019 11:27:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/16/2019 9:19 AM, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
> 
> Yet another batch of ~30 topics have graduated to 'master', and
> 'next' has also gained ~25 topics.  We may want to start merging
> down fixes to 'maint' for a 2.21.1.
> 
> You can find the changes described here in the integration branches
> of the repositories listed at
> 
>      http://git-blame.blogspot.com/p/git-public-repositories.html
> 
> --------------------------------------------------

<snip>

> * bp/post-index-change-hook (2019-02-15) 1 commit
>    (merged to 'next' on 2019-03-11 at cb96d1d7c4)
>   + read-cache: add post-index-change hook
> 
>   Originally merged to 'next' on 2019-02-23
> 
>   A new hook "post-index-change" is called when the on-disk index
>   file changes, which can help e.g. a virtualized working tree
>   implementation.
> 
>   Will cook in 'next'.
> 
> 

Anything in particular this is waiting for?  I'm unaware of any requests 
for a re-roll. If something is needed, please let me know.
