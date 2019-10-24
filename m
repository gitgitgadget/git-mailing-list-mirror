Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6958A1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 19:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437187AbfJXTRO (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 15:17:14 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:60825 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437182AbfJXTRO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 15:17:14 -0400
X-Originating-IP: 1.186.12.46
Received: from localhost (unknown [1.186.12.46])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B379E40004
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 19:17:11 +0000 (UTC)
Date:   Fri, 25 Oct 2019 00:47:09 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     git@vger.kernel.org
Subject: git-shortlog man page missing a bunch of options
Message-ID: <20191024191709.gqkjljuibyashtma@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I was looking at the git-shortlog man page today and realized that it 
didn't mention an option that I have used before '--no-merges'. Looking 
further, there are a lot of options that are not documented.

One fix would be to include rev-list-options.txt (which is where I 
assume these options come from), just like git-log does.

But rev-list-options.txt is a rather large file and I'm not sure if 
including it in both git-log and git-shortlog would be a good idea. The 
way I see it, git-log is the "primary" log interface, and git-shortlog 
is a "secondary" log interface, so git-log warrants such a large man 
page, but git-shortlog doesn't especially since most options are 
repeated. So maybe it is a better idea to just include a pointer to 
git-rev-list in the shortlog man page.

I'll send in a patch after some suggestions on which alternative to go 
for.

-- 
Regards,
Pratyush Yadav
