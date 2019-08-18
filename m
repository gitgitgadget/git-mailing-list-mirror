Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A53211F461
	for <e@80x24.org>; Sun, 18 Aug 2019 16:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfHRQDW (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 12:03:22 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50619 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726115AbfHRQDW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Aug 2019 12:03:22 -0400
Received: from callcc.thunk.org ([12.235.16.3])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7IG3HCC027600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 18 Aug 2019 12:03:19 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 340AF4218EF; Sun, 18 Aug 2019 12:03:17 -0400 (EDT)
Date:   Sun, 18 Aug 2019 12:03:17 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     git@vger.kernel.org
Subject: Missing file in 2.23 (p5302-pack-index.subtests)?
Message-ID: <20190818160317.GA13772@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was trying to run "make profile" on the master branch (commit
5fa0f5238b: "Git 2.23") and it died in the

	$(MAKE) PROFILE=GEN perf

dies with:

	cannot open test-results/p5302-pack-index.subtests: No such file or directory at ./aggregate.perl line 153.

I presume that's becuase the file t/perf/test-results/p5302-pack-index.subtests is missing?

						- Ted
