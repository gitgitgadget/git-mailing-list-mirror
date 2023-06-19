Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7308FEB64D9
	for <git@archiver.kernel.org>; Mon, 19 Jun 2023 22:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjFSWIN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jun 2023 18:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFSWIM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2023 18:08:12 -0400
X-Greylist: delayed 433 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Jun 2023 15:08:09 PDT
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDE0AF
        for <git@vger.kernel.org>; Mon, 19 Jun 2023 15:08:09 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4QlNxb6gkvz1sBq3;
        Tue, 20 Jun 2023 00:00:51 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 4QlNxb6Rg5z1qqlW;
        Tue, 20 Jun 2023 00:00:51 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id AHcJMuKTZTYD; Tue, 20 Jun 2023 00:00:51 +0200 (CEST)
X-Auth-Info: /JC8X/Yw4JMUUYYmEnGVhxN6O7Sqv1dwsA3sNIMAK+9YIZAvCd23JCqR+xwE0kDy
Received: from igel.home (aftr-62-216-205-216.dynamic.mnet-online.de [62.216.205.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 20 Jun 2023 00:00:51 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id B06B92C1DF0; Tue, 20 Jun 2023 00:00:50 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: Re: [BUG] git-web unable to show this commit properly?
In-Reply-To: <SA1PR21MB1335BD64334ABD240C23C43ABF5FA@SA1PR21MB1335.namprd21.prod.outlook.com>
        (Dexuan Cui's message of "Mon, 19 Jun 2023 21:37:21 +0000")
References: <SA1PR21MB1335BD64334ABD240C23C43ABF5FA@SA1PR21MB1335.namprd21.prod.outlook.com>
X-Yow:  Yow!  Did something bad happen or am I in a drive-in movie??
Date:   Tue, 20 Jun 2023 00:00:50 +0200
Message-ID: <87o7lb5cz1.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jun 19 2023, Dexuan Cui wrote:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/arch/x86/coco?id=122333d6bd229af279cdb35d1b874b71b3b9ccfb

That URL corresponds to this command:

git show 122333d6bd229af279cdb35d1b874b71b3b9ccfb -- arch/x86/coco

If you want to see the whole commit, use
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit?id=122333d6bd229af279cdb35d1b874b71b3b9ccfb

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
