Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 271621F461
	for <e@80x24.org>; Mon,  2 Sep 2019 07:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbfIBHBe convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 2 Sep 2019 03:01:34 -0400
Received: from mx3.uni-regensburg.de ([194.94.157.148]:48142 "EHLO
        mx3.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbfIBHBe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 03:01:34 -0400
Received: from mx3.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 190B9600005F
        for <git@vger.kernel.org>; Mon,  2 Sep 2019 09:01:31 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx3.uni-regensburg.de (Postfix) with ESMTP id 03648600005D
        for <git@vger.kernel.org>; Mon,  2 Sep 2019 09:01:30 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Mon, 02 Sep 2019 09:01:30 +0200
Message-Id: <5D6CBE49020000A100033415@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.1.1 
Date:   Mon, 02 Sep 2019 09:01:29 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: "show" in git-stash(1)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Reading the (somewhat older) manual page GIT-STASH(1)  for "show" I found:

       show [<stash>]
           Show the changes recorded in the stash as a diff between the
           stashed state and its original parent. When no <stash> is given,
           shows the latest one. By default, the command shows the diffstat,
           but it will accept any format known to git diff (e.g., git stash
           show -p stash@{1} to view the second most recent stash in patch
           form). You can use stash.showStat and/or stash.showPatch config
           variables to change the default behavior.

The syntax summary suggested that there are no further "interesting options", but somewhat later googling for "git diff against a stash" (a very frequently asked question, BTW) showed that a diff output is enabled if there are diff options like "-u". Agreed, it is explained further down in the text, but users reading manual pages "efficiently" may miss that ;-)

Why not change the syntax to something like
"show [diff-option]... [<stash>]
?

Regards,#
Ulrich


