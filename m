Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F03971F404
	for <e@80x24.org>; Sun, 10 Dec 2017 06:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbdLJGsJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 01:48:09 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:43093 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbdLJGsI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 01:48:08 -0500
Received: by mail-lf0-f50.google.com with SMTP id 94so15832013lfy.10
        for <git@vger.kernel.org>; Sat, 09 Dec 2017 22:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2uSt9wAm3JfR30O0xKcjqVgv7iOxan1RIIyB/c1D7Tg=;
        b=VOUc4dsAlC5ADnRsW6TUU+tU5JrGWmdDeH/JDqsbFd247/fZLBU98LGxCoWnKVY2bf
         6njjXEaZBtiOx+uUX7uxqg5aZhI2xBaedDUtli+Ud2kf5xoFGz8beeNz2KdO0qUiDDtS
         m3oCG2yjipoD3QUNLTe/J1UEswqUJpkG7ZE1ecsuthA74g6PGEGhCnQyaWfFDOTxM9HR
         03AzK4hVja5OsCqoPI+NuNgmv9Tsh+/2Syxj/XqHl4+Vwq077vFZS7jwsXqZ5Acrwtvq
         Lyc7ERbgCIz/mug4x4KUwvCoEJQ4lz9wcnNmujqSsTzDDIN9IIrwqZDyDMPkuISMk1Qc
         WHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2uSt9wAm3JfR30O0xKcjqVgv7iOxan1RIIyB/c1D7Tg=;
        b=Hr0Ul1poHUgE2FwlXxd+wMiFaIUQObzcpwdjDv+GuyDrY8fUhFDSKxckoKAWnmN+bI
         SI3CxbDJX2kchaZsCN3IwRKyVnxRMDoAyCfi8ttIFMpW8yWUH9i23NdN7+g0t0a25VaB
         ejmp1TqMjlEOdz/O4Zk4oB4ZT7sj7B6VZZB99LYMsVGe699yT9QIfLxhfI2iZVcMA3Mw
         Vh03VFuoOcOYgbi3U9LHch+poc0eORffUxfJxBFe+lvJmEVjREIZchg5D/hV99CCLn9o
         cIbzO3ctnwWv7QxbgVaLbIuNDbGA/y5oc7dTKMFXi8VfusTX5SmHr/+JgpuC+/404/gk
         52BQ==
X-Gm-Message-State: AJaThX42gJE/pt+2s9kE0Ho/Bokm40yVcLX8l3R/wxI6/c64Ns7JWr29
        MUPkF57WoWIJGWBkFtOYVpNJWqnMAJI=
X-Google-Smtp-Source: AGs4zMZ6llWLxnTOyLAX/ejUFuetYpscseEhfom6w+rocC8pIQWoqZOr0Fp+mUXsl7KTPDm60JkFaQ==
X-Received: by 10.46.82.132 with SMTP id n4mr19011595lje.31.1512888486704;
        Sat, 09 Dec 2017 22:48:06 -0800 (PST)
Received: from localhost ([185.65.132.137])
        by smtp.gmail.com with ESMTPSA id f67sm2166419lfb.20.2017.12.09.22.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Dec 2017 22:48:06 -0800 (PST)
Date:   Sun, 10 Dec 2017 06:48:40 +0000
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] pull: add config option for verifySignatures
Message-ID: <20171210064840.GA8087@darpa.mil>
References: <20171209090530.6747-1-hji@dyntopia.com>
 <20171209090530.6747-3-hji@dyntopia.com>
 <20171209120623.GC6006@alpha.vpn.ikke.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171209120623.GC6006@alpha.vpn.ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 09, 2017 at 01:06:23PM +0100, Kevin Daudt wrote:
> On Sat, Dec 09, 2017 at 09:05:30AM +0000, Hans Jerry Illikainen wrote:
> > Verify the signature of the tip commit when `pull.verifySignatures` is
> > true.  This option overrides `merge.verifySignatures` on pull, and can
> > be disabled with the option `--no-verify-signatures`.
> 
> Is there a reason why git pull would need a different behaviour from git
> merge? Pull itself is just a convenience command for fetch +
> merge/rebase.
> 
> One precedent for having a separate configuration option for pull
> however is 'pull.ff', so there might be a usecase for it.
> 
> I guess your commit message could use a motivation on why you want to
> set this differently from 'merge.verifySignature'.

Thanks for the review!  I wasn't sure whether pull.verifySignatures made
sense -- I included it to be consistent with pull.ff/merge.ff, but it's
scrapped in v2.

-- 
hji
