Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87F9C432BE
	for <git@archiver.kernel.org>; Sun, 29 Aug 2021 23:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EFBE60551
	for <git@archiver.kernel.org>; Sun, 29 Aug 2021 23:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbhH2X5g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 19:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhH2X5f (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 19:57:35 -0400
Received: from tilde.club (unknown [IPv6:2607:5300:61:c67::196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105FDC061575
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 16:56:43 -0700 (PDT)
Received: from tilde.club (unknown [185.100.87.72])
        by tilde.club (Postfix) with ESMTPSA id D45AF2208B756;
        Sun, 29 Aug 2021 23:56:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 tilde.club D45AF2208B756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tilde.club; s=mail;
        t=1630281400; bh=xWR5k/K8uYVF1Q2uaekHDmG8q2XjSg9l1/NgChUA9FQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wf20E8u4M5COjI+sokNOPdFZfF5CK1DXz8UNzicZhqJT8BrfKYGOirPAC882GLGy0
         2BZWiwxaapC/9kdATI7Qvo1TiQXJ4inPAEDKpEcO26HUVEblsKIlkoEGvpngDqR7Ls
         tr4+vIElZ3wH8r6mOWVRpsfsMBgxDBRHPkQvefbs=
Date:   Sun, 29 Aug 2021 23:56:18 +0000
From:   Gwyneth Morgan <gwymor@tilde.club>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v7 0/9] ssh signing: Add commit & tag
 signing/verification via SSH keys using ssh-keygen
Message-ID: <YSweouO5B4gD3XLB@tilde.club>
References: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
 <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
 <xmqqczpv99u4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqczpv99u4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-08-29 15:15:15-0700, Junio C Hamano wrote:
> The previous rounds saw enough reviews and responses, but this round
> didn't.  Usually no response means no interest from the community,
> but let's see if somebody other than the author actually tried the
> feature, and and want to tell us about their experience, either
> positive or negative?

I've been using this feature (including this round) on and off and I've
been happy with it. I ran into a small bug in an earlier version which
has since been fixed, but other than that I haven't had any issues. The
setup and use is all pretty easy.

Admittedly, I haven't been daily-driving this feature, as I didn't want
to put SSH-signed commits in repositories in case the format changes in
the future.
