Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 549121F404
	for <e@80x24.org>; Wed, 14 Feb 2018 17:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161396AbeBNRr7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 12:47:59 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:44797 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161300AbeBNRr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 12:47:58 -0500
Received: by mail-qt0-f174.google.com with SMTP id f18so8698272qth.11
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 09:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GGH4rW0LUaS9/XNoagG6T5G7h6qIavbj3XycmpeLDyc=;
        b=DcZZWsQS54kaqlw2/U4lDuPmO7b6+3zx08TtyvzkmHgayP0JBbfKKniQA8pl1rRWgq
         Vmiwcbw2ESWnBKYoSoZKhwC/tl+zozEl9YMnaTLY8Y/zJJTRN3bR8fJV5mF00u6H9p3p
         oE3AG03XafsGR5lB3tJXxfiznEU8EJlzGeB3PwdDLAdcrhgPRNyjx4nPMQs6kQNU+qYl
         lpLaQZU9sTBfzJ5EgKMFHelCZijuLASJl8Mf6z2669lX2317pPDRyqkwnoTVWudUI2wD
         PurhfPe5RuADTN4Bpllo+rGq8gy85PPTh0HtJnjrz3COgXpAZyGeLiNQaFlmMjpckFyx
         c0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GGH4rW0LUaS9/XNoagG6T5G7h6qIavbj3XycmpeLDyc=;
        b=tv9HbaCjljYXc2fKN7hqkpSQWvYGOKjpWlwJyqXwYkJ6XoublQod7j+a33FSzhQApW
         rywFl2nRx+81XbVcxPf3/ebHfZmIrRJ3BIbsiw7cThEG43EEtIuz3NJCvp0VZErvBeb+
         Avn/QMvd+/u9OfcfH0scY5GNGiQu+ARSIyU6Rb5OBOlwFEZ00xzhciG6w0xfQyIP7Kkz
         W++8brYvpbvxNeP1Ctvdn56gQUzZFcBlN4YQ4IzNKDjrcU+hdUMsSUzZgwJOnbTktEAp
         ChlI8CPpjiC19b3/QNHOiVNUI+waDzycVwyHEF3HDwTM0bt/SAfb0tSw4Yy6bWsnLYXl
         xEXA==
X-Gm-Message-State: APf1xPD8Fq0PLV2iGQZOrE1V4ZgpwZbWANyCmxb9Gsc+XQGaUBb9Mid7
        85Ou5IubMv2JYCvaUiJuD5N1oBab
X-Google-Smtp-Source: AH8x224MPGzPsCIvz3ZUeG8jm2jDZb6fW65r24RrRNdVkwCXHiDRZ+WVd980r79xeVt6jSSqK7Orgw==
X-Received: by 10.237.37.196 with SMTP id y4mr9388752qtc.182.1518630477085;
        Wed, 14 Feb 2018 09:47:57 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id c26sm10259867qtg.38.2018.02.14.09.47.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2018 09:47:56 -0800 (PST)
Subject: Re: What's cooking in git.git (Feb 2018, #02; Tue, 13)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqq8tbwpcdv.fsf@gitster-ct.c.googlers.com>
 <8f014e98-8360-785c-fc5d-0664466057fb@gmail.com>
 <xmqqy3jvo57n.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7259deac-1d9b-fb01-e8dc-3ad7fdd8ecee@gmail.com>
Date:   Wed, 14 Feb 2018 12:47:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqy3jvo57n.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/14/2018 12:23 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> There have been a few "What's cooking" emails since I submitted v1 of
>> "Serialized Git Commit Graph" and it has not appeared with a tracking
>> branch. Is this a mistake, or is it something about the state of the
>> review?
> The latter.
>
> Once I pick up a topic and have it in 'pu', I'd be committing to
> carrying it and keeping it up-to-date, while dealing with possible
> conflicts with other topics.  As I do not have infinite bandwidth, I
> try not to chase targets that are still moving too rapidly, which in
> turn means that a hot topic everybody is excited by its goal will
> take more rerolls than other topics before hitting 'pu', because it
> gets more good suggestions and it takes time for its patches to stop
> morphing a lot.

Thanks for clarifying. That makes sense.

> The discussion in the last and current rounds gave me an impression
> that some stuff (e.g. "graph-head") are still likely to change quite
> a lot during the review-response cycle.  Is everybody happy with the
> latest set of patches or are there issues raised already in the
> review that are better addressed before we start making it interact
> with other topics in flight?

To avoid causing a tangent in this thread, I'll send a message on the v3 
thread summarizing what I plan to do for v4 and ask for consensus on 
that approach before I do.

Thanks,
-Stolee
