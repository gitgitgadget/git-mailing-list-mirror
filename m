Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7E8D1F8CF
	for <e@80x24.org>; Wed, 11 Oct 2017 22:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbdJKWep (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 18:34:45 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:56221 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbdJKWeo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 18:34:44 -0400
Received: by mail-wm0-f50.google.com with SMTP id u138so8798767wmu.4
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 15:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hh11JLftJdN6ThBTedMd1Of4EsSOurDCUYsr5f6g7DI=;
        b=enb5c7O/f1D+wsle/KFTfU84qNeYozn+/3bfEtLo7LMHJvov9RHbLs182QHPbwD3Bk
         gj2WuX5SEYyaEyLfHOCIijypcwsOoNKWfeGW9+4RXeWx+DIjixqJs6dWbPUBWxCXwXmH
         KF6qlUm8Y4RbbrL8iKLvsVfV7TMfLBDgXjfxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hh11JLftJdN6ThBTedMd1Of4EsSOurDCUYsr5f6g7DI=;
        b=PNkxToRNfUgN9c4THBaNwmQ/yXFvv1C6Wz9AGoiGq9pu+LFHKXdiQ3rMur1zb/OYFr
         2l1H7GE4Yi49ikji0vodpRjolba0ACsRlUhgyMqGUrYPIqyJJuXQ+e0cvxQnn2GAxr1M
         AVcOzpHWVlF3tcM1kIaOOZ5+jUWpmKc0qnM+EfH838H11hezrSglfeCTL7/dpDh5XRaP
         eLNqX9NvGapOAlI8K62lA98qWRAzlsmbyfWXhfkiQ/7aYWZwrhT7vGeNcVZyiPethvmv
         6cD6NSyOoTO44LsyFzJ7ZxfIBzlHm12hqYK9xrxnSGdnG+eJGa/VK/DDFvVcjN3AEndw
         U3BA==
X-Gm-Message-State: AMCzsaVuqDAiVSX2zA4mgNduTOPUT5X+Qkeu2d6jyX+0mlXtKGkCPEOh
        k20fneCYjAMRd5KhKOJf2Uxbq1khnXg=
X-Google-Smtp-Source: AOwi7QB65AdbuEQV/Ob9aF382SHoOv01bQheQKOwsuuKytTyMBAaqH5zZLl1qxhD4HCTG08pXPM6rQ==
X-Received: by 10.223.167.7 with SMTP id c7mr333229wrd.274.1507761283655;
        Wed, 11 Oct 2017 15:34:43 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id w4sm5698997wrc.17.2017.10.11.15.34.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Oct 2017 15:34:42 -0700 (PDT)
Date:   Wed, 11 Oct 2017 23:34:33 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Subject: Re: v2.15.0-rc1 test failure
Message-ID: <20171011223433.GA6079@dinwoodie.org>
References: <8dd12465-0dc2-340e-8db0-e37719f34efc@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dd12465-0dc2-340e-8db0-e37719f34efc@ramsayjones.plus.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2017 at 11:15:57PM +0100, Ramsay Jones wrote:
> Hi Adam,
> 
> I had a test failure on the v2.15.0-rc1 build tonight.
> The test in question being t0021-conversion.sh #15
> ('required process filter should filter data'). I didn't
> have any test failures on v2.15.0-rc0, and I don't see
> any change that would have affected this test.
> 
> Also, I ran this test by hand (well, in a shell loop) at
> least 70 times tonight (after the test-suite run), without
> any failures, so ... (unfortunately, I don't have a trash
> directory to look at. :( )
> 
> I have just kicked off another full test-suite run.
> 
> Just a heads up! ;-)

Hi Ramsay,

I assume, given you're emailing me, that this is a Cygwin failure?

t0021.15 has PERL as a requirement, and I see semi-regular failures from
Git tests that are Perl-based in one way or another (git-svn tests are
the most common problems).  I've not spotted t0021 failing in that way,
but it sounds like the same class of problem.

I dig into these failures when I see them, mostly by running the script
a few hundred times until I get the failure again, and they've always
been Perl itself segfaulting.  That points to the problem being in
Cygwin's Perl package rather than Git, and it's very unlikely to be
anything that's got worse in v2.15.0.

I've never managed to get further than pinning the blame on Perl,
though.  If you manage to reproduce the failure and it turns out to be
something different, or you manage to dig into the failure in Perl
itself, that'd be some very interesting news.

Adam
