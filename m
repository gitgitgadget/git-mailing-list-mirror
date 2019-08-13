Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FF5F1F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 14:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfHMOSV (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 10:18:21 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:43665 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729264AbfHMOSU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 10:18:20 -0400
Received: from localhost (unknown [157.49.214.110])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 8531010000C
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 14:18:18 +0000 (UTC)
Date:   Tue, 13 Aug 2019 19:48:16 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     git@vger.kernel.org
Subject: How to reset selected lines?
Message-ID: <20190813141816.yoer6pfjdnlgtj76@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

To put things into context of why I am asking this, git-gui has a 
feature where you can select parts of a displayed diff, and can 
stage/unstage those parts. That feature is implemented in git-gui by 
just generating a diff from the selected lines, and then applying it. 
Check git-gui/lib/diff.tcl:643 for the implementation.

Now, I want to add a similar feature, but one that discards/resets the 
selected lines. And I'd like to avoid the hack that git-gui's 
apply_range_or_line is. So, is there a cleaner way to do this that does 
not involve generating a diff and then applying it?

Also, if there is a better way of staging and unstaging selected lines 
as well, do let me know, and I will try to fix git-gui's hacky way of 
doing it.

-- 
Regards,
Pratyush Yadav
