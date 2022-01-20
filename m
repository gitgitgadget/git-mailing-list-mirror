Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9290DC433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 12:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242356AbiATM2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 07:28:21 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:51627 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242299AbiATM2M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 07:28:12 -0500
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Jan 2022 07:28:12 EST
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4JfhP71GgZz1sFFc;
        Thu, 20 Jan 2022 13:18:19 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4JfhP70xwXz1qqkB;
        Thu, 20 Jan 2022 13:18:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id k3Hpp8tPFgPl; Thu, 20 Jan 2022 13:18:18 +0100 (CET)
X-Auth-Info: ew88vRU0xm1EZmFqAPzWKEN2f18ongAKh8UJV/d5mYVIvq3IAa5gVZRzrMxxLQsg
Received: from igel.home (ppp-46-244-187-247.dynamic.mnet-online.de [46.244.187.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 20 Jan 2022 13:18:18 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id D9ABC2C3953; Thu, 20 Jan 2022 13:18:17 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch,checkout: fix --track usage strings
References: <220111.86a6g3yqf9.gmgdl@evledraar.gmail.com>
        <3de40324bea6a1dd9bca2654721471e3809e87d8.1642538935.git.steadmon@google.com>
        <220120.86zgnqli9v.gmgdl@evledraar.gmail.com>
X-Yow:  ..  I don't understand the HUMOR of the THREE STOOGES!!
Date:   Thu, 20 Jan 2022 13:18:17 +0100
In-Reply-To: <220120.86zgnqli9v.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 20 Jan 2022 13:05:52 +0100")
Message-ID: <877dauy512.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jan 20 2022, Ævar Arnfjörð Bjarmason wrote:

> With that we'll now emit:
>     
>     $ ./git add -h 2>&1|grep chmod
>         --chmod[=](+|-)x      override the executable bit of the listed files

That looks like --chmod+x is valid, which isn't.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
