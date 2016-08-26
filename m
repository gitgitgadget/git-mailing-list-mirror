Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1144A1F6C1
	for <e@80x24.org>; Fri, 26 Aug 2016 11:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753332AbcHZLmt (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 07:42:49 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36244 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753244AbcHZLmq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 07:42:46 -0400
Received: by mail-wm0-f45.google.com with SMTP id q128so275800392wma.1
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 04:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Y9JXMZB05lIzFzJO/Hl9cgYntBOLgsOZKIy0Ll4psYM=;
        b=GhnN7X2XWoktpHdAjGitUNQKaq1zu2ug7z8h+hNIxwxNbltvN64P/kDLc1+AnbT6zW
         arZIBjkdGE987TwErhTVMdtH1i8VYPO/ZR0JMXllViHiwhci6llI3ZUjNMzxeo2J0Btu
         mURPZ7eS9bsG7tWjJI2nBnkUiaF2+BatHaNUv3sUDiDJbA6RPXEmK+/zww6K0FW6rAQA
         /AUhi457teM6lyG3xk3yvWpDuhxNUKubnAdxfWO6cKKE8VYHCNWL0N5U6milNkykVrbW
         RmIXd5a79Z1sWi/v5qh9gwkRpMAD1oYKIBwp7HrF3vF2R6Cc32jDpbBVWM43B2KetQnP
         qCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Y9JXMZB05lIzFzJO/Hl9cgYntBOLgsOZKIy0Ll4psYM=;
        b=loyXrTEKi5FoUiUV3f+Y/8ao1eIPM57RVVd1bZln0/ad5CRErN8298HBHfzRGGUvTk
         9K8HUm4kol+wco4jVHtXTHBulD7X/XPteHufaMkDiUtwsILDLFDIwBvHr5ye9kABh9rH
         wHvdrKcQm7+Cmdeosbq6gut9/nIJBKws7dWEyDgluDSQgGstaRcN4t4jUj8gmCFFOTzf
         V9g2da8L7k16fwKlB5iXNJunQPQzNtW198v0kyBspsQpUIeLMQD/E78zEPK8jqxtw4b3
         xckVCPddxB5RCZ26Kz7lAw8TSdIMzyqiKessPrDsqjlM0TdAFx0v/61V8iUq9CKtWkO2
         oXkQ==
X-Gm-Message-State: AE9vXwPS2Dc/pbhUEWEp6R8yHNY70mvFKBwOLxdtlSFutDKjfdU8UXoPPzGaTPFWomzFcQ==
X-Received: by 10.28.22.6 with SMTP id 6mr3558747wmw.55.1472211741489;
        Fri, 26 Aug 2016 04:42:21 -0700 (PDT)
Received: from [192.168.1.26] (elj39.neoplus.adsl.tpnet.pl. [83.21.203.39])
        by smtp.googlemail.com with ESMTPSA id i80sm20245075wmf.11.2016.08.26.04.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Aug 2016 04:42:20 -0700 (PDT)
Subject: Re: [RFC] Proposed questions for "Git User's Survey 2016"
To:     Andrew Ardill <andrew.ardill@gmail.com>
References: <91a2ffbe-a73b-fbb9-96da-9aea4d439e5a@gmail.com>
 <CAH5451n0=kmr9SeOKSH5iiJr5Lnr2TapfZrTUR6Pm90xUEKFxQ@mail.gmail.com>
 <90165dce-c508-4cb4-ec6e-c3d271181fe3@gmail.com>
 <CAH5451nMeuZttRgM8LK3JcPhfOYHieyawV2pJzp0jdh2KAf60Q@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Doug Rathbone <doug@dougrathbone.com>,
        David Bainbridge <david.bainbridge@gmail.com>,
        Stefan Beller <sbeller@google.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <a1a45f00-ce11-6e7a-ad40-efe9a1158aa9@gmail.com>
Date:   Fri, 26 Aug 2016 13:42:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAH5451nMeuZttRgM8LK3JcPhfOYHieyawV2pJzp0jdh2KAf60Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 26.08.2016 o 08:58, Andrew Ardill pisze:
> Jakub Narębski <jnareb@gmail.com> wrote:
>> Andrew Ardill pisze:
>>> Jakub Narębski <jnareb@gmail.com> wrote:
[...]
>>>> 25. What [channel(s)] do you use to request/get help about Git [(if any)]
>>>
>>> It may also be useful to ask how people hear news about git, such as
>>> when a new release comes out. Not sure if worth a separate question,
>>> as there is a lot of crossover in the resources available for this and
>>> for requesting help, but knowing this information would help us
>>> understand what kinds of users are responding and which communication
>>> channels are effective for git news.
>>
>> How would you propose such question would look like, and what proposed
>> answers would be (if it were not a free-text / essay question)?
> 
> Something like:
> 
> XX. How do you hear about git related news 
>     (such as new releases and community events)?
>     (multiple choice or single choice?)
>  * I wasn't aware there was any news
>  * I don't read any news, but I'm aware of it
>  * through news aggregation sites (such as reddit or hacker news)
>  * from a newsletter (such as Git Rev News)

I wonder if we should also add

   * through a watched blog (such as GitHub Blog)
   * announcement section in news site (such as LWN.net)

>  * from a mailing list (such as the git developer or the git for windows list)

Are there any other common channels that you (the people) watch for
git news or software news?  Freshmeat / Freecode is defunct, and no
replacement got popular enough...

>  * other

The last would be

   * other, please specify

> It would be good to allow a list of specific resources to be written
> to capture things we don't know about, and specific instances of the
> categories above, e.g.:
> "hacker news, git mailing list, git rev news"

On Survs.com it would require an additional question with free-form
answer, I think.

>> Note that there might be a problem of severe bias: people who heard
>> about Git User's Survey 2016 are probably ones that watch news about Git.
>> Still, it would be useful to know if people read RelNotes...
> 
> Agreed, the intent behind the question is to work out what are the
> effective communication channels so that they can be used more
> effectively.

Right.

Nb. I wonder if this question should not replace the one about
how you heard about the survey (at least if there would be too many
questions).  But I'll have to see how many questions we have now.

Thanks for suggestions,
-- 
Jakub Narębski

