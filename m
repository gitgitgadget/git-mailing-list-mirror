Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 431611F45F
	for <e@80x24.org>; Mon,  6 May 2019 07:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfEFHOX (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 03:14:23 -0400
Received: from mx1.uni-regensburg.de ([194.94.157.146]:43852 "EHLO
        mx1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfEFHOW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 03:14:22 -0400
Received: from mx1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id DC17C6000051
        for <git@vger.kernel.org>; Mon,  6 May 2019 09:14:20 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx1.uni-regensburg.de (Postfix) with ESMTP id C281E6000050
        for <git@vger.kernel.org>; Mon,  6 May 2019 09:14:20 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Mon, 06 May 2019 09:14:20 +0200
Message-Id: <5CCFDECB020000A1000310EC@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.1.1 
Date:   Mon, 06 May 2019 09:14:19 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     "Andreas Schwab" <schwab@linux-m68k.org>
Cc:     <git@vger.kernel.org>
Subject: Antw: Re: Surprising semantics of "git add file"
References: <5CCF414A020000A10003108C@gwsmtp.uni-regensburg.de><5CCF414A020000A10003108C@gwsmtp.uni-regensburg.de>
 (Ulrich Windl's message of "Sun, 05 May 2019 22:02:18 +0200")
 <87o94gbq46.fsf@igel.home>
In-Reply-To: <87o94gbq46.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> Andreas Schwab <schwab@linux-m68k.org> schrieb am 05.05.2019 um 22:31 in
Nachricht <87o94gbq46.fsf@igel.home>:
> On Mai 05 2019, "Ulrich Windl" <Ulrich.Windl@rz.uni‑regensburg.de> wrote:
> 
>> After that a "git diff ‑‑cached file" just shows the changes added 
> interactively, but when I "git add file" to commit those changes), even the

> unstaged changes from file are committed.
> 
> Did you really mean "git add" here?  It doesn't commit, it adds to the 
> index.

Sorry, you are right "git commit file" I meant. I guess I was distracted when
writing that. Otherwise it wouldn't make any sense.

> 
> Andreas.
> 
> ‑‑ 
> Andreas Schwab, schwab@linux‑m68k.org 
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."



