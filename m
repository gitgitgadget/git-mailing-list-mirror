Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 517161FAE5
	for <e@80x24.org>; Thu,  8 Jun 2017 14:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbdFHOri (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 10:47:38 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34024 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751509AbdFHOrh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 10:47:37 -0400
Received: by mail-pg0-f43.google.com with SMTP id v18so16810086pgb.1
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 07:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4ybjiNTQ4KdUlMcNISHNTh9sHiRx7DcAliTxJlAGrjk=;
        b=bUtrNY2ClP63V53FGjV3ncHzTn0h2HFfjVoJ0hapWnNZbXAthspQbRafc28U3rM9OC
         yN1jWVRHziAFSebTfi1/8XT7sCi3Pr1tsO845MVZzs3krJainQR5Y4ZY7tw/oV+tJ4Kj
         ct/0Qye6woeKLBXz1aohKwksHNWvPAUtVHcDSG/6InNOjtRmzLuCiCW9/hj0rcm1UQMp
         qbpuRntWU7jdeGKB4gWL9YPQ7Rw0y4x+wgsuJUE1AiyHLxDNr8X8ZvkC2oCdqaxP8l0b
         Mn8Y5kfuiqbAF05FNihPy5PB2Ynt4nm3Clcdje/MIQfWXgcJMFAzGNHFXPNKofanh2LL
         Pf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ybjiNTQ4KdUlMcNISHNTh9sHiRx7DcAliTxJlAGrjk=;
        b=EXBhwr62HQxElsG1T3XOdjta1nx5eWcyOVznVkhq7z1rJ0X1coacpzHj5kLl+zFfZt
         SQDi+8gV7XwUCo0XqJhcCx6dR+M/6mBe6DxRJjFMvEpkEtuL+SCuAEZOdd+cMA4Nk53H
         LJci+G/X/oQS5lPBCX8ql54x9yHdwhfE0Sdcrj8XPCJPOTYtRb8ONHzwICKWpwBUFlxg
         tL12h7oJTGPWIqypU9EUfCBNsySWHczVC5zHw8UyNKHDMczZjqYi+QOrnwib3bGRDFVM
         4t2nLWfc77E7esblxHzb5wSABDi+Kppnn3Nq7MCxOHFyitrbJs1w7NPaQNnUVZ6aJ2SS
         6+vw==
X-Gm-Message-State: AODbwcBMxMBObpBSDYJDy8WqMg1tGSj59OI0p6JyszDBmTLRHIPGg/VM
        KoIbeulxi50/+oWC3H1cOA==
X-Received: by 10.98.149.142 with SMTP id c14mr13100458pfk.29.1496933256521;
        Thu, 08 Jun 2017 07:47:36 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:4d0d:6f3d:27f:3a24])
        by smtp.gmail.com with ESMTPSA id w2sm9404210pfb.18.2017.06.08.07.47.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 07:47:35 -0700 (PDT)
Date:   Thu, 8 Jun 2017 07:47:34 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/9] t1308: relax the test verifying that empty alias
 values are disallowed
Message-ID: <20170608144734.GI110638@google.com>
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
 <3325827e66b1a9e693f81e8aa4cae44f41dfdc25.1496851544.git.johannes.schindelin@gmx.de>
 <20170607181553.GE110638@google.com>
 <alpine.DEB.2.21.1.1706081221090.171564@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1706081221090.171564@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/08, Johannes Schindelin wrote:
> Hi Brandon,
> 
> On Wed, 7 Jun 2017, Brandon Williams wrote:
> 
> > On 06/07, Johannes Schindelin wrote:
> > > We are about to change the way aliases are expanded, to use the early
> > > config machinery.
> > > 
> > > This machinery reports errors in a slightly different manner than the
> > > cached config machinery.
> > 
> > Not a comment on the patch but just a genuine question: Is there any
> > reason why they complain in a different way?  Doesn't it make sense for
> > the errors to be reported consistently?
> 
> Yes, I agree that they should not complain in different ways.
> 
> I had a brief look to see whether I could quickly fix that "while at it".
> But it seems to be quite a bit more involved than I am comfortable
> slipping into this patch series (whose purpose is not to fix the dichotomy
> between direct and cached config parsing, after all).

Fair enough, thanks!

> 
> Ciao,
> Dscho

-- 
Brandon Williams
