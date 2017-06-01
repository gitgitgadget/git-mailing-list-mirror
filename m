Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26FD02027C
	for <e@80x24.org>; Thu,  1 Jun 2017 09:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbdFAJzn (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 05:55:43 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35747 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbdFAJzm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 05:55:42 -0400
Received: by mail-wm0-f48.google.com with SMTP id b84so151494743wmh.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 02:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jrudk6WIxwW/aajTVlgVlIA/DDmC0p6g5BR2Hm14tzs=;
        b=KL0QfJCkuXncgpJc4fazXSUhca0pSgcO94vBxbd/SkouMDHV1lajbn2ANPi26NNTHy
         QIlxL9PEF1UYhJfoS8O1ohg2fTrMbtihJks+caETRqXi+orF+BVwrGaEBPHkaIlSauSW
         HRdf055ZvHYR0drnncLgn/WZYfkakzU3MVS9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jrudk6WIxwW/aajTVlgVlIA/DDmC0p6g5BR2Hm14tzs=;
        b=uYZsNbBN/Ljnh6OUKMDBy8sajFh5fGNz9yxeL693SccmpHX6hc57/vtXei7CKwCfb3
         Im6agvMIYKij5Wa3oKvFRWZNHCz1T/XGfSn4nTZs2sQVh2KyVPZAHpM6QzlkSCsyn9D7
         KdVnJTvt+opiDQDSJKW6LIbV+tJzJemKxHYp5LkAhphIew/eQ0Up9WH5K8kU5vVU6xyp
         qfC/CU+AE0KeIqObNVkNqjUWtfjRO2A50bNDMECJhHMS/kBOOLAcim0DE3TKs4crtTgJ
         ZXg5tCLYZos4M3MkTCyFAR7bMOVAvHF75d/Ob7EIRuB3VuxdP5+dVEDKFdNknUKqt0/p
         QLDw==
X-Gm-Message-State: AODbwcDtvZvGRMPcjad9gx7bxz9gejJW3XyiXpyAFBHF63w6wqI0q2Tv
        H9lA19BNmYEbkWBD
X-Received: by 10.223.131.34 with SMTP id 31mr701448wrd.95.1496310940891;
        Thu, 01 Jun 2017 02:55:40 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id l8sm19310202wmd.8.2017.06.01.02.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jun 2017 02:55:40 -0700 (PDT)
Date:   Thu, 1 Jun 2017 10:55:20 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] docs: fix literal quoted spaces
Message-ID: <20170601095520.GA25777@dinwoodie.org>
References: <20170531150624.GC18266@dinwoodie.org>
 <20170531160721.4yimitnyy6pdxkq5@sigill.intra.peff.net>
 <xmqqy3tc797p.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy3tc797p.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 01, 2017 at 11:06:18AM +0900, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Wed, May 31, 2017 at 04:06:24PM +0100, Adam Dinwoodie wrote:
> >
> >> Instead, use + to avoid asciidoc's literal passthrough, and encode the
> >> space as {sp}.  In particular, this means asciidoc will correctly detect
> >> the end of the monospace formatting, rather than having it continue past
> >> the backtick.
> >
> > In these particular cases, is the space adding anything? Would a simpler
> > fix be to just use:
> >
> >   ...the value on `URL:` line
> >
> > We've had such headaches with other entities like {sp} between different
> > asciidoc versions (not to mention asciidoctor) that I tend to reach for
> > the simplest solution.
> 
> Me, too (and no, I am not from AOL).  If `URL:` is typeset correctly
> the approach to drop the space is much more preferred.

I decided against that fix on the assumption that there was _some_
reason for including the space, even if I couldn't immediately see it.
Given Junio wrote the original text and is now suggesting removing it,
I'll respin the patch now.

> > (I'd also suggest the minor English correct of saying "_the_ URL line";
> > that's orthogonal to what you're trying to fix, but may make sense on
> > top while we're here).

Sure.  I'll include that in the follow up patch.
