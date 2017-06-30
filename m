Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E31220209
	for <e@80x24.org>; Fri, 30 Jun 2017 07:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbdF3HJE (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 03:09:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:54418 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751565AbdF3HJD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 03:09:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3339AAC60;
        Fri, 30 Jun 2017 07:09:02 +0000 (UTC)
Date:   Fri, 30 Jun 2017 09:08:54 +0200
From:   Borislav Petkov <bp@suse.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yazen Ghannam <yazen.ghannam@amd.com>, git@vger.kernel.org
Subject: Re: git send-email (w/o Cc: stable)
Message-ID: <20170630070833.rwevr2yvp4wwo3ou@pd.tnic>
References: <20170616190200.6210-1-tony.luck@intel.com>
 <20170619180147.qolal6mz2wlrjbxk@pd.tnic>
 <20170621174740.npbtg2e4o65tyrss@intel.com>
 <20170622093904.ajzoi43vlkejqgi3@pd.tnic>
 <20170629221136.xbybfjb7tyloswf3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170629221136.xbybfjb7tyloswf3@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 29, 2017 at 03:11:37PM -0700, Luck, Tony wrote:
> So there is a "--cc-cmd" option that can do the same as those "-cc" arguments.
> Combine that with --suppress-cc=bodycc and things get a bit more automated.

Yeah, whatever works for you.

I did play with cc-cmd somewhat but can't be bothered to generate the CC
list per hand each time.

I'd prefer if that switch:

	--suppress-cc=<category>

had the obvious <category> of single email address too:

	--suppress-cc=stable@vger.kernel.org

so that we can send patches and unconditionally suppress only that
single recipient from the CC list.

And maybe there is a way...

Let me CC the git ML.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
