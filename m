Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA32C433EF
	for <git@archiver.kernel.org>; Sun, 22 May 2022 23:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344105AbiEVXfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 May 2022 19:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240460AbiEVXfq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 May 2022 19:35:46 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B99C387B9
        for <git@vger.kernel.org>; Sun, 22 May 2022 16:35:45 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2DE411A9524;
        Sun, 22 May 2022 19:35:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h2AEsJ7qiSX3Ruexd3nSWJKEIWMwkhqKx+KeJi
        zc86E=; b=vW0S0cf26wDHQ95x4RSxP/1pbTVAeNx3uhcEGhi0MeprQEw07Hxw4P
        VdvtB4k19HQTF0/GEuykxZxZdHysb2gWNQOkv5/fCsksU2pYOWaKAhQsSOsPEbLY
        KXnf0fck0rkf+kIhN7aj7mUAAxlcH/ZJUBgF2GdgH3TcDviDB7/6k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 247C01A9523;
        Sun, 22 May 2022 19:35:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9D6E51A951F;
        Sun, 22 May 2022 19:35:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Hrushikesh Rao <hrushikesh20thegreat@gmail.com>,
        git@vger.kernel.org
Subject: Re: Git commands version documentation
References: <ccb312dc-c2cc-ca3a-e659-0f87ceec0d15@gmail.com>
        <f3814646-4763-62e1-b64e-d1aab3fdbbc8@iee.email>
Date:   Sun, 22 May 2022 16:35:38 -0700
In-Reply-To: <f3814646-4763-62e1-b64e-d1aab3fdbbc8@iee.email> (Philip Oakley's
        message of "Sun, 22 May 2022 23:02:43 +0100")
Message-ID: <xmqqr14l87jp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3797CE0-DA27-11EC-997A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> One manual method is to look at the history (blame) for the respective
> man pages to see when the man page was initially committed, and when
> appropriate options were added.
>
> Maybe use one of the hosting providers GUI if that is your choice e.g.
> https://github.com/git/git/blame/master/Documentation/git-gc.txt

I got an impression that blame/log is an overkill for the request,
which asks for "what tagged version?", to which the answer would be
to compare the manual pages for each release (or scan the release
notes), perhaps?


