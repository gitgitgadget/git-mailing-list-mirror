Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 877A41F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 17:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKRRfV (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 12:35:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbfKRRfV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 12:35:21 -0500
Received: from localhost (unknown [89.205.134.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A0172192B;
        Mon, 18 Nov 2019 17:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574098520;
        bh=qcAeLgwzuMVxi2KtU2+/MT6hnx1Dw0WfKZY4aTsHq70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cbrNI1H/qHKRJpkIRyZrH3AAVHufIbELBQnzMRYHp/XwQ7xu4pjH0Hm83u8UBDRkD
         PvFENJPgW4CHZFTvStfCGX78i11aLq/JmpAK1ARVTsixiV5R0fBGVng7ukWMSq39sA
         32sJ7MQHlH38R+GEroarYZbjsDygKrNTDHaSezCw=
Date:   Mon, 18 Nov 2019 18:35:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     git@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: Signal conflict on merging metadata-differing patches
Message-ID: <20191118173517.GA599094@kroah.com>
References: <20191118172917.GA6063@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118172917.GA6063@vmlxhi-102.adit-jv.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 18, 2019 at 06:29:17PM +0100, Eugeniu Rosca wrote:
> Dear Git community,
> 
> Due to high inflow of patches which Linux maintainers carry on their
> shoulders and due to occasionally intricate relationships between
> consecutive revisions of the same series, it may [1] happen that two
> distinct revisions of the same patch (differing only/mostly in
> metadata, e.g. Author's time-stamp and commit description) may end up
> being merged on the same branch, without git to complain about that.

Why would git complain about that?

> Is there any "git merge" flag available off-the-shelf which (if used)
> would signal such situations?

I don't understand what you are looking for here.  Two different
versions of the patch were merged to different branches and then merged
together, and git did the right thing with the resolution of the code.

What more can it do here?

thanks,

greg k-h
