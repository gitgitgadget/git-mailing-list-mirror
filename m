Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A461CC433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 22:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72FAA65253
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 22:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhCHV7d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 16:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhCHV7G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 16:59:06 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C362C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 13:59:03 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DvXKx0M87z1rwDY;
        Mon,  8 Mar 2021 22:59:01 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DvXKw73Znz1qqkQ;
        Mon,  8 Mar 2021 22:59:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id NTC-pj6uM-g0; Mon,  8 Mar 2021 22:59:00 +0100 (CET)
X-Auth-Info: jDMsmPCMUw08M5MfZar1usPch2+1liV5XDZolA/ltkUygcEqL2jKr7u2p4Urw5Rj
Received: from igel.home (ppp-46-244-182-153.dynamic.mnet-online.de [46.244.182.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  8 Mar 2021 22:59:00 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id A5A1F2C37BC; Mon,  8 Mar 2021 22:58:59 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Fabien Terrani <terranifabien@gmail.com>, git@vger.kernel.org
Subject: Re: remote.<name>.merge missing from the git-config man page?
References: <CAOuwed4HJLTgk48Fre5vGYjYanqD6hu8yZM73CpcAmF1ajiTnA@mail.gmail.com>
        <xmqqlfax7dya.fsf@gitster.c.googlers.com>
        <YEZwY0721KvQNkK+@nand.local> <87pn092yja.fsf@igel.home>
        <YEaI5JIobsbtBQO1@nand.local> <87lfax2xat.fsf@igel.home>
        <YEaM7ruZCvaQQbPI@nand.local> <87h7ll2wiz.fsf@igel.home>
        <YEaRw5x5hnh9RRyM@nand.local>
X-Yow:  What UNIVERSE is this, please??
Date:   Mon, 08 Mar 2021 22:58:59 +0100
In-Reply-To: <YEaRw5x5hnh9RRyM@nand.local> (Taylor Blau's message of "Mon, 8
        Mar 2021 16:06:11 -0500")
Message-ID: <87a6rd2tp8.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mär 08 2021, Taylor Blau wrote:

> On Mon, Mar 08, 2021 at 09:57:56PM +0100, Andreas Schwab wrote:
>> The configured upstream is the value of branch.<name>.merge, isn't it?
>> That would be the name of a remote, not the name of a branch.
>
> Right; the '<name>' in 'branch.<name>.merge' is your local name for a
> branch, but the value of that configuration is the remote's name.

Sorry, I was misreading branch.<name>.merge as branch.<name>.remote.
Now it makes all sense to me.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
