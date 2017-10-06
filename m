Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 548A81FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 14:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbdJFOhb (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 10:37:31 -0400
Received: from ms-10.1blu.de ([178.254.4.101]:49856 "EHLO ms-10.1blu.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751755AbdJFOh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 10:37:29 -0400
X-Greylist: delayed 6582 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Oct 2017 10:37:28 EDT
Received: from [132.187.15.85] (helo=localhost)
        by ms-10.1blu.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.86_2)
        (envelope-from <alexander.gehrke@qwertyuiop.de>)
        id 1e0S2b-0008V4-6Z
        for git@vger.kernel.org; Fri, 06 Oct 2017 14:47:45 +0200
Date:   Fri, 6 Oct 2017 14:47:30 +0200
From:   Alexander Gehrke <alexander.gehrke@qwertyuiop.de>
To:     git@vger.kernel.org
Subject: [bug] git add -p breaks, if color.ui is set to "always"
Message-ID: <20171006124730.onetucvpt3btlali@wheatley.informatik.uni-wuerzburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170912 (1.9.0)
X-Con-Id: 33701
X-Con-U: 0-me
X-Originating-IP: 132.187.15.85
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After an update to version 2.14.2 from 2.14.1 "git add --patch" stopped working
for me, just producing the same output as "git diff", but not prompting to stage
anything.

I found that unsetting the config key color.ui, which was set to "always" fixed
the problem.

From the manpage, color.ui should not have that effect and "always" should be a
legal value.

Regards
Alexander Gehrke
