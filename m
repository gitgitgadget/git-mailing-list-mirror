Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E5541FAF5
	for <e@80x24.org>; Fri,  3 Feb 2017 09:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752360AbdBCJYj (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 04:24:39 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36214 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752232AbdBCJYh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 04:24:37 -0500
Received: by mail-pg0-f65.google.com with SMTP id 75so1536887pgf.3
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 01:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0WW/L4t/GxNBNqNQeMs/dDhYQ9wMsG8aFLX+/aeTmUs=;
        b=E9JCLv3gBzr8qidXfb4NxCouL9eaxd9QWjzwmsWiw0vJ25PuTyDRL10GpP+83niLsr
         Z8X3AkJeW4eo640uMn6ja9awm20iBRlnX2giBYLw+Oq3M5LNXC5U2o3fntQJStRJScLD
         7YRNb+ixStJGZCtQVOnqSKdKQt3ddeo9jEt4VRD1DJgwyL74QxY0svVM/aAvwvknBrQb
         SKhWe2GCJrn1P3ma1CRJjAqPy5X/Fzd9gUjmwlxAXkhI7+jIi7irOsnnp5mPgkHPK5ua
         7EJ18xlP0xuiK264J/Ct7JV9bSqFhv8WdNNZcmybVCQ4asskjmCm6aejRQv0yOMPzo/6
         ZKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0WW/L4t/GxNBNqNQeMs/dDhYQ9wMsG8aFLX+/aeTmUs=;
        b=KJmdAq/QAZApM8BC3VhrE1KV+nZBnhhC2dwvepwaKmtlqgqktfcSN/HTMViqEpyj5c
         c/jCgop+bYVbebVWHyKYeSvP+//ct/y2DPnFgjxSBZy2Ttd13T7JEsid6bZ4EB5CxidM
         xav+mRto/unYo5ywP4uHlIMgoSnBYPQYp5Wwg+wUjpwDU2P7+tv6V8K3q3OzkvCoh15H
         S9RJhEt+jm0L+pyFfYBccDRyzIJVNpxjcoVNZM5f6gkPgHV1c2oBomYGrp49MZwUXmWR
         muR7l8QgBlBJJhTQPFPDqiGnNQGMV3aoSqgRa567eDiYRwu5ungIf9Js34a8dZTMzqCs
         E4fA==
X-Gm-Message-State: AIkVDXLRcqfpOT+ZUtqkE8SppEyU+3cu5ADwpNxK+x6Z5FxMiswfEVQ2i7vC1SLSORz9jg==
X-Received: by 10.99.53.195 with SMTP id c186mr16438248pga.24.1486113876686;
        Fri, 03 Feb 2017 01:24:36 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id 21sm65168249pfy.4.2017.02.03.01.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Feb 2017 01:24:35 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 03 Feb 2017 16:24:30 +0700
Date:   Fri, 3 Feb 2017 16:24:30 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] document behavior of empty color name
Message-ID: <20170203092430.GA10987@ash>
References: <xmqqpoj2q25n.fsf@gitster.mtv.corp.google.com>
 <20170201002129.xb62hmxwrzwgp6vg@sigill.intra.peff.net>
 <20170202091615.GA22337@ash>
 <20170202124238.53k74cedpp2rcmzo@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170202124238.53k74cedpp2rcmzo@sigill.intra.peff.net>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 02, 2017 at 01:42:44PM +0100, Jeff King wrote:
> On Thu, Feb 02, 2017 at 04:16:15PM +0700, Duy Nguyen wrote:
> 
> > > I hadn't heard anything back,
> > 
> > Sorry I was accidentally busy during Luna new year holiday.
> 
> No problem. That sounds much more fun than working on Git. :)
> 
> > > -	if (!len)
> > > -		return -1;
> > > +	if (!len) {
> > > +		dst[0] = '\0';
> > > +		return 0;
> > > +	}
> > >  
> > >  	if (!strncasecmp(ptr, "reset", len)) {
> > >  		xsnprintf(dst, end - dst, GIT_COLOR_RESET);
> > 
> > I wonder if it makes more sense to do this in builtin/config.c. The
> > "default value" business is strictly git-config command's. The parsing
> > function does not need to know. Maybe something like this?
> 
> I don't think so. The default value is a git-config thing, but you would
> want to be able to do the same thing in a config file. For example, to
> disable coloring entirely for part of the diff, you could do:
> 
>   [color "diff"]
>   meta = ""

OK but it makes log.graphColors add empty colors though. In t4202.39,
we have " blue,invalid-color, cyan, red , ". With this patch the color
after red would be no color. Without it, we get a complaint and the
next color would be cycled back to blue. The test does not catch this
because the test graph does not have enough fork points to get to red
and back to blue.

I suppose this is ok after your documentation patch ("that's by
design!"). Just wanted to point it out in case I miss something.
--
Duy
