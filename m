Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFC911F4B6
	for <e@80x24.org>; Wed, 24 Jul 2019 09:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfGXJyO (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 05:54:14 -0400
Received: from mx4.uni-regensburg.de ([194.94.157.149]:45670 "EHLO
        mx4.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfGXJyO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 05:54:14 -0400
Received: from mx4.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 899AF6000055
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 11:54:11 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx4.uni-regensburg.de (Postfix) with ESMTP id 741626000052
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 11:54:11 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Wed, 24 Jul 2019 11:54:11 +0200
Message-Id: <5D382AC1020000A100032608@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.1.1 
Date:   Wed, 24 Jul 2019 11:54:09 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: blank lines in pre-created merge message
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I think I had tried bringing this to your attention before, but I think it was
without success.
The issue may seem purely cosmetical, while being easy to fix (is my guess):

When using "git merge --no-ff --no-commit ..", the pre-created merge message
always contains two empty lines in between the comment lines. However if there
was a merge conflict (being resolved) an extra blank line is added after the
first line.

In vi those empty lines are easy to spot, and I routinely remove them. But
maybe it's better not to create them at the beginning. (A "normal commit" never
creates any emüpty lines in the pre-created comment)

My Git version is 2.12.3, but the bug is probably quite old...

Regards,
Ulrich Windl

