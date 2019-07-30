Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57CDF1F462
	for <e@80x24.org>; Tue, 30 Jul 2019 06:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbfG3GwO (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 02:52:14 -0400
Received: from mx1.uni-regensburg.de ([194.94.157.146]:40388 "EHLO
        mx1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbfG3GwO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 02:52:14 -0400
Received: from mx1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 64314600004E
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 08:52:11 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx1.uni-regensburg.de (Postfix) with ESMTP id 50658600004D
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 08:52:11 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Tue, 30 Jul 2019 08:52:11 +0200
Message-Id: <5D3FE919020000A100032932@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.1.1 
Date:   Tue, 30 Jul 2019 08:52:09 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:     <git@vger.kernel.org>
Subject: Re: Antw: Re: blank lines in pre-created merge message
References: <5D382AC1020000A100032608@gwsmtp.uni-regensburg.de>
 <nycvar.QRO.7.76.6.1907251204310.21907@tvgsbejvaqbjf.bet>
 <5D39812C020000A10003265F@gwsmtp.uni-regensburg.de>
 <nycvar.QRO.7.76.6.1907251355500.21907@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1907251355500.21907@tvgsbejvaqbjf.bet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> schrieb am 25.07.2019 um
13:58
in Nachricht <nycvar.QRO.7.76.6.1907251355500.21907@tvgsbejvaqbjf.bet>:
> Hi Ulrich,
> 
> On Thu, 25 Jul 2019, Ulrich Windl wrote:
> 
>> >>> Johannes Schindelin <Johannes.Schindelin@gmx.de> schrieb am 25.07.2019
um
>> 12:07
>> in Nachricht <nycvar.QRO.7.76.6.1907251204310.21907@tvgsbejvaqbjf.bet>:
>> >
>> > On Wed, 24 Jul 2019, Ulrich Windl wrote:
>> >
>> >> When using "git merge ‑‑no‑ff ‑‑no‑commit ..", the pre‑created
>> >> merge message always contains two empty lines in between the
>> >> comment lines. However if there was a merge conflict (being
>> >> resolved) an extra blank line is added after the fiVrst line.
>>
>> [...]
> 
>> Could anybody provide a rough overview how and where these editor
>> comments are created?
> 
> The best bet would be to call `git grep` with text in that pre‑created
> merge message, preferably some text that is most likely fixed, i.e. that
> does not depend on the current worktree/commit.
> 
> If you give me an example of such a merge message, I can provide you
> with the appropriate `git grep` call and the code locations to touch.

Hi!

Sorry for the delay:
OK, here is an example where the auto-generated comment has two blank lines:
---snip---
Merge branch 'shared'
#
# It looks like you may be committing a merge.
# If this is not correct, please remove the file
#       .git/MERGE_HEAD
# and try again.


# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
# On branch master
# All conflicts fixed but you are still merging.
#
# Changes to be committed:
#       new file:   .filelist
#       new file:   .gitignore
...more lines omitted
---snip---

> 
> Ciao,
> Johannes



