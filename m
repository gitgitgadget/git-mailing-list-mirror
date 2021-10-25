Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CE8C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 08:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58EB960EE9
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 08:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhJYI1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 04:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbhJYI1H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 04:27:07 -0400
Received: from mackerel.carobme.de (unknown [IPv6:2a01:4f8:1c1c:4990::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C73C061220
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 01:24:44 -0700 (PDT)
Received: from mail.carobme.de (p57a9a54f.dip0.t-ipconnect.de [87.169.165.79])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: mrelay)
        by mackerel.carobme.de (Postfix) with ESMTPSA id 4Hd7Kk2JQPzFTYc
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 10:24:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eaddrinuse.net;
        s=thorn; t=1635150282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xRiR4pTwlQU7vB2XYKwbSfPEYvUaOp92rTl4B8J0ZmU=;
        b=TgIOkbypatPDnViu/yzzxzkxozwkc4RQZEuuvZ1qq8bLPkV8LW/PPUzyTEIBBPYXHu5nSW
        Y9BrpaTgVclqlWAtzavTtiLROoWMZ6yM8UFz3cP9xdY5VDA8696R2AoZQtIvKf2hvJD7Qf
        3OClLAhryVvlpIv11qdlX4zgwd6lGPR0NAGeb7nALShv/nS8qYx5iGfSpAH2EE1fUC8y/t
        7R+2s73Lz99P6alsoJ02F3VfyOjUn9fKWrsASVc9oRuV+HHRVcBCDDPxHckGwi2r9k8zU1
        5aV2sutBszj6Pzus3z45dcl1DKzws/D4J8dXIu5mN2BKF93mU1sPa3nH/ZGrog==
Received: from octopus.int.carobme.de (octopus.int.carobme.de [192.168.78.3])
        by mail.carobme.de (Postfix) with ESMTP id 4Hd7Kj6ChtzXRVd
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 10:24:41 +0200 (CEST)
Received: from mbeck (uid 1000)
        (envelope-from mbeck@eaddrinuse.net)
        id 7e228a
        by octopus.int.carobme.de (DragonFly Mail Agent v0.11+);
        Mon, 25 Oct 2021 10:24:41 +0200
Date:   Mon, 25 Oct 2021 10:24:41 +0200
From:   Marco Beck <mbeck@eaddrinuse.net>
To:     git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: allow selecting key id with env variable
Message-ID: <YXZpyWesc8VRWYwr@octopus.int.carobme.de>
References: <20211024193625.148-1-mbeck@eaddrinuse.net>
 <xmqqsfwq40w7.fsf@gitster.g>
 <YXXMroOBvDERXIMP@octopus.int.carobme.de>
 <8661a491-5ef1-a469-878f-7dd81d4a1aa2@gigacodes.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <8661a491-5ef1-a469-878f-7dd81d4a1aa2@gigacodes.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 25, 2021 at 09:31:33AM +0200, Fabian Stelzer wrote:

>[includeIf "gitdir:~/projects/work/"]
>  path = ".gitconfig.work"

Yeah, that's what I added to my config recently just for signing key
selection. I'm using direnv[1] for some time now to switch between
different "profiles" (more than just Git settings) by just setting
some environment variables and it was nice to have everything in one
place. That's why I disliked adding the includeIf to my .gitconfig.

Thanks anyway,
Marco

[1] https://direnv.net/
