Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05BFC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 01:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245712AbiBPBzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 20:55:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiBPBzg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 20:55:36 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5DEFABD7
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 17:55:25 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 49F77174BFC;
        Tue, 15 Feb 2022 20:55:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PrXdc0N2ZvsHTSb++dCR6rsiscgM+w2/bxwqgw
        U7aI8=; b=TU1Ulnnyacifj+0g+DCVphgBtwQxr63UOfgcsmxHTTOFx+ivOv/2eL
        kCrbEzo3tI+VjF0Vr2nDSmYNK6juoSkUjsbjQQoUUjrCxZoNrwHzamIbj2tQs/5i
        sR1GtUAbB+X8By3pee0i1AliTp3Q80KnM2scK6aZzq1nCU46bOWW0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4206F174BFB;
        Tue, 15 Feb 2022 20:55:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A1142174BFA;
        Tue, 15 Feb 2022 20:55:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Subject: Re: ds/sparse-checkout-requires-per-worktree-config (was Re: What's
 cooking in git.git (Feb 2022, #02; Wed, 9))
References: <xmqqa6ez60l8.fsf@gitster.g>
        <f36712f5-28bd-42d7-3ea1-f4afa328be07@gmail.com>
        <xmqqfsope48k.fsf@gitster.g>
        <CAPig+cR+n=LQg5AJQgGQXuYStN90-jExWnE45sS1EXo+O8dQgQ@mail.gmail.com>
Date:   Tue, 15 Feb 2022 17:55:21 -0800
In-Reply-To: <CAPig+cR+n=LQg5AJQgGQXuYStN90-jExWnE45sS1EXo+O8dQgQ@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 15 Feb 2022 17:40:35 -0500")
Message-ID: <xmqqzgmrwp6e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 807C1AB4-8ECB-11EC-A1AC-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> I wouldn't go so far as to characterize it as a disagreement. In my
> review, I only pointed out that this series was introducing some new
> instances of inconsistency which some earlier efforts (started by
> Michael Haggerty) had eliminated. As mentioned in [2], I personally
> prefer the term "worktree".

These two words mean different things, so I am not sure there is
much room for personal preference.  If what a documentation refers
to is the working tree plus its administrative files, referring to
the whole as a "worktree" would be more precise and concise.  If the
discussion is only about the thing above .git/ that the editors and
the compilers see, "working tree" is the right term to use.
