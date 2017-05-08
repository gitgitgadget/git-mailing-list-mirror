Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0DBC2019E
	for <e@80x24.org>; Mon,  8 May 2017 17:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbdEHRFZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 13:05:25 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33317 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbdEHRFY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 13:05:24 -0400
Received: by mail-pg0-f45.google.com with SMTP id u187so30034323pgb.0
        for <git@vger.kernel.org>; Mon, 08 May 2017 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FjJBFXdzbv5TlxNwb/FZ5F2L0n1dLkZ8z3NbI60GRjE=;
        b=G46XkUdePha9dJeokwlNHzMCFcCPzCiN5ihPBo9bYf4BeNPlxU3+A6E9bSumEO1SPG
         wsQdpv3P0NSRfI2+ysXQBZEe4LTpnmv1eGkV3o3r4VGOOMNih7GmJAbqI8JkmLXvQVBl
         qpLXnENDMB5AWRAXdGRlznBlMndV/9TFUyILItWQKhtsQQ8SlILZ4CVZZpzk7lhRNa9a
         oH3SQxEESPgjF/lAcHBV7j6yv6HSviyUg6wCSfyx5IQJZ8i81/oh/ZZiekYw3wnBWIiS
         cnuxnpwVUQdfxOvmi2nlpvaLyYzBdoV/Nvb0rx+AW+3ShmA5N4fg8VT4U0mz9OPkc9OW
         DrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FjJBFXdzbv5TlxNwb/FZ5F2L0n1dLkZ8z3NbI60GRjE=;
        b=VjqAeyZXakRSikal5C/71YUhy3qvsk+Tkk27E1k+XcG+dX6wG+xfLyToBBSlUA5X6L
         opfwdZblvo4+DsDS+SlWKniN57upUelpPIOR35qpjSa0TCVL2A+/B4qV5bJSi0z6QuFa
         VX1O/qZho8sW4nn1OY1rkkUITCMmXd9Wuv+IwjueeyJLe3YWLIi7+RRipnVmsq1nXRJh
         DLH5+dibKcF9Hg+lsYwBguRIhb4RMa+Y5EVKvLNjw4sJEtjqbehAeRK7yg33yeKn3WcF
         gzT/Z5gafPOwuDKaHPjafDMZujIKuz9yJxl5RDWK7lXMTap8Noag1/zQhJchlTlbK0g9
         1F/A==
X-Gm-Message-State: AN3rC/6skNf/NryYQpdw1rFYNK39/8otl8lygPNGKAFu4M0hbZa55l7H
        hqZch8aKBC01JC23
X-Received: by 10.84.224.206 with SMTP id k14mr56950773pln.162.1494263123724;
        Mon, 08 May 2017 10:05:23 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:998e:2b7a:726f:b074])
        by smtp.gmail.com with ESMTPSA id f6sm26885076pfe.57.2017.05.08.10.05.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 10:05:22 -0700 (PDT)
Date:   Mon, 8 May 2017 10:05:21 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Eric Wong <e@80x24.org>
Cc:     Samuel Lijin <sxlijin@gmail.com>,
        Jonathan Tirado <tiradojonathan32@gmail.com>,
        Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        meta@public-inbox.org
Subject: Re: vger not relaying some of Junio's messages today?
Message-ID: <20170508170521.GC179149@google.com>
References: <v26esrmyqyqykypjs75fx2vy.1494092763967@email.android.com>
 <CAJZjrdWYDMFHRrbeFk89p+GebLpWJBUQfnpC6w87aVh8czL5_w@mail.gmail.com>
 <20170506205041.GA26189@starla>
 <CAJZjrdXPgrSAHJPsQiW756XFK1-XyGY0skJTefczaqJpOy6yKQ@mail.gmail.com>
 <20170507002630.GA15897@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170507002630.GA15897@starla>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/07, Eric Wong wrote:
> Samuel Lijin <sxlijin@gmail.com> wrote:
> > > Samuel Lijin <sxlijin@gmail.com> wrote:
> > >> Yep, I see these on public-inbox.org/git/ but not in my gmail inbox:
> > >
> > > Hi Samuel, check your Spam box (and move it to a normal inbox so
> > > they can train it).  Gmail filters are known to trigger happy
> > > and incorrectly flag messages.  It's been a problem on LKML,
> > > too.
> > 
> > Sorry, should've been clearer - I did check my spambox in my original
> > message. Some old patches from Brandon were in there, but the ones I
> > mentioned in my original message just seem to have been dropped.
> 
> Yikes.  I wonder if Gmail automatically nukes messages if
> they end up in enough Spam boxes...  Really hoping Googlers
> can do something about this (or better, more people start
> running their own SMTP servers, again).

That's quite odd, none of my coworkers are seeing behavior like this (my
mail going to spam).

-- 
Brandon Williams
