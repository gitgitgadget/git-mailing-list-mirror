Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B876FC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 21:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239327AbiG2Vbe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 17:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiG2Vbd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 17:31:33 -0400
X-Greylist: delayed 143339 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 29 Jul 2022 14:31:31 PDT
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08055B04C
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 14:31:31 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4Lvggf3m4tz5tlB;
        Fri, 29 Jul 2022 23:31:26 +0200 (CEST)
Message-ID: <c9aec5b6-0a78-a580-3658-5189bd2075a6@kdbg.org>
Date:   Fri, 29 Jul 2022 23:31:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mingw: include the Python parts in the build
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1306.git.1659016906707.gitgitgadget@gmail.com>
 <xmqqczdpcfhx.fsf@gitster.g> <0s3o2pr2-o0q3-q394-83n3-n117355o8o29@tzk.qr>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <0s3o2pr2-o0q3-q394-83n3-n117355o8o29@tzk.qr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.07.22 um 16:29 schrieb Johannes Schindelin:
> Now, I vaguely remember that j6t said that they switched to MSYS2 some
> time ago, but all I found on the Git mailing list was
> https://lore.kernel.org/git/6c2bbca7-7a8f-d3d8-04b6-31494a3e1b43@kdbg.org/
> which says that in 2017, MSys1 was still used by the person who apart from
> myself did the most crucial work to support Git on Windows (and that
> counts a lot in my book, so in this instance I am willing to bear a bit
> more maintenance burden than I otherwise would for a single person, even
> if the Windows-specific part of `config.mak.uname` is quite messy, I
> admit).
> 
> Hannes, do you still build with MSys1?

Thank you for keeping me in the loop. No, I have long since switched to
the Git for Windows tool set, i.e., MSYS2 + MinGW64. I don't know if
anybody is still using MSys1 + MinGW. There's likely no reason to keep
the MSys1 config section.

-- Hannes
