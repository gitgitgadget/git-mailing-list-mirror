Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21A3C4BA3B
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 09:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D30C2467F
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 09:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgB0JvQ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 27 Feb 2020 04:51:16 -0500
Received: from mx2.uni-regensburg.de ([194.94.157.147]:43838 "EHLO
        mx2.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbgB0JvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 04:51:16 -0500
X-Greylist: delayed 486 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Feb 2020 04:51:15 EST
Received: from mx2.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id BD5886000054
        for <git@vger.kernel.org>; Thu, 27 Feb 2020 10:43:07 +0100 (CET)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx2.uni-regensburg.de (Postfix) with ESMTP id A731E6000053
        for <git@vger.kernel.org>; Thu, 27 Feb 2020 10:43:07 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Thu, 27 Feb 2020 10:43:07 +0100
Message-Id: <5E578F2A020000A1000373EF@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.2.0 
Date:   Thu, 27 Feb 2020 10:43:06 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: Q: submodules and detached HEAD
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I'm rather new to submodules, and I have a question on something I don't understand (git-2.12.3 from SLES12):
I had checked out tag v0.0.1 of my submodule.
When checking the status, I see:

iptables> git status
HEAD detached at v0.0.1
nothing to commit, working tree clean
iptables> git checkout v0.0.1
HEAD is now at b23fbdc... .version: 0.0.1
iptables> git checkout v0.0.2
Previous HEAD position was b23fbdc... .version: 0.0.1
HEAD is now at 5af0df5... v0.0.2: Fix issue with "xtables lock"
/iptables> git status
HEAD detached at v0.0.2
nothing to commit, working tree clean
iptables> git branch
* (HEAD detached at v0.0.2)
  master

git reflog says:
5af0df5 HEAD@{0}: checkout: moving from b23fbdc0e18e570a4d9ec4cb8826afc82e2e0b64 to v0.0.2
b23fbdc HEAD@{1}: checkout: moving from ec7dd70b59e039b49bb478a3134b713a2b0a279c to v0.0.1
ec7dd70 HEAD@{2}: checkout: moving from master to v0.0

Config submodule.iptables.branch is not set.

Who can explain?

Regards,
Ulrich


