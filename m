Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D4C81F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 13:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388673AbfJANrE (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 09:47:04 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:34127 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfJANrD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 09:47:03 -0400
X-Originating-IP: 1.186.12.44
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 492DCFF804;
        Tue,  1 Oct 2019 13:47:01 +0000 (UTC)
Date:   Tue, 1 Oct 2019 19:16:54 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Thomas Klaeger via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Klaeger <thklaeger@gmail.com>
Subject: Re: [PATCH 1/1] git-gui (Windows): use git-bash.exe if it is
 available
Message-ID: <20191001134654.vpiygrpczegynfis@yadavpratyush.com>
References: <pull.360.git.gitgitgadget@gmail.com>
 <414cf2c89876fe122ee18f8d6533f083c2f65654.1569519977.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <414cf2c89876fe122ee18f8d6533f083c2f65654.1569519977.git.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/09/19 10:46AM, Thomas Klaeger via GitGitGadget wrote:
> From: Thomas Klaeger <thklaeger@gmail.com>
> 
> Git for Windows 2.x ships with an executable that starts the Git Bash
> with all the environment variables and what not properly set up. It is
> also adjusted according to the Terminal emulator option chosen when
> installing Git for Windows (while `bash.exe --login -i` would always
> launch with Windows' default console).
> 
> So let's use that executable (usually C:\Program Files\Git\git-bash.exe)
> instead of `bash.exe --login -i` if its presence was detected.
> 
> This fixes https://github.com/git-for-windows/git/issues/490
> 
> Signed-off-by: Thomas Kläger <thomas.klaeger@10a.ch>

While applying the patch, my patch check script complained that the 
author did not sign off.

Well, they did... but with a slightly different name (Kläger vs  
Klaeger) and a completely different email address.

I'm not sure if I can do something about it, just thought it was 
something worth mentioning.

-- 
Regards,
Pratyush Yadav
