Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6525620754
	for <e@80x24.org>; Sun, 28 Aug 2016 13:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753688AbcH1Np7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 09:45:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33799 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbcH1Np6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2016 09:45:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so6076008wma.1
        for <git@vger.kernel.org>; Sun, 28 Aug 2016 06:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=gxXBfmy454J5H3GWrj/eRvYy/2nUnQlicIPq1Gc9HmQ=;
        b=pSKG6KtjspKEDItMbKxo6WzdnCejDIfCuTsdP8EofFhxErhKK1FENr11YOnRCih4n0
         0jWIIUsB2QSqENb/rP09jmrF2rvpj4tyDM9IX+empWT40UQOARXGqcVmBAvFQ61SA3/G
         cdDcBga8HVpH5UqAjENSy4hfc775hOmQXTwzScRjcraUjVJJSY9RLajAJiNVbnvzSgHH
         LgXq6dQvavVzGF3TKVeX1FZ4MazXb4sot4x0k4nA+x5EZwWhcnZ2mWC/6e2AczyrzAlB
         F3v1Z+aZpQl9Rvlle6RixnEEbKiReCYztT/rHBEDGFQ7r82hTO+mcObiCsimedp86Jkm
         QGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=gxXBfmy454J5H3GWrj/eRvYy/2nUnQlicIPq1Gc9HmQ=;
        b=fsxmGE8rLfSndvHnauJa1Z/Cyb2kkJyKOil0tfbVHEO2sXBiN0oap2Qof+IFWlllSr
         XKfz24nucdRArE/7921CpDH8he+TiDVaCrI9XzJvtDNx4IT1oQHxDWUOcMYT7PGiWYHj
         JsIFXrO/xvL/Dn4PQM6y205I+ZLJJwx3cT4MFJFzbCA9jgbqmG6DYMR6gNVxtRDTL0vD
         YHgspMJi3XQJo/8zah5EQlmnNz9zfZaoeX3f9TJH9uyu4ufACR5ZAdxSuwIM3MGdwjdJ
         xZQ57m0tCwnp5OW87ZJkuMG7JoEyiqdM/ONq2dbiEmqb3ouoJHejKbbgrgpztO/sA1yA
         OVBA==
X-Gm-Message-State: AE9vXwMo8RzMccwlGG8WdDYgOivNSZ5QftYTPuOW/8ylkjKIHqa2aHgmB6aq8VZYAWT4kg==
X-Received: by 10.194.41.194 with SMTP id h2mr11424501wjl.2.1472391956396;
        Sun, 28 Aug 2016 06:45:56 -0700 (PDT)
Received: from [192.168.1.26] (enk96.neoplus.adsl.tpnet.pl. [83.20.0.96])
        by smtp.googlemail.com with ESMTPSA id r67sm8659744wmb.14.2016.08.28.06.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Aug 2016 06:45:55 -0700 (PDT)
Subject: Announcing Git User's Survey 2016 [was: Working with
 public-inbox.org]
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox>
 <20160819150340.725bejnps6474u2e@sigill.intra.peff.net>
 <alpine.DEB.2.20.1608221450250.4924@virtualbox>
 <CACsJy8BG63oaLbw0f7try3OpzdphLC7UGAaJ=vgikEB36Pagqg@mail.gmail.com>
 <5e480a5b-3752-55c0-65ed-52ca5802851f@gmail.com>
 <alpine.DEB.2.20.1608281036460.129229@virtualbox>
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>, meta@public-inbox.org,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <bb1ee52f-c4b6-ded3-19af-ddb7b65b376d@gmail.com>
Date:   Sun, 28 Aug 2016 15:45:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1608281036460.129229@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

W dniu 28.08.2016 o 10:38, Johannes Schindelin pisze:
> On Sun, 28 Aug 2016, Jakub Narębski wrote:
>> W dniu 22.08.2016 o 15:15, Duy Nguyen pisze:
>>> On Mon, Aug 22, 2016 at 8:06 PM, Johannes Schindelin
>>> <Johannes.Schindelin@gmx.de> wrote:
>>>>
>>>> My point stands. We are way more uninviting to contributors than
>>>> necessary. And a huge part of the problem is that we require contributors
>>>> to send their patches inlined into whitespace-preserving mails.
>>>
>>> We probably can settle this in the next git survey with a new
>>> question: what's stopping you from contributing to git?
>>
>> Added to second take on proposed questions for Git User's Survey 2016
>> https://public-inbox.org/git/ae804c55-d145-fc90-e1a9-6ebd6c60453a@gmail.com/T/#u
>> '[RFCv2] Proposed questions for "Git User's Survey 2016", take two'
>>
>> Message-ID: <91a2ffbe-a73b-fbb9-96da-9aea4d439e5a@gmail.com>
> 
> I would like to strongly caution against putting too much stock into this
> users' survey. It is the best we have, granted. Yet I have not heard from
> anybody that they participated in the survey, unless they were also
> subscribed to the Git mailing list.

I tried in past and will try for this year Git User's Survey to be
announced more widely than just Git mailing list (git@vger.kernel.org).


And I think it was successful; we had 6385 responses in the survey
from 2012 (the one without analysis on Git Wiki) - the last one,
the maximum of responses we had was 11498 responses in 2011.
This is almost an order of magnitude more than number of past and
current contributors ("git shortlog -s | wc -l"), and I think
much more than all current readers and watchers of Git mailing list.

In 2011 there was "How did you hear about this Git User's Survey?"
question at the end (with 7022 responses out of 11498); most popular
answers were
 - news web site or social news site (e.g. Digg, Reddit)  1592 / 22.7%
 - git hosting site                                       1315 / 18.7%
 - other - please specify                                 1287 / 18.3%
   (which was not git mailing list)
 ...
 - git mailing list                                        230 /  3.3%	 
 - git-related mailing list (msysGit, ...)                  53 /  0.8%
https://git.wiki.kernel.org/index.php/GitSurvey2011#35._How_did_you_hear_about_this_Git_User.27s_Survey.3F

In 2012 I have used different channels for different announcements;
examining channel list shows that Git Homepage one was most used.
This does not mean that people who selected those answers, or used
that channels do not read git mailing list; they might just find
the news somewhere else first.

Also, "Which communication channel(s) do you use?" in 2011, there were
only 387 responders who selected git@vger.kernel.org out of 11498
in total (and out of 1018 people who selected at least one answer
in this question).  Though some people might though lurking is not use...
https://git.wiki.kernel.org/index.php/GitSurvey2011#32._Which_communication_channel.28s.29_do_you_use.3F



I am not saying that there would be no bias in Git User's Survey
2016 responses.  I agree with you that we should take caution
when analyzing results of "What's stopping you from contributing
to Git?" question.  But it might be nor as bad as you fear.


That said, where should Git User's Survey 2016 be announced?
The ones that should be easy are:
 - Git mailing list, and related lists
 - #git IRC channel, and its description (and other IRC channels)
 - Git page on Google+
 - Git Homepage
 - Git Wiki
 - Git Rev News

The ones that would be harder are git hosting sites, among others
the GitHub blog.

The ones that would be quite difficult are news sites and news
aggregation sites, such as LWN.net or HackerNews.

Where else?

Thanks in advance,
-- 
Jakub Narębski

