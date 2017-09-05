Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19201208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 14:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbdIEOq5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 10:46:57 -0400
Received: from onethreetwo.vfemail.net ([199.16.11.132]:41479 "EHLO
        vfemail.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750858AbdIEOq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 10:46:56 -0400
X-Greylist: delayed 393 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Sep 2017 10:46:56 EDT
Received: (qmail 21474 invoked by uid 89); 5 Sep 2017 14:40:15 -0000
Received: from localhost (HELO freequeue.vfemail.net) (127.0.0.1)
  by localhost with (DHE-RSA-AES256-SHA encrypted) SMTP; 5 Sep 2017 14:40:13 -0000
Received: (qmail 91341 invoked by uid 89); 5 Sep 2017 12:47:44 -0000
Received: by simscan 1.4.0 ppid: 91339, pid: 91340, t: 0.1010s
         scanners:none
Received: from unknown (HELO smtp102-2.vfemail.net) (172.16.100.62)
  by FreeQueue with SMTP; 5 Sep 2017 12:47:44 -0000
Received: (qmail 6965 invoked by uid 89); 5 Sep 2017 12:47:44 -0000
Received: by simscan 1.4.0 ppid: 6958, pid: 6962, t: 0.0648s
         scanners:none
Received: from unknown (HELO localhost) (d2FmZmxlY29kZUBvcGVubWFpbC5jYw==@172.16.100.93)
  by 172.16.100.62 with ESMTPA; 5 Sep 2017 12:47:44 -0000
Date:   Tue, 05 Sep 2017 12:47:43 +0000
Message-ID: <20170905124743.Horde.bgYg8gUhE6ubSHtPAr3lCGl@vfemail.net>
From:   wafflecode@openmail.cc
To:     git@vger.kernel.org
Subject: Empty directories in Git: Current guidance for historical commits?
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hello,

Per the FAQ it's clear that Git (by current design) does not track  
empty directories:   
https://git.wiki.kernel.org/index.php/GitFaq#Can_I_add_empty_directories.3F

That's fine and I can fix that for my code going forward via the build  
system, as needed.

However I'm looking to import a fairly deep (10k+ commits) svn history  
in to Git and I'm wondering what the current best practices are for  
dealing with empty folders?   Meaning to say, I'd like to be able to  
check out an older revision of the code and have it build correctly  
using the older build system which expects certain folders to exist.

There are a few different answers floating around the net, so I  
figured I'd confirm via the mailing list.

Is just dropping a ".gitignore" or "README" file in the empty  
directories during conversion still the most reasonable approach?  If  
so, is there a way to do this automatically during the conversion  
using "git svn" or the like?


Thank you
David



-------------------------------------------------

ONLY AT VFEmail! - Use our Metadata Mitigator to keep your email out of the NSA's hands!
$24.95 ONETIME Lifetime accounts with Privacy Features!  
15GB disk! No bandwidth quotas!
Commercial and Bulk Mail Options!  
