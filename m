Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CCB320248
	for <e@80x24.org>; Tue, 12 Mar 2019 17:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbfCLRYS (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 13:24:18 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:49177 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729807AbfCLRYM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 13:24:12 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44JhfJ6tb2z1r93G;
        Tue, 12 Mar 2019 18:24:08 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44JhfJ63nwz1qrvg;
        Tue, 12 Mar 2019 18:24:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id KDtkXb9z2JOn; Tue, 12 Mar 2019 18:24:07 +0100 (CET)
X-Auth-Info: 9l7ZXhmuoxTCZW1qVvn28ENjMzcH+GG33w1/846oUzcaDZQRbIQcMnQ+m3RlTfP9
Received: from igel.home (ppp-46-244-168-24.dynamic.mnet-online.de [46.244.168.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 12 Mar 2019 18:24:07 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 323CD2C1EE9; Tue, 12 Mar 2019 18:24:07 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        Elijah Newren <newren@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        vincent.guittot@linaro.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Deprecating git diff ..; dealing with other ranges
References: <20190311093751.GA31092@archbookpro.localdomain>
        <xmqqmum0h88n.fsf@gitster-ct.c.googlers.com>
X-Yow:  This is my WILLIAM BENDIX memorial CORNER where I worship William
 Bendix like a GOD!!
Date:   Tue, 12 Mar 2019 18:24:07 +0100
In-Reply-To: <xmqqmum0h88n.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 12 Mar 2019 16:17:28 +0900")
Message-ID: <87va0orop4.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mär 12 2019, Junio C Hamano <gitster@pobox.com> wrote:

> I however think it may be worth making sure that our docs do not
> encourage "diff A..B" and teach "diff A B" when comparing two
> endpoints.  That can be done without changing anything in the code.

The nice thing about "diff A..B" is that you can c&p the output from the
fetch run without the need to edit it.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
