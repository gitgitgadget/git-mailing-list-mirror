Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C30BA2082E
	for <e@80x24.org>; Fri, 23 Jun 2017 02:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753946AbdFWCZc (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 22:25:32 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33895 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753833AbdFWCZb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 22:25:31 -0400
Received: by mail-pf0-f177.google.com with SMTP id s66so17118246pfs.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 19:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references
         :disposition-notification-to:date:mime-version
         :content-transfer-encoding;
        bh=AhR7ITgsZmYSHpXixNlF1qXul7y1+u/hYINJNwOe5qU=;
        b=lrts2FMbYlsrygaadKJOQbytohcuAsamLRA3u2LZDOaLm8J6PeuiEDKTWKzIQm5HxB
         j0or6HKYAylJsa6tSlVSOQaNTxLYRZ+LnJglC8V1xSYuNWiJxv8I3i+9MGjsiL6qbex1
         w7QyjgrPsPuKmc3T5UaEdL4dkUx2Q71e7fuQbThd5EdptpEWLGNsUGrzTerfuMsJQbWi
         /VYKO/X3eavn710Es1pu1im5SpM/00NW8Tb0CF9q2lvOItJn+VdOxQ5aoLrkO9/3vztP
         RJNLuX81b/UW0RLnu41Wemc4e/fUSJd37VzqmmilERcP4FfOwkctjstaPi1/qB6+vxDz
         xWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:disposition-notification-to:date:mime-version
         :content-transfer-encoding;
        bh=AhR7ITgsZmYSHpXixNlF1qXul7y1+u/hYINJNwOe5qU=;
        b=NbrakKqDwCPNQ2z9VQP1Tp5jGUPxfvxCessslODxTTqqhI4b6VeFLAPp1IGfk7p2el
         MrwcTncG44Jz4Qu2K2wPS5iY0kClLuQV9ndQcDrmXJdrGS1X0n9ZD9Zg6CLIdsdiSHD4
         rAVU+GBoPihauBzVznTdvoI6EY8eIfs3boflrq8/nhCanbTfCJ+x2HxJQiramXQ8OCQB
         hHI90Le0Zm1r/HiatAEExdHOVpyMGsXjky5cHrA1sg9ToEVPQ5xJbV2EX0XYg6FHHcJD
         7OG6sQcil79K3ymg+a2u/rKoHMRYBCDEKzgsP6AH6HYcqGnqDifnvLAVMhApHftSZjc3
         XhHw==
X-Gm-Message-State: AKS2vOxyTyiPin/PxHUGEJV5RcUAakUJQmIgqmfleD2fq0xGT+KAXaTt
        jfxgXysLjLN03/bUHFg=
X-Received: by 10.99.119.198 with SMTP id s189mr5637157pgc.32.1498184730619;
        Thu, 22 Jun 2017 19:25:30 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id 72sm6426094pfl.66.2017.06.22.19.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 19:25:30 -0700 (PDT)
Message-ID: <1498183919.1783.9.camel@gmail.com>
Subject: Re: Ambiguity warning printed twice ?
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
In-Reply-To: <20170622142348.hwlrajujgrxo6nwf@sigill.intra.peff.net>
References: <1498135581.2089.1.camel@gmail.com>
         <20170622142348.hwlrajujgrxo6nwf@sigill.intra.peff.net>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Fri, 23 Jun 2017 07:41:59 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-06-22 at 10:23 -0400, Jeff King wrote:
> It's not unreasonable for a complex command like git-status to need
> to
> resolve HEAD multiple times. You can see how we get to each case by
> running:
> 
>   gdb /path/to/git-status
> 
> and then doing:
> 
>   break warning
>   run
> 
> Each time it breaks, you can run "bt" to get a backtrace, and then
> "c"
> to continue".
> 
Thanks for the guidance about debugging. It was very helpful and was a
reminder that there's a useful tool called the debugger which I have
failed to consider!

> It looks like the first one is when cmd_status() resolves the HEAD to
> see if we are on an unborn branch, and the second is done by
> wt_status
> to diff the index against HEAD. It would probably be possible to feed
> the results of the first resolution to wt-status. But that would just
> help this case, and I wouldn't be surprised if there are other
> commands
> that do multiple resolutions (or even scripts which call multiple
> commands).
> 
> Since warning should be rare, we could keep track of which names
> we've
> warned about and suppress multiple warnings. That would help
> single-process cases like this, but scripts which call multiple Git
> commands would still show multiple warnings. I don't know if that's
> worth doing or not.
I guess it's NOT. If I understood things correctly, this issue occurs
only if the ref 'HEAD' is ambiguous. Trying out a very approximate
calculation shows the probability to be some where around "1 in the
trillions or quadrillions". Further, it drops down to 0 when common
sense is kicked-in (most people would know git uses HEAD internally).
Thus this isn't worth enough to deserve a  fix except if there are
other things that I'm missing that could spoil my calculation.

Anyways, hoping some "big" would happen, that avoids these kind of
issues (inherently). :)

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
