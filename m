Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C42B1F462
	for <e@80x24.org>; Wed, 29 May 2019 07:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfE2HqC convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 29 May 2019 03:46:02 -0400
Received: from mx2.uni-regensburg.de ([194.94.157.147]:51202 "EHLO
        mx2.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfE2HqC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 03:46:02 -0400
Received: from mx2.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 457146000051
        for <git@vger.kernel.org>; Wed, 29 May 2019 09:45:59 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx2.uni-regensburg.de (Postfix) with ESMTP id 2F779600004E
        for <git@vger.kernel.org>; Wed, 29 May 2019 09:45:59 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Wed, 29 May 2019 09:45:59 +0200
Message-Id: <5CEE38B4020000A1000317C6@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.1.1 
Date:   Wed, 29 May 2019 09:45:56 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: Q: git describe --always --tags .. gives "warning: tag 'tag1'
 is really 'tag2' here"
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I have a project that changed its name some time ago (from "isredir" to "iredir"), so I added another tag for the same commit ID (What's the command to show the commit IDs for tags, BTW?: "git tag -v" does not.

As part of the build process, I run (for example) "git describe --always --tags af467c7".
So I got the response:
warning: tag 'isredir-0.3.0' is really 'iredir-0.3.0' here
isredir-0.3.0-3-gaf467c7

I'm unsure what the message is actually saying: The hash cannot be resolved in a unique way?

I just see two tags remaining in refs:
> ls .git/refs/tags/
iredir-0.3.0  iredir-0.3.1

Regards,
Ulrich


