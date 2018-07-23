Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28BB61F597
	for <e@80x24.org>; Mon, 23 Jul 2018 23:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388196AbeGXAED (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 20:04:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45315 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388109AbeGXAED (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 20:04:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id f1-v6so1400411pgq.12
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 16:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w19JWI8Mrk+3xZ68csSfAsbwFRtCVKaYs1wcX+F6zNM=;
        b=bAon2Y+XumjPm6k6Lvjqpod8g2cd46Jnh1SgvRglMGygFmuLG6vHTHw4gk6SyFT7av
         ewrVWlrNSYWxoFIsyY0D0pKmG8ecHqlq91ExSUIEE5UtiMEUu/WjT3uEHQGdkVUMFLLE
         eu/xpZz1N8e2Gx4u/iRTNWmlb59E7TPhpgx1VcS2BH6CBputyr1l55aEcFwRCLqIuO1s
         jAKU72X+Vs4xENnuLY4Wn4QZqmoLA5vNsXwL/0S53pOimTozqRpHGca7lVR+YhAtrfZR
         RyyBhzZ+gujqibtGrlDGfGd5cxKBHBVkThiBsS9Ebfml1FMkPEeQj5u4jkbLoCF7cp25
         w+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w19JWI8Mrk+3xZ68csSfAsbwFRtCVKaYs1wcX+F6zNM=;
        b=mhtrXM4BSxGnEsRrI8ZwWpnjVZIZIZlu/LNEho2WyCy7wgkvs4e/usuzvBVOiByNWQ
         WYKuuVhsFkUz3KMH1StFRYMnSPzWRDWysFLi57RIyR4pTf39k2QvJ0NvWVPeP9K0AlKR
         0EJXwwShmcPfR9rHsTXrlJf1JUmNfyb2SPDY9b/7MfgWKP0OHXtgwedKI37qSjAy3jG+
         AyUbvZL5yDgycPChCTkjUG0pniG0zLlJJcMP6Lrvo04B+vxD3hOvru7QWQBKkWju6+KW
         APVbKWqCIdr12gjyYDEIoKn9neKEggohO3mOQda4MhCU7o1bbCXwJ8Lp8zUNGTaHdC6y
         OZBA==
X-Gm-Message-State: AOUpUlFjivQ8y//QxLGwDEK3lAkY7BkIi/ArY+fW38FKPpg2VsS1FUA8
        eLaUv4PUKP56xgkDiebz99Y7pQ==
X-Google-Smtp-Source: AAOMgpcjoh5tHiXU4SDSwkxNcO0GPizLOEmv908uydsvA4MA0dSn1g9hJl2DKZqgjHHpAnVQ1Z/6lA==
X-Received: by 2002:a65:5803:: with SMTP id g3-v6mr14108777pgr.117.1532386834968;
        Mon, 23 Jul 2018 16:00:34 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id z10-v6sm13977247pfh.83.2018.07.23.16.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 16:00:33 -0700 (PDT)
Date:   Mon, 23 Jul 2018 16:00:33 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: mark die strings for translation
Message-ID: <20180723230033.GC25435@google.com>
References: <CACsJy8CJG5RCL40vCbNnQMHmtjQmch9qntxeh_Pt6ZUfnRN9uA@mail.gmail.com>
 <20180723175635.31323-1-bmwill@google.com>
 <xmqqpnzd36hy.fsf@gitster-ct.c.googlers.com>
 <xmqqlga136es.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlga136es.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/23, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Brandon Williams <bmwill@google.com> writes:
> >
> >> Signed-off-by: Brandon Williams <bmwill@google.com>
> >> ---
> >>  fetch-pack.c | 16 ++++++++--------
> >>  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > I do think this is a good idea, but what release does this target?
> > It does not seem to apply to master@{4.hours.ago}, and I do not
> > think a change as trivial like this wants to be taken of a hostage
> > of _all_ topics that are in 'next'.
> >
> 
> Answering myself, this would come on top of (and would become part
> of) bw/ref-in-want topic, I would think.  And I am perfectly OK for
> this change to be hostage of that topic ;-)

haha yes sorry for not mention it, but yes I built it on top of
bw/ref-in-want because it was in response to this topic :)
-- 
Brandon Williams
