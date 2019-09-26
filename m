Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47D951F463
	for <e@80x24.org>; Thu, 26 Sep 2019 12:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfIZMQY (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 08:16:24 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40864 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfIZMQX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 08:16:23 -0400
Received: by mail-qk1-f194.google.com with SMTP id y144so1527770qkb.7
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 05:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rDDHJNkDcvav6dGapR/wjapZ9oszFGqzWohK4op+L1k=;
        b=Kq+3vcaFc7pv9OyDjsaRq1y8U9bSFoOumFwBvZzoVNUOQBBQ2TbRPRg02K2AWb6US9
         0IWMstWOLIYE4opa22EOP7oNYkR9O/FWnjuYMG0BzM3F1UXr/7UhL80Zc7efGawUWVS7
         GXGRH0Qi+2d3HdYd/REsNgWDyJT9oAW62FZePEgsm7BGK+2n4QVUEY21WWU8EmywcBlt
         1NPoFwfxokW40vYtlExeizjK3xK+csuF4xTbbbYO6WALjBotWe1jT7DdfU9g6xmCoMHp
         U4ud4yQxFF96LRhyVCgu989fxENWVbEoKCkqM3noTcLXqnOf94xGk76eWvhuQJo3C+5p
         OSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rDDHJNkDcvav6dGapR/wjapZ9oszFGqzWohK4op+L1k=;
        b=otgErHCgjQnUIWnq02TUb29zkEw7jvh1aRpLIXCaHXF3aWCDFGPTFfGV2PC/Ze+JNk
         V7dfzcY6/dvaDKx5IdqcCOBngmRi2rhttfKz2MpLPnlEgAPaX1aq8DMQIkkF3tHoRB7t
         55OLu/t1n6fSMou5iWXhP9Rc4icoDG6oivpXy+0lpaILtVDcRSxP7R7bSx6pZr9Laqfb
         pVnDLVymOx+gGukta00R1zzNYK/pIiqxHsEx/tSTS5hycY6+xfPdWbF/4MLbkhjcDS+9
         LDmUUjZHGO6NRhE6f50TnXb55J1h7ZN5dqNdENJUhVkZ6p+HvcKpOZN9tcP7xZyjhwKC
         e0hA==
X-Gm-Message-State: APjAAAVZw5Rsx7yKdSJrcCp6vXgWdeIwZe0GOLCDk6kEk+X67tgxhi95
        pcRYo7LLKwvuSVVFxbypotc=
X-Google-Smtp-Source: APXvYqz5vV2kbVbGidtaluV67ijOEe+9NXb1I4VF3X7++Kve1mMvdsRcCm2JnKRKLB1amK/fijVPEg==
X-Received: by 2002:a05:620a:389:: with SMTP id q9mr2895863qkm.81.1569500182208;
        Thu, 26 Sep 2019 05:16:22 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:b594:20f6:c10f:d45d? ([2001:4898:a800:1012:66c8:20f6:c10f:d45d])
        by smtp.gmail.com with ESMTPSA id z12sm997506qkg.97.2019.09.26.05.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 05:16:21 -0700 (PDT)
Subject: Re: [PATCH] CODE_OF_CONDUCT: mention individual project-leader emails
To:     Jeff King <peff@peff.net>, Emily Shaffer <emilyshaffer@google.com>
Cc:     Denton Liu <liu.denton@gmail.com>, Git List <git@vger.kernel.org>,
        git@sfconservancy.org, Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
References: <20190924064454.GA30419@sigill.intra.peff.net>
 <20190924171214.GA11452@dentonliu-ltm.internal.salesforce.com>
 <CAJoAoZkw08A_nkJNMwgTTFvGMCRUqR2UqEckOp65Vg_TW7K8bg@mail.gmail.com>
 <20190926072046.GB20653@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0188e484-20d4-59b1-5fdd-bbaecdc1819a@gmail.com>
Date:   Thu, 26 Sep 2019 08:16:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190926072046.GB20653@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/26/2019 3:20 AM, Jeff King wrote:
> On Tue, Sep 24, 2019 at 04:52:56PM -0700, Emily Shaffer wrote:
> 
>>>> I've cc'd git@sfconservancy.org here, because I think it's important for
>>>> all of the project committee members to endorse it (and because the
>>>> document puts us on the hook for enforcing it!).
>>>
>>> I tried looking it up but I couldn't find who the project committee
>>> members are. Is this list published anywhere? More on that later...
>>
>> To be honest, I'm a little worried about it too. What if I have a
>> problem with someone on the project committee? What if I have a
>> problem with someone I don't know is on the project committee?
> 
> I think those are very good points. See the patch below.
> 
>> I helped my other FOSS project to adopt a Code of Conduct earlier in
>> the year (https://github.com/openbmc/docs/blob/master/code-of-conduct.md)
>> and we got around this by asking for volunteers from the technical
>> steering committee to agree to have their contact info listed on the
>> escalation path; at the end of the escalation path we also listed
>> someone external to the project (which we were able to do because we
>> had been adopted by the Linux Foundation, and they have someone for
>> that).
> 
> Yeah, I think this is sort of the same thing except that I
> pre-volunteered the whole project committee. ;)
> 
> We could have a separate list of contacts for the code of conduct, but
> it seems simplest to just use the existing group that we already have,
> unless there's a compelling reason not to.
> 
>> A possible con of being on this escalation path is having your name
>> and contact info outed to trolls as a supporter of something
>> controversial like a code of conduct. However, I'd argue that the
>> growing list of ACKs on this thread expose us in a similar way. On the
>> other side, the benefit of having a transparent escalation path like
>> this is that you can bypass a problematic individual who may be in a
>> position of power. It also provides an opportunity for increased
>> discretion in delicate situations like the example Peff gave
>> downthread.
> 
> Yep, agreed with all of this.
> 
> So here's a patch that I think improves the situation.
> 
> -- >8 --
> Subject: [PATCH] CODE_OF_CONDUCT: mention individual project-leader emails
> 
> It's possible that somebody on the project committee is the subject of a
> complaint. In that case, it may be useful to be able to contact the
> other members individually, so let's make it clear that's an option.
> 
> This also serves to enumerate the set of people on the committee. That
> lets you easily _know_ if you're in the situation mentioned above. And
> it's just convenient to list who's involved in the process, since the
> project committee list is not anywhere else in the repository.

I think this handles the conflict of interest issues. This is likely
never to be needed, but helpful to have.

Thanks,
-Stolee

> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  CODE_OF_CONDUCT.md | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/CODE_OF_CONDUCT.md b/CODE_OF_CONDUCT.md
> index b94f72b0b8..fc4645d5c0 100644
> --- a/CODE_OF_CONDUCT.md
> +++ b/CODE_OF_CONDUCT.md
> @@ -74,6 +74,14 @@ Project maintainers who do not follow or enforce the Code of Conduct in good
>  faith may face temporary or permanent repercussions as determined by other
>  members of the project's leadership.
>  
> +The project leadership team can be contacted by email as a whole at
> +git@sfconservancy.org, or individually:
> +
> +  - Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> +  - Christian Couder <christian.couder@gmail.com>
> +  - Jeff King <peff@peff.net>
> +  - Junio C Hamano <gitster@pobox.com>
> +
>  ## Attribution
>  
>  This Code of Conduct is adapted from the [Contributor Covenant][homepage],
> 

