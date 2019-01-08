Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C21AF1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 17:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfAHRny (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 12:43:54 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:58925 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbfAHRny (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 12:43:54 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43Z0482LFLz1qvvd;
        Tue,  8 Jan 2019 18:43:52 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43Z0481z3jz1qsn4;
        Tue,  8 Jan 2019 18:43:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id IUxvc-ayPs1F; Tue,  8 Jan 2019 18:43:51 +0100 (CET)
X-Auth-Info: J5S4MhpE1RJ/PN39Ys8Hf3rM5vAgOg3SCCywyQGhMU7LCBiqinx3sgNQY6hvAZw3
Received: from igel.home (ppp-188-174-153-44.dynamic.mnet-online.de [188.174.153.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  8 Jan 2019 18:43:51 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id A050F2C12E6; Tue,  8 Jan 2019 18:43:50 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Markus Wiederkehr <markus.wiederkehr@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git rebase: retain original head?
References: <CA+h-Bnuf6u=hkPBcxhMm06FbfkS+jtrozu+inqqmUY1cNkXrWQ@mail.gmail.com>
X-Yow:  I'm having an emotional outburst!!
Date:   Tue, 08 Jan 2019 18:43:50 +0100
In-Reply-To: <CA+h-Bnuf6u=hkPBcxhMm06FbfkS+jtrozu+inqqmUY1cNkXrWQ@mail.gmail.com>
        (Markus Wiederkehr's message of "Tue, 8 Jan 2019 16:06:06 +0100")
Message-ID: <87va2zavu1.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jan 08 2019, Markus Wiederkehr <markus.wiederkehr@gmail.com> wrote:

> During the rebase operation the original head seems to get stored in
> 'rebase-merge/orig-head'. Unfortunately this references gets removed
> after the rebase operation completes.
>
> Would it be possible to retain this information?

You could use the reflog of the current branch, where it is the second
entry.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
