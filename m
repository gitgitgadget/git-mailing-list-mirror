Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4711EE4993
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 17:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbjHUR5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 13:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjHUR5J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 13:57:09 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EF4E9
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 10:57:07 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 321BB1BB1B8;
        Mon, 21 Aug 2023 13:57:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+sD02ob8VjwyHpGlElyJxQ3yLg4X96Svelgls4
        iTSmQ=; b=CQwutSIu0I4wQDnUYnZ1StymFlI5s2Vy23LLiYrR0WZ/aARfuk4B7G
        rLdJw0R1VrUBf0QY2uB6D7Yf+Z68TOq1VaHT2PyzsGoxB7S8SDtm0JEZUOv+XMlq
        I915JbK/9f+B3E90jsnu+XoaQxN9tp/khHsMMI7q6aV292NAGQsgI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2876F1BB1B7;
        Mon, 21 Aug 2023 13:57:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 508EC1BB1B6;
        Mon, 21 Aug 2023 13:57:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5] send-email: prompt-dependent exit codes
References: <xmqq5y5msmc0.fsf@gitster.g>
        <20230821170720.577835-1-oswald.buddenhagen@gmx.de>
Date:   Mon, 21 Aug 2023 10:57:05 -0700
In-Reply-To: <20230821170720.577835-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Mon, 21 Aug 2023 19:07:20 +0200")
Message-ID: <xmqq1qfwqnwu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2429C142-404C-11EE-AEF7-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> to opt-in (which is obviously the status quo, and is likely to persist
> in most cases) is potentially at least somewhat serious.

What's the weaseling "potentially at least somewhat" phrase about?

Quite honestly, it makes it apparent that the patch is trying to
make a change that cannot be justified and makes it lose all the
remaining credibility.

The users have lived with the current behaviour practically forever
in Git's timescale and not changing the default and letting them
"live with" the status quo cannot be any _serious_ at all.

Will replace what I had kept but out of 'seen', as the changed parts
of the patch are definite improvements, but I do not think I want to
merge it without starting this as an optional feature.

Thanks.

