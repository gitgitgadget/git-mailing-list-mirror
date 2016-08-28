Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4CC11FD99
	for <e@80x24.org>; Sun, 28 Aug 2016 11:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755389AbcH1LmE (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 07:42:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35271 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755359AbcH1LmC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2016 07:42:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so5804901wmg.2
        for <git@vger.kernel.org>; Sun, 28 Aug 2016 04:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=BHg9Ui9eC6+QgU3VQQBsQveJBwO1YN8FBeAFtEjyxck=;
        b=vNwS71/lNq++SXOPVbQ/iWCW1jX+61SzArTrC4z93lyrd/+GuQUiJnrC6QzG6a+836
         PcunYFArBqtoNO7uvVFRyMlz/hgb9GzhdOseYJlWFafYuT/zVDYwhItwQA3PlzedGUq7
         P5/uWT/Yb5qvplwHTHvfr3qYz0HoYtYqNu4mzjV2eRnzAqchZe8bDaf4J0bjp005fD1W
         KUs6/QsslDck6K1u+XNq32ieOfeaKCZGa5XLz420lNMFqpW93DpxYKhoE60VeMVODL9E
         G0IZWYvAEDbeYG1Fi3rhXtpQSoMZFvGw1/7vXstn+Sqi96ZooW94OAF6r+XLJMyzgk7Y
         AZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=BHg9Ui9eC6+QgU3VQQBsQveJBwO1YN8FBeAFtEjyxck=;
        b=KUQ2ojKYcywONoPJdXBfzDxX/8XohNFBYAn9XErgLNKuyFMNnNksM+l3JbXABwsd2w
         awNh0tA5NcU3A1wGebYLPUtwD+ltF/0FImz6wKGn1QbuELchG1tVB746sMsQVMUIMz04
         za8mbJBoP6S3vcngetQ286hKAAhxjHQxsu2VxrPR3GRe/p4iEIKV+agqrKHOV8N7dfVN
         nFJ1mUW4iKVM/Xo8pfEz7aoNxUwM4mxtC6Kkshaq8Ij0wnE6IoPHryi5ctPR3Xaog0nV
         lrhL+lNLIGBEK5qBnbkzXzO85ugQV6+1b9deqQc+h+UhGzJlbuIcB82yOMvPq1XQ2O5d
         wO/Q==
X-Gm-Message-State: AE9vXwOyQG6WLUWuRkHBNBaYdEev9ZzVsOuBzjhWvFEDwRbVVBs9QUvlKJpjuVOfKAOgGA==
X-Received: by 10.194.96.205 with SMTP id du13mr10802223wjb.89.1472384519773;
        Sun, 28 Aug 2016 04:41:59 -0700 (PDT)
Received: from [192.168.1.26] (enk96.neoplus.adsl.tpnet.pl. [83.20.0.96])
        by smtp.googlemail.com with ESMTPSA id d7sm29047598wjg.13.2016.08.28.04.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Aug 2016 04:41:59 -0700 (PDT)
Subject: Re: Working with public-inbox.org
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox>
 <20160818204902.GA1670@starla>
 <alpine.DEB.2.20.1608191720040.4924@virtualbox> <20160819223547.GB16646@dcvr>
 <alpine.DEB.2.20.1608221509010.4924@virtualbox>
 <20160822225549.GA25383@starla>
 <alpine.DEB.2.20.1608251457310.4924@virtualbox>
 <d2c4d54f-e3be-8e17-860c-d9b8bacf68e0@gmail.com>
 <alpine.DEB.2.20.1608281033340.129229@virtualbox>
Cc:     Eric Wong <e@80x24.org>, Stefan Beller <sbeller@google.com>,
        meta@public-inbox.org, git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <d4c44d3c-7361-2a33-4ae5-03cc45f8a034@gmail.com>
Date:   Sun, 28 Aug 2016 13:41:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1608281033340.129229@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

W dniu 28.08.2016 o 10:36, Johannes Schindelin pisze:
> On Sun, 28 Aug 2016, Jakub Narębski wrote:
>> W dniu 25.08.2016 o 14:58, Johannes Schindelin pisze:
>>> On Mon, 22 Aug 2016, Eric Wong wrote:
>>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>>>
>>>>> I just want developers who are already familiar with Git, and come up with
>>>>> an improvement to Git itself, to be able to contribute it without having
>>>>> to pull out their hair in despair.
>>>>
>>>> We want the same thing.  I just want to go farther and get
>>>> people familiar with (federated|decentralized) tools instead of
>>>> proprietary and centralized ones.
>>>
>>> Why require users to get familiar with (federated|decentralized) tools
>>> *unless* they make things provably more convenient? So far, I only see
>>> that this would add to the hurdle, not improve things.
>>
>> Arguably for some federated/decentralized tools are preferred
>> (for philosophical reasons), even if they do not achieve even feature
>> parity with centralized tools (c.f. FSF).

Philosophical and ideological reasons.

> This statement is false. If you had talked about *your* preference, it
> would be true. But to state that federated/decentralized tools are
> universally preferred is nonsense.

The key word is "some" (or, if you prefer, "a few").

> You know as well as I do that most users/contributors go for convenience.
> 
> And if you require an inconvenient step (e.g. subscribing to a
> federated/decentralized philosophy), most potential contributors simply
> stop being potential contributors. End of story.

For some people registering on GitHub and using web interface (though
I think there is also command line interface, don't know if it covers
PRs) would be the inconvenient step.  Just saying.


What I would like to see is bidirectional bridge between email and
GitHub (and possibly other hosting sites), so that everybody could use
their favorite interface, be it Git + email client, or Git + web browser
(or desktop client for GitHub).  Just like thanks to Gmane and Gmane-like
public-inbox I can use either email client or news reader, and it is
[nearly] transparent regarding to which one I use.

Even better if hosting site implementation (of pull requests, etc.)
were based on federated systems (like email, or Usenet, or IRC, or XMPP),
and not closed in walled gardens; with hosting site just being one
particular implementation (like e.g. Ghost blog engine, and Ghost Pro
hosting site).

I agree that lowering barriers to contribution for new class of users
(like MS Windows users; setting up MTA on Linux etc. for git-send-email
or git-imap-send is not very complicated), if it would be possible
without inconveniencing existing reviewers... which are even more
important, judging by the amount of "needs review" messages in
"What's cooking...".

Best,
-- 
Jakub Narębski

