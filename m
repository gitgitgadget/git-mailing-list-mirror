Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A8AB20954
	for <e@80x24.org>; Mon,  4 Dec 2017 15:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbdLDP5g convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 4 Dec 2017 10:57:36 -0500
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:56753 "EHLO
        rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752303AbdLDP5V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 10:57:21 -0500
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 78C4E5D4A4
        for <git@vger.kernel.org>; Mon,  4 Dec 2017 16:57:18 +0100 (CET)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by rrzmta1.uni-regensburg.de (Postfix) with ESMTP id 61D3F5D443
        for <git@vger.kernel.org>; Mon,  4 Dec 2017 16:57:18 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
        with Novell_GroupWise; Mon, 04 Dec 2017 16:57:18 +0100
Message-Id: <5A25705C020000A1000292B0@gwsmtp1.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date:   Mon, 04 Dec 2017 16:57:16 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <philipoakley@iee.org>, <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
Subject: Antw: Re: bug deleting "unmerged" branch (2.12.3)
References: <5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de><5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de><xmqqtvxd6gu9.fsf@gitster.mtv.corp.google.com><5A1E70AA020000A100029175@gwsmtp1.uni-regensburg.de><7973FF5C21C64E6492828DD0B91F5AF7@PhilipOakley>
 <xmqq1skcleo7.fsf@gitster.mtv.corp.google.com>
 <AB9C836772CD4391A8866DC71103CCFE@PhilipOakley>
In-Reply-To: <AB9C836772CD4391A8866DC71103CCFE@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Philip!

I'm unsure what you are asking for...

Ulrich
>>> "Philip Oakley" <philipoakley@iee.org> 04.12.17 0.30 Uhr >>>
From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> I think it was that currently you are on M, and neither A nor B are
>> ancestors (i.e. merged) of M.
>>
>> As Junio said:- "branch -d" protects branches that are yet to be
>> merged to the **current branch**.
>
> Actually, I think people loosened this over time and removal of
> branch X is not rejected even if the range HEAD..X is not empty, as
> long as X is marked to integrate with/build on something else with
> branch.X.{remote,merge} and the range X@{upstream}..X is empty.
>
> So the stress of "current branch" above you added is a bit of a
> white lie.

Ah, thanks. [I haven't had chance to check the code]

The man page does say:
.    -d
.    Delete a branch. The branch must be fully merged in its upstream
.    branch, or in HEAD if no upstream was set with --track 
.    or --set-upstream.

It's whether or not Ulrich had joined the two aspects together, and if the
doc was sufficient to help recognise the 'unmerged' issue. Ulrich?
--
Philip


