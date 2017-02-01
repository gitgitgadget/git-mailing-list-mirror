Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8394C1FAAD
	for <e@80x24.org>; Wed,  1 Feb 2017 09:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbdBAJcS (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 04:32:18 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34229 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751732AbdBAJcR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 04:32:17 -0500
Received: by mail-wm0-f65.google.com with SMTP id c85so4513224wmi.1
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 01:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hWrep1UA4MlnjgMPX9d2QleXIhTIaUJCB9mJIw0ZN6I=;
        b=SxrnHfOD0ur3NHxkihGvr9wztQ0OZ0Cr1XRhkowsFSfOs9eQE+OzlXqY3VH5p6QfLi
         SMctQOp2ZQdQPht6rhkNA1J7XfSvfnaB4jQEwfD0scWyC16XsSzkDCpQfOLiuXrwEZEn
         YTUFW1jJJzBy8LLkSjzao3qwx5qTAr55+F74GdrAOnOrXthZL3L1elo5wVSQ090Sraw1
         X0eOlJjR1zIGsUm6ScDmc12wrxAtfh1LyAkyeTVEe9S6twcVeOvQWPqFTslCYhlnXzh9
         GwIsrKVzsnIeNem1mpkY1A43iI8ujPXiyK20VXkADKamR1YedPrq3WVC/orYVzNOMHsg
         iNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hWrep1UA4MlnjgMPX9d2QleXIhTIaUJCB9mJIw0ZN6I=;
        b=lr0f5gaFWkumN5F9Q5LNp2DEqJUnDgpmtITSCS/rjkqQaLYyEjWT13XKeafvpDk6J5
         yYDBTO2D/t95ANneKPIFMeZcx5RGk06kAeNTMKyXejSy0vxUZ8z2149kLom6Okw30beM
         vN0T2g6pSPnsGpuQmreHnyPurJNGEzgGc8DkqNFWsTeRqfcjLH8NClLaDG0kNpt6Vjxq
         oeDdkYMPj01C8fBlJ2DKra0lfpLgT6D9UwKC4G8/AMI+GM3BxZl6EurbCk3kb16HTrZX
         cuHTbHK20EDPxiLosTSh/gaFoFjH47uzcHYr7xDE9G1K+b40Epe+Mv/cswhQm6R/JOh/
         jkJA==
X-Gm-Message-State: AIkVDXJnSYrf1JJCEzyby/FBNejs3REzmXmLlA1Hj59R4ySxH2avJV1Hiwr0FJoZnPp71Q==
X-Received: by 10.28.156.86 with SMTP id f83mr20921610wme.93.1485941535677;
        Wed, 01 Feb 2017 01:32:15 -0800 (PST)
Received: from localhost.localdomain ([212.123.9.170])
        by smtp.gmail.com with ESMTPSA id n10sm33018730wrb.9.2017.02.01.01.32.14
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 01 Feb 2017 01:32:15 -0800 (PST)
From:   Erik van Zijst <erik.van.zijst@gmail.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, ssaasen@atlassian.com,
        mheemskerk@atlassian.com
Subject: Re: [ANNOUNCE] Git Merge Contributor Summit topic planning
Date:   Wed,  1 Feb 2017 10:32:12 +0100
Message-Id: <1485941532-47993-1-git-send-email-erik.van.zijst@gmail.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <20170131004804.p5sule4rh2xrgtwe@sigill.intra.peff.net>
References: <20170131004804.p5sule4rh2xrgtwe@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 31, 2017 at 01:48:05AM +0100, Jeff King wrote:

> The list of topics is totally open. If you're coming and have something
> you'd like to present or discuss, then propose it here. If you're _not_
> coming, you may still chime in with input on topics, but please don't
> suggest a topic unless somebody who is there will agree to lead the
> discussion.

I would like to talk about the possibility of CDN-aided cloning
operations as mentioned on this list earlier this week:
http://public-inbox.org/git/CADoxLGPFgF7W4XJzt0X+xFJDoN6RmfFGx_96MO9GPSSOjDK0EQ@mail.gmail.com/

At Bitbucket we have recently rolled out so-called clonebundle support
for Mercurial repositories.

Full clone operations are rather expensive on the server and are
responsible for a substantial part of our CPU and IO load. CDN-based
clonebundles have allowed us to eliminate most of this load for
Mercurial repos and we've since built a clonebundle spike for Git.

Clients performing a full clone get redirected to a CDN where they seed
their new local repo from a pre-built bundle file, and then pull/fetch
any remaining changes. Mercurial has had native, built-in support for
this for a while now.

I imagine other large code hosts could benefit from this as well and
I'd love to gauge the group's interest for this. Could this make sense
for Git? Would it have a chance of landing?

Our spike implements it as an optional capability during ref
advertisement. What are your thoughts on this?

Cheers,
Erik
