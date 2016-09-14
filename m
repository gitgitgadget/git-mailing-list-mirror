Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2CCF1FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 19:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761935AbcINTaw (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 15:30:52 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37782 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756249AbcINTav (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 15:30:51 -0400
Received: by mail-wm0-f44.google.com with SMTP id k186so26886071wmd.0
        for <git@vger.kernel.org>; Wed, 14 Sep 2016 12:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R9Um3gtWbTRKOG9ubxTm77X1Q8qzhNVX+Qccc8hspdE=;
        b=GvoeQ0ZuR4ns4oRtezum4ee2hBIAyj+oN1nWWADhbGzMDU5jXsPDWZG42s6D8in2L2
         VEAwCX7XsqxgvDdOtlemfKUEikjUHBfKYEXUjoAFSLEB8BZpJhsXizH0dRhZ72hQM9fC
         oTdSJc6Q2q5iVkFLPUAc/IdjSe7e07ma9+BGRsZo7Ee6brCOC0lxdoc6US+dB4vB+2/G
         OiMzLv290MZYngihT06MJPIjO4RJwGp4gqrFL4ExCQRxUcBEUsNRegnc7GLV5j1rXNMv
         dzInZkGHhjzNYi0qRnppmy2JE419n10hVlc3wv+WiaNSQ6C5MzGNZ/gBEqrjQyYIT5DU
         8Udg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R9Um3gtWbTRKOG9ubxTm77X1Q8qzhNVX+Qccc8hspdE=;
        b=hirQsUtovGWxD75Qio/q/yfUn03X1qsFrLJ1wdh+giFQBN+QqpO5grFbbUYQYS+9bi
         /TNeDEyPrzhz6rliYBydeq6Dkix7dxaNuZGMwzCmoMtPp3GDhoZoMnnSgEAn9/Srtu1/
         WjFpP0I8HztR90Z4lE7jZqEmMCaVFbxIoOD1v3JwWcOqidkX2bedzgnfrS4S5p23qNHH
         nkn5a99a+fDLEJAA9+W+yFuoNzo2/xMbZFJl+PChXOORnfbtf9Cs7oCR3zoM0T8J8n75
         P/hTxkrQM0VYFHlf0K5/9pgnTR+R3RwZMkPJ8/g55XPu2EpCZEjx7Mo/wVO/gZO7Wxca
         /bjQ==
X-Gm-Message-State: AE9vXwP7UBA9Mb8GoR56RMLXfu6YFW/D2znBd/ia7Ab8/2SDKd7lrgB+sPui4SPBX1RkLh+grpOFxY9GcG4ncLw7
X-Received: by 10.28.197.76 with SMTP id v73mr5057368wmf.100.1473881450379;
 Wed, 14 Sep 2016 12:30:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.15.79 with HTTP; Wed, 14 Sep 2016 12:30:49 -0700 (PDT)
In-Reply-To: <20160914192341.mgpcc35kgmjqunbh@sigill.intra.peff.net>
References: <1473785571-60439-1-git-send-email-bmwill@google.com>
 <20160913181552.74bhacoa2q76yv6k@sigill.intra.peff.net> <20160914192341.mgpcc35kgmjqunbh@sigill.intra.peff.net>
From:   Brandon Williams <bmwill@google.com>
Date:   Wed, 14 Sep 2016 12:30:49 -0700
Message-ID: <CAKoko1qKLPWZEZxzHkrpm-tvz4oLMf=odRLNSRgrHXPxGhHFvg@mail.gmail.com>
Subject: Re: [PATCH] pathspec: removed unnecessary function prototypes
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 14, 2016 at 12:23 PM, Jeff King <peff@peff.net> wrote:

> On Tue, Sep 13, 2016 at 11:15:52AM -0700, Jeff King wrote:
> I should have done a better job of not just providing the answer, but
> showing how. The easiest tool here is "git log -S":
>
>   git log -1 -p -Scheck_path_for_gitlink
>
> (and then you can see that the whole function went away there).
>
> -Peff

Perfect thanks! There's still a lot of little features like this that
I'm unaware
of so I really appreciate the pointer.

-Brandon
