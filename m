Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F4281FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 23:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbdFMXII (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 19:08:08 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35962 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751802AbdFMXIH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 19:08:07 -0400
Received: by mail-pg0-f43.google.com with SMTP id a70so66685684pge.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 16:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yb61o5yQ9iacWA/Jgs8VOEvob8N9HPzbO5NcJHGk+HM=;
        b=HcpbfQwZZ5sLOb55MjpzFGjyBnMoGHEB4xbqlOHqXIP2AhDG9V4kjUKAnJ3bSJkU9z
         QJ0QS2cpKIjMsGSoQhOwu5t3YcnrP97bDoYcZZ/3u4+7dPGNV5qfHYdmemZR7s90tjrL
         JtXG12pmt1QgYuw6+jargSBtW7+1s4TaCcJGP003zTCz7sHB7LYHDquW0AjXwsmESGHA
         Am+g3y/ClZf0grQxYgqXJCR4ufOhswNOH9+TVVsQpPjyd/43EfLKBevmNh8jCd2eVGfw
         lTp+QmJz3gI6KcWMq8pmrmquUdM7ptxTBfoiXwKtToHl0E6svyXqPi1nPgqPPItMRzRn
         90Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yb61o5yQ9iacWA/Jgs8VOEvob8N9HPzbO5NcJHGk+HM=;
        b=Jy/+KUD/7JhsJC5hnXgKB6HUSswQPdSK4fFqI8fHgY3AhVS+umP17jZbZtT5y0M76g
         DChT5byFG9Vq5BOqZ0UUZOP/A9+2wuP1hasSFLNKrFHMzr+vSaXtYhjBMWm7sYSHJaeI
         Gfl02LjOvFAaAXfFx8IS8nLp7HgooXKmcO5px4fvaOWi7ECfjfkDW8UhDV/Ki+Ze4IOx
         RVeM0QNgEWOkgm3T30IG1S00unLdJu9gv2otQaKuIgrqG07tEtLKm5ZvdJMFaNusjj06
         1aa3UVX6tPEwxzf6gmtSxyv5FuFvyV+FYeuA8okcQcb3bjG5H83r5Qk/sQ+h8B6fyGPj
         evWg==
X-Gm-Message-State: AKS2vOxD7/BvpQ/HNiD0kXEhMRAadodK3+uVQ8G3cb2cgcBvBZF1G0mz
        UtOfkUA981jFKQ==
X-Received: by 10.98.211.198 with SMTP id z67mr1275104pfk.231.1497395286526;
        Tue, 13 Jun 2017 16:08:06 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:8130:47b0:791f:5985])
        by smtp.gmail.com with ESMTPSA id r63sm277623pgr.65.2017.06.13.16.08.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 16:08:05 -0700 (PDT)
Date:   Tue, 13 Jun 2017 16:08:03 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 8/8] t0012: test "-h" with builtins
Message-ID: <20170613230803.GP133952@aiede.mtv.corp.google.com>
References: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
 <20170530051930.pqywvihwl5klg7hz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170530051930.pqywvihwl5klg7hz@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:

> --- a/t/t0012-help.sh
> +++ b/t/t0012-help.sh
> @@ -49,4 +49,16 @@ test_expect_success "--help does not work for guides" "
>  	test_i18ncmp expect actual
>  "
> 
> +test_expect_success 'generate builtin list' '
> +	git --list-builtins >builtins
> +'
> +
> +while read builtin
> +do
> +	test_expect_success "$builtin can handle -h" '
> +		test_expect_code 129 git $builtin -h >output 2>&1 &&
> +		test_i18ngrep usage output
> +	'
> +done <builtins

I love this.  A few thoughts:

- I think the "generate builtin list" test should be marked as setup
  so people know it can't be skipped.  I'll send a followup to do that.

- By the same token, if "generate builtin list" fails then these
  commands afterward would fail in an unpleasant way.  Fortunately
  that's straightforward to fix, too.

- This checks both stdout and stderr to verify that the usage appears
  somewhere.  I would have expected commands to be consistent ---
  should they always send usage to stdout, since the user requested it,
  or to stderr, since that's what we have done historically?

  So I understand why this test is agnostic about that but I suspect
  it's pointing to some inconsistency that could be fixed independently.

- Do we plan to translate the "usage:" prefix some day?  I could go
  both ways --- on one hand, having a predictable error:/usage:/fatal:
  prefix may make life easier for e.g. GUI authors trying to show
  different kinds of error messages in different ways, but on the other
  hand, always using English for the prefix may be unfriendly to non
  English speakers.

  In the past I had assumed it would never be translated but now I'm
  not so sure.  What do you think?

- Should we have something like this for non-builtins, too?

In any case,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
