Return-Path: <SRS0=YD5J=2F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1570CC43603
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 05:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE942072B
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 05:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="pSAmTw0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfLOFdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Dec 2019 00:33:31 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:47693 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfLOFd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Dec 2019 00:33:28 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 47bCjy4xdtz9sR4; Sun, 15 Dec 2019 16:33:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1576388006; bh=gfInR29rSM8ebgkjkdxM134ivf5E8s7GLS76TX1YjFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pSAmTw0v0kt67dmSjWn/ZHMPrVdDQLjKiUMD9NbhTKmCZ3+IrwOs7bMGNuPly+ODa
         FQHR3SbIHGyLUhGxB4Zu+S3aK4qKXm4/FY6Se+oBX93kgWlDQBSYjogvQlATvbIl1g
         3z/KvxfH7sL1zaLBQRmCMnik8TDVauNwJefc2tlq+xAAHmN3eflK4lf6I9ecdYaY7m
         8pBLpkTcU/VnQCe9xUm6aPscxiM9CgBz7vgHOV6do0D3OMX3iqSmt4COUtvlmt1mBU
         rzrpIx7EgDmF1P7yUYQVa9lIYT77ZMqZta2zeF8NqqpjPh5Cjj1HJAmy+sI57JYbV8
         /6u/ViaBa+jDA==
Date:   Sun, 15 Dec 2019 16:33:04 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Eric Huber via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Huber <echuber2@illinois.edu>
Subject: Re: [PATCH 1/1] gitk: Preserve window dimensions on exit when not
 using ttk themes
Message-ID: <20191215053304.GF12512@blackberry>
References: <pull.389.git.1571098396.gitgitgadget@gmail.com>
 <364976a833e33696e983bbdd9c1e7974480c1397.1571098396.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <364976a833e33696e983bbdd9c1e7974480c1397.1571098396.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 15, 2019 at 12:13:16AM +0000, Eric Huber via GitGitGadget wrote:
> From: Eric Huber <echuber2@illinois.edu>
> 
> Bug was: gitk would overwrite the botwidth setting in .gitk with
> a nonsense value when not using tk themes. I'm not sure if this
> is the right fix or not but it seems to work. Moving the affected
> line within the conditional results in the expected behavior.
> 
> Signed-off-by: Eric Huber <echuber2@illinois.edu>

Thanks, patch applied.

Paul.
