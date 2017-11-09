Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E1FC1F442
	for <e@80x24.org>; Thu,  9 Nov 2017 12:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754495AbdKIMrT (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 07:47:19 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:48592 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754450AbdKIMrS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 07:47:18 -0500
Received: by mail-wr0-f180.google.com with SMTP id 15so5487300wrb.5
        for <git@vger.kernel.org>; Thu, 09 Nov 2017 04:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZQz4O4CQ6kew9oCrroMdMzQFqvstfTO2OhT4XBKx/go=;
        b=Do0OFiI1/9deOPFmO+UK4+vnCNbQ3KsfGAQjFvhl6JQw2G2myyTeV0FqZTswkaMw33
         e6GdRrywOM8CYRdoyKPcA7h7S69TN/aACSioCTdAQIl69vMPArux84fRm7M52MGKob7a
         Qo0V/8BlFknio859jTnQ9i59+DDA2n3PPF7Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZQz4O4CQ6kew9oCrroMdMzQFqvstfTO2OhT4XBKx/go=;
        b=Vtg0+z9mbUxXIo45WbAW2BaN/4mzNVXWMAPxfacHIkbW9AhfBJ2RYV74fTRfjB+hHX
         qxUHkc1rx4sk9EMEwdBLnWo7kSecSagtj2CWl2ej1Xrw+88eTWFXkLkAu9wnXlQbyzgI
         EJdzehGSdFE3oMgAW3uHOcrYzxECh7EdHHDzYBEtYkcYQ9O1P0djrh24D6/KwQ1oSiZ6
         HcW5qhGzZN62Y3m9cvOFz3kSh0E4CBN2IJlm1qP0e8AuJ6YBBny+k8onV2YSrV+oWBHv
         jh3InSThfudLMv6vBfs9Tv69svbAGpgsOds0cnAhe2BIWjoSKHOsqa+IayoVb1nWHl3D
         FCSw==
X-Gm-Message-State: AJaThX5Wsp/YyoP13xpnCiXldsu8qf+zXzvxcJdmFuL501dOgPBzfFao
        xNEA4dECmSw75wGxpEZ3KwRXAc7Q49w=
X-Google-Smtp-Source: ABhQp+SLy6W7JkAV2DcDNMfy8yuqHjX02ayJvaHgxGsIC+EoXOhenuv+4UsapSvNICHOrXAczhVKPw==
X-Received: by 10.223.135.143 with SMTP id b15mr326644wrb.278.1510231636723;
        Thu, 09 Nov 2017 04:47:16 -0800 (PST)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id p23sm12974224wrb.76.2017.11.09.04.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Nov 2017 04:47:15 -0800 (PST)
Date:   Thu, 9 Nov 2017 12:47:14 +0000
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v2] doc/SubmittingPatches: correct subject guidance
Message-ID: <20171109124714.GH20681@dinwoodie.org>
References: <20171108131601.280992-1-adam@dinwoodie.org>
 <20171108134752.214056-1-adam@dinwoodie.org>
 <CAPig+cRaygrQ9_J1UHr_rynPsUn2J0--RHRvP2mFQbVQhWEm-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRaygrQ9_J1UHr_rynPsUn2J0--RHRvP2mFQbVQhWEm-Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 08 November 2017 at 09:10 am -0500, Eric Sunshine wrote:
> On Wed, Nov 8, 2017 at 8:47 AM, Adam Dinwoodie <adam@dinwoodie.org> wrote:
> > +e-mail discussions.  Use of markers in addition to PATCH within
> > +the brackets to describe the nature of the patch is also
> > +encouraged.  E.g. [RFC PATCH] is often used when the patch is not
> > +ready to be applied but it is for discussion, and can be added
> > +with the `--rfc` argument to `git format-patch` or `git
> > +send-email`, while [PATCH v2], [PATCH v3] etc.  are often seen
> 
> It has become a bit of a run-on sentence, but aside from that and the
> unnecessary extra whitespace between "etc." and "are", it looks good
> to me.

Both good points, thank you!  I suspect the extra whitespace was a
result of Vim being "helpful" when reflowing the text.

I'll re-spin now with fixed whitespace and breaking up the sentence a
bit.
