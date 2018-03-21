Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5B561F404
	for <e@80x24.org>; Wed, 21 Mar 2018 18:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752720AbeCUSpI (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 14:45:08 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:40844 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752556AbeCUSpH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 14:45:07 -0400
Received: by mail-qk0-f181.google.com with SMTP id o64so6551818qkl.7
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 11:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qabFz+QoQTiIfyuwWS4uT+bG8ONW9F0SgFXFTRMMVpc=;
        b=oDj+kSkoGFubM/HqY0/7/Zosae5TeYkJKvMo+27jvWMeKRVlFQ+UvVTtwkCRAeqz9I
         Qsh+r8RkgeEmj1zwlAiS69TmKaawyxXzlFVWxCkl1z6Q3pn28taMeFqIyNfqVTcpvGRu
         F/+rFtYx2/tMge6gOeXwb7B7J2Lqb0/eVNC+D/5wc0SkD6yeFoPCI/Xf1N0+ylA5onL1
         b7sqQILVjG/PwrbW/ZfhTctOxSa04PvOFLrZdrZIcDU+fnNOrtLccgsG+RP1HHMRqbQl
         lqYuNU8WfzjuuoCQY3AtAHQvbOrdjScXKa1w1UsYrRsm7J5ddwX8UvS/lZzAKi4Cznxa
         mWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=qabFz+QoQTiIfyuwWS4uT+bG8ONW9F0SgFXFTRMMVpc=;
        b=eXz6pwJz3sQ25F3ov9qxE5jhgU9NIiUvxZJWEMupRgCPKnRAhsQ87XYlQrhgvTBJg9
         gfvjxkhzd27qXnrkqMH8exvPvMFHaOGkvi2vTKhxRfLrqZpmv0Z2WTrLf5Dj5JRqxqed
         KmtNb0Ws0IHdCg3YKsm3026kdY+6wd5MmOKuXBQrDv0B5kRGyGeiwZh7zRGmkpqNJRA3
         QdYlZ11wfpux1qlhWFKUFfAOHCZuxLG2o6BvkDLtR2SaLZpRPNm8BjKGrkfN2eANZJiT
         LVNkn9H8tN7zoWE4l7bMmLlqRXymWr8lVyI+GIU86EFa/Vb0pKkS+0rKATfs2gp+E8n3
         vfNQ==
X-Gm-Message-State: AElRT7FWhJkczUVBlTR0zvzQaFVtMtVwjz5Ggn9gipfFHv9+ExGhqxpC
        IPchzDB67SlWCsn4VZB9319sP5PXEU8jROzavMz37Q==
X-Google-Smtp-Source: AG47ELtjs1SFLN2DAiSd1/zEsQcakThM8UTVcG4eMNU0D+M68xGRmMidktTd8Tu2dWKM3tQ5wJGbSCWMu8z0aDzV9Uw=
X-Received: by 10.55.3.140 with SMTP id 134mr31149712qkd.26.1521657906685;
 Wed, 21 Mar 2018 11:45:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Wed, 21 Mar 2018 11:45:06 -0700 (PDT)
In-Reply-To: <xmqqo9jhpadh.fsf@gitster-ct.c.googlers.com>
References: <CAPig+cTKkp6kpFcJfVV8W1ejCrCWQH33mHtgFUn+MpMgw5i1pA@mail.gmail.com>
 <20180321152356.10754-1-predatoramigo@gmail.com> <xmqqo9jhpadh.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 21 Mar 2018 14:45:06 -0400
X-Google-Sender-Auth: 21Q2lTET5eoAikswoWfDxpeVvGs
Message-ID: <CAPig+cQ1KSL8LreoE7waBzqz2V1N0rwLujDCM82nqTdgF=MC3g@mail.gmail.com>
Subject: Re: [GSoC][PATCH v3] test: avoid pipes in git related commands for test
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Pratik Karki <predatoramigo@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 21, 2018 at 2:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pratik Karki <predatoramigo@gmail.com> writes:
>> The changes in patch increased from v1 to v2 because I
>> got excited to work in Git codebase and I tried to
>> fix the exisiting problems as much as possible.
>> Hence, the large number of changes.
>
> Eric understands why the scope was increased between the two; he
> explained why it is not a good idea to increase the scope in the
> middle, and I tend to agree with his reasoning.  The reason why the
> scope was increased does not matter.

Thanks, Junio. I had just started writing a review of v3 when your
review arrived, and you covered every point I was going to make, thus
saved me the effort. I agree with everything in your review.

One additional comment, Pratik, is that this patch seems to be based
upon a slightly old version of the Git source code, thus does not
apply cleanly to present-day 'master'. Before re-rolling, update to
the latest Git and rebase your patch atop it.

>> -     PACK5=$( git rev-list --objects "$LIST" "$LI" "$ST" | \
>> -             git pack-objects test-5 ) &&
>> -     PACK6=$( (
>> +     git rev-list --objects "$LIST" "$LI" "$ST" >actual &&
>> +     PACK5=$( git pack-objects test-5 <actual ) &&
>> +     PACK6=$((
>
> I thought that Eric already pointed out and explained why this
> change to PACK6 is wrong in the previous round?

I probably should have been more explicit by naming PACK6 directly.
Comparing v3 against v2, I see that Pratik probably misunderstood my
comment, thinking that I was talking about losing the whitespace
inside PACK5=$(...); v2 dropped that whitespace and v3 restored it.

Pratik, dropping the unnecessary whitespace inside PACK5=$(...) is
fine (no complaint about that), but changing PACK6=$( (...) ) to
PACK6=$((...)) is outright incorrect as explained in [1].

[1]: https://public-inbox.org/git/CAPig+cTKkp6kpFcJfVV8W1ejCrCWQH33mHtgFUn+MpMgw5i1pA@mail.gmail.com/
