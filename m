Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A93F1FCA9
	for <e@80x24.org>; Sun, 11 Sep 2016 19:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756408AbcIKTex (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 15:34:53 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:48202 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756197AbcIKTex (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 15:34:53 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3sXLk20XMTz3hjg7;
        Sun, 11 Sep 2016 21:34:50 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 3sXLk20KKZzvkTp;
        Sun, 11 Sep 2016 21:34:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
        with ESMTP id L8WudrEGIjYv; Sun, 11 Sep 2016 21:34:49 +0200 (CEST)
X-Auth-Info: ijGEWwOdV8fHcvUeA2IJKGlfC5TmtamEkdABSu7pFhBHmD0y3Swu5jrY+kvxB236
Received: from igel.home (ppp-88-217-19-108.dynamic.mnet-online.de [88.217.19.108])
        by mail.mnet-online.de (Postfix) with ESMTPA;
        Sun, 11 Sep 2016 21:34:49 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id D58662C3910; Sun, 11 Sep 2016 21:34:48 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Bug: git-add .* errors out
References: <CAFZEwPPSiy1dxZgxWg1saPcw2QWgHtZKx26oSN3g1mCv25=0AA@mail.gmail.com>
X-Yow:  I just had a NOSE JOB!!
Date:   Sun, 11 Sep 2016 21:34:48 +0200
In-Reply-To: <CAFZEwPPSiy1dxZgxWg1saPcw2QWgHtZKx26oSN3g1mCv25=0AA@mail.gmail.com>
        (Pranit Bauva's message of "Mon, 12 Sep 2016 00:40:27 +0530")
Message-ID: <87h99m8c2v.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sep 12 2016, Pranit Bauva <pranit.bauva@gmail.com> wrote:

> One of my friend was trying to add files using the command `git add
> .*` and got an error that "fatal: ..: '..' is outside repository"
> which did seem a little obvious to me. But then I tried to reproduce
> it in my machine with `git add ".*"` and it didn't error out.

Probably you were running it in a subdirectory.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
