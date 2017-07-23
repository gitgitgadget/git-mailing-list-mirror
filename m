Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_05,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C50A203F3
	for <e@80x24.org>; Sun, 23 Jul 2017 07:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751103AbdGWH04 (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 03:26:56 -0400
Received: from mail.pdinc.us ([67.90.184.27]:37630 "EHLO mail1.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750837AbdGWH04 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 03:26:56 -0400
X-Greylist: delayed 1161 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Jul 2017 03:26:56 EDT
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail1.pdinc.us (8.14.4/8.14.4) with ESMTP id v6N77W86027656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 23 Jul 2017 03:07:33 -0400
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Cc:     <kmarek@pdinc.us>
Subject: index.lock porcelain interface?
Date:   Sun, 23 Jul 2017 03:07:33 -0400
Organization: PD Inc
Message-ID: <DE816FDC2674421DB90DC132F963A178@blackfat>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdMDglsbYfIlCy8KSemzGwTqn4wYsw==
X-MimeOLE: Produced By Microsoft MimeOLE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While working on some scripts for continuous integration, we wanted to check
if git was doing anything, before running our script.

The best we came up with was checking for the existence of index.lock or if
a merge in progress. The MERGE_HEAD can be checked, but we chose to use git
status --porcelain=v2 . Is there a better check than does .git/index.lock
exists, e.g. a porcelain interface?

-Jason

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

