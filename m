Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 742D81F404
	for <e@80x24.org>; Sat,  3 Feb 2018 19:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbeBCTvW (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Feb 2018 14:51:22 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:35249 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752414AbeBCTvU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Feb 2018 14:51:20 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3zYkxf2n6Pz1qsh9;
        Sat,  3 Feb 2018 20:51:18 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3zYkxf2RrMz1qqkK;
        Sat,  3 Feb 2018 20:51:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id kw_IPe4DOioB; Sat,  3 Feb 2018 20:51:17 +0100 (CET)
X-Auth-Info: 8rDHTB7f21jxyMS1oQbqsXktkjUujkclJOraJiOtl9mBtIWtWM2t1HPPQllrD1MY
Received: from localhost (ppp-188-174-153-77.dynamic.mnet-online.de [188.174.153.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat,  3 Feb 2018 20:51:17 +0100 (CET)
Received: by localhost (Postfix, from userid 1000)
        id 1DBD62C3C1E; Sat,  3 Feb 2018 20:51:17 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: contrib/completion/git-completion.bash: declare -g is not portable
References: <1e618c0c-81ba-fa7e-8039-748bdfa5a6d9@web.de>
X-Yow:  YOW!!  The land of the rising SONY!!
Date:   Sat, 03 Feb 2018 20:51:16 +0100
In-Reply-To: <1e618c0c-81ba-fa7e-8039-748bdfa5a6d9@web.de> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Sat, 3 Feb 2018 18:20:18
 +0100")
Message-ID: <87lgg9g8cr.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Feb 03 2018, Torsten Bögershausen <tboegi@web.de> wrote:

> What is "declare -g" good for ?

      -g        create global variables when used in a shell function; otherwise
                ignored

    When used in a function, `declare' makes NAMEs local, as with the `local'
    command.  The `-g' option suppresses this behavior.
    
Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
