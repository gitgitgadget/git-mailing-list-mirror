Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8CFC7EE23
	for <git@archiver.kernel.org>; Tue,  2 May 2023 05:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjEBFsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 01:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjEBFsO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 01:48:14 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11261FC2
        for <git@vger.kernel.org>; Mon,  1 May 2023 22:48:11 -0700 (PDT)
Date:   Tue, 02 May 2023 05:48:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1683006489; x=1683265689;
        bh=10/4DXyBe68seKbDPl3I7gpBI5TuKKGGWOooTjHoYiE=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=sj0TUOD17MLlW1pcWKU8kpMDCyFytsP1G2il0rG/JB9+fBIDixUw8oHP0wkxc69Wi
         s+wlQ57hVlQxS2tZAL52mZZNcuMNFBEkM0oTdneGoBS+hHszgS4xUqEmmgrk86Vkhe
         SAKlgqjbGfDwlMAAAi3v7EUb23n3wOlgkIaXyfbfzkNB0/DuFCc3XgzigF5EiPzORf
         Zk8f/xIGDxlDXtdZJcRnR5GVfDxrS6sU+velEM+m2WbBGinIxkun6Y+eIBaMs3tz+V
         KyCD1TPd49UEIm7Ji1tOkQbIG8x8R6QxxlY+MR4g/Qa4MmBvrCRsl5s241g3/Kbotf
         InhP26Q6wcaJw==
To:     Junio C Hamano <gitster@pobox.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v9 0/8] worktree: Support `--orphan` when creating new worktrees
Message-ID: <m7crhly2j3k76whydbtdwhvzghvoql436g3lqtst4v3ahv75aa@wq5zjepgrxz5>
In-Reply-To: <xmqqcz3j4t68.fsf@gitster.g>
References: <20230417093255.31079-1-jacobabel@nullpo.dev> <wk2wpftowc7wqeaqrylxq7eci4bkmuffwu75h4qugxulcgsk2b@gw6ouq3g5g2j> <xmqqcz3j4t68.fsf@gitster.g>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/05/01 02:51PM, Junio C Hamano wrote:
> Jacob Abel <jacobabel@nullpo.dev> writes:
> > [...]
>
> Once the thread is broken, it is broken.  You gave a link in the
> message I am responding to, to make it easier for people to go back
> to earlier iterations and that is good enough, I think.

Understood.

>
> Your eventual v10 can be sent with its cover set as a reply to the
> cover of v9 and we will be fine.
>
> It seems that we may need another iteration, but if I reclal
> correctly what remains are all minor issues?
>
> Thanks.

Based on the feedback so far yes. However I have yet to get any reviews
on patches 5/8 through 8/8 for this revision so it's unclear to me if
they were fine/didn't require any changes or if they just weren't
reviewed yet?

Also I have yet to hear anything back about whether to keep patches
7/8 and 8/8 in this patchset or break them out into their own followup
patchset (original note about this was in the cover letter [1]).

1. https://lore.kernel.org/git/20230417093255.31079-1-jacobabel@nullpo.dev/

