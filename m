Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C008C6FD18
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 03:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjDTDHD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 23:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbjDTDGY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 23:06:24 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E383E49FF
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 20:05:45 -0700 (PDT)
Date:   Thu, 20 Apr 2023 03:05:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1681959944; x=1682219144;
        bh=wcsQSYbCg1aPNQ+tDgjAiu+gTj4O+9NkA9Gw838AQKI=;
        h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=n+dENjYVlPO08iRonqrfWTDpee653D4l/4givJIVe/6bpgNFhyZ7nzDUoYpoLxP+U
         4aX0bch0h8Q6CYWky+DhrgkFLivGySSvQKKErnhReOeQ0h6g5NrXSyfPKVMvfLjycz
         X9J9FuJ8AIc5edmfetQ71ruFY+Hnj3WzeIvlAOgXSe5no+0W6cxXXFoBqYaHmGCJnN
         ess6JMdodFfUekjpchwSjGOyKMhe0b/U9lnqSZ/ZV3BQdaE45QkGmMlGS0+CSsDR+N
         CEis1wwAasg/u++ysbM/hhR7loO+oDJeK6B9mT4qjUhAG5hYjbidf7qwgc5tNmULmB
         dUHsm5pdMLoDg==
To:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
From:   Jacob Abel <jacobabel@nullpo.dev>
Subject: Re: [PATCH v9 0/8] worktree: Support `--orphan` when creating new worktrees
Message-ID: <wk2wpftowc7wqeaqrylxq7eci4bkmuffwu75h4qugxulcgsk2b@gw6ouq3g5g2j>
In-Reply-To: <20230417093255.31079-1-jacobabel@nullpo.dev>
References: <20230417093255.31079-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/04/17 09:33AM, Jacob Abel wrote:
>
> [...]

I've noticed on the lore that this revision didn't continue the existing
thread[1] for the patchset. It seems this is because the `In-Reply-To`
header was stripped from the message due to a bug with the MTA/mail bridge
I use on my dev machine [2].

Apologies for any confusion this may have caused.

For continuity purposes I can either:

A. RESEND the revision to the main thread with a note in the cover letter
tagging the discussions from this thread so far.

B. Reply to [1] in the main thread to point to this thread and then
eventually publish v10 in reply to that reply message in the main thread.

C. Reply to [1] in the main thread to point to this thread and then
eventually publish v10 in reply to this cover letter.

Let me know which would be the least disruptive/most ideal way forward or
if there is another way I should approach this.

Thanks.

1. https://lore.kernel.org/git/20230109173227.29264-1-jacobabel@nullpo.dev/
2. https://github.com/ProtonMail/proton-bridge/issues/374

