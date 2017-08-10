Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62787208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 21:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbdHJVaR (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 17:30:17 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:32771 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbdHJVaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 17:30:16 -0400
Received: by mail-pf0-f177.google.com with SMTP id h68so7987758pfk.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 14:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yAj8LjZMujvM3S1EQR62eTMC5ZGEPyEPb0rYqnnviwc=;
        b=CrqfHpNeMtS93izqn+5FGUzXTUDi5gnfuPNFvoDEUAtTfOz1+oS1tBxvYkG1bbKK3F
         mQVYzrju4RGnMv6JoCkm1JLcceQZi6lsoFl+NYBMHOBeVTy38YSGX4eHKTRlU+soN0FA
         oaoZvSyu6qVn//NrdNAxYrJ3eo44e/H9zYZ0thLGPASrQx6wAtlnzjzCgBMJbD/apD+t
         Y25vQWZerudwtH5ag8pu9TtFgLM3Zh5J3etj/UZg1ML+u5T537M5GgQFR4Jfx9fZA6ki
         KSMcqlaOGryKqy2FImYhfNq8Hofpfq8Qq9kktPpfE7N+BItTi3RPuxSIACfdwr2W0RiQ
         4yoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yAj8LjZMujvM3S1EQR62eTMC5ZGEPyEPb0rYqnnviwc=;
        b=Y56ZawnDbWW00Xi7OCuAzg5dsZnvbtEYE5D6izaaoUbawpxdT+rc0I/RK4HYpBbmKa
         ej/YKMU8fKF0fophGe1Kn4+jPG3TbgbWfr8EJPJZMEYRSZTcITb7DM0fCyAukl/fcC9d
         l3nX4witof6r4vpZJpbOktSiVyE1lhq9zGFZDVUKVI3wtVam88FFDAEtBQS2FN/ujFnH
         d7stKjzWayPZqIu5sLoe5fnkPeKHGlbnYoX3XBv7JDlgJoAQCfodMRiUfE74fdLFn//1
         2XyU5DcdW+Lzp+JcTmd2xzEDapy41wFftEUe1ZgrvkLfj0HRy/xR6cU8ipqucClu3TlH
         mL4w==
X-Gm-Message-State: AHYfb5jww033kvgPriGnZ1IKf4b09XohIUOvbnY49Myd7see46DsTDG0
        +QBMRR4sjgRDmAg3
X-Received: by 10.98.33.148 with SMTP id o20mr13704459pfj.89.1502400615958;
        Thu, 10 Aug 2017 14:30:15 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ed9d:9bd9:5ee6:bf0b])
        by smtp.gmail.com with ESMTPSA id c25sm12978818pfj.85.2017.08.10.14.30.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Aug 2017 14:30:14 -0700 (PDT)
Date:   Thu, 10 Aug 2017 14:30:13 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] clang-format: outline the git project's coding style
Message-ID: <20170810213013.GD73298@google.com>
References: <20170808012554.186051-1-bmwill@google.com>
 <alpine.DEB.2.21.1.1708081404200.4271@virtualbox>
 <CAGZ79kb2860nUs46bP=x-gAx9Ao6DxnvXQv3x387Wxw+kEyxJw@mail.gmail.com>
 <20170808182324.GB73298@google.com>
 <alpine.DEB.2.21.1.1708100032050.11175@virtualbox>
 <CAGZ79kb6Ljk8brLN1bbOnBLfm=Q=aCnkZ=ZBtDPzf7MZionmSw@mail.gmail.com>
 <alpine.DEB.2.21.1.1708101137190.11175@virtualbox>
 <xmqqk22b5q9m.fsf@gitster.mtv.corp.google.com>
 <20170810171545.GC73298@google.com>
 <xmqqzib749ix.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzib749ix.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/10, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > On 08/10, Junio C Hamano wrote:
> >
> >> I vaguely recall that there was a discussion to have SubmitGit wait
> >> for success from Travis CI; if that is already in place, then I can
> >> sort of see how it would help individual contributors to have the
> >> style checker in that pipeline as well.  
> >> 
> >> I have a mixed feelings about "fixing" styles automatically, though.
> >
> > I still think we are far away from a world where we can fix style
> > automatically.  If we do want to keep pursuing this there are a number
> > steps we'd want to take first.
> >
> > 1. Settle on a concrete style and document it using a formatter's rules
> >    (in say a .clang-format file).  This style would most likely need to
> >    be tuned a little bit, at least the 'Penalty' configuration would
> >    need to be tuned which (as far as I understand it) is used to
> >    determine which rule to break first to ensure a line isn't too long.
> 
> Yes.  I think this is what you started to get the ball rolling.
> Together with what checkpatch.pl already diagnoses, I think we can
> get a guideline that is more or less reasonable.
> 
> > 2. Start getting contributors to use the tool to format their patches.
> >    This would include having some script or hook that a contributor
> >    could run to only format the sections of code that they touched.
> 
> This, too.  Running checkpatch.pl (possibly combined with a bit of
> tweaking it to match our needs) already catches many of the issues,
> so a tool with a similar interface would be easy to use, I would
> imagine.
> 
> > 3. Slowly the code base would begin to have a uniform style.  At
> >    some point we may want to then reformat the remaining sections of the
> >    code base.  At this point we could have some automated bot that fixes
> >    style.
> 
> I suspect I am discussing this based on a different assumption.
> 
> I think the primary goal of this effort is to make it easier to
> cleanse the new patches that appear on the list of trivial style
> issues, so that contributors and reviewers do not have to spend
> bandwidth and brain cycles during the review.  And I have been
> assuming that we can do so even without waiting for a "tree wide"
> code churn on existing code to complete.

Yes that's one of the steps I missed we can call it 2.5 ;)  (3) could be
a long term goal which is what I was trying to get at by saying:

> > 3. Slowly the code base would begin to have a uniform style.

-- 
Brandon Williams
