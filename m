Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,
	RCVD_IN_SBL_CSS,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ED1920899
	for <e@80x24.org>; Wed,  2 Aug 2017 12:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753117AbdHBMbf (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 08:31:35 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36730 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752370AbdHBMbf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 08:31:35 -0400
Received: by mail-it0-f68.google.com with SMTP id r9so3755279ita.3
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 05:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=DDA1IRjeyEcu7pFoY3J3mDEUFvgZ9P3N7xgxrwuFS8k=;
        b=PTXkQGUHjHESYNbJtTDl3/ikG+Xa6J3Arp5N0aOOjJTZGkI08iigF5cf9q2Ij3di2H
         FQhEectR8Bzn52w2SvSz5SgCL7W47hRdDnpDeRNw8atqMblzXnXvXfNywDkoOQsdoNr+
         iRilELGOkqVegIFyHOAHNQEB3n/tSrQO46MWDFWYZYMewOxkubmp2AweVr1VTqDvUY+q
         C8EV1uFz8my9FdNEVIAhnyjf/G7UiyKRFLzZFEGYV37AIrd5588vt41GSYoQJSiQVJo/
         U0Djm4GZhPdJkqpJBX/zfyGGDv7WpVe0s/4ZhCcDolAu5v7TH9dXKtW3vat6D8gPHkrc
         Ewvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=DDA1IRjeyEcu7pFoY3J3mDEUFvgZ9P3N7xgxrwuFS8k=;
        b=Cz+9fBmYkXMlaZoXbjQZOMKdQt/s5G2ck2IX/sqxcAc8z98mbKGWXEKEifHYZbCcZE
         VO+JzDN2s2ZnTQp683a//QemwIw6ozVayW+9eofkaH839SpT1xIl4afIt8nW2KW1e5kc
         ayJzNvR0s8wFtbrez9jX1OqS9gbHD35xyWu5SmNSqbE6BCTVD9ShnqK4bJwVv3qHiG65
         MUN5mzVm0KI3/HTFiNSCl58BD7YlhSQ20hjAMZXcn19CzHmG+KoJmlIobiZeSJ098P5C
         p8r39Mr2eT0IAfnoas0uEh0Dd1/6lMRhrl8fuRDmx+WymYQ2KAS0iBtLpi9+acFmDEQ/
         M+EA==
X-Gm-Message-State: AIVw113QhFLppfujhaCxIM2nBCZTbftnX5p9z4ivwWHt3nkmk27j3S37
        0b5Vw/aJ6uslWA==
X-Received: by 10.36.160.72 with SMTP id o69mr5403569ite.150.1501677094472;
        Wed, 02 Aug 2017 05:31:34 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id l193sm1978826itl.13.2017.08.02.05.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 05:31:33 -0700 (PDT)
Message-ID: <1501677122.1957.8.camel@gmail.com>
Subject: Re: [PATCH 2/2] doc: add another way to identify if a patch has
 been merged
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <CAGZ79kZgV1=2HcYeXyoCy2Jk6v__trvTh_-rH+kbFX7fgWziyw@mail.gmail.com>
References: <CAGZ79kYg9jQ3kaKnNEJCH9fde=ar1KPiUr7=X+TguNc0Twqdzg@mail.gmail.com>
         <20170801160539.5587-1-kaarticsivaraam91196@gmail.com>
         <20170801160539.5587-2-kaarticsivaraam91196@gmail.com>
         <CAGZ79kZgV1=2HcYeXyoCy2Jk6v__trvTh_-rH+kbFX7fgWziyw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Wed, 02 Aug 2017 18:02:02 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-08-01 at 10:46 -0700, Stefan Beller wrote:
> Actually I am slightly negative on this one, because of
> occurrences like [1].
> 
> Our SubmittingPatches is already considered *too long* for most people
> who just want to drop a drive-by patch.
> 
> Adding more knowledge (which btw is about general git usage and not
> specific to our development workflow; you'd find the same tip in the
> kernel community).
> 
> I wonder if we need a document that describes workflows.
> (Oh, look we have 'man gitworkflows'! I did not know)
> 
> So maybe we want to cut a lot of workflow related commendatory from
> the SubmitingPatches and then encourage to read such man page?
> 
That's right. Maybe Documentation/SubmittingPatches needs a revamp to
be one-time contributor friendly? Maybe introducing a "gist" for people
who do not have the time to read the whole document, might be of help?

> [1 ]https://public-inbox.org/git/CA+dzEB=cDvp7ZS8x+p+U-5NbK3SNd0FPyj_wP=gvi8mJi6D2ag@mail.gmail.com/
> 
> 
> 
> > --
> > 2.14.0.rc1.434.g6eded367a
> > 

-- 
Kaartic
