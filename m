Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A12C47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 18:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B4FE613B8
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 18:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhFCSax (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 14:30:53 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:43062 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFCSax (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 14:30:53 -0400
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Jun 2021 14:30:53 EDT
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4FwvNS0TY7z1qtQl;
        Thu,  3 Jun 2021 20:21:12 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4FwvNS006lz1qqkT;
        Thu,  3 Jun 2021 20:21:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id E8I2xNfYuRHS; Thu,  3 Jun 2021 20:21:10 +0200 (CEST)
X-Auth-Info: zCsVgKe+JZZzNpAtnWgDDc/EWip9AGjyzAGGYsnITJwJfDQzXVO0aIH/ARqoZbne
Received: from igel.home (ppp-46-244-161-251.dynamic.mnet-online.de [46.244.161.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu,  3 Jun 2021 20:21:10 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 38D142C3706; Thu,  3 Jun 2021 20:21:10 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Gmail OAuth2 in git send-email
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
        <YLhx7nIptHUwXfBD@google.com> <878s3r73g3.fsf@evledraar.gmail.com>
        <60b9158f92812_258801208e0@natae.notmuch>
X-Yow:  Look DEEP into the OPENINGS!!  Do you see any ELVES or EDSELS...
 or a HIGHBALL??...
Date:   Thu, 03 Jun 2021 20:21:10 +0200
In-Reply-To: <60b9158f92812_258801208e0@natae.notmuch> (Felipe Contreras's
        message of "Thu, 03 Jun 2021 12:46:55 -0500")
Message-ID: <874keeyfl5.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jun 03 2021, Felipe Contreras wrote:

> If Google requires a client secret, then it can't be used with open
> source applications. Period.

https://invent.kde.org/pim/kmailtransport/-/blob/master/src/kmailtransport/plugins/smtp/smtpjob.cpp#L31

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
