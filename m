Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA800C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 14:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC9686136F
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 14:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbhJDOkt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 10:40:49 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:47915 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbhJDOkt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 10:40:49 -0400
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Oct 2021 10:40:48 EDT
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4HNNSj020Yz1r0Ph;
        Mon,  4 Oct 2021 16:31:33 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4HNNSh6vwlz1qqkC;
        Mon,  4 Oct 2021 16:31:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id fRGto5SidFL7; Mon,  4 Oct 2021 16:31:32 +0200 (CEST)
X-Auth-Info: 64nhZbuRI0PrUWIY5iZ1qU9v4vGpLaDXTL/gsvMmr45pk2F5SXkrNjG5FaiUjkeh
Received: from igel.home (ppp-46-244-163-69.dynamic.mnet-online.de [46.244.163.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  4 Oct 2021 16:31:32 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id E52782C17A1; Mon,  4 Oct 2021 16:31:31 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     git@vger.kernel.org
Subject: Re: git send-email splits name with comma
References: <CAMuHMdXuTqUu6-b0y6VSFbEz7HKdH6U+__n7B8JRnO_ZWNeeLQ@mail.gmail.com>
X-Yow:  Is there something I should be DOING with a GLAZED DONUT??
Date:   Mon, 04 Oct 2021 16:31:31 +0200
In-Reply-To: <CAMuHMdXuTqUu6-b0y6VSFbEz7HKdH6U+__n7B8JRnO_ZWNeeLQ@mail.gmail.com>
        (Geert Uytterhoeven's message of "Mon, 4 Oct 2021 16:11:04 +0200")
Message-ID: <87r1d0svy4.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Okt 04 2021, Geert Uytterhoeven wrote:

> If the name of an email address contains a comma, it will be split
> incorrectly into multiple addresses.

If you want to include a comma in the display-name part of an address,
you need to use the quoted-string form of the phrase.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
