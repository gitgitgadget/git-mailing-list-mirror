Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 434E71F404
	for <e@80x24.org>; Mon, 16 Apr 2018 16:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbeDPQZK (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 12:25:10 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:52168 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeDPQZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 12:25:09 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 40PtyW6p6Qz1qvCY;
        Mon, 16 Apr 2018 18:25:07 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 40PtyW5gwRz1qqkx;
        Mon, 16 Apr 2018 18:25:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id manq3m5ppx7Y; Mon, 16 Apr 2018 18:25:07 +0200 (CEST)
X-Auth-Info: +GiOSBzf/H4ETi+N0zIP42/xTASgdQoTc4diNZjPF7VA2EgLSZ+3EzK6aAkaSx0N
Received: from localhost (ppp-188-174-148-193.dynamic.mnet-online.de [188.174.148.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 16 Apr 2018 18:25:07 +0200 (CEST)
Received: by localhost (Postfix, from userid 1000)
        id ABA842C069F; Mon, 16 Apr 2018 18:25:06 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Marko Vasic <vasic@utexas.edu>
Cc:     git@vger.kernel.org
Subject: Re: Git Bash Completion Not Working In Emacs
References: <CALH-0NbMxkQewnrr6S_xtyVH0BrC2J6gpB5r-hx8=PpekP1VKw@mail.gmail.com>
X-Yow:  NOT fucking!! Also not a PACKAGE of LOOSE-LEAF PAPER!!
Date:   Mon, 16 Apr 2018 18:25:06 +0200
In-Reply-To: <CALH-0NbMxkQewnrr6S_xtyVH0BrC2J6gpB5r-hx8=PpekP1VKw@mail.gmail.com>
        (Marko Vasic's message of "Mon, 16 Apr 2018 10:44:41 -0500")
Message-ID: <87tvsb5db1.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Apr 16 2018, Marko Vasic <vasic@utexas.edu> wrote:

> Git bash completion script works perfectly under the terminal,
> however, it does not work in Emacs (neither shell nor gui mode). Did
> anyone encounter this issues and how can it be solved?

Depend on how you run the command in Emacs.  If you use M-x shell then
Emacs handles special keys like TAB itself (and the started shell
usually disables its own command line editing).  If you use M-x term
then Emacs emulates a terminal and lets the running process handle all
special keys.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
