Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCF6C433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 12:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348461AbiCKMBP convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 11 Mar 2022 07:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239962AbiCKMBN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 07:01:13 -0500
X-Greylist: delayed 376 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 04:00:09 PST
Received: from mx3.uni-regensburg.de (mx3.uni-regensburg.de [IPv6:2001:638:a05:137:165:0:4:4e79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3521AA06A
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 04:00:09 -0800 (PST)
Received: from mx3.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id AC5B6600004A
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 12:53:50 +0100 (CET)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx3.uni-regensburg.de (Postfix) with ESMTP id 982DA6000047
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 12:53:50 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Fri, 11 Mar 2022 12:53:51 +0100
Message-Id: <622B384D020000A1000488F7@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.3.1 
Date:   Fri, 11 Mar 2022 12:53:49 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: git submodule add adding an extra "Git" to path
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I just noticed this (in ~/src/C/iotwatch.lib):
% git submodule add ../Git/threadtools.git threadtools

complained:
fatal: repository '~/src/C/Git/Git/threadtools.git' does not exist

"~" is not actually displayed here, but that does not matter: Just image it reads "/home/user" instead.

Using the absolute path, worked, however.
% git submodule add ~/src/C/Git/threadtools.git threadtools

git version 2.26.2 from SLES12 SP5

Regards,
Ulrich



