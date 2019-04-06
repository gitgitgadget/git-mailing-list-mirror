Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A39820248
	for <e@80x24.org>; Sat,  6 Apr 2019 13:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDFN1z (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 09:27:55 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:34817 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfDFN1z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 09:27:55 -0400
Received: from localhost.localdomain ([2.101.245.142])
        by smtp.talktalk.net with SMTP
        id ClMPhui0snuQZClMPhhS4P; Sat, 06 Apr 2019 14:27:53 +0100
X-Originating-IP: [2.101.245.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=mQgiQ6BlbOv19lEfDgieCg==:117
 a=mQgiQ6BlbOv19lEfDgieCg==:17 a=TG7pU1ooXNnMWWpGhRMA:9
From:   Philip Oakley <philipoakley@iee.org>
To:     GitList <git@vger.kernel.org>
Subject: [PATCH 0/2] Minor document fixes
Date:   Sat,  6 Apr 2019 14:27:45 +0100
Message-Id: <20190406132747.16376-1-philipoakley@iee.org>
X-Mailer: git-send-email 2.21.0.windows.1.80.gdc2ae9a382
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfIJSaphgkdVtW9NslD+hPLy9IwXyHxIv7UvRROOl6i31LV0/wJRzDkdOg8DD7W/EIyDVSIkuiNS40P/rwnxuzhfFU2cXzo6sCUT53CKNyG9Hj8cfjUb7
 8JnlWLEB4IjbsvirAfkP5fgXNEU07oRUgza/z8WQFDkLA3Oxvkgg7rjCoxOHeH3FN+yEiVK9YuvO+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple of minor fixes seen while looking at the Git-for-Wondows
patch thicket and getting my head around the conflict resolutions

I did note that there was potential for the rerere-train to be integrated
with the main rerere code, and maybe learn from the range-diff, and the
rebasing merge todo lists, when repetition is occuring in development.
Maybe also 'show' options for the resolutions (-cc?). Possibly an
intersting student project, including its documenation.

Philip Oakley (2):
  rerere doc: quote `rerere.enabled`
  describe doc: remove '7-char' abbreviation reference

 Documentation/git-describe.txt | 2 +-
 Documentation/git-rerere.txt   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.21.0.windows.1.80.gdc2ae9a382

