Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88736C4332F
	for <git@archiver.kernel.org>; Sun, 18 Dec 2022 10:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiLRKZ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Dec 2022 05:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiLRKZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2022 05:25:56 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946436552
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 02:25:53 -0800 (PST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4NZfB76J9dz1qyJB;
        Sun, 18 Dec 2022 11:25:51 +0100 (CET)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.84])
        by mail.m-online.net (Postfix) with ESMTP id 4NZfB75nKtz1qqlR;
        Sun, 18 Dec 2022 11:25:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan3.mail.m-online.net [192.168.6.84]) (amavisd-new, port 10024)
        with ESMTP id g4vKoQFM5OCp; Sun, 18 Dec 2022 11:25:50 +0100 (CET)
X-Auth-Info: qByYfRq3JAprh5VZkbPxY9wk+9biXKkj0a22E7CusK3tJ/8O7cwQWlQg4jIaiROv
Received: from tiger.home (aftr-62-216-205-197.dynamic.mnet-online.de [62.216.205.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 18 Dec 2022 11:25:50 +0100 (CET)
Received: by tiger.home (Postfix, from userid 1000)
        id 5298D1490C4; Sun, 18 Dec 2022 11:25:45 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Askar Safin <safinaskar@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: https://github.com/rust-lang/rust is not bisectable
References: <CAPnZJGABhczzs-6Pri2SAOkujJXT1+JDH9FiwdDns6=miZmvFQ@mail.gmail.com>
        <878rj6rnuo.fsf@igel.home>
        <CAPnZJGAMRY02s6UvMg7B6f=NSAgK0PJQAoftwnhXk-ufD2YknQ@mail.gmail.com>
        <20221218093734.GC3411@szeder.dev>
        <CAPnZJGBwFMPAJKj9Qa_Vv9yJWrGaNXqaNaPUSrYcjZ8J+OfLrg@mail.gmail.com>
X-Yow:  Are you guys lined up for the METHADONE PROGRAM or FOOD STAMPS??
Date:   Sun, 18 Dec 2022 11:25:45 +0100
In-Reply-To: <CAPnZJGBwFMPAJKj9Qa_Vv9yJWrGaNXqaNaPUSrYcjZ8J+OfLrg@mail.gmail.com>
        (Askar Safin's message of "Sun, 18 Dec 2022 13:03:54 +0300")
Message-ID: <87tu1tuhxy.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you are only interested in the linear part of the history you can use
--first-parent.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
