Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8A3620958
	for <e@80x24.org>; Wed, 29 Mar 2017 18:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932316AbdC2Sn5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 14:43:57 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:40037 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932201AbdC2Sn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 14:43:56 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3vtc9P2RPWz1qql5;
        Wed, 29 Mar 2017 20:43:53 +0200 (CEST)
Received: from localhost (dynscan01.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3vtc9P1qkPz3jgZ0;
        Wed, 29 Mar 2017 20:43:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan01.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id AeRlmMzYjB92; Wed, 29 Mar 2017 20:43:52 +0200 (CEST)
X-Auth-Info: 6eJEvSJOHdMBKJ/XDngUjxtuGy33cUsQx+D3sR3F+eWI74fFlmD42/auzD/53Gc6
Received: from igel.home (ppp-88-217-19-158.dynamic.mnet-online.de [88.217.19.158])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 29 Mar 2017 20:43:52 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 14BD22C3DF2; Wed, 29 Mar 2017 20:43:52 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Eyal Lotem <eyal.lotem@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: BUG: Renaming a branch checked out in a different work tree
References: <CALA94fPqm5UnYBwqZ5fDJ=DL_9EaZeRfqHB5ZzUQt11FSz4ZMA@mail.gmail.com>
X-Yow:  ..The TENSION mounts as I MASSAGE your RIGHT ANKLE according to
 ancient Tibetan ACCOUNTING PROCEDURES..are you NEUROTIC yet??
Date:   Wed, 29 Mar 2017 20:43:52 +0200
In-Reply-To: <CALA94fPqm5UnYBwqZ5fDJ=DL_9EaZeRfqHB5ZzUQt11FSz4ZMA@mail.gmail.com>
        (Eyal Lotem's message of "Wed, 29 Mar 2017 21:02:10 +0300")
Message-ID: <87d1czditz.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mär 29 2017, Eyal Lotem <eyal.lotem@gmail.com> wrote:

> git version: 2.7.4
> installed from Ubuntu repos:
> Ubuntu Version: 1:2.7.4-0ubuntu1
>
> When renaming a branch checked out in a different work tree, that work
> tree's state is corrupted. Git status in that work tree then reports
> itself being on the "initial commit" with all files being in the
> staging area.

Fixed since 2.8.3.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
