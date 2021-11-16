Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1871AC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A5A63227
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhKPJ6X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:58:23 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:58619 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbhKPJ6S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 04:58:18 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4HthJ74xYWz1qwH3;
        Tue, 16 Nov 2021 10:55:19 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4HthJ74Rn9z1qqkG;
        Tue, 16 Nov 2021 10:55:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 0SEjYnldEAEB; Tue, 16 Nov 2021 10:55:19 +0100 (CET)
X-Auth-Info: n07yr6ijbf0R9uPzjG0UKuglr0gnf9nlC+wnlsPpxqKCbp34H3vZOYqn3X7dEJeQ
Received: from igel.home (ppp-46-244-181-163.dynamic.mnet-online.de [46.244.181.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 16 Nov 2021 10:55:18 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 705C92C24FD; Tue, 16 Nov 2021 10:55:18 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Hamza Mahfooz <someguy@effective-light.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii
 patterns and UTF-8 data
References: <20211015161356.3372-1-someguy@effective-light.com>
        <20211015161356.3372-3-someguy@effective-light.com>
        <877dd9i1zj.fsf@igel.home>
        <211115.86fsrxqbvp.gmgdl@evledraar.gmail.com>
        <87o86kv6fh.fsf@igel.home>
        <CAPUEspi=r9EsG8KPvdiD-HM7Drq8ho1yjkN_c_T1e+ZeR4eejg@mail.gmail.com>
        <87fsrwv46h.fsf@igel.home>
        <CAPUEspg8ZUdn+KFz35yG1k9bbfVTe1b+7=+WdMknRS1zu8VcDQ@mail.gmail.com>
X-Yow:  Are you selling NYLON OIL WELLS??  If so, we can use TWO DOZEN!!
Date:   Tue, 16 Nov 2021 10:55:18 +0100
In-Reply-To: <CAPUEspg8ZUdn+KFz35yG1k9bbfVTe1b+7=+WdMknRS1zu8VcDQ@mail.gmail.com>
        (Carlo Arenas's message of "Tue, 16 Nov 2021 01:38:13 -0800")
Message-ID: <87bl2kv309.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Nov 16 2021, Carlo Arenas wrote:

> Reverting this specific commit might fix it and is unlikely to
> introduce other issues, did you try it?

Yes, of course.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
