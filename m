Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47558C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 09:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27778206D5
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 09:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgFHJt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 05:49:59 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:51137 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbgFHJt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 05:49:59 -0400
X-Originating-IP: 157.36.94.170
Received: from localhost (unknown [157.36.94.170])
        (Authenticated sender: me@yadavpratyush.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 103701BF20B;
        Mon,  8 Jun 2020 09:49:55 +0000 (UTC)
Date:   Mon, 8 Jun 2020 15:19:51 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     sunlin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunlin <sunlin7@yahoo.com>,
        "lin.sun" <lin.sun@zoom.us>
Subject: Re: [PATCH] Enable auto-merge for meld to follow the vim-diff
 beharior
Message-ID: <20200608094951.pu2fz3kxaj37tk46@yadavpratyush.com>
References: <pull.781.git.git.1588901124066.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.781.git.git.1588901124066.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lin,

I'm not familiar with the code so I'll let someone else comment on that. 
But...

On 08/05/20 01:25AM, sunlin via GitGitGadget wrote:
> From: "lin.sun" <lin.sun@zoom.us>
> 
> The mergetool "meld" does NOT merge the no-conflict changes, while the
> mergetool "vimdiff" will merge the no-conflict parts and highlight the
> conflict parts.
> This patch will make the mergetool "meld" similar to "vimdiff",
> auto-merge the no-conflict parts, highlight conflict parts.
> 
> Signed-off-by: Lin Sun <sunlin7@yahoo.com>

... your name and email in "From:" and "Signed-off-by:" should be the 
same. So either use "lin.sun" <lin.sun@zoom.us> in both places or use 
Lin Sun <sunlin7@yahoo.com> in both.

-- 
Regards,
Pratyush Yadav
