Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A5581F404
	for <e@80x24.org>; Fri,  9 Feb 2018 19:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752422AbeBITHm (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 14:07:42 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:55530 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbeBITHl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 14:07:41 -0500
Received: by mail-it0-f65.google.com with SMTP id b66so12195760itd.5
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 11:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pxdrbxb5mL91vTtBf4duRv/csk2BfsjmcAfuw86W4R4=;
        b=pzIegboLxDtVyb8Ed47eu6iwLnHHePEQUAIMvrL1Fb8Ar1Kx2JbQyNt5QOjef5xoMA
         A2d/TnExWBJMNCkHRFA9pYBqI3wqKZi8gKY4EbdkOZpBUnbqCG/gutNkhFzzn6Eoc43h
         iPqj4Ox3mtEiwXeu9JRgES8ddX1cc9CNEXwtGHWtaUk1tr3zMgMM9JteSD8WVRQyrOZZ
         TRv8bqB5p8ej17T5sX6wjzebf63Bbew3af4jLGPCREvfJB4s0RpMZKssmRnv3hVZ94pC
         QGyBNrVSi3JoP+UxDJlSepdZ5RakkGo8KYR6LqbgPRxW/UpU8Srz0rhIjLJAiUfreUpA
         rB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pxdrbxb5mL91vTtBf4duRv/csk2BfsjmcAfuw86W4R4=;
        b=OXboZPDfv3yQR+xK/FF2y6oqFtinC7eBouAsREhCVhJ7b2j5YJwpg1LgY618mbxnJl
         nWovplsrwzEeQyC7fx20BCx+FZPmGVHgsK4zgrjxfQ3IHdWFnTifV3DDL6qjw6TRyrcI
         wChOEmrY++E1o75Uefv2zSA4JkbfxWxST98uMD+uK9WQM1PYlD2DgcEqXpw6SzncAlvM
         8avBrWHNqiaaulQ8mgDB3rDwbGO1acsEMqrsCvCuJVPcD5M55FIXi/PKRzn/CmO4yoaB
         o+ZS6w3otbzQ6kQBRsNuXOpeckD7pVh38tZ/qcMPJbrmpP+HWSPZv+WAj+AkZ0hJDDKt
         hlZw==
X-Gm-Message-State: APf1xPCQFgEesF68zQC+uRSO8PHKrzG/KtxiAgSkSgfkUSkHS4VTXk6A
        QINLC7ko/WrbDMaBkX3Ns2XkNoYl7bg=
X-Google-Smtp-Source: AH8x226QzJpDWdPE+61UtR78JQnTcJobHfyBLdJR6BUC8/ebYt+EuyVGmXlukSAbGvqrwOkMAs1J/w==
X-Received: by 10.36.20.145 with SMTP id 139mr4656307itg.15.1518203260566;
        Fri, 09 Feb 2018 11:07:40 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:402:7570:b525:af9b:18f3])
        by smtp.gmail.com with ESMTPSA id j77sm3869933iod.47.2018.02.09.11.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 11:07:39 -0800 (PST)
Date:   Fri, 9 Feb 2018 11:07:38 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] CodingGuidelines: mention "static" and "extern"
Message-Id: <20180209110738.edbc7a700b689db6967ec86a@google.com>
In-Reply-To: <CAPig+cT_ddVSEvdnMTNhtxWJMm4=DLyq8-hSDXa5X0i6rXa3xA@mail.gmail.com>
References: <20180208201546.194935-1-sbeller@google.com>
        <20180208204309.GA4541@sigill.intra.peff.net>
        <CAGZ79kb+xEVZagqqNCHCPQUbfH89N7fdrO7dp6WHRGgJJje28Q@mail.gmail.com>
        <20180208213806.GA6381@sigill.intra.peff.net>
        <CAPig+cT_ddVSEvdnMTNhtxWJMm4=DLyq8-hSDXa5X0i6rXa3xA@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 8 Feb 2018 18:14:06 -0500
Eric Sunshine <sunshine@sunshineco.com> wrote:

> On Thu, Feb 8, 2018 at 4:38 PM, Jeff King <peff@peff.net> wrote:
> > Subject: [PATCH] CodingGuidelines: mention "static" and "extern"
> > [...]
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> > @@ -386,6 +386,11 @@ For C programs:
> > + - Variables and functions local to a given source file should be marked
> > +   with "static". Variables that are visible to other source files
> > +   must be declared with "extern" in header files. However, function
> > +   declarations should not use "extern", as that is already the default.
> 
> Perhaps:
> 
>     ... as that is already the default, unless declarations in the
>     header are already "extern", in which case consistency
>     may favor mirroring existing usage.
> 
> or something.

I would prefer not mirroring existing usage in this case - I think it's
better if the code becomes eventually consistent in not using extern.
