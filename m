Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E114C20401
	for <e@80x24.org>; Thu, 15 Jun 2017 20:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750830AbdFOUdg (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 16:33:36 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35647 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750814AbdFOUdf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 16:33:35 -0400
Received: by mail-pg0-f41.google.com with SMTP id k71so11304526pgd.2
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 13:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5PS1cVFO15F4Q9mvpkRehJjg/7l9zz31+7ZiennwXo8=;
        b=HyZuvFuGVkfj2yr2mAvWQX8WgtWPhJC/ocH8rRBpYa12vJ4OXzbn7Jxxi1unlMPPXc
         qHJfY9GIL8f0bqXQ5EUGdgLA/m37/tHaGDCkvZUXXrXFRAXHjVg8WZhg1+9IUl4IvMoc
         eJ4cbtDOiN2xVqaltvoElrsP/VDxsCQBhC4fESHVE3Qhsv6WYl1/LOFkyQskVa0FFbYr
         KJXxxUpa9UnJmxybOT/SaKisrTeUpkywOlbJCPvtHEfJjQARycxE8bU+EOgJ38gqxwDo
         AlcQU9HRUXowN1kE/xyMQRlarmctc0zRDVIS+BQgsgTLW3U8vNtYau47U4frSOaPyRpM
         qqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5PS1cVFO15F4Q9mvpkRehJjg/7l9zz31+7ZiennwXo8=;
        b=VR+vjESSKvKTNOyVqCc2IDPOmOpho0cshGVIWf6ioFZCEMIWmcZUNKw/iZF1I0Xxxu
         enE2CGXQQq25/dj9Ky/hhqWw+NisiOTj3ZoIFPyrPokzWVDAtiIJANx3NBffT1tWxgSM
         FltB5g+jPGN5HKxwlvClO0VHdSgLE1M5/ID47N8gflBElVItvrt/iRSPxAct+yAkP0J6
         or5Ff+fPo5nTSczH8YMKgx78MBGYcqhGpE4UrEdxpB+3J63GXr9JUOCZ3F6MXcaNSOZY
         lsVRDPFNnB1hi9OdsQrDuccxscYTBHUCDVEZDQ9AIAgQfRvE8Px/qdmD7FytLs/jGCnJ
         2Oaw==
X-Gm-Message-State: AKS2vOy4Z/IGUNZaPGXdrYkDyNA4rNG4aeaYMy/7nCQyCLh5nUyIfj55
        84/i6yT+HjFZpsWGdYIWZw==
X-Received: by 10.99.7.129 with SMTP id 123mr7203212pgh.171.1497558814840;
        Thu, 15 Jun 2017 13:33:34 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:2d7f:7526:8947:80f4])
        by smtp.gmail.com with ESMTPSA id 15sm261780pfj.59.2017.06.15.13.33.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 13:33:33 -0700 (PDT)
Date:   Thu, 15 Jun 2017 13:33:32 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v3 0/6] config.h
Message-ID: <20170615203332.GB176947@google.com>
References: <20170613210321.152978-1-bmwill@google.com>
 <20170614180739.72193-1-bmwill@google.com>
 <xmqq8tkt10pt.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8tkt10pt.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/15, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Changes in v3:
> >
> > * tweaked the discover_git_directory function's API based on Peff's feedback
> > * reordered the last three patches so that they flowed a bit better
> > * renamed 'git_config_with_options'
> > * rebased ontop of v4 of Dscho's alias series
> >   https://public-inbox.org/git/cover.1497440104.git.johannes.schindelin@gmx.de/
> 
> Applying this series was messier than necessary, I'd have to say, as
> this series would not apply cleanly on top of the result of applying
> Dscho's v4 on top of the same base as Dscho's v3 was applied (which
> is v2.13.0).  It applied cleanly only when Dscho's v4 and then this
> series were applied on top of 02a2850a ("Sync with maint",
> 2017-06-13), which is a much newer commit than v2.13.0.
> 
> Which in turn means these two fixes cannot be merged to 'maint' as
> you two collaboratively prepared.
> 
> I've applied Dscho's v4 on top of v2.13.0 (just like his v3 was
> queued in my tree on the same base), and then tweaked this series to
> apply on top of that, so that they can go to 'maint' if we chose to.
> 
> But it is possible that during this unnecessary patch shuffling, I
> may have made some mistake, so please eyeball the resulting 12
> patches carefully when they are pushed out.

Ugh, I'm terribly sorry.  Completely my bad as I didn't consider what
you would need to do on your end.  When I built my patches on top of his
I naively just applied his v4 to what ever the current origin/master was
at that point in time.  I'll be sure to be more careful with this
next time.

-- 
Brandon Williams
