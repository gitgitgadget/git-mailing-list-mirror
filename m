Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55CCEB64DC
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 20:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjF1Ucv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 16:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjF1Ucu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 16:32:50 -0400
X-Greylist: delayed 110 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Jun 2023 13:32:49 PDT
Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE1619B0
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 13:32:48 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4QrtYp2D24z5tl9;
        Wed, 28 Jun 2023 22:32:46 +0200 (CEST)
Message-ID: <64ebdd83-8833-44b6-ccb3-6ba630ef1958@kdbg.org>
Date:   Wed, 28 Jun 2023 22:32:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/9] gitk: improve keyboard support
Content-Language: en-US
To:     =?UTF-8?Q?Jens_Lidestr=c3=b6m?= <jens@lidestrom.se>,
        Jens Lidestrom via GitGitGadget <gitgitgadget@gmail.com>
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>, git@vger.kernel.org
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
 <0cb94aa5-726f-a57f-858c-b29764c63ce7@kdbg.org>
 <102dabfc-595b-5f85-bc2c-ed9a003cd7bd@lidestrom.se>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <102dabfc-595b-5f85-bc2c-ed9a003cd7bd@lidestrom.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.06.23 um 19:32 schrieb Jens Lideström:
> @Hannes: I choose key combinations with Ctrl+<another-key>.
> 
> Another possibility is to use Ctrl+Shift+<another-key>. That is more
> complicated to press, but it creates a nice distinction between two
> categories of commands:
> 
> Searching and navigation command (existing): Ctrl+<another-key>
> 
> Branch modification commands (new): Ctrl+Shift+<another-key>
> 
> Do you have any opinion on this? Only Ctrl, or Ctrl+Shift for the new
> commands?

I have no strong opinion, with a mild preference for the versions
without Shift, just because they are more ergonomic.

-- Hannes

