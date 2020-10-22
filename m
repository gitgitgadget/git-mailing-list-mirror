Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F009BC388F2
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 05:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75396206B6
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 05:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sTuj2yM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508035AbgJVFon (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 01:44:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62281 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438071AbgJVFol (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 01:44:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93D4583A64;
        Thu, 22 Oct 2020 01:44:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ULF5FqL8VUnO3OaM/Z840urlYvQ=; b=sTuj2y
        M7wjvq3vhEgfaSfLX1WVoow+/ookoiqAv7zpcquYBNCnCKKxD99SBIOzIlm7mlfU
        8t1dgqLpk13I85U4Yt9yl1+Orh2nZ5+LUbhBOlFRUJTOL9c7G489020qyBNhGcZ3
        HU3aV87KXhnfIBJrhk0BG2tNahDmBL+4qHEIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LY/LIm1PC6UBtTJEGJKi3BbWUSenPZJG
        1mPrjWfG5Yd8c01xL1vUlTCQsWkpnPixlJWhtjw9GUrBi9a6ufiNJkT9boDBHItc
        nfmtLkLJenofNlDETQcdKcdwpGegcCi8yLgXwR0rWc38RGH0WQKcZJU1z9ZhNjNv
        oGsjWvbO4Ro=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A6C083A62;
        Thu, 22 Oct 2020 01:44:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1495B83A61;
        Thu, 22 Oct 2020 01:44:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 3/5][Outreachy] t7102,t7201: remove whitespace after
 redirect operator
References: <20201020121152.21645-1-charvi077@gmail.com>
        <20201021124823.2217-1-charvi077@gmail.com>
        <20201021124823.2217-4-charvi077@gmail.com>
        <CAPig+cRzLpY4Pe11SQ0uux-_+x_CSVYM1FvRvDebH3TNi-bVow@mail.gmail.com>
Date:   Wed, 21 Oct 2020 22:44:38 -0700
In-Reply-To: <CAPig+cRzLpY4Pe11SQ0uux-_+x_CSVYM1FvRvDebH3TNi-bVow@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 21 Oct 2020 13:20:06 -0400")
Message-ID: <xmqq36264xx5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACD88066-1429-11EB-BF3B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Oct 21, 2020 at 8:51 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
>> According to Documentation/CodingGuidelines, redirect
>> operator is written with space before, but no space
>> after them.
>>
>> Let's remove these whitespaces after redirect operators.
>>
>> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
>> ---
>> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
>> @@ -460,14 +460,14 @@ test_expect_success 'resetting an unmodified path is a no-op' '
>> -cat > expect << EOF
>> +cat >expect << EOF
>
> There's still a space after the '<<' operator which should be removed:
>
>     cat >expect <<EOF

Also, this is outside any test_expect_*, which is unusual in
modernized test scripts.  There are many other instances of
preparing expected output outside test_expect_* in this file,
so we may need another patch to clean them up.

For now, within the context of this patch, let's just fix the space
after the << here-doc redirection operator, as you spotted.  The
attached I'll squash into this patch.

Thanks.

 t/t7102-reset.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git i/t/t7102-reset.sh w/t/t7102-reset.sh
index a8c96bf162..07acaa2beb 100755
--- i/t/t7102-reset.sh
+++ w/t/t7102-reset.sh
@@ -460,7 +460,7 @@ test_expect_success 'resetting an unmodified path is a no-op' '
 	git diff-index --cached --exit-code HEAD
 '
 
-cat >expect << EOF
+cat >expect <<EOF
 Unstaged changes after reset:
 M	file2
 EOF



