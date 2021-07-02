Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471E8C11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 10:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE736113B
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 10:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhGBKNe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 06:13:34 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:48929 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhGBKNe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 06:13:34 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4GGW7R0JZJz1qtQC;
        Fri,  2 Jul 2021 12:10:59 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4GGW7Q702Dz1qwYg;
        Fri,  2 Jul 2021 12:10:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id RlCHS93ybSpN; Fri,  2 Jul 2021 12:10:58 +0200 (CEST)
X-Auth-Info: dtcA2BmyPUYYm2N9yq+YlwGZA5mczubPu6mVBWlfqu1M32VOxT/tGwmkaOAk9RDm
Received: from igel.home (ppp-46-244-180-78.dynamic.mnet-online.de [46.244.180.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri,  2 Jul 2021 12:10:58 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id BCEA42C1C67; Fri,  2 Jul 2021 12:10:57 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] config: add default aliases
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
        <20210702100506.1422429-6-felipe.contreras@gmail.com>
X-Yow:  I'm having BEAUTIFUL THOUGHTS about the INSIPID WIVES
 of smug and wealthy CORPORATE LAWYERS..
Date:   Fri, 02 Jul 2021 12:10:57 +0200
In-Reply-To: <20210702100506.1422429-6-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Fri, 2 Jul 2021 05:05:06 -0500")
Message-ID: <871r8hauvi.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jul 02 2021, Felipe Contreras wrote:

> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 340c5fbb48..32b1fdba45 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -17,6 +17,10 @@ SYNOPSIS
>  	   [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]
>  	   [--] [<pathspec>...]
>  
> +ALIAS
> +~~~~~
> +'git co'

That's `checkout' in hg, bzr, svn and cvs.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
