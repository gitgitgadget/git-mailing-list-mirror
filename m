Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9442C001DC
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 05:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjGZFPW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 01:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjGZFPP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 01:15:15 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D2D2119
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 22:15:15 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BE0F33592A;
        Wed, 26 Jul 2023 01:15:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OMRm56fScPXYaz9rBA+C6ZXq4p5O3XfDLRkX2F
        MjK58=; b=mCX0mtpot6EvT9ttz8qrIoF0HnKrih9Xp5+dRmhkLlkRbI/ZexaVQP
        AhMcdKvPc2Ad/qeAPxPe47M+RaAtwYeK6dN3z9gBymdhoEv7WYw4eOyZsmGNqlBH
        62hjaPrDOkJ0uOIh87TAXjE5NoEm0B4ZYMEInUvyJCjmsz+oPLET8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A474035929;
        Wed, 26 Jul 2023 01:15:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2E75C35925;
        Wed, 26 Jul 2023 01:15:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: Re: [PATCH v3 0/5] SubmittingPatches: clarify which branch to use
References: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
        <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com>
Date:   Tue, 25 Jul 2023 22:15:09 -0700
In-Reply-To: <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com> (Linus Arver
        via GitGitGadget's message of "Wed, 26 Jul 2023 03:04:56 +0000")
Message-ID: <xmqqpm4ffe3m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6512E05A-2B73-11EE-8C6D-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series rewords the "base-branch" section (now renamed to
> "choose-starting-point") to be more informative in general to new
> contributors, who may not be as familiar with the various integration
> branches. Other smaller cleanups and improvements were made along the way.

Well, both of us forgot that the previous round has already been in
'next' for quite a while.

So, I've split the difference between the previous round and the
result of applying this round into two patches, and then added a bit
of fix-ups on top.  I'll send them out shortly.

Thanks.
