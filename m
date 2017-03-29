Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DCDC20966
	for <e@80x24.org>; Wed, 29 Mar 2017 07:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753800AbdC2HFc (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 03:05:32 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36495 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753391AbdC2HFa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 03:05:30 -0400
Received: by mail-pf0-f176.google.com with SMTP id o126so3374878pfb.3
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 00:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0Mi6cvvgTrKqaZy71yh2LMK0OBp9QD/nEOoCoug7lnA=;
        b=Mh+9xvAbRG5yLvNzRk7Vv9j0orQbckA0S9Sx8jgYbtOJpPr0eC/fF5IqYDk0w0tXcu
         MhcjJkaM9lDcGaUXUApnJu8RPITFEr9oGDcMQlzV4pq9Hg+Mx0nk1lVIns8T/LdTEcTj
         sN7HIhWDqzf2scrHGzUD7zYF1EHzYyct3E6qsu48bv9Bg4175brARkhaJbbA6ReKIa5/
         slvGL9Z6uXPgaZoa9DQ7PRHE5SVRkFR4zjpOyWnN1BROLSR6GCHUM161NtUqUHOietH4
         GAL87JL9W3PFBilXVWpvrEXwqUP78hzId7xk8nvUUXbVs5y2+eWWfVyCXrUjR3tB022C
         28uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Mi6cvvgTrKqaZy71yh2LMK0OBp9QD/nEOoCoug7lnA=;
        b=MI9TX6p1ifRpnSAyRKeypVPwX8re5T6zBhDYgL6UZWRkEgTbTnwGnaR+G1OzetaUfb
         cdXnMJbcmy365yE6psGcK5QoBw+ib2me9NKgEwNJaGtqlDBvZnimtakxLoCC24uQp/aE
         e7MZgsO75oAyjZQHdHge35teYpPrlCe+j1G5dqsyExO3o8SiIYAvs3aJtxYuDyoIQgE7
         7Eq2AVUoEIHrVmxMAYyuBRNxe8dDdhEREJTbgclb1PXQbTT9y4XC/Li1O1GAw9/8uWiM
         a0xO04BTFD8P3K95D4PKIb85736GhYnNA1Lq6jANX7SSFJNKCFZ407R3Ra+Zd6ueUA9u
         hOfQ==
X-Gm-Message-State: AFeK/H3dch+Ex7iNYBs55G8pK7OMxZw60wE8htgoFhCsXVwnAy2wzgSA98kh525iPriXPQ==
X-Received: by 10.99.135.193 with SMTP id i184mr33646549pge.120.1490771119588;
        Wed, 29 Mar 2017 00:05:19 -0700 (PDT)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id f84sm1628162pfa.127.2017.03.29.00.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Mar 2017 00:05:18 -0700 (PDT)
Date:   Wed, 29 Mar 2017 00:05:15 -0700
From:   David Aguilar <davvid@gmail.com>
To:     Kirill Katsnelson <kkm@smartaction.com>
Cc:     git@vger.kernel.org, apenwarr@gmail.com
Subject: Re: should git-subtree ignore submodules?
Message-ID: <20170329070515.znaox4q52q5elkxy@gmail.com>
References: <183ca87e-1bc0-080c-3d42-87c689b9f62e@smartaction.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <183ca87e-1bc0-080c-3d42-87c689b9f62e@smartaction.com>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2016 at 12:41:50PM -0700, Kirill Katsnelson wrote:
> "git-subtree add" fails to add the subtree into a repository with
> submodules, reporting that the worktree is not clean, while `git status`
> says that everything is clean (including submodules). I tracked the problem
> down to the command "git index HEAD" returning all submodules as having the
> M status:
> 
> $ git diff-index HEAD
> :160000 160000 d3812c9318c4d0336897fd2d666be908fa1a7953
> d3812c9318c4d0336897fd2d666be908fa1a7953 M      ext/grpc
> <snip more submodules>
> $ git --version
> git version 2.9.2.windows.1
> 
> I worked around the problem in my local copy of git-subtree shell script by
> adding "--ignore-submodules=all" to the two invocations of `git diff-index`
> in the ensure_clean() function (direct link
> <https://github.com/git/git/blob/next/contrib/subtree/git-subtree.sh#L586>).
> 
> I am wondering, is this a defect in git-subtree? To my understanding, the
> command should not care about submodules more than ensuring their worktree
> is not in the way of new prefix, and that's a separate check. So *even if*
> the submodule is modified, this should not be a show stopper for
> "git-subtree add". Or am I missing some subtleties?

That sounds correct to me; subtree should ignore submodules.
-- 
David
