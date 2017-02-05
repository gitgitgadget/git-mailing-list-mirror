Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 215551FAF4
	for <e@80x24.org>; Sun,  5 Feb 2017 20:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754037AbdBEUR6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 15:17:58 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33260 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753923AbdBEURz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 15:17:55 -0500
Received: by mail-pg0-f67.google.com with SMTP id 194so7133380pgd.0
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 12:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aTuTCSa985Vryb5/ADbMSBkCS2nFUikbvOalIlskMQI=;
        b=qJOQBLoPVliJlnYEcWa15d7RG6d4e1LK0jROeiffHQLgFX5+oUPswdWi+yAgNZZRoQ
         7PhxBjUUWIdgo+oLBlAT0PQY06mfxSX1xfQFbCTZ8AoFYRZlLU11Rj1g7E/veU17+SNs
         iaDOt0ZC0E8V1HudI1icpKS2zMK36jU0TuS0MKfAr79J7p9bgZI5V4QCOR6sUaYNZWZG
         hKoNbhim9FOMNfnLjPNY8SWTTfyuWLxTYe4QsEr5f1wq4Arzj7EGy/oUh/ndOslcsVS4
         1rnTwSAaR0JADOgkiqOKtI3+z1cfcCHEp8NJVUcALK4dE3/ctg5KMkNpkXTQcoajuv6G
         U2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aTuTCSa985Vryb5/ADbMSBkCS2nFUikbvOalIlskMQI=;
        b=UlPmxdk2JnYcwPKKWGH4oELls85qaxIX56l5ZMqGr9i5+DtdvQgf41GJOtXVmAO4Qi
         rAlWZiU96wVPro5hz1NjojukqdLpys8bUW2dP+zpG7+dXhcHy6cBRIVrSYpDhCAwpYNw
         KTw/3EE0M9uGkq0465MgE5koF3LfXfGqtG+cso8GpQWkvtM9QHOLAZyzh1/mpqIMnBWg
         IQOCG+5Cp/aq1cKR3Jo9zHCdCeUGPPpGuWOEWZyluF+dzHfqqp5h1LMzdmrjQ7kgCy43
         ONa5Hct5sCxJfu/qnjsQjg6D2UnzaFccFoe8NSjqVqzKAvsCnNsjyfpb2ICf7SxhRBVt
         APsA==
X-Gm-Message-State: AIkVDXJ/y9giTSAkepmH0CkMboPsOwxFMusM//NbFPl4kPTsLivtRG//tWItreS0kz2kwg==
X-Received: by 10.98.33.131 with SMTP id o3mr9336196pfj.86.1486325875175;
        Sun, 05 Feb 2017 12:17:55 -0800 (PST)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id e129sm82943964pfe.8.2017.02.05.12.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Feb 2017 12:17:54 -0800 (PST)
Date:   Sun, 5 Feb 2017 12:17:51 -0800
From:   David Aguilar <davvid@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [BUG] was: Re: [PATCH] Remove --no-gui option from difftool usage
 string
Message-ID: <20170205201751.z4rfmy5xxaqg472l@gmail.com>
References: <20170204025617.GA9221@arch-attack.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170204025617.GA9221@arch-attack.localdomain>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 03, 2017 at 06:56:17PM -0800, Denton Liu wrote:
> The --no-gui option not documented in the manpage, nor is it actually
> used in the source code. This change removes it from the usage help
> that's printed.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  git-difftool.perl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

[Dscho, I found a bug, see below]

I forgot to mention that the scripted difftool has been
rewritten in C and will be going away soon.
builtin/difftool.c is already in "next".

New patches against difftool should target the builtin.

Regarding removing it from the usage string, IMO that can be
considered a good change if the rationale were instead that
we never expect users to ever type "--no-gui" in practice.

Wasting the short usage string screen space with a useless to
99.99% users option is bad for usability.  From that perspective
we shouldn't mention it there, so reframing the commit message
towards that argument would make for a better motivation.

Removing the mention from the usage string and adding it to the
manpage would be the a good change from that perspective as well.


BTW, in "next", it seems that the builtin difftool crashes when
doing "git difftool -h", so we should probably add a test
for that too...

From the tip of next:

$ git difftool -h
fatal: BUG: setup_git_env called without repository
-- 
David
