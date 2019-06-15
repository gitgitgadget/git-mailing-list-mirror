Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80C4F1F462
	for <e@80x24.org>; Sat, 15 Jun 2019 07:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfFOH1n (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jun 2019 03:27:43 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:58853 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfFOH1n (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jun 2019 03:27:43 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 45QpwD6JH2z1rXv5;
        Sat, 15 Jun 2019 09:27:40 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 45QpwD63Xgz1qqkq;
        Sat, 15 Jun 2019 09:27:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id wQwxHZJpBxVw; Sat, 15 Jun 2019 09:27:40 +0200 (CEST)
X-Auth-Info: wnV1ERS9Tj7CUuB30YlfHMTxHtrp99nf7wcdHUkL9h4P72xycpSNBdj1BzTYaxch
Received: from linux.local (ppp-46-244-181-62.dynamic.mnet-online.de [46.244.181.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 15 Jun 2019 09:27:40 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
        id 3E20B1E5466; Sat, 15 Jun 2019 09:27:36 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Deadname rewriting
References: <CABURp0poUjSBTTFUXP8dAmJ=37qvpe64=o+t_+mHOiK9Cv+=kg@mail.gmail.com>
X-Yow:  My CODE of ETHICS is vacationing at famed SCHROON LAKE
 in upstate New York!!
Date:   Sat, 15 Jun 2019 09:27:36 +0200
In-Reply-To: <CABURp0poUjSBTTFUXP8dAmJ=37qvpe64=o+t_+mHOiK9Cv+=kg@mail.gmail.com>
        (Phil Hord's message of "Fri, 14 Jun 2019 18:54:26 -0700")
Message-ID: <m27e9nux3r.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jun 14 2019, Phil Hord <phil.hord@gmail.com> wrote:

> It feels like `.git/info/grafts` would work the best if it could be
> distributed with the project, but I'm pretty sure that's a non-starter
> for many reasons.

The graft file is obsoleted by git replace.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
