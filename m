Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A534FC35666
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 18:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88353206ED
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 18:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgBVSAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 13:00:49 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:51110 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgBVSAt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Feb 2020 13:00:49 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 48Px2P48Skz1qql7;
        Sat, 22 Feb 2020 19:00:45 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 48Px2P3bfJz1r0cB;
        Sat, 22 Feb 2020 19:00:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id LQnj3r6L4IQZ; Sat, 22 Feb 2020 19:00:44 +0100 (CET)
X-Auth-Info: 9OZkZW8CplNMrwlOh944FpGP/4uRIIj1VFOUPJYvvorqwQIru4/qLi0Qxwkv+C+U
Received: from igel.home (ppp-46-244-176-159.dynamic.mnet-online.de [46.244.176.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 22 Feb 2020 19:00:44 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 0034B2C28FB; Sat, 22 Feb 2020 19:00:43 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
Subject: Re: Getting clean diff data from git-mailinfo
References: <20200221171312.xyzsrvebuwiw6pgj@chatter.i7.local>
        <xmqqk14e7emp.fsf@gitster-ct.c.googlers.com>
        <xmqqftf27e8n.fsf@gitster-ct.c.googlers.com>
X-Yow:  NOW, I'm supposed to SCRAMBLE two, and HOLD th' MAYO!!
Date:   Sat, 22 Feb 2020 19:00:43 +0100
In-Reply-To: <xmqqftf27e8n.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 22 Feb 2020 08:56:08 -0800")
Message-ID: <87sgj2fqno.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Feb 22 2020, Junio C Hamano wrote:

> *1* Even when people edit without changing the line numbers (imagine
>     a typofix on a '+' line), I saw that "patch" mode of Emacs broke
>     the line count on "@@ ...@@" line of the last hunk when the
>     patch ends with certain patterns.

For example, when followed by the "-- " signature of git format-patch,
as that makes the output ambiguous.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
