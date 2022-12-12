Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CC7C4167B
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 00:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiLLAiK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Dec 2022 19:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLLAiI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2022 19:38:08 -0500
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0891AE64
        for <git@vger.kernel.org>; Sun, 11 Dec 2022 16:38:06 -0800 (PST)
Date:   Mon, 12 Dec 2022 00:38:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1670805483; x=1671064683;
        bh=W1hkwugiZLoHzsgutA2yKwQsUssXPziLqj9uu3klYgw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Uy2kczSPpKOBytbfTKW0HnIwk0uqINvIXDVEOxLxF8OS8iLBjRS1kLDe5rsyCzT/Z
         1Tlpx8i7eKmJD7MEp93CugZNUavVCji0w62xiqygUP9W0aXQTMyoRakU3C6KSrEK6h
         9UOYsdM8LSHwaJAttvtzAZzt0RsJaF5+tIjw6x+N/+n+MLWHBRNBk0jG9StyyOAiPY
         CFyeb9ElqAaW1d1F75PK3wO9kB5L7f3E3tX3R0s8khMzrsRabuyr0kh4+VChJt59S5
         uN8VkqsKrtkPZGyeRSsogacPziihmiKBWaqoGHPYL2VuSRucokhOa0R9Ak08BYXuOG
         KBty7tItQKxSw==
To:     rsbecker@nexbridge.com
From:   'Jacob Abel' <jacobabel@nullpo.dev>
Cc:     =?utf-8?Q?=27=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason=27?= 
        <avarab@gmail.com>, 'Eric Sunshine' <sunshine@sunshineco.com>,
        'Phillip Wood' <phillip.wood123@gmail.com>,
        =?utf-8?Q?=27Rub=C3=A9n_Justo=27?= <rjusto@gmail.com>,
        'Taylor Blau' <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] worktree: Support `--orphan` when creating new worktrees
Message-ID: <20221212003509.t4pucrlxxl5htj62@phi>
In-Reply-To: <007001d90b50$8ee3c000$acab4000$@nexbridge.com>
References: <20221208214110.bdu5n65c3fvcxjom@phi> <007001d90b50$8ee3c000$acab4000$@nexbridge.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/12/08 05:00PM, rsbecker@nexbridge.com wrote:
>
> I am not sure this is entirely related, but there is a gap in worktree
> configuration, specifically includeIf that I was working on, but suspende=
d
> waiting for worktree code to stabilize. Do you have a sense as to whether=
 this
> might run into this topic?
>
> Regards,
> Randall

I may be mistaken as I'm still pretty new with respect to contributing to g=
it
but I don't believe the two should conflict.

