Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A81611FCA9
	for <e@80x24.org>; Sun, 11 Sep 2016 19:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756426AbcIKTi5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 15:38:57 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37379 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756197AbcIKTi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 15:38:56 -0400
Received: by mail-wm0-f53.google.com with SMTP id c131so26210726wmh.0
        for <git@vger.kernel.org>; Sun, 11 Sep 2016 12:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ssFN4L9WzasZMHG8NfqWRzgI8/g5OmCcAdJ2ukDxuRc=;
        b=chb/xgNHJkJ/zudJ+WPDa5AvdC4YH45x8LpxIie7K5/mZCfP+HZPJuXaUqi5qDZsrY
         XlYhKD/nCultg6ZfUdy40AZJTV55x6vik6Dhc68FiJRNCAD6l9Hc/6VhrEN758KZ5CN5
         IMx4bp5XJa78qjGyoNitpvhnks7ITW8UR1P2FCravhVkzaduvh5tGqiyPxoNkcMwL2gb
         TPxfWjmpUNplLFG/Hatp2AJgyy+iXz9ZchOxYMa9wUPLRuRsLGxPIibPGRAatf3Uu3HC
         gF3XLoCj9/jvJv4raVDNwz10rnFTMwN+aqA/zKYwgKXbvaCkxvI/Nv91KIQ3NF8eTT3a
         EUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ssFN4L9WzasZMHG8NfqWRzgI8/g5OmCcAdJ2ukDxuRc=;
        b=DvPGWbXBoujGIHY7kD93e53vO/Ow/I69CZlbORjW+kdN8VIcKeqMG+44+fYOfc65g2
         q98fcY93zjbfIr4RAMApu/04dORZOKM4iMl2rjg+h5HMMjBsRBKrqbGD9spMOeG9cr4l
         ntTFT5PMz/bewxHDtx/NhZwtMWFC+DBjpTqqBWOVxCMXtgcD/Ez7+v1ZzrndNxgO92Yv
         2ooVgLFyjoUkgBWXO5vnoWoOU++GXVH1R7betB14Y7Mc75zCLC9Ohy7QRD8yhy6dGCTi
         2KW6Wfp+3USSRuN67lxzOyZF+fDcK5avpUFb+bRndNrx/4dB4qZOnyoOhdmjm7jt+b7T
         sDuA==
X-Gm-Message-State: AE9vXwOPrpFX685cELJCH2RV0esbUToKSXIfRV6q08apB80+o132qTcOuHtDwIbzVMOlGg==
X-Received: by 10.28.188.137 with SMTP id m131mr7869862wmf.48.1473622735163;
        Sun, 11 Sep 2016 12:38:55 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id 190sm14244374wmk.13.2016.09.11.12.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Sep 2016 12:38:54 -0700 (PDT)
Date:   Sun, 11 Sep 2016 20:39:06 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Bug: git-add .* errors out
Message-ID: <20160911193906.GC8254@hank>
References: <CAFZEwPPSiy1dxZgxWg1saPcw2QWgHtZKx26oSN3g1mCv25=0AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFZEwPPSiy1dxZgxWg1saPcw2QWgHtZKx26oSN3g1mCv25=0AA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 09/12, Pranit Bauva wrote:
> Hey everyone,
> 
> One of my friend was trying to add files using the command `git add
> .*` and got an error that "fatal: ..: '..' is outside repository"
> which did seem a little obvious to me. But then I tried to reproduce
> it in my machine with `git add ".*"` and it didn't error out. I am
> currently using git 2.9.3 on Ubuntu 15.04 while he is using git 1.9.1
> on Ubuntu 16.04. What might have gone wrong?

The difference seems to be that you quoted the .*, which leaves the .*
in place for gits internal pathspec machinery, which then only
considers paths inside of the repository.

The non quoted version your friend used meanwhile is expanded by the
shell itself, which seems to be expanding it to ., the current
directory, and .., the parent directory.  This behaviour also depends
on the shell used, for me .* in bash includes the current as well as
the parent directory, while .* in zsh doesn't include either of these.

> Regards,
> Pranit Bauva

Hope this helps,
Thomas
