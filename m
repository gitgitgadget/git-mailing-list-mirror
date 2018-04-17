Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C1221F404
	for <e@80x24.org>; Tue, 17 Apr 2018 19:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeDQTpL (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 15:45:11 -0400
Received: from titan.plasma.xg8.de ([85.10.203.189]:39494 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeDQTpK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 15:45:10 -0400
X-Greylist: delayed 1743 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Apr 2018 15:45:09 EDT
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w3HJG48M020225
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 21:16:04 +0200
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w3HJG4xe020224
        for git@vger.kernel.org; Tue, 17 Apr 2018 21:16:04 +0200
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w3HJFn7j001409
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 21:15:49 +0200
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w3HJFnJJ001408
        for git@vger.kernel.org; Tue, 17 Apr 2018 21:15:49 +0200
Date:   Tue, 17 Apr 2018 21:15:49 +0200
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     Git Mailing List <git@vger.kernel.org>
Subject: GDPR compliance best practices?
Message-ID: <20180417191549.GA1199@helen.PLASMA.Xg8.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'd like to ask whether anyone has best practices for achieving GDPR 
compliance for git repos? The GDPR will come into effect in the EU next 
month.

In particular, how do you cope with the "Right to erasure" concerning 
entries in the history of your git repos?

Erasing author names from the history changes the commit hashes.  It is 
well known that this leads to a lot of problems.  So I don't consider 
this a workable solution.

And how do you justify publishing your employee's name/email as part of 
a git commit under GDPR rules in the first place?

github has the following page mentioning the "Right to erasure" but 
AFAICS nothing about how it will be implemented
https://about.gitlab.com/gdpr/

Here are discussions I found but they do not really provide a solution:
https://law.stackexchange.com/questions/24623/gdpr-git-history
https://news.ycombinator.com/item?id=16509755

Best wishes
Peter

-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
