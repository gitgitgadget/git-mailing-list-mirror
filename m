Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467BDEB64DC
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 16:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjGQQfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 12:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGQQfP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 12:35:15 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FF91B6
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 09:35:12 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4R4SNr4Myvz1sJQr
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 18:35:08 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 4R4SNr451qz1qqlS
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 18:35:08 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id H79ByscKNWkd for <git@vger.kernel.org>;
 Mon, 17 Jul 2023 18:35:08 +0200 (CEST)
X-Auth-Info: noJlr5Ehh4Rp7mO72byw1eDamttHjYfg7Adxo2fuBVUyA6zzPYE262zISFqZGYsA
Received: from igel.home (aftr-62-216-205-205.dynamic.mnet-online.de [62.216.205.205])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 18:35:07 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id AA2CF2C1380; Mon, 17 Jul 2023 18:35:07 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Pressing Ctrl-C during 'git checkout <branch-name>' messes up
 the repository
In-Reply-To: <20230717091849.z7bvqbygbpg4sluk@carbon> (Konstantin Khomoutov's
        message of "Mon, 17 Jul 2023 12:18:49 +0300")
References: <ZLM4sTUjBQt4QMfG@tapette.crustytoothpaste.net>
        <20230717091849.z7bvqbygbpg4sluk@carbon>
X-Yow:  Can you MAIL a BEAN CAKE?
Date:   Mon, 17 Jul 2023 18:35:07 +0200
Message-ID: <87bkgalcn8.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jul 17 2023, Konstantin Khomoutov wrote:

> Just a fun remark: that "INT" in SIGINT stands for "INTeractive attention",

Do you have a source for that?  The oldest manpage for signal(2)
available at man.freebsd.org describes it as "interrupt".

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
