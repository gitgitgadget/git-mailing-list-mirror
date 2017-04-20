Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC2D7207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 23:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S946871AbdDTXSq (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 19:18:46 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:34619 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S945475AbdDTXSo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 19:18:44 -0400
Received: by mail-io0-f180.google.com with SMTP id a103so92572057ioj.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 16:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E1v+3Pj04Vjbbgxus1m7U5I+Io+xel6ymuI75E0stHo=;
        b=ZXzo1dW98ejqy03tof754hGCwV/qh+A1T+aAsnsx/h6ZunucRgjftMgZFCNNBMkRSl
         uNnlpUkRpsyh2MTshs1xe/BOuWL8xMILTpkbqjz/v4Dx58rzHGbWlNaCI0lXWiCLW5zf
         naiwnMHA6gWPvxBE7FespAeu8KXhvWkK0dghbV8aVUSintRgheBsMrEJmUdh/AgTby29
         EkZP2MkIGBp/LyycA4VVPSCrfkycmKbA+z1E4ImFndiFZjgxKL1duEshaVuNHBnQuSd+
         HblPQPS4XzZn02NWiAUnlhiKJ6xKzn9PzKtK3nbeatAGUI9wC/V0v/bU5DWUAmmfrNyD
         QEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E1v+3Pj04Vjbbgxus1m7U5I+Io+xel6ymuI75E0stHo=;
        b=pw+z38z9gW8a17jR4bBLLkmIBYj/xyl+oJzmqCQclhMAE+vd9j3fB81l9T8mentqbm
         +QB/J9KhMcfqSx6VxYqhTdHKjQ+Z6EByXHwTJv6SZA8CNXTCpmt0roSJXMBG/qNNPeqz
         YEJBWpK8/0VBOOsgpkAe3zn+PD8ArenpHFONsPtToqpTehWkwTUV5tcI46wfxDlpnLnn
         Nggxa1Yk1I6YkJtOcAjtE+umqFEN6bW4I0+OMRxeg9tW2ppTAXYeAYWwQdoW/8PhAjfF
         DEwQ4VciiqoOs1RORT/BRoWVnlS3hFn3mCwGN+K+wO8itPLXbgKbofRlev3QhZJElT/e
         Kdbg==
X-Gm-Message-State: AN3rC/4hrhZmF4sdgt1u9+NAeKkBkdj4TiFxXpAks/7H9HTH1olc9rgA
        lQa4ZwIPW2tQu+FA
X-Received: by 10.99.122.12 with SMTP id v12mr9615009pgc.98.1492730318898;
        Thu, 20 Apr 2017 16:18:38 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6c7e:3273:2d37:5651])
        by smtp.gmail.com with ESMTPSA id j73sm12281901pfe.108.2017.04.20.16.18.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Apr 2017 16:18:37 -0700 (PDT)
Date:   Thu, 20 Apr 2017 16:18:36 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
Message-ID: <20170420231836.GM142567@google.com>
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com>
 <D61D47BD-9750-4FB6-892E-013504E03738@gmail.com>
 <alpine.DEB.2.20.1704201523390.3480@virtualbox>
 <20170420165622.GC142567@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170420165622.GC142567@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/20, Brandon Williams wrote:
> On 04/20, Johannes Schindelin wrote:
> > Hi Lars & Junio,
> > 
> > On Thu, 20 Apr 2017, Lars Schneider wrote:
> > 
> > > > * bw/forking-and-threading (2017-04-19) 11 commits
> > > > - run-command: block signals between fork and execve
> > > > - run-command: add note about forking and threading
> > > > - run-command: handle dup2 and close errors in child
> > > > - run-command: eliminate calls to error handling functions in child
> > > > - run-command: don't die in child when duping /dev/null
> > > > - run-command: prepare child environment before forking
> > > > - string-list: add string_list_remove function
> > > > - run-command: use the async-signal-safe execv instead of execvp
> > > > - run-command: prepare command before forking
> > > > - t0061: run_command executes scripts without a #! line

I just double checked what differences existed between what I have
locally and what is queued at bw/forking-and-threading and it looks like
the changes (adding the !MINGW) to just this one patch were missed,
while the rest of them were picked up.  Just and fyi.

> > > > - t5550: use write_script to generate post-update hook
> > > > 
> > > > The "run-command" APIimplementation has been made more robust
> > > > against dead-locking in a threaded environment.
> > > > 
> > > > Will merge to 'next'.
> > > 
> > > There might be a problem on Windows with this (that's just a hunch, i can't test this right now):
> > > https://travis-ci.org/git/git/jobs/223830474
> > 
> > Thanks for keeping track of Travis' failure reports. From what I see, the
> > latest iteration (which does not seem to have made it to `pu` yet) has the
> > !MINGW prerequisite which should fix the issue. Hopefully my suggested
> > addition to the commit message will make it into the commit history, too.
> 
> Thanks for catching this.  And as you pointed out the latest reroll
> should fix the issue.
> 
> > 
> > Ciao,
> > Dscho
> 
> -- 
> Brandon Williams

-- 
Brandon Williams
