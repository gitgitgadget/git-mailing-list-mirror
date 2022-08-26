Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B699ECAAA3
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 07:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245009AbiHZHSL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 03:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244989AbiHZHSI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 03:18:08 -0400
X-Greylist: delayed 520 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Aug 2022 00:18:04 PDT
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D9AC277C
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 00:18:04 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4MDWD02Sphz1s88p;
        Fri, 26 Aug 2022 09:09:20 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4MDWD02Fw6z1qqkC;
        Fri, 26 Aug 2022 09:09:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Ibhmvx8Dw46r; Fri, 26 Aug 2022 09:09:18 +0200 (CEST)
X-Auth-Info: U/b7ngLQSnQz1l/W60zlNFPF4jKz3zFzBD/Sbs9KMKPyM66nqGAayK1uSx/yXJAn
Received: from tiger.home (ppp-46-244-178-84.dynamic.mnet-online.de [46.244.178.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 26 Aug 2022 09:09:18 +0200 (CEST)
Received: by tiger.home (Postfix, from userid 1000)
        id E4CE0112DD3; Fri, 26 Aug 2022 09:09:17 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Javier Mora <cousteaulecommandant@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Potential problems with url.<base>.insteadOf
References: <CAH1-q0iPsnkypiF=2LRgXwNqE_+R0gj706FCKgqGEUum+OAhQg@mail.gmail.com>
X-Yow:  I'm having a MID-WEEK CRISIS!
Date:   Fri, 26 Aug 2022 09:09:17 +0200
In-Reply-To: <CAH1-q0iPsnkypiF=2LRgXwNqE_+R0gj706FCKgqGEUum+OAhQg@mail.gmail.com>
        (Javier Mora's message of "Fri, 26 Aug 2022 01:47:08 +0200")
Message-ID: <87a67rjxb6.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Aug 26 2022, Javier Mora wrote:

> Well, now I have a problem.  If I do:
>
> git config url.'http://example.com/'.insteadOf 'http://example.org/'
> git config url.'http://example.com/'.insteadOf 'http://example.net/'

git config --add url.'http://example.com/'.insteadOf 'http://example.net/'

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
