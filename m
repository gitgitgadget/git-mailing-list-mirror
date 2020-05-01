Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD4FC47254
	for <git@archiver.kernel.org>; Fri,  1 May 2020 07:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C066214D8
	for <git@archiver.kernel.org>; Fri,  1 May 2020 07:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgEAHTY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 03:19:24 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:47610 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgEAHTY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 03:19:24 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49D3XS5MKmz1qs0P;
        Fri,  1 May 2020 09:19:20 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49D3XS4xxvz1qtwj;
        Fri,  1 May 2020 09:19:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 1u6ZrjPomd-P; Fri,  1 May 2020 09:19:19 +0200 (CEST)
X-Auth-Info: mckycLnhp9wSRS1GEx0sZ7n+AbjROswZktVb7w/YLgQIfrXUhRTvC5NiCZCLTjIO
Received: from hase.home (ppp-46-244-191-54.dynamic.mnet-online.de [46.244.191.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri,  1 May 2020 09:19:19 +0200 (CEST)
Received: by hase.home (Postfix, from userid 1000)
        id 980EA1024DF; Fri,  1 May 2020 09:19:18 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, douglas.fuller@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] gitcredentials(7): clarify quoting of helper examples
References: <20200501061917.GC23665@coredump.intra.peff.net>
        <20200501062039.GA25603@coredump.intra.peff.net>
X-Yow:  I hope you millionaires are having fun!  I just invested half
 your life savings in yeast!!
Date:   Fri, 01 May 2020 09:19:18 +0200
In-Reply-To: <20200501062039.GA25603@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 1 May 2020 02:20:39 -0400")
Message-ID: <87tv10i0ll.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mai 01 2020, Jeff King wrote:

>  # or you can specify your own shell snippet
> -!f() { echo "password=`cat $HOME/.secret`"; }; f
> +[credential]
> +helper = "!f() { echo password=$(cat $HOME/.secret); }; f"

That now lacks a pair of quotes around the argument of echo.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
