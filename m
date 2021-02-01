Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88B4C433E6
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 16:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9302264E24
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 16:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhBAQmq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 11:42:46 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:35007 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhBAQmo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 11:42:44 -0500
Received: from localhost (unknown [103.82.80.85])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id B02F3100004;
        Mon,  1 Feb 2021 16:42:01 +0000 (UTC)
Date:   Mon, 1 Feb 2021 22:11:58 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Hongyi Zhao <hongyi.zhao@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: The error subcommand given by git tab completion.
Message-ID: <20210201164158.q35j6zniuebspqx2@yadavpratyush.com>
References: <CAGP6POLQ_6cZHh0UCaavNBL7+FcMEX8bwb=VxvNMtmO0ZSCPwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGP6POLQ_6cZHh0UCaavNBL7+FcMEX8bwb=VxvNMtmO0ZSCPwg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/02/21 11:15PM, Hongyi Zhao wrote:
> On Ubuntu 20.04, the `git TAB' will give me the following available subcommands:
> 
> $ git TAB
> add               deborig           merge             rm
> am                describe          mergetool         send-email
> apply             diff              mv                shortlog
> archive           difftool          notes             show
> bisect            fetch             pull              show-branch
> blame             format-patch      push              sparse-checkout
> branch            fsck              range-diff        stage
> bundle            gc                rebase            stash
> checkout          gitk              reflog            status
> cherry            grep              remote            submodule
> cherry-pick       gui               repack            switch
> citool            help              replace           tag
> clean             init              request-pull      whatchanged
> clone             instaweb          reset             worktree
> commit            latexdiff         restore
> config            log               revert
> 
> Then I try the following:
> 
> $ git gui
> git: 'gui' is not a git command. See 'git --help'.
> 
> The most similar commands are
>     gc
>     grep
>     init
>     pull
>     push
> 
> The git version is shown as below:
> 
> $ git --version
> git version 2.25.1
> 
> As you can see, gui is among the auto-completed subcommands list, but
> it can be run like the manner of other subcommands. Any hints for this
> problem?

Do you have git-gui installed? Some distros (like Ubuntu IIRC) don't 
ship git-gui by default and you have to install it separately.
 
> Regards
> -- 
> Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
> Theory and Simulation of Materials
> Hebei Polytechnic University of Science and Technology engineering
> NO. 552 North Gangtie Road, Xingtai, China

-- 
Regards,
Pratyush Yadav
