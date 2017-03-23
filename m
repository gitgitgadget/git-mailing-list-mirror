Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79B6820958
	for <e@80x24.org>; Thu, 23 Mar 2017 18:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935833AbdCWSYi (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 14:24:38 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36813 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935747AbdCWSYh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 14:24:37 -0400
Received: by mail-pf0-f177.google.com with SMTP id o126so109256717pfb.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 11:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cO5xBYFW/LzwfTVVJflhmJVyyBh25BkBfUBQxcgs2l0=;
        b=NxbwqeKGTfE9K77iDRxZ/Z+KV9AU4/zHR7c4yOhYyomGeM4EMIeb0joshMgVQ47DL2
         uqBvqOTT105xhHw+4EESecr1gUredJ3o/ILinT8a6gg8E6B8YeSGNxQm5DIQbSgf1P/o
         mNkeScsAJBp+uMpBVzBGeHbduvLmDl4S7BQuTcAQGDv6N4+Lpd7h66R6YKeNrgmEqyL0
         8hSXPonJjQB1Bth2GmxJBPgVvlUUAnan1DSNiXc8AU5kW6DthKCDAFNuuwNfibe8oAgg
         vilYfthbMDS+W7DhXRCD4U0uBF1Yc632HSzPNnp02tnocDuxaJnY9EXdWOk9tFOR29+A
         /irA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cO5xBYFW/LzwfTVVJflhmJVyyBh25BkBfUBQxcgs2l0=;
        b=cmgQUnO0F5bcLexwoP5rm37iRjl64h1veWSfRXAo3bR2T53E8he7LuTm1+VpFKjPWh
         pM9kmy7t0EvFVozos1++X5bRkci/b+KzaHyJkFUE6ISJ0pc6WHK+ObKTbH4VdZYEFLR9
         ll2pXBQkdvIk/Di+RMybPW9mdMehRW7IKdKLGqBmQp83rMZpJ5k096+75c3Donr3bD34
         kJ7m5EKe+u/MDQul/2ak42Of2d83EBdmnDg8EBPfwtfn79Uloy0EPFt9+qdevYATHzsU
         pP0fIZYjj1gyN4VJmfAM36XsYdiUvAdYk0sMVXxj/wjzcfmJzqh7ELQMyfbxF0EcSTAF
         Lq3w==
X-Gm-Message-State: AFeK/H2gkI5+/2M26paUshN0R5ftOTJzIo9xVzg6SJEekV2OhPSLma2XB6B3bTYtUYFExfYM
X-Received: by 10.84.233.205 with SMTP id m13mr5509611pln.49.1490293466555;
        Thu, 23 Mar 2017 11:24:26 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:5cf0:9414:795c:7600])
        by smtp.gmail.com with ESMTPSA id h25sm11645363pfk.119.2017.03.23.11.24.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 11:24:25 -0700 (PDT)
Date:   Thu, 23 Mar 2017 11:24:24 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] sequencer: fix missing newline
Message-ID: <20170323182424.GB111250@google.com>
References: <20170323170233.50499-1-bmwill@google.com>
 <alpine.DEB.2.20.1703231839570.3767@virtualbox>
 <20170323174716.GA111250@google.com>
 <20170323182221.i3noikxpmrn4ymi4@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323182221.i3noikxpmrn4ymi4@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/23, Jeff King wrote:
> On Thu, Mar 23, 2017 at 10:47:16AM -0700, Brandon Williams wrote:
> 
> > On 03/23, Johannes Schindelin wrote:
> > > Hi Brandon,
> > > 
> > > On Thu, 23 Mar 2017, Brandon Williams wrote:
> > > 
> > > > When using rebase --interactive where one of the lines is marked as
> > > > 'edit' this is the resulting output:
> > > > 
> > > >     Stopped at ec3b9c4...  stuffYou can amend the commit now, with
> > > 
> > > Ugh, I should have caught this. The warning() call implicitly adds a
> > > newline, the fprintf() doesn't.
> > > 
> > > Patch is obviously good.
> > 
> > All good.  If we're keeping score for finding each others bugs, I still
> > think you're winning :)
> 
> It's my bug, actually. Brown paper bag, anyone?

TIL I should use 'blame' before actually blaming someone ;P

-- 
Brandon Williams
