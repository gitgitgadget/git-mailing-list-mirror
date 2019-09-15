Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53D3D1F463
	for <e@80x24.org>; Sun, 15 Sep 2019 23:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfIOXI3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Sep 2019 19:08:29 -0400
Received: from ozlabs.org ([203.11.71.1]:39451 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727409AbfIOXI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Sep 2019 19:08:28 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 46WlRG09d8z9sP7; Mon, 16 Sep 2019 09:08:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1568588906; bh=WR17qYZLj6cHmTVPXgqXxIlT+cDfw3wf7ngYv9SGK/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U53jClIjl6pQpdcP5bin64O5Vt2tfwD3m4Hc5asLl84TIiwZ5h/GBVtMxfOts4NpU
         5qLjo4mrZnYIHW2J3nI/GeGgAcElw+RC+I1/07LrJML1mTWFNnb6G64LnL6iODAga/
         PGZc8pUJhNHu5tBX5zjLfLfPvbYvUoj2BzEZ2qICdsU4rcS3vSCn+C61yKr0T9NIST
         TxnK98Te0yeEezNb4yV6zOZ2tvr98hPW+i+Y9c9CTaHoUb/7HQjPLA/YzdxvOKZHhY
         jWiIHEGTqM0p1dEdJhieD8i1E3leyPtgLj/1SXSkqiPMf2dLMtyf7b+o7f0Y/IU4H5
         DJ1p0sCjB2Brg==
Date:   Mon, 16 Sep 2019 09:08:21 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gitk: Do not mistake unchanged lines with submodule
 changes
Message-ID: <20190915230821.GC9560@blackberry>
References: <20190323170036.21533-1-gabriele.mzt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190323170036.21533-1-gabriele.mzt@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 23, 2019 at 06:00:36PM +0100, Gabriele Mazzotta wrote:
> Unchanged lines are prefixed with a white-space, thus unchanged lines
> starting with either " <" or " >" are mistaken for submodule changes.
> Check if a line starts with either "  <" or "  >" only if we listing
> the changes of a submodule.
> 
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>

Thanks, patch applied to my git://ozlabs.org/~paulus/gitk.git repository.

Paul.
