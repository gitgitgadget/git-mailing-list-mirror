Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C380FC77B75
	for <git@archiver.kernel.org>; Mon, 15 May 2023 19:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244334AbjEOTw1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 15:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242842AbjEOTw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 15:52:26 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9A4DDBD
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:52:25 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E0A51F6BA9;
        Mon, 15 May 2023 15:52:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=73e5soWGDqL9dUo+cNJgp1ZzGK+xRAu4asbItB
        anNTU=; b=tEJcTQ7b1Yl84TqQUtezfwTTssw+DetPLdI+uxOilCSUAqIFMSAS8M
        BqHnBbcQyPfSEIGZ6vnZ8apeP8tzH1mTjn+PenSUWVY7IdlcmL7xA13/cqg9vvTd
        t+t1Hf2A0dXRZ84b+KqDtrADR+ihScnv9P7i0SGlEpv4Jq/IWOfj4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 25CFA1F6BA8;
        Mon, 15 May 2023 15:52:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 57BB01F6BA7;
        Mon, 15 May 2023 15:52:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Sean Allred <code@seanallred.com>
Subject: Re: [PATCH v3 3/6] ls-remote doc: remove redundant --tags example
References: <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
        <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
        <8b644fb12038ccaf8967fb04d73c0fe94bd004bb.1684152793.git.gitgitgadget@gmail.com>
Date:   Mon, 15 May 2023 12:52:21 -0700
In-Reply-To: <8b644fb12038ccaf8967fb04d73c0fe94bd004bb.1684152793.git.gitgitgadget@gmail.com>
        (Sean Allred via GitGitGadget's message of "Mon, 15 May 2023 12:13:10
        +0000")
Message-ID: <xmqqpm718j9m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01F4757A-F35A-11ED-A67A-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sean Allred via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sean Allred <allred.sean@gmail.com>
>
> The --tags option is already demonstrated in the later example that
> lists version-patterned tags. As it doesn't appear to add anything to
> the documentation, it ought to be removed to keep the documentation
> easier to read.
>
> Signed-off-by: Sean Allred <allred.sean@gmail.com>
> ---
>  Documentation/git-ls-remote.txt | 7 -------
>  1 file changed, 7 deletions(-)

I like deletions ;-)  Thanks.
