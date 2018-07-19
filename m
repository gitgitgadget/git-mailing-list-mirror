Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FD7E1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 07:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbeGSI1H convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 19 Jul 2018 04:27:07 -0400
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:53498 "EHLO
        rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731215AbeGSI1G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 04:27:06 -0400
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Jul 2018 04:27:05 EDT
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 08ED4619A5
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 09:38:44 +0200 (CEST)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by rrzmta1.uni-regensburg.de (Postfix) with ESMTP id 627D45E8A0
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 09:38:27 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
        with Novell_GroupWise; Thu, 19 Jul 2018 09:38:27 +0200
Message-Id: <5B503FF0020000A10002C6B5@gwsmtp1.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.0.1 
Date:   Thu, 19 Jul 2018 09:38:24 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: Q: Ignore ./foo, but not script/foo
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I have a (simple) question I could not answer elegantly from the gitignore(5) manual page:

A project produces a "foo" binary in the root directory that I want to ignore (So I put "foo" into .gitignore)
Unfortunately I found out taht I cannot have a "script/foo" added while "foo" is in .gitignore.
So I changed "foo" to "./foo" in .gitignore. I can could add "script/foo", but now "foo" is not ignored any more!

Is there as solution other than:?
--
foo
!script/foo
!bla/foo
#etc.
--

If "foo" is one exception to generally using foo elsewhere, it seems to be counterproductive to have to add exceptions for all the cases that are not exceptions, while "foo" is the only exception...

Did I miss something? If so, maybe add it to a future manual page.

Regards,
Ulrich


