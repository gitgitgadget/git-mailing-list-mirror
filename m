Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC59FC11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 14:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D199B613F4
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 14:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbhGBODn convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 2 Jul 2021 10:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbhGBODn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 10:03:43 -0400
Received: from mx2.uni-regensburg.de (mx2.uni-regensburg.de [IPv6:2001:638:a05:137:165:0:3:bdf8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DBBC061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 07:01:11 -0700 (PDT)
Received: from mx2.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id C26626000055
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 16:01:07 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx2.uni-regensburg.de (Postfix) with ESMTP id AE5EB6000054
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 16:01:07 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Fri, 02 Jul 2021 16:01:07 +0200
Message-Id: <60DF1C22020000A100042225@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.3.1 
Date:   Fri, 02 Jul 2021 16:01:06 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: bug in "git fsck"?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!


I was wondering whether git fsck should be able to cleanup orphaned branches ("HEAD points to an unborn branch") as described in https://stackoverflow.com/q/68226081/6607497
It seems I can fix it be editing files in the repository, but I feed that's not the way it should be.


Regards,
Ulrich

