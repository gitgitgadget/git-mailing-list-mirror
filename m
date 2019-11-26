Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C74C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 21:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8742084D
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 21:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfKZVYf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 16:24:35 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:32865 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfKZVYe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 16:24:34 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 47Mxk80bFkz1qql3;
        Tue, 26 Nov 2019 22:24:32 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 47Mxk80J7Zz1qql2;
        Tue, 26 Nov 2019 22:24:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id gWgMFx53gJ0y; Tue, 26 Nov 2019 22:24:31 +0100 (CET)
X-Auth-Info: fwaoQMDdXY424FL5+NdHl5afZZblEHcHW1LgGFhzEbq4JoPRhm5YawuPOLZOjwdn
Received: from igel.home (ppp-46-244-161-164.dynamic.mnet-online.de [46.244.161.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 26 Nov 2019 22:24:31 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 180C92C017B; Tue, 26 Nov 2019 22:24:30 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Marketa Calabkova <mcalabkova@suse.cz>, git@vger.kernel.org
Subject: Re: Failing tests on s390x and aarch64 architectures
References: <2d7f373f-5cf5-a956-53d7-1e67ba157e9d@suse.cz>
        <94b6452d-9888-a129-78f9-38eb0f03eea3@suse.cz>
        <CAPUEsph-sP79ov0DoTj9vfhFeD_dt=FpPWgk78syX+qKeVBT3Q@mail.gmail.com>
X-Yow:  Yow!  I'm UNEMPLOYED!
Date:   Tue, 26 Nov 2019 22:24:30 +0100
In-Reply-To: <CAPUEsph-sP79ov0DoTj9vfhFeD_dt=FpPWgk78syX+qKeVBT3Q@mail.gmail.com>
        (Carlo Arenas's message of "Wed, 27 Nov 2019 02:09:50 +0700")
Message-ID: <87ftial4a9.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Nov 27 2019, Carlo Arenas wrote:

> is this failing only in factory? couldn't find any failing logs going
> through the links in the original email but while I don't have
> OpenSUSE with me right now, I hadn't been able to reproduce the
> problem with an aarch64 chromebook and its emulated Linux runtime
> (based on Debian 9)

The test only fails if pcre2 was configured without JIT.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
