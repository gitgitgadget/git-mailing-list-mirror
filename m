Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADC2C4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 11:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 066C02075A
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 11:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgJGLNj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 07:13:39 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:43595 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgJGLNj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 07:13:39 -0400
X-Originating-IP: 103.82.80.10
Received: from localhost (unknown [103.82.80.10])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 9EDE840005;
        Wed,  7 Oct 2020 11:13:36 +0000 (UTC)
Date:   Wed, 7 Oct 2020 16:43:33 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Serg Tereshchenko <serg.partizan@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-gui: Basic dark mode support
Message-ID: <20201007111333.iojf5dbwoxbnie3z@yadavpratyush.com>
References: <20200824154835.160749-1-serg.partizan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824154835.160749-1-serg.partizan@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/08/20 06:48PM, Serg Tereshchenko wrote:
> Hi all.
> 
> I want to use dark themes with git citool, and here is my first attempt
> to do so.
> 
> I am new to tcl, so i happily accept any tips on how to improve code.
> 
> First things first: to properly support colors, would be nice to have
> them separated from app code, so i created new file lib/colored.tcl. Name
> is selected to be consistent with "lib/themed.tcl".
> 
> Then, i extract hardcoded colors from git-gui.sh into namespace Color.
> Then, if option use_ttk is true, i update default colors for
> background/foreground from current theme.
> 
> How it was looking before:
>  - Dark theme (awdark): https://i.imgur.com/0lrfHyq.png
>  - Light theme (clam): https://i.imgur.com/1fsfayJ.png
> 
> Now looks like this:
>  - Dark theme (awdark): https://i.imgur.com/BISllEH.png
>  - Light theme (clam): https://i.imgur.com/WclSTa4.png

How do you tell git-gui which theme to use? I had some trouble setting 
the theme and ended up adding code to source the theme files and then 
set the theme via `ttk::style theme use`. I hope there is a better way 
than that.

-- 
Regards,
Pratyush Yadav
