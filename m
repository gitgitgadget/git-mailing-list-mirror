Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEBEC4320E
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 08:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF92B61077
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 08:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbhH3I5L convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 30 Aug 2021 04:57:11 -0400
Received: from mx4.uni-regensburg.de ([194.94.157.149]:43792 "EHLO
        mx4.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbhH3I5K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 04:57:10 -0400
Received: from mx4.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id E4CA96000055
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 10:56:14 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx4.uni-regensburg.de (Postfix) with ESMTP id D16696000050
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 10:56:14 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Mon, 30 Aug 2021 10:56:15 +0200
Message-Id: <612C9D2D020000A100043924@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.3.1 
Date:   Mon, 30 Aug 2021 10:56:13 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: Q: Should "submodule set-url" add .gitmodules to index?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Realizing that some of my git submodule repositories were at the wrong path, I moved the repositories and updated a workspace using "git submodule set-url ...".
Checking the status I noticed that .gitmodules was not added to index (as opposed to a "git mv ...").
Is that intentional?
Seen in git 2.26.2.

Regards,
Ulrich Windl



