Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1CD520954
	for <e@80x24.org>; Tue, 28 Nov 2017 14:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbdK1Obn convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 28 Nov 2017 09:31:43 -0500
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:37016 "EHLO
        rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751790AbdK1Obn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 09:31:43 -0500
X-Greylist: delayed 589 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Nov 2017 09:31:42 EST
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 202A55DEAB
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 15:21:52 +0100 (CET)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by rrzmta1.uni-regensburg.de (Postfix) with ESMTP id 07B0B5DCDA
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 15:21:52 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
        with Novell_GroupWise; Tue, 28 Nov 2017 15:21:51 +0100
Message-Id: <5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date:   Tue, 28 Nov 2017 15:21:49 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: bug deleting "unmerged" branch (2.12.3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

During a rebase that turned out to be heavier than expected 8-( I decided to keep the old branch by creating a temporary branch name to the commit of the branch to rebase (which was still the old commit ID at that time).
When done rebasing, I attached a new name to the new (rebased) branch, deleted the old name (pointing at the same rebase commit), then recreated the old branch from the temporary branch name (created to remember the commit id).
When I wanted to delete the temporary branch (which is of no use now), I got a message that the branch is unmerged.
I think if more than one branches are pointing to the same commit, one should be allowed to delete all but the last one without warning. Do you agree?

Regards,
Ulrich


