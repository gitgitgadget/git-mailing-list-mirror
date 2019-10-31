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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D8C31F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 17:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfJaRfN (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 13:35:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38217 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbfJaRfN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 13:35:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id w8so2996536plq.5
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 10:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YxhRCxYQN86JsT4aY0/oduodhPTNfdK2nhl30E124Bc=;
        b=G5DyUlTGKCXkYnpVOko81dbfAk0Qiu0qFBHyZDOC+I4FesiP1oxKKKmmHIUXBG8VoY
         gYH363cXqxWz3XN7pKUK9cSyhc6YHH31eWSrsz7jEouaMqrjohQWQ60+kZAxDtrymrLq
         RoOtXs7SroDNJmVUTCJAeWKB4+32ur7U0Rntk+WxmNxekwUmy7USO73hXBoG6K/Q418h
         WCcF+m0i46xdNcjdBzHL+0+dhL8Ak6229SGgt4LkH1iBXyODF5PPqOXgj+7hyK2dURz5
         Xz7gumirgyM2NCcMjuLDiXeBTi+UwDcC4glNBCatu0uBqgbVnoOCQbHDaz4Bp7GEGKR9
         uiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YxhRCxYQN86JsT4aY0/oduodhPTNfdK2nhl30E124Bc=;
        b=T1iotKLnyB/R7zpO3OedNLiAu9jQhOXoub0UMmPYDLNG0w8LqNjV2u6CYhPbbSYksh
         +jAz1y/ET1hmOeVe9ZdR2K4kFnLsmkczIdUqZj2BHv4vvYUpMu6J2jFmyM6xiPi6ia+w
         xajmdcOJdZO4P1+7nacuRPr6SvjR5EMsyGhvc1eroh9NHe7ue/M0gGIMRqIohLs2mWB/
         DeYb/7O/OJ1RHBjqveNPYEvcFWrhwJvcuEx+kqX9aGn/5eGflD9/kC/RA2xSQnQ+7Nmd
         LoGyXKLz5lvEVXdBTEWWtcGUb17be3EhS6tN48BHUi2HWiPEjtYsLpqwHxzhn9mXxudv
         lC8Q==
X-Gm-Message-State: APjAAAWweLfC+NKCYPDxDu+c9NMWlzkptSFy9uXdUkby5B020t8iJqqT
        LGv8x8RfV74zVbjp5SJ4Aer2jiNg
X-Google-Smtp-Source: APXvYqyiJE4Z7Rd3ef+lHIwuxHNY5s6WFJsKoD4ZFzaAKPfcomdcbo7e7xwpmZmEdIDk/1ew3mIe6w==
X-Received: by 2002:a17:902:8a96:: with SMTP id p22mr7487239plo.272.1572543310836;
        Thu, 31 Oct 2019 10:35:10 -0700 (PDT)
Received: from generichostname ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id w8sm3842340pfn.175.2019.10.31.10.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 10:35:09 -0700 (PDT)
Date:   Thu, 31 Oct 2019 10:35:07 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git branch --edit-description a custom file
Message-ID: <20191031173507.GA70819@generichostname>
References: <20191030183950.GA21277@generichostname>
 <20191030202835.GB29013@sigill.intra.peff.net>
 <20191030224328.GB44961@generichostname>
 <20191031061832.GA20830@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031061832.GA20830@sigill.intra.peff.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 31, 2019 at 02:18:32AM -0400, Jeff King wrote:
> On Wed, Oct 30, 2019 at 03:43:28PM -0700, Denton Liu wrote:
> 
> > On Wed, Oct 30, 2019 at 04:28:35PM -0400, Jeff King wrote:
> > Dscho brought up in the GGG thread[1] that perhaps we want to treat
> > branch descriptions like notes and have them all under something like
> > `refs/notes/branches`. This would certainly solve my problem of
> > having versioned descriptions and it would probably do it in a much more
> > general way than having a versioned included config.
> > 
> > Anyone see any potential problems with this approach?
> 
> I don't think it would be `refs/notes/`, as that is assumed to contain
> mappings of object ids (and if I understand correctly, this would be a
> mapping of branch names to data.
> 
> You could just have "refs/meta/descriptions/foo" pointing to a blob
> which contains the description of "refs/heads/foo". That makes it easy
> to edit descriptions, even if you don't like using "git branch
> --edit-description".
> 
> You could also have "refs/meta/descriptions" to point to a _single_ blob
> with all of the descriptions. It could even be in the existing config
> format. And then you could include it with "[include] blob = ...". That
> doesn't exist yet, but it would be easy to add (it was something I had
> always considered when writing the config-include code, but there was
> never really a good use; and you do have to be careful about pointing to
> untrusted blobs). That's a convoluted way to get where you want, but I
> wonder if integrating to the existing config system would have any
> benefits. I haven't really thought it through.

I like the ability to include blobs for several reasons:

Main one is that it handles the versioned branch description problem.
But it goes further than that, there are a lot of config properties that
teams might want to share amongst each other. For example, whenever a
project has a custom smudge filter, usually they include some sort of
config in the project's README or some sort of setup script. With some
way to include a shared version of some config, this might be simpler.

> 
> (Of course that's also only one step away from having a versioned config
> file in your .git directory, but it might possibly be a bit easier to
> manage, since it would always be committed).
> 
> That's mostly off-the-top-of-my-head rambling, so please disregard
> anything that seems totally off-base. :)

Thanks for the discussion on this, I probably won't be implementing the
blob config stuff for the purpose of branch descriptions but I think
it's a good thing to think about.

> 
> -Peff
