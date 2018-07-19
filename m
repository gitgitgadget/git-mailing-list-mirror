Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B5761F597
	for <e@80x24.org>; Thu, 19 Jul 2018 12:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbeGSNdT (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 09:33:19 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:51702 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbeGSNdT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 09:33:19 -0400
Received: by mail-wm0-f52.google.com with SMTP id h3-v6so5665413wmb.1
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 05:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=4Ow3U2hf5aVjkFNS/3oZtB/wJY6nhcMxfhoSNuaCJqU=;
        b=kW50RqH9ntwg/sS/o7oxUuQ9gccUqHmgXO5M7uWv37ePQwv6UBpt4mOR+TUS77ml/6
         kP2ajQt6HxkvIIBmhgWoZ/diOV15GBDSHpyYnjy04dzfYS/nfnNczqrBzVqqKzX3ncjp
         hsrWmXrQpE8djqJlYV8a16IuSKMvVDopSELKqT+Dy3+ukIYPuoIezzBaj5nTd+7U23n+
         UlWMdunJnA+r5Wv8YaiS2YVJE/0xu6wWTUDh6Ls2BOSbhIXshq/ajOLnITEzNiVJTvGn
         9VRSpRf3VMwDEW9YvVvHPyHnVSfsHANyXOxthW6yxDSW9K+6+qkSb0kXNEhUcIisjmwQ
         rCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=4Ow3U2hf5aVjkFNS/3oZtB/wJY6nhcMxfhoSNuaCJqU=;
        b=ncmVK8kr9RpyFIqhibD71FqZ59XvJc46iR/9t2ebhSdFO5BvZoidtEYh09nh2l7GMh
         3UJM89J7GoSZXjFdFrdpY5Wj8O8mnlzfTkC3Q1rb4Chekl2ngqvgP3mB/Q0pTtDcCh8Q
         SkB2EjgN636nk9CNJSfJYNPR30Zl3l0iTcmgtZhHl8fWIeMsC7ih8iJfJay9+mAULNwH
         LkaTOqWQ1e6NNPOEzwKwdQH2quLL50ezQEHBzU03TH/vSrJtF+5luDfxOD6Wtv4V0khf
         hiwWTlq/qWbJjtSDUGL3VASIyEhLoM1LMVoy2uYE5/Gb8IrUBh6ZHCwlrX7lPFMdCl6i
         1ZPw==
X-Gm-Message-State: AOUpUlGXYVx7a+5jYd3ivDJkXK28ngGEOawK+r/oy5BZqjd5UX05dbgG
        xnFHyTj2yv301d+3LmPwSVs=
X-Google-Smtp-Source: AAOMgpdakprFLrVejp2V/uy+rOovqrmMA4N5f20rJSPO7JKuLRxgd2tvSWfOSKwH1Q5ySPb+LsEEuA==
X-Received: by 2002:a1c:9cd3:: with SMTP id f202-v6mr4137417wme.148.1532004617903;
        Thu, 19 Jul 2018 05:50:17 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id o13-v6sm4657099wmc.33.2018.07.19.05.50.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 05:50:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Basin Ilya <basinilya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Use different ssh keys for different github repos (per-url sshCommand)
References: <44d3c280-3fb2-2415-46b7-343983e76e0b@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <44d3c280-3fb2-2415-46b7-343983e76e0b@gmail.com>
Date:   Thu, 19 Jul 2018 14:50:16 +0200
Message-ID: <87zhynbd9z.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 19 2018, Basin Ilya wrote:

> Hi.
>
> I have two github accounts, one is for my organization and I want git to automatically choose the correct ssh `IdentityFile` based on the clone URL:
>
>     git@github.com:other/publicrepo.git
>        ~/.ssh/id_rsa
>     git@github.com:theorganization/privaterepo.git
>        ~/.ssh/id_rsa.theorganization
>
> Unfortunately, both URLs have same host name, therefore I can't configure this in the ssh client config. I could create a host alias there, but sometimes somebody else gives me the github URL and I want it to work out of the box.
>
> I thought I could add a per-URL `core` section similar to `user` and `http`, but this section is ignored by git (2.18):
>
>     [core "git@github.com:theorganization"]
>         sshCommand = /bin/false
>         #sshCommand = ssh -i ~/.ssh/id_rsa.theorganization
>
> I thought of writing a wrapper script to deduce the key from the arguments:
>
>     git@github.com git-upload-pack '/theorganization/privaterepo.git'
>
> Is this the only option?

Yes, I had a similar problem a while ago (which I sent an RFC patch for)
which shows a script you can use:
https://public-inbox.org/git/20180103102840.27897-1-avarab@gmail.com/

It would be nice if this were configurable. Instead of the way you
suggested, it would be more general if we supported:

    [Include "remote:git@github.com:theorganization*"]
    path = theorganization.config

Although I'm sure we'd have some interesting chicken & egg problems
there when it comes to bootstrapping the config parsing.
