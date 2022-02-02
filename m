Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2D4C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 18:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346750AbiBBSq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 13:46:59 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56459 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239848AbiBBSq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 13:46:57 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 58F2317907A;
        Wed,  2 Feb 2022 13:46:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KmKejFj1I3gYTlm1ApdOSfINrw4zTJidXrnwt6
        DWZes=; b=bSNe+HkZZiLji2fae5OtobHdF7c2t5y2lIvqgBk1uvoIHUbkBTvtfr
        XL1gGQUDbMMjS5qtJ3VAJxPp9wPhdkEWGIawosvT187u9R8K0TAjwzTZ51yTuy8t
        DWbD7Hw+dUsq1/yXFFrGcvspVBMa8YlgqmoEmWT3tYxI6Gg9Lcnbk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 503FF179077;
        Wed,  2 Feb 2022 13:46:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ADB59179075;
        Wed,  2 Feb 2022 13:46:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "lgl via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, lgl <liginity@outlook.com>
Subject: Re: [PATCH] fix typo in git-mktree.txt
References: <pull.1207.git.git.1643792450866.gitgitgadget@gmail.com>
        <xmqqfsp115my.fsf@gitster.g>
Date:   Wed, 02 Feb 2022 10:46:51 -0800
In-Reply-To: <xmqqfsp115my.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        02 Feb 2022 10:32:21 -0800")
Message-ID: <xmqqbkzp14ys.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CCA799C-8458-11EC-BC84-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "lgl via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: liginity <liginity@outlook.com>

No need to resend only to fix it this time, but for future
reference, please make sure your user.name (and user.email) is set
up so that they match the author identity on the Signed-off-by line.

I'll also fix this line to ...

>>    Signed-off-by: Liginity Lee liginity@outlook.com

... read

    Signed-off-by: Liginity Lee <liginity@outlook.com>

