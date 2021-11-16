Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C44C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 08:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B037B61929
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 08:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhKPIo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 03:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhKPIoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 03:44:25 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6673BC061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 00:41:28 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Htffr42b3z1rk4w;
        Tue, 16 Nov 2021 09:41:24 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4Htffr3T8nz1qqkB;
        Tue, 16 Nov 2021 09:41:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id zyUSK8HdN6y2; Tue, 16 Nov 2021 09:41:23 +0100 (CET)
X-Auth-Info: 8c5DZUcfvgnCbUKdlAlN1q2g7hGWh4AVoPbmsg+lEkt/zyLnD5FJg1Fzqim7VSa9
Received: from igel.home (ppp-46-244-181-163.dynamic.mnet-online.de [46.244.181.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 16 Nov 2021 09:41:23 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id BE81B2C1833; Tue, 16 Nov 2021 09:41:22 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Hamza Mahfooz <someguy@effective-light.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii
 patterns and UTF-8 data
References: <20211015161356.3372-1-someguy@effective-light.com>
        <20211015161356.3372-3-someguy@effective-light.com>
        <877dd9i1zj.fsf@igel.home>
        <211115.86fsrxqbvp.gmgdl@evledraar.gmail.com>
X-Yow:  Youth of today!  Join me in a mass rally for traditional mental
 attitudes!
Date:   Tue, 16 Nov 2021 09:41:22 +0100
In-Reply-To: <211115.86fsrxqbvp.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 15 Nov 2021 23:41:27 +0100")
Message-ID: <87o86kv6fh.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Nov 15 2021, Ævar Arnfjörð Bjarmason wrote:

> What PCREv2 version are you using?

10.31

https://build.opensuse.org/package/show/openSUSE:Leap:15.3:Update/pcre2

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
