Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED278C43334
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 22:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiGJWIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 18:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGJWIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 18:08:09 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0F313E38
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 15:08:08 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AE6C12352C;
        Sun, 10 Jul 2022 18:08:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PorI6DscxPrA5mkQAHxLBknpg6X+zIsKI2scJJ
        WQ50k=; b=YcJBeHJti2EyT3/ktvabJuGkjmYvPja+RY6GLFHhaqzAU9iXXjNEMZ
        zJ+DHrRZWpuybu5kh/LZK8AbY8EdyzU9X+QDzwHpxMxYwIKD4Z7hAsh4MdnY6VeC
        2tOYFNuTUfup8DLfGxseCpGqeqL91tH8RmqlmlvAHmVQ5u0HMa0R8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EACA3123528;
        Sun, 10 Jul 2022 18:08:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 34DB3123525;
        Sun, 10 Jul 2022 18:08:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: Automatic code formatting
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
Date:   Sun, 10 Jul 2022 15:08:05 -0700
In-Reply-To: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 10 Jul 2022 21:50:15 +0000")
Message-ID: <xmqqo7xwpqnu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7065EF2-009C-11ED-B064-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I should point out that most platforms (and all major platforms) have
> clang and therefore I think clang-format should be a fine choice.  It's
> highly configurable and will let us pick a style that most resembles the
> one we have now. However, I'm not picky and if we like something else
> better, great.  As long as the option we pick is shipped in Debian, I'm
> for it.

As long as the options in clang-format we choose to use would
reformat the current codebase without disrupting too much, I would
be happy to see this done.  It would probably need a bit of work but
hopefully clang-format is flexible enough to accomodate our style to
allow us do this.
