Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 368FC20323
	for <e@80x24.org>; Wed, 22 Mar 2017 18:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965542AbdCVSXd (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 14:23:33 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36756 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965446AbdCVSX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 14:23:27 -0400
Received: by mail-pf0-f196.google.com with SMTP id r137so24253380pfr.3
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 11:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rGImb5G9HSJloKDGBmPREnV5G7TZwlH+wOmpVd+6Lq4=;
        b=GM4o9czQoxh9DJFogJj/Gf64TMN1UbxZsOMcTGzFoOxQTcZdPVR48hfydr2xarXmR7
         yiS+iJJfL2HqnWKTicisAKGJbbZnnv8Mmka5FZ8nf6kYIvRPK507k/82ggsqE7fFpDU5
         APMJ23RRj5aKlL613JIdK4DCysEquiqFKnACkunJ5hzTVPDHa6el2qRrjnB2iQW7pBZi
         VlGrXWtIowmh0gPt7FlpjhMx4c8Lz6+9bcnxl9dGcE+oUPr9CS4/0w1GvS2GmOMN6b5M
         QkaNOqJ1ogF/coXnrceehaUbc3bt+V7LFxT64XM47iN+c1llLG9oBNZEHzBBMPdaKfDy
         gWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rGImb5G9HSJloKDGBmPREnV5G7TZwlH+wOmpVd+6Lq4=;
        b=IVR03nK+xSPaQHrscgnhH0MSakd6s3Igq1dKVW8CMBKPmzZINAbsqIAG6mvMfTptfS
         6w/sExvUoDUjgTdo54i6TL604I8J624auQgN3f0eaV56/rhG7yJ0LajglFnrBe7MnhHb
         Ml5VUchGHHYdlvzV0GlT9MrMOj7P5BmJC0IGg7m+lTWaRxYP+acoSayyMFeN5H6ZiNq6
         xS65m1jsPcSx/Jh3D744JSYIWyr2yQ5K2NWPyjvlcMihm3clgYrMhejtiXQNnM2CUJ+n
         Se4p3p93xKUgBuuDMWPFJ4h2Cvhu/7+a/gpjT2DOCrVicOQOHVpBtfdShZ4P9zr/ji0O
         o3MA==
X-Gm-Message-State: AFeK/H1doYqks1fwu0qqfRWSHcXSjmCduFqBBsq4Kt8JkKpNxHcZ2r/ceA4PMDvbL1Czxg==
X-Received: by 10.98.200.19 with SMTP id z19mr48476202pff.223.1490207005740;
        Wed, 22 Mar 2017 11:23:25 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:55f5:992d:bc78:c749])
        by smtp.gmail.com with ESMTPSA id t133sm5366954pgc.24.2017.03.22.11.23.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 11:23:25 -0700 (PDT)
Date:   Wed, 22 Mar 2017 11:22:59 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] t3600: rename test to describe its functionality
Message-ID: <20170322182259.GA26108@aiede.mtv.corp.google.com>
References: <20170322010058.GA31294@aiede.mtv.corp.google.com>
 <20170322165639.21658-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170322165639.21658-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> This was an oversight in 55856a35b2 (rm: absorb a submodules git dir
> before deletion, 2016-12-27), as the body of the test changed without
> adapting the test subject.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Yup.  Thanks for taking care of it.

Jonathan
