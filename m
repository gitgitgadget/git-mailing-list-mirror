Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFA062047F
	for <e@80x24.org>; Tue,  1 Aug 2017 17:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbdHARi6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 13:38:58 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34623 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbdHARi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 13:38:57 -0400
Received: by mail-lf0-f49.google.com with SMTP id g25so10067124lfh.1
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 10:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rWRYsUfdnu3FBz2XXj8060my44Ur+WT6xw4TmX5eANA=;
        b=cdDHe6HAKKtqJi0yDb+KMAVxEAWIL/CJOVSSR3wNgfwdieT3sp5ta4VUpInKn7OEi0
         3xmSzr5fcW5ygknXwFSsFmK17ZrAdGTBwO5nn1dRfkuXpQ1nqf5SZkVRehTI7qbc8Vvy
         NUUl3khE0X7AXMBACE1LnxXwVmQd08yX5vzxkfa6R1PtaQ5QIsfmREm81WTWPjloMYo1
         xJ/KnInXtjuq2y1NeHwXw4GXmF6QRS2aOCD58LaaZwFkjiuzZaTXdSAd37qIu8tfvNDs
         Rqv2/Ont0Ue7hmZTr93Scthyek/ptUYlLowSwOBroNI/3zGs/eKgCBRPn5LGgWsVzh6O
         5ouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rWRYsUfdnu3FBz2XXj8060my44Ur+WT6xw4TmX5eANA=;
        b=hkD5YXaF+nIxQcIg4xwkAHgS2ELeUGjDAlO6VZ35FQaxsdPRcjg2FbEPaL4m25qQpa
         ZU7gzaw47YDLKGMDMxVzWwiayeH9+g9dRwVbkt3syijxcy+snpCTw3wsalIhrZTnxY2j
         1RujhnmKwV/eAaO7e5cq6iJVEOwuL6vCblHHgkwkTar/8u8QBCYGQa0PNL0Co+91/5VP
         aeZyQaSI2Q8lcKJZpCFCqnuDhiP7k+jj5e53jylZoXbzBiQfEE5uDtGjTdTp587uphLV
         ep7AGxEetd++DZ1PtC5aDwlzcnRXqAbza2r2h4FN9BacyI8dYGmhbQ2WaGucYi/UGOM+
         B1Gg==
X-Gm-Message-State: AIVw113qr6eJ7B4ZTR6e28ihhJGS3EXVsux00rvqtDrMinFBzkky/3pu
        W/oUROYN47JaoOwXyIKBMlfvxj35E0ym
X-Received: by 10.25.15.221 with SMTP id 90mr6087535lfp.220.1501609136237;
 Tue, 01 Aug 2017 10:38:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Tue, 1 Aug 2017 10:38:55 -0700 (PDT)
In-Reply-To: <1501603171.1671.8.camel@gmail.com>
References: <8256C530C7DE43D7BC72BFB327DF4726@PhilipOakley>
 <20170730161816.2412-1-kaarticsivaraam91196@gmail.com> <CAGZ79kYg9jQ3kaKnNEJCH9fde=ar1KPiUr7=X+TguNc0Twqdzg@mail.gmail.com>
 <1501603171.1671.8.camel@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 1 Aug 2017 10:38:55 -0700
Message-ID: <CAGZ79kY_NdBe1QjJWrLUkfDOk8Zrnopa945F1xBq=WFDNpRWMg@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc: fix small issues in SubmittingPatches
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 1, 2017 at 8:59 AM, Kaartic Sivaraam
<kaarticsivaraam91196@gmail.com> wrote:
> On Mon, 2017-07-31 at 13:23 -0700, Stefan Beller wrote:
>> On Sun, Jul 30, 2017 at 9:18 AM, Kaartic Sivaraam
>> <kaarticsivaraam91196@gmail.com> wrote:
>> > Replace the dashed version of a command with undashed
>> > version and quote it.
>>
>> I like it, but similar as below, we'd want to go for
>> consistency.
>>
> I assume you mean the consistency in quoting i.e., you're expecting the
> patch to use (") instead of (') for quoting. Correct me, if I'm wrong.

Actually I did not imply any expectation on the outcome, because I
do not know what the consistency end game looks like for this issue.

So maybe we'd want to go with the currently most used way?
(Are there only three? (a) with dash, (b) with single quotes and
(c) with double quotes?)

>> >
>> > Further, remove duplicated space character.
>>
>> https://en.wikipedia.org/wiki/Sentence_spacing
>> seems like a globally controversial thing. (I assumed
>> it was some sort of local dialect before researching
>> it properly)
>>
> Man, I had no idea about people using two spaces after period.
>
>> I personally do not mind one way or another regarding
>> (double) spaces after a period, but I would think we'd
>> strive for consistency throughout the project.
>>
> Consistency is crucial. I'll just remove that part of the patch.
>
> --
> Kaartic
