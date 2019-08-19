Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8CBD1F461
	for <e@80x24.org>; Mon, 19 Aug 2019 23:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfHSXQR (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 19:16:17 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40344 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbfHSXQR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 19:16:17 -0400
Received: by mail-io1-f67.google.com with SMTP id t6so8091362ios.7
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 16:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mc1stdaHBuQZsVndprbDWjl01ZWgV8jSbxeYesVQ1eE=;
        b=sSVv09fdyFP1fV0xwHNvDFi/7783nWv101IdtpOHfbeXDVrdL5578R6yh37XK8p2WU
         FRHo8bB8LDESZDnsX5by6ww9f2Aw18pVKwreLN4vfPXdvP1NbL3DcwfrH3Yv6Y7DV9ha
         PIi8JRwZWJHP9ecBIaML1IBVFz4QRHsaZCywWZqDjSZq5U8nUNkVO3h1PTpMQY0D+Sb5
         0+00kh4MjeruhcDaSnNQKQ+3OwKAofP8lszwm5+ihHAQu4pflFe/Cz5P2LyRxojv3LBf
         /DIRpfCRiB4N5URTBG0zuhnFdO1hYg0OgF9VqugEmWPrOlpAI1BXk4RV3hcuFTvwzLHW
         1g3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mc1stdaHBuQZsVndprbDWjl01ZWgV8jSbxeYesVQ1eE=;
        b=m/n8upkTw9k3CW6B2ruwKKjW4/XzdZ0B5tDN2pdILCVRmqGjOP4T7F5wIrWjaMGFHu
         KZVb12ATdbI6+kfw2R0NSaSSJDUJxqzYIqNZ2i5bS08FI/a3hvwSPzBMe6+itVhC9F95
         oejMBQ83ee2bh2tIr8xv+bNW9v/u2t77xHYzMHtppHcgg3Mtzxw1zI27UOp4HsJvWQ9i
         LMoFok5LH8yGBzOeLPjBZ9v9W9aUnH3Gg8N2WaZWMXpY7C+rDE3C6ZFvDas8R2y9y9ui
         YlqyFFoEwj8AbdSflBFKch9y8F+hJyWAqyeP5UJSnA4gblfjqoPbdaf3j+kK3KeFN690
         iHlw==
X-Gm-Message-State: APjAAAXa+kuNTS7fTGyqt5D6LsVd9vXh0fcmiylbL6CIQ/tCjQBpZPqh
        CrobuWASVyPXn9jFgsesllNSAFCc
X-Google-Smtp-Source: APXvYqy5G18BX1F9k31eq2e8U48FaDxHNCLZjbTL1TmUNDj9GmlYGmKdXtHdP75oJsE0BRFdCzV84w==
X-Received: by 2002:a02:c012:: with SMTP id y18mr314530jai.85.1566256576527;
        Mon, 19 Aug 2019 16:16:16 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id s12sm8105705ios.31.2019.08.19.16.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:16:15 -0700 (PDT)
Date:   Mon, 19 Aug 2019 19:16:14 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Doc: add more detail for git-format-patch
Message-ID: <20190819231614.GA3444@archbookpro.localdomain>
References: <cover.1566182184.git.liu.denton@gmail.com>
 <7619da962d1fc804392e3552fbd56bf4bc68ac38.1566182184.git.liu.denton@gmail.com>
 <CAPig+cSG6mHCgLRw=QLWkVhK4oVSFkQRCszrBdO6SCGA+M0B3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cSG6mHCgLRw=QLWkVhK4oVSFkQRCszrBdO6SCGA+M0B3Q@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 19, 2019 at 01:09:04PM -0400, Eric Sunshine wrote:
> On Sun, Aug 18, 2019 at 10:37 PM Denton Liu <liu.denton@gmail.com> wrote:
> > In git-format-patch.txt, we were missing some key user information.
> > First of all, using the `--to` and `--cc` options don't override
> > `format.to` and `format.cc` variables, respectively. They add on to each
> > other. Document this.
> >
> > In addition, document the special value of `--base=auto`.
> >
> > Next, while we're at it, surround option arguments with <>.
> >
> > Finally, document the `format.outputDirectory` config and change
> > `format.coverletter` to use camelcase.
> 
> I can't figure out if you typeset "camelcase" like that intentionally,
> as opposed to "camelCase" or "camel case" or "camel-case".

I thought that was how it's spelled but a quick Google search proves me
wrong.

> 
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> > diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> >  --to=<email>::
> >         Add a `To:` header to the email headers. This is in addition
> > -       to any configured headers, and may be used multiple times.
> > +       to any configured headers, and may be used multiple times. The
> > +       emails given will be used along with any emails given by
> > +       `format.to` configurations.
> 
> Hmph. This seems redundant. The description already says "This is in
> addition to...", so a new sentence saying "...used along with..." is
> just parroting what was already stated.
> 
> >         The negated form `--no-to` discards all `To:` headers added so
> >         far (from config or command line).
> > @@ -314,7 +318,8 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
> >  --base=<commit>::
> >         Record the base tree information to identify the state the
> >         patch series applies to.  See the BASE TREE INFORMATION section
> > -       below for details.
> > +       below for details. If <commit> is equal to "auto", a base commit
> > +       is automatically chosen.
> 
> "is equal to" is unnecessarily technical-sounding. How about:
> 
>     If <commit> is "auto", ...
