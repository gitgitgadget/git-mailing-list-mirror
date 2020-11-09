Return-Path: <SRS0=J6fK=EP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C599C2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 09:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C31E02080C
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 09:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgKIJt0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 04:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgKIJt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 04:49:26 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E0EC0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 01:49:26 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4CV5my74Ngz1rwb5;
        Mon,  9 Nov 2020 10:49:22 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4CV5my6fBDz1qy68;
        Mon,  9 Nov 2020 10:49:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id hGa_R8C4vLfe; Mon,  9 Nov 2020 10:49:22 +0100 (CET)
X-Auth-Info: OY9J02wu1rP8vnZul4KKehDGF4tHUKmLvqQKSA3lNjkRO6AkzX29JU4jCgBr9bU+
Received: from igel.home (ppp-46-244-183-237.dynamic.mnet-online.de [46.244.183.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  9 Nov 2020 10:49:22 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id B277E2C3606; Mon,  9 Nov 2020 10:49:21 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: git gc ineffective
References: <20201109092041.GV29778@kitsune.suse.cz>
X-Yow:  ..  I want a COLOR T.V. and a VIBRATING BED!!!
Date:   Mon, 09 Nov 2020 10:49:21 +0100
In-Reply-To: <20201109092041.GV29778@kitsune.suse.cz> ("Michal =?utf-8?Q?S?=
 =?utf-8?Q?uch=C3=A1nek=22's?=
        message of "Mon, 9 Nov 2020 10:20:41 +0100")
Message-ID: <87361ilv1a.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Nov 09 2020, Michal Suchánek wrote:

> I noticed I am running out of disk space, and one repository taking up
> about 38G. Did git gc --aggressive, and the used space *raised* to 42G,
> and git would report it does gc after every commit.

Do you have a lot of loose objects?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
