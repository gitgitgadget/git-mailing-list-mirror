Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA97C07E98
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 07:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ECF3613E1
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 07:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhGEHMs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 03:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhGEHMr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 03:12:47 -0400
Received: from mx1.uni-regensburg.de (mx1.uni-regensburg.de [IPv6:2001:638:a05:137:165:0:3:bdf7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149BFC061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 00:10:11 -0700 (PDT)
Received: from mx1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id E9F56600004E
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 09:10:04 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx1.uni-regensburg.de (Postfix) with ESMTP id B729D600004D
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 09:10:04 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Mon, 05 Jul 2021 09:10:05 +0200
Message-Id: <60E2B04B020000A100042291@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.3.1 
Date:   Mon, 05 Jul 2021 09:10:03 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
Subject: Antw: [EXT] Re: bug in "git fsck"?
References: <60DF1C22020000A100042225@gwsmtp.uni-regensburg.de><60DF1C22020000A100042225@gwsmtp.uni-regensburg.de>
 (Ulrich Windl's message of "Fri, 02 Jul 2021 16:01:06 +0200")
 <xmqqczs0popg.fsf@gitster.g>
In-Reply-To: <xmqqczs0popg.fsf@gitster.g>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> Junio C Hamano <gitster@pobox.com> schrieb am 02.07.2021 um 20:15 in
Nachricht
<xmqqczs0popg.fsf@gitster.g>:
> "Ulrich Windl" <Ulrich.Windl@rz.uni‑regensburg.de> writes:
> 
>> I was wondering whether git fsck should be able to cleanup
>> orphaned branches ("HEAD points to an unborn branch") as described
>> in https://stackoverflow.com/q/68226081/6607497 It seems I can fix
>> it be editing files in the repository, but I feed that's not the
>> way it should be.
> 
> HEAD pointing at an unborn branch is not even a corruption, isn't
> it?
> 
>    $ rm ‑rf trash && git init trash
> 
> would point HEAD at an unborn one, ready to be used.


OK, so maybe I was just confused by "fsck". At it seems after committing, fsck
no longer complains.
As "EXTRACTED DIAGNOSTICS" In man git-fsck (Git 2.26.2) does not mention
"unborn" (and as it's not a common IT phrase), one could probably explain what
it means.

Regards,
Ulrich



