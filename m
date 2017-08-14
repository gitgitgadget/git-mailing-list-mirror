Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF29320899
	for <e@80x24.org>; Mon, 14 Aug 2017 22:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752853AbdHNWyf (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 18:54:35 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33947 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752687AbdHNWye (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 18:54:34 -0400
Received: by mail-pg0-f47.google.com with SMTP id u185so55850432pgb.1
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 15:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LkttXDBqebQE1ue99AsAYS786duATN/5kaNO/hVnez8=;
        b=XMoFM2HMMv0R2/AYBzl60c/BKwh8p8FFwBJQwBx5O4Ev5qcvMPBubBcJ+E5x4578bf
         r6hkIKZnkeCuu7eLQ7i4nSfPjSe6PLL871dVuMm7EFwf48DQVH07uldLx3NwaeLQE58Z
         yVIhlsz5nrlgtVZ8mNIPT9f5L8BGmsn5QDv3+yqvmbWNOt41xPUaAi2jz9i/KGvFL4Zj
         9yh1kL/8ZKzJ4ag8rEOybxku3AREQ5zlpQ0/I1D+prRyeOhffp3dnCFXkPaQd8FW7/vI
         VloYm3Q1LmcY0CiCbNqjzu+TZhB58uLYKZ8zkgQfMmU5uzEvV1+JSfsBUdpVOyPVZMRB
         7Kgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LkttXDBqebQE1ue99AsAYS786duATN/5kaNO/hVnez8=;
        b=A9xj60hYZ7zsYSTsSnQ/xRS0MRypbzFKAQNmz/s9Zih2YaXolvXirPAIIla6vHltcP
         YKamWctuxX5GNtgomv2mjTNBpimdEdwE1zmNwxU/1baRaRbx4Uc9/qhtYSTPK2NVyVBM
         d8T2m+B7HiUoWmZB+VARQ0+BGTcC51zUMKIW0mPq+ajTNzo5g7bcO3aWRwL98fkNu9E7
         /hkqDi3i0RnrJVtTfgX8xxdRdc/teq5a3TDWRb4gPD8Hw0DgvIonpIeqNiwpO6woQnAG
         kusrDxpk7req+P/IMWQHVhUkDnx2nnm4rBRAvqAZEJTNUyuInxrjd9op4PoP9R++EL4M
         lJOw==
X-Gm-Message-State: AHYfb5gWJjx3k8jQz2X0Xv56Dc/4fWGermiLM+lkUb3pnFqezyLfRVMb
        aP+yzCqR6/fxWsCj
X-Received: by 10.84.231.130 with SMTP id g2mr29558199plk.342.1502751273432;
        Mon, 14 Aug 2017 15:54:33 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:8d3a:cd80:9f5c:505b])
        by smtp.gmail.com with ESMTPSA id z127sm15014964pfb.64.2017.08.14.15.54.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 14 Aug 2017 15:54:32 -0700 (PDT)
Date:   Mon, 14 Aug 2017 15:54:30 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, jrnieder@gmail.com,
        ramsay@ramsayjones.plus.com, peartben@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v2 1/2] clang-format: outline the git project's coding
 style
Message-ID: <20170814225430.GB95777@google.com>
References: <20170808012554.186051-1-bmwill@google.com>
 <20170814213046.107576-1-bmwill@google.com>
 <20170814213046.107576-2-bmwill@google.com>
 <20170814224831.qhs7b44bg7v7tryx@sigill.intra.peff.net>
 <20170814225108.qoq6noojqznp4be6@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170814225108.qoq6noojqznp4be6@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/14, Jeff King wrote:
> On Mon, Aug 14, 2017 at 06:48:31PM -0400, Jeff King wrote:
> 
> > On Mon, Aug 14, 2017 at 02:30:45PM -0700, Brandon Williams wrote:
> > 
> > > +# Align escaped newlines as far left as possible
> > > +# #define A   \
> > > +#   int aaaa; \
> > > +#   int b;    \
> > > +#   int cccccccc;
> > > +AlignEscapedNewlines: Left
> > 
> > I get:
> > 
> >   $ git clang-format-5.0 --style file -p --extensions c,h
> >   YAML:34:23: error: unknown key 'AlignEscapedNewlines'
> >   AlignEscapedNewlines: Left
> >                         ^~~~
> >   Error reading /home/peff/compile/git/.clang-format: Invalid argument
> > 
> > Same with clang-format-3.8.
> 
> And if I remove that line, I get:
> 
>   YAML:155:25: error: unknown key 'PenaltyBreakAssignment'
>   PenaltyBreakAssignment: 100
> 
> Removing that gives:
> 
>   YAML:86:22: error: unknown key 'BreakStringLiterals'
>   BreakStringLiterals: false
> 
> And removing that gives me a clean output. I have no idea why my clang
> doesn't like these (but presumably yours does). It's clang-format-5.0 in
> Debian unstable (and clang-format-3.8, etc).
> 
> -Peff

Those must be features in version 6 (which is what I seem to have
installed on my machine).

-- 
Brandon Williams
