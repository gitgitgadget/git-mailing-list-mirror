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
	by dcvr.yhbt.net (Postfix) with ESMTP id B18881F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 18:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfKSSBb (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 13:01:31 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:54408 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfKSSBb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 13:01:31 -0500
Received: by mail-wm1-f54.google.com with SMTP id z26so4196149wmi.4
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 10:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ylNa7TaHkfv+t9R4AMo694wQ9SYiNDn6+IGEGrX2Cz4=;
        b=rV0nDc64mRbQb8xGDIUdmcX/EFmPtjnN4NTErzPhQP47DLN1tbcQejnAHYQdGjUcDm
         nQAfU62bffJKi8fM017HjYE6IZfYOaScz3a8jnwom5E3cevuptpXap1qw+tLJCIv9DON
         Tho3RBXexZ9it6LOFio+t565f6+AkiHmvparVQm7bFqwP8tiigYKUc3rOFAClyEFqckV
         xUPHlkbmx06tBbeXMxgUfQOAyxrwvv0hGVWkA6noBLoSpoq3248QLQGhy9Cz7tgXik7X
         l9Rn4gG3vkvUX9Bgf0KHL4pgLZDDPlXJaWa1Ku7Qwb9tK41qe7ykaZv/DTf5OIFLU/zy
         62dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ylNa7TaHkfv+t9R4AMo694wQ9SYiNDn6+IGEGrX2Cz4=;
        b=EOqZJehTZckKEonrD0Bfq2HotCMBbV5mrdrYzmoOT+iL3/JSaFbeFDMKqHnFwfXcct
         Fl92CfT/Pka+pNYLnBULNZO9Umq8hkZ/b9vK0pIKXCdib7Il+R6/7f8HwLAWfLtl4/P6
         oJLsVciPArc7TSL8isu2108ZIttiH+v3GjQMkSJY5QNkK/7BHmwQc8zpMW7W/T2++0ay
         x47oNxXd4F/mNJR1IRIZxoR3KA9+30CJOCdKV8yZjTrhSWTKbOtZ56RNBg1icZM0Fp7I
         gxPew+08rIBtd11WikFxsewneHpFKUoEaKnYGhpGitZuogOE9lq4z8oo8L3OKX4EpSjn
         KlbA==
X-Gm-Message-State: APjAAAXvPSVCz4UgniEtYpTVYofOsElqM5nlJHmiSu94bpvrNmDYT/kJ
        9tNcqgnjWWUO7YboJGoDK48j7z/x
X-Google-Smtp-Source: APXvYqwO3nB5BDwanwLn4OKUmDs+oc2ktFfT+k/EdkYpcKhomXM11XnfdJIR5oNsI2mBzIH3827vFg==
X-Received: by 2002:a1c:96d5:: with SMTP id y204mr7113927wmd.63.1574186484402;
        Tue, 19 Nov 2019 10:01:24 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-658-1-6-103.w86-222.abo.wanadoo.fr. [86.222.149.103])
        by smtp.gmail.com with ESMTPSA id r2sm3982060wma.44.2019.11.19.10.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 10:01:23 -0800 (PST)
Subject: ag/sequencer-todo-updates , was Re: What's cooking in git.git (Nov
 2019, #03; Tue, 19)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqftikxs4z.fsf@gitster-ct.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <3e616116-2f6f-acff-91b3-4aefc7e62653@gmail.com>
Date:   Tue, 19 Nov 2019 19:01:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqftikxs4z.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 19/11/2019 à 08:05, Junio C Hamano a écrit :
> * ag/sequencer-todo-updates (2019-10-28) 6 commits
>  - SQUASH??? tentative leakfix
>  - sequencer: directly call pick_commits() from complete_action()
>  - rebase: fill `squash_onto' in get_replay_opts()
>  - sequencer: move the code writing total_nr on the disk to a new function
>  - sequencer: update `done_nr' when skipping commands in a todo list
>  - sequencer: update `total_nr' when adding an item to a todo list
> 
>  Reduce unnecessary reading of state variables back from the disk
>  during sequener operation.
> 
>  Is the leakfix patch at the tip the only thing that needs to
>  prepare the topic ready for 'next'?
> 

Yes, it is.

Cheers,
Alban

