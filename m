Return-Path: <SRS0=BObu=DK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D94EC4363D
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 09:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89E85206CA
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 09:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="SywDCF0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgJCJO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Oct 2020 05:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgJCJO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Oct 2020 05:14:27 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEA0C0613D0
        for <git@vger.kernel.org>; Sat,  3 Oct 2020 02:14:27 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1003)
        id 4C3Llg35krz9sSf; Sat,  3 Oct 2020 19:14:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1601716463; bh=2vnKsBSResjyFCsTSAzP/YvLO38AsICn1bY3Dl9ILu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SywDCF0g9wDrm7wAbBUnryc+TcVzJT0m/bUQGwXDVHqi6zWnKDlLS5Ej7zJeDkMdX
         /GWF+16HefqVyuHhaV8agxPo2qpejSBt1V4Negm3h6HQ8i+UfGa1wBsLj2dnOjZFhZ
         VjCIZbVUXxAfQg9PJA244YPx98n6p6u0QheCXzj7aOfupM6IDtUvxnnPBB+3pA3l4n
         QpUT2qwnCynSBLMFi9M9BYzq8LzfSS7Uj+nT7fywjrSsNg38Lwiyz0cHquF0cTagEo
         wkbiHwOYbTjjo62SUaN6pe8gFla9anktmY6M65ssW4vf2Gi3m2ofjVeoLbewsig59w
         ogFdA2impEz9Q==
Date:   Sat, 3 Oct 2020 19:14:19 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] gitk: replace tabs with spaces
Message-ID: <20201003091419.GB3089868@thinks.paulus.ozlabs.org>
References: <cover.1599726439.git.liu.denton@gmail.com>
 <cover.1599798976.git.liu.denton@gmail.com>
 <ecdede5cf50bdb966f53bcf5171c80b5f8959d4b.1599798976.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecdede5cf50bdb966f53bcf5171c80b5f8959d4b.1599798976.git.liu.denton@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 10, 2020 at 09:36:33PM -0700, Denton Liu wrote:
> The source code is a mix of tabs and spaces. The indentation style
> currently is four spaces per indent level but uses tabs every other
> level (at eight spaces). Fix this inconsistent spacing and tabbing by
> just using a space-indent for everything.
> 
> This was done mechanically by running:
> 
> 	$ expand -i gitk >gitk.new
> 	$ mv gitk.new gitk
> 
> This patch should be empty with `--ignore-all-space`.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>

Thanks, applied, though in fact I regenerated the patch since I had
some local commits that I had not yet pushed out.

Paul.
