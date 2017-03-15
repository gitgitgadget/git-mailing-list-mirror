Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8206E20951
	for <e@80x24.org>; Wed, 15 Mar 2017 00:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbdCOAUS (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 20:20:18 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33137 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751294AbdCOAUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 20:20:16 -0400
Received: by mail-pf0-f169.google.com with SMTP id w189so1036021pfb.0
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 17:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2EgZlBj5vaxch4G+6W7LSSg3xlmUKP9lqOyH+ETDMTk=;
        b=Hk7azhgI3QWhtH4fsCh5w1hxmyBBU+NREly+Z5jVO3PPkbk8Lnrg0V0d1C0G71E1tF
         TkrDBG5SObv1c4psbUv5Zn+C07hB24kOFNKgIM8a6NHqJFCCcdE43z6l1qTB0MWSYiox
         Xwzf2nmRHgesuf4ud467dAndQa3muSHiOArIBiXyG2MQ5a8+W05hO87gxstzR25MU4nr
         CU7VWudfCDp8rnmBpKKq0CkhUU+Jga3x5w5x4LuUbBlOpAJb0d3ppGJsgdmftND5RQs9
         ksfDZYy1ku9315PCGZoxP/cV3g6TVO4rBwRyqO7q4rSaflX0n5zcYv6TkvcGdNaljwQw
         CRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2EgZlBj5vaxch4G+6W7LSSg3xlmUKP9lqOyH+ETDMTk=;
        b=a3yXSHUfu1thhDoTI7GDHQQe8wDr6Kwq6LY6xfprtAivFNLHmXT0rHasOGLEMPLXCv
         zkhHp9Oe9EzgV18gzSu/I2BqdJcxFD/REdbUPrWyYOyBEPuPOtP53W9aZolpY0/bK+qd
         krT1NYEpOOnMbH5da1Ha1mfZLouXFtWSIAwkD8EMfjolG3w17YHF25EqaBCyvyNFYQ+4
         lFALtMKRQxDTT3qZXv3rvZxCt6guAf52FnfE+1pk4zYqdjfbsBIXrjnu4Hjw6R3fS2/m
         AfzBx7pohPuDUuO94niHwK5l9gqee9nLYmOI4PN+4Yb+l2iEn44buHt2AD3FI31jaHPI
         n7jg==
X-Gm-Message-State: AFeK/H0iA00jMKBG4tN+U9L17hVkegSQYsp8HAPWNKMMkX0HL5zEbqXfssPv8Drd5FHTTyDF
X-Received: by 10.84.133.36 with SMTP id 33mr576709plf.87.1489537210250;
        Tue, 14 Mar 2017 17:20:10 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:491b:baa8:63f0:3cf1])
        by smtp.gmail.com with ESMTPSA id g64sm203353pfc.57.2017.03.14.17.20.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 17:20:08 -0700 (PDT)
Date:   Tue, 14 Mar 2017 17:20:07 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/4] grep: fix help text typo
Message-ID: <20170315002007.GH168037@google.com>
References: <20170224235100.52627-1-bmwill@google.com>
 <20170314221100.24856-1-bmwill@google.com>
 <20170314221100.24856-2-bmwill@google.com>
 <CAGZ79kZwUcNB=ZKAb38CBMX1Y-EoP_CbXOzEod6wAaKnATghrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZwUcNB=ZKAb38CBMX1Y-EoP_CbXOzEod6wAaKnATghrg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/14, Stefan Beller wrote:
> On Tue, Mar 14, 2017 at 3:10 PM, Brandon Williams <bmwill@google.com> wrote:
> 
> Missing SoB here, too.

I guess I'm having an off day...Will fix.

> 
> > ---
> >  builtin/grep.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/builtin/grep.c b/builtin/grep.c
> > index 9304c33e7..4694e68f3 100644
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
> > @@ -979,7 +979,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
> >                 OPT_SET_INT(0, "exclude-standard", &opt_exclude,
> >                             N_("ignore files specified via '.gitignore'"), 1),
> >                 OPT_BOOL(0, "recurse-submodules", &recurse_submodules,
> > -                        N_("recursivley search in each submodule")),
> > +                        N_("recursively search in each submodule")),
> >                 OPT_STRING(0, "parent-basename", &parent_basename,
> >                            N_("basename"),
> >                            N_("prepend parent project's basename to output")),
> > --
> > 2.12.0.367.g23dc2f6d3c-goog
> >

-- 
Brandon Williams
