Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C2601F955
	for <e@80x24.org>; Fri, 29 Jul 2016 16:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbcG2Q7L (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 12:59:11 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:38231 "EHLO
	mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbcG2Q7J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 12:59:09 -0400
Received: by mail-it0-f49.google.com with SMTP id j124so114859694ith.1
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 09:59:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1ANUvOiu/abXMDki61+5+t2iED2ckpu8jGQHmRUFXro=;
        b=ItdrXzvPYmZRU3K9t2tplWKBeGrgR96Xt+ri7qTnQOHLUk8ikqnzo6k6ttUDZwPSUM
         8yzpEXhAx/4X8p05c2nUFlz1MsNNx++i/zkl90TN5sIfM2p1gnpvm0jzaPJUFDYDH9Ia
         b/+PVMDKqRhjPaY+8cj/po53ezD3uKhN4+M3jzBeHFtb0YETHVdJ1ZKBwLaWpfD7NiEj
         GMRrQ2zS4t7b2BMhxoDzgTsDDU7qY7/RNNt/NkR3OVN6DWan0Ycl7ofzm+tEz7lnombk
         T6edr3HbvsjCDLXnua1yL1+pCS3tGy4GD4HX3L3oTzIpEXZ9BHW7lJxjTeo/tzBiy8aI
         bbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1ANUvOiu/abXMDki61+5+t2iED2ckpu8jGQHmRUFXro=;
        b=IrOYUavhtvJXENWgDj5oMprV3Fo1aEoA7XRC4scs98SmfWORHuEOQtOb1nTWgh8FW+
         BIbe0ffa5cOPSr5UeNR+LiXlAfGARDWdxouQ8cG1SkZwIdia6HMkx38od2T6UaVXg3qU
         ynEZod0L5ICLanx10Vuy2V3P/tPlr/vBa8BL/hjdrUDUXxe5xY/Y9x7QSJfnpoqSh1mA
         60ezBO47g8P3izEAKrfAQ6XetC9iDYncD/8DJi6mMthHiytJwPGAMISAywUYdOXMA20d
         MKcJ+VKw8eKwoyxDk012JezEV7x5oUzi6UBVaO57XtFEgLaL0K5ptWlS9PrpS7ozOpnt
         vGBw==
X-Gm-Message-State: AEkoouvqHTyNyXPeXCd8DQ31eXtwkzR/SyRueoeOr+QzrVsLuVhh3ue+r+uqYzYB/9Nw8O6wee139M8tUqbgs0sF
X-Received: by 10.36.189.7 with SMTP id x7mr7976717ite.97.1469811548749; Fri,
 29 Jul 2016 09:59:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 29 Jul 2016 09:59:08 -0700 (PDT)
In-Reply-To: <20160729124443.GA3686@salo>
References: <20160729064055.GB25331@x> <20160729101011.GA3469@salo>
 <20160729110426.GA2945@x> <20160729124443.GA3686@salo>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 29 Jul 2016 09:59:08 -0700
Message-ID: <CAGZ79kbTViNYLq0aouQ--5d7m=HYi3QxUYqaaH8sTCS_YTDquQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] git-series: track changes to a patch series over time
To:	Richard Ipsum <richard.ipsum@codethink.co.uk>
Cc:	Josh Triplett <josh@joshtriplett.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	Dave Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 5:44 AM, Richard Ipsum
<richard.ipsum@codethink.co.uk> wrote:
>>
>> These definitely seem like a family of related problems.  I'd like to
>> use git-series as a format for storing iterations on things like GitHub
>> pull-requests or Gerrit patch versions (in the latter case, overcoming
>> Gerrit's limitations on only handling one patch at a time).  Integrating
>> reviews with that seems helpful.
>
> Worth noting here that Gerrit's one patch per change format isn't
> intrinsic to Notedb, since we just need to track the sha we want
> to merge and optionally the branch we intend to merge into.

Note that Gerrit started to lose the "one patch at a time" notion.
It is possible to at least submit multiple changes coupled together
(even across project boundaries) via the topic. Some sort of cover
letter is missing though, that could be used e.g. for the merge commit.
