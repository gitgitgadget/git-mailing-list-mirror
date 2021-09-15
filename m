Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172D5C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE75E611C4
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhIOSJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:09:16 -0400
Received: from mout02.posteo.de ([185.67.36.66]:47031 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230215AbhIOSJM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 14:09:12 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 33930240109
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 20:07:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1631729270; bh=xGUsjWsmy+ABy0r0IkGiP0EjNeYqcaYuUkyBXN8E1y8=;
        h=Subject:To:Cc:From:Date:From;
        b=fYay6vHi/XB9MsGWRHg0A7Lpmzup2Fyb3PLkfQt4nBzGl/s5Bpr0lI7NZVCiX9Xum
         UmpJw3RL7MRBf3HyOqhpzQXL/7d8xNKmtOwMMJtnVcBXrH9SMdFoee0t1EbWAxkoXm
         +K6v2G81R0EEDIdHddOxpgmKAFEs6tMLGg2X42j/aRxl+4s54f9xOhxtxIHdJv0luu
         JdT4gelYocWh9Zj+S/+Q44RyNFDAIioW5DUuBEN4kQ4QWKfCpfFWcP4r7QgcT8TAMk
         qrTdxfDg6c5mhzF/4Mq9dCxUlS6l/6rgON0ecd2dacQtfcL3YWCtmmtj08QT3a+YnF
         qbl/2/IArNjUg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4H8p915SHKz6tm4;
        Wed, 15 Sep 2021 20:07:49 +0200 (CEST)
Subject: Re: [PATCH] send-email: Avoid incorrect header propagation
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <20210830153001.29961-1-mhaeuser@posteo.de>
 <0c753ae6-cc2c-2d70-c510-5370a0b4dcf9@posteo.de>
 <87o88tn2z5.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Marvin_H=c3=a4user?= <mhaeuser@posteo.de>
Message-ID: <155e591f-3b85-1819-0e46-017e3bbedef0@posteo.de>
Date:   Wed, 15 Sep 2021 18:07:49 +0000
MIME-Version: 1.0
In-Reply-To: <87o88tn2z5.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,

Sorry, I'm used to getting Reviewed-by mails from other lists. I will 
check more carefully next time. :)
Thanks for the merge and the links!

Best regards,
Marvin

On 15/09/2021 19:47, Ævar Arnfjörð Bjarmason wrote:
> On Wed, Sep 15 2021, Marvin Häuser wrote:
>
>> Ping? :)
> Hi there. The patch you sent has been picked up after you sent it and
> has now been merged to the master branch of git.git. See
> https://github.com/git/git/commit/bd29bcf9136 and your commit at
> https://github.com/git/git/commit/e0821134846
>
> This means it'll be in the next release, v2.34, set to come out
> mid-to-late November.
>
> Thanks a lot for contributing to git, for future submissions you can
> keep an eye on the What's Cooking summaries that get sent out to the
> list, for your patch see:
> https://lore.kernel.org/git/?q=%22send-email%3A+avoid+incorrect+header+propagation%22

