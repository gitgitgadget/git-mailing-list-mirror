Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EFC520281
	for <e@80x24.org>; Tue, 26 Sep 2017 23:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970630AbdIZX1Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 19:27:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:35393 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964864AbdIZX1P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 19:27:15 -0400
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2017 16:27:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.42,442,1500966000"; 
   d="scan'208";a="1018793220"
Received: from mherber2-mobl.jf.intel.com (HELO mherber2-mobl.ger.corp.intel.com) ([10.7.199.152])
  by orsmga003.jf.intel.com with ESMTP; 26 Sep 2017 16:27:15 -0700
Subject: Google indexing https://public-inbox.org/git (was: BUG in git
 diff-index)
To:     Eric Wong <e@80x24.org>
Cc:     git <git@vger.kernel.org>
References: <loom.20160331T143733-916@post.gmane.org>
 <20160331140515.GA31116@sigill.intra.peff.net>
 <CAJxkE8SVF_ikHqDCh6eHExq=seitHPVpxW2GmPo40jtqWvz1JQ@mail.gmail.com>
 <20160331142704.GC31116@sigill.intra.peff.net> <56FD7AE8.4090905@nglowry.com>
 <xmqqwpoil6vt.fsf@gitster.mtv.corp.google.com>
 <d9b4725b-3204-03af-1bc2-6469bb815c63@intel.com>
 <20170926201112.GA26968@whir>
From:   Marc Herbert <Marc.Herbert@intel.com>
Message-ID: <cb495eeb-73d0-ef88-57b6-a601e1d8cfc0@intel.com>
Date:   Tue, 26 Sep 2017 16:27:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170926201112.GA26968@whir>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Reduced Cc: and change Subject:]

On 26/09/17 13:11, Eric Wong wrote:
> There's no blocks on public-inbox.org and I'm completely against
> any sort of blocking/throttling.  Maybe there's too many pages
> to index?  Or the Message-IDs in URLs are too ugly/scary?  Not
> sure what to do about that...
> 
> Anyways, I just put up a robots.txt with Crawl-Delay: 1, since I
> seem to recall crawlers use a more conservative delay by default:

Not sure what made the difference: Google can now easily find this
thread on both https://public-inbox.org/git and on spinics too.

Same change observed for another, unrelated thread on this list.

Nevermind.

"Unsearchable are his judgments, and his ways past finding out"
