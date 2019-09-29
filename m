Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D8091F463
	for <e@80x24.org>; Sun, 29 Sep 2019 17:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbfI2RPn (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 13:15:43 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:40001 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfI2RPm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 13:15:42 -0400
X-Originating-IP: 1.186.12.44
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 177D1FF804;
        Sun, 29 Sep 2019 17:15:39 +0000 (UTC)
Date:   Sun, 29 Sep 2019 22:45:37 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/4] git gui: set GIT_ASKPASS=git-gui--askpass if not set
 yet
Message-ID: <20190929171537.3t5f5glq2jamkpa5@yadavpratyush.com>
References: <pull.358.git.gitgitgadget@gmail.com>
 <cb9f8c8158c5a7b55ed746234624ae69a575f608.1569511793.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb9f8c8158c5a7b55ed746234624ae69a575f608.1569511793.git.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What is the difference between SSH_ASKPASS and GIT_ASKPASS? On my first 
read, I assumed SSH_ASKPASS is replaced by GIT_ASKPASS, but I might be 
wrong.

On 26/09/19 08:29AM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git-gui.sh | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 76d8139b8d..66f046a0c7 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1248,6 +1248,9 @@ set have_tk85 [expr {[package vcompare $tk_version "8.5"] >= 0}]
>  if {![info exists env(SSH_ASKPASS)]} {
>  	set env(SSH_ASKPASS) [gitexec git-gui--askpass]
>  }
> +if {![info exists env(GIT_ASKPASS)]} {
> +	set env(GIT_ASKPASS) [gitexec git-gui--askpass]
> +}
>  if {![info exists env(GIT_ASK_YESNO)]} {
>  	set env(GIT_ASK_YESNO) [gitexec git-gui--askyesno]
>  }

-- 
Regards,
Pratyush Yadav
