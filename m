Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08095C47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 14:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8B2820708
	for <git@archiver.kernel.org>; Mon, 11 May 2020 14:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbgEKOs3 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 11 May 2020 10:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729463AbgEKOs2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 10:48:28 -0400
X-Greylist: delayed 520 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 May 2020 07:48:28 PDT
Received: from mx2.uni-regensburg.de (mx2.uni-regensburg.de [IPv6:2001:638:a05:137:165:0:3:bdf8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA18CC061A0C
        for <git@vger.kernel.org>; Mon, 11 May 2020 07:48:28 -0700 (PDT)
Received: from mx2.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id BD006600004D
        for <git@vger.kernel.org>; Mon, 11 May 2020 16:39:43 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx2.uni-regensburg.de (Postfix) with ESMTP id 4E504600004E
        for <git@vger.kernel.org>; Mon, 11 May 2020 16:39:43 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Mon, 11 May 2020 16:39:43 +0200
Message-Id: <5EB963AF020000A100038ECE@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.2.1 
Date:   Mon, 11 May 2020 16:39:43 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: Improving git's password prompt
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I'm aware that most repositories use "open HTTP" or SSH public key authentication, but for the few cases where SSH with password is being used, there is a minor probem like this:
---
tester@host:~/iredir> git fetch
Password:
---

Now if you are working busily with the project you probably know where the repository came from, what the username and password is, but if you haven't worked with the repository for a while, it might be helpful to see the username and host (the part up to ':' in the display of "git remote -v", e.g.: "windl@server") with the password prompt to select the correct password.

So my proposal would be "Password for user@host:" instead of just "Password:".

Problem seen in git 2.26.1...

Regards,
Ulrich




