Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5180B1F461
	for <e@80x24.org>; Wed, 28 Aug 2019 11:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfH1LAv (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 07:00:51 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:44500 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfH1LAu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 07:00:50 -0400
Received: by mail-ed1-f43.google.com with SMTP id a21so2485150edt.11
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 04:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xbrPkCyzcsMhrGt4LvtxCNiB5PitTonnCa7lJdJbFow=;
        b=UeTqB419CN8yklBJYsAqAdKw6sNCjQhys5fWaRGlq+U9ob86kDqsnWZZKpqhGQU74x
         ubFCoCXqDfqPMF2C+jV0o0J4vFbFkKwk8UXsqM3X3FYMfp1WMX0kYh50GSPuKFiAy8nL
         csch3PwCSzdqDtPR1Y4gBxUhBtr9FOD4sIlgvxdKYVH4xSUoIaLawmi5ZSSr3xVsGNLw
         V4cv0k0UphgXMo6MyohfdqFoscKIhSEWC0chLixXwTZbBwC8YnsV8Hfcv8p8AJbsOT2Q
         0+Qs73UnMyqr7uPCFgf6DoRGfi592kssMPJwi9iwQa18039PWlVu7om0IiLkQ+23IxaH
         nstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xbrPkCyzcsMhrGt4LvtxCNiB5PitTonnCa7lJdJbFow=;
        b=DFDlPkHk0kmLEI40FBeuX5/l0j22ka2xIPftrY1YacBfN8d8aRn0T3sICdrG3DjVee
         R6MeSHsGXzAe8g9nk5LQHeE+EyRJLNYXqVxNJb+VJ1PHVMfwV2TDM72Hxte13IYOvkKX
         OlSgbjSZOWbda7OWexwtHWacYx0trDWLFXOR2dIpE8vOJDyxNucjyfFuHU3Ln0bc1VM8
         DDgyJW2WTSsTJDnk0rGLaA9kcYoo0kZrUDJ3px/sWJzS+Ytd65/Xuh1flclt4H3rXfBP
         dbX/lqYVW49bthQVzhHzQje6dD0HDlln6D7LNJWULoM66R65us1lzgUmQBG4lZUraIel
         EN5w==
X-Gm-Message-State: APjAAAWaoWarneGtf5GcMnFSHhn3/mN6dHIsBZerc1L0eChA4aRoej50
        wvbH2spn2IY9gwv0WmZJPZY=
X-Google-Smtp-Source: APXvYqxM9zWfwCwNApyNWMOt5PELXEP1lm8Q762BIlSuBiDrc5xh/Q0HC2He6ALjF7+JB2hVdXz5bg==
X-Received: by 2002:a17:906:4b13:: with SMTP id y19mr2573022eju.145.1566990048915;
        Wed, 28 Aug 2019 04:00:48 -0700 (PDT)
Received: from instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal (1.133.65.34.bc.googleusercontent.com. [34.65.133.1])
        by smtp.gmail.com with ESMTPSA id g13sm383117eds.39.2019.08.28.04.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Aug 2019 04:00:48 -0700 (PDT)
Date:   Wed, 28 Aug 2019 11:00:46 +0000
From:   Giuseppe Crino' <giuscri@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Giuseppe Crino' <giuscri@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        git@vger.kernel.org
Subject: Re: How to build to debug with gdb?
Message-ID: <20190828110046.GB4450@instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal>
References: <1d44d8d6-6c6f-591e-dd2c-5102c9fd7d11@kdbg.org>
 <20190827183640.GC8571@szeder.dev>
 <20190828081557.GA18785@instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal>
 <20190828103217.GA6400@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190828103217.GA6400@szeder.dev>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 28, 2019 at 12:32:17PM +0200, SZEDER Gábor wrote:
> I don't think it's unusual at all that the 'install' target depends on
> 'all'.  A quick and incomprehensive survey of Makefiles from a few
> open source projects that I happen to have lying around seems to
> confirm this.
> 
> What might be unusual (but is rather convenient for developers) is
> that Git's build process checks the build flags, and rebuilds the
> whole thing after the flags changed.

Maybe I'm biased by my incompetence with Makefile's but since rebuilding
the project with `install` but different flags from the first make is
unusual this is worth mentioning to developers.
