Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EDDC4363A
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 17:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 602782463B
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 17:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qLr0qEHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368052AbgJVRfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 13:35:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59833 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900632AbgJVRfL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 13:35:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D3FA80B3B;
        Thu, 22 Oct 2020 13:35:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QPp2DVy5IZpnTgzwuv/k9kzOE9M=; b=qLr0qE
        HXyc/i4qzHxQZAzPtkS8/jWaYYCmgzrzeqOgYjNkSXr1tTEbQNI/wuOUEnoGLo6M
        MFReGRrzlH3jPgA9Hj2ixR/3J/UcWJ4VildCd7BgM8Qel9hZy+6bXk/CiZHI10Ar
        6X6U5epsf73zhJFucZbr2lIh5wBHLPpcHRaks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KSGTjKq/nvyJQvOV1Xk47vJ0C0LrTVWF
        b3vW/n/6NBhCrgTffD+wKm8VJuq+E5UgY0Ug+r0LVFd9W8hCZKmMFirl7LPUsh8y
        itApZQBKtLoHaJ0zf/sEtPJPRkFteqpeG5nChnuqDdR+ngdDRgaWXlUCuYgusN/K
        2MJTLO/9qAY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EEC6080B39;
        Thu, 22 Oct 2020 13:35:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA4FB80B38;
        Thu, 22 Oct 2020 13:35:06 -0400 (EDT)
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
        <xmqq36264xx5.fsf@gitster.c.googlers.com>
        <xmqqh7qmolch.fsf@gitster.c.googlers.com>
        <CAPig+cSL-9o=c=iYtvHNDZmtRVoy2=EED1RdoX2Tsjnm3ioevQ@mail.gmail.com>
Date:   Thu, 22 Oct 2020 10:35:04 -0700
In-Reply-To: <CAPig+cSL-9o=c=iYtvHNDZmtRVoy2=EED1RdoX2Tsjnm3ioevQ@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 22 Oct 2020 02:04:01 -0400")
Message-ID: <xmqqmu0emaev.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED0AB52E-148C-11EB-93D6-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Oct 22, 2020 at 1:56 AM Junio C Hamano <gitster@pobox.com> wrote:
>> Subject: t7102: prepare expected output inside test_expect_* block
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> diff --git c/t/t7102-reset.sh w/t/t7102-reset.sh
>> @@ -82,15 +82,15 @@ test_expect_success 'reset --hard message (ISO8859-1 logoutputencoding)' '
>> ->.diff_expect
>> ->.cached_expect
>> -cat >.cat_expect <<EOF
>> -secondfile:
>> -EOF
>> -
>>  test_expect_success 'giving a non existing revision should fail' '
>> +       >.diff_expect &&
>> +       >.cached_expect &&
>> +       cat >.cat_expect <<-\EOF &&
>> +       secondfile:
>> +       EOF
>
> You used <<-\EOF rather than plain <<-EOF when possible. Good.
>
> (Might be worth mention in the commit message, but perhaps too minor?)
>
>> @@ -191,38 +191,38 @@ test_expect_success 'resetting to HEAD with no changes should succeed and do not
>>  test_expect_success '--soft reset only should show changes in diff --cached' '
>> +       >.diff_expect &&
>> +       cat >.cached_expect <<-EOF &&
>> +       diff --git a/secondfile b/secondfile
>> +       index $head5p1s..$head5s 100644
>
> And used plain <<-EOF when necessary. Fine.

Yup.

Let's declare victory with v5 plus this one as [patch 6/5], and move
on.

We both know very well that through the microproject that it has
been demonstrated that Charvi can now comfortably work with us in
the review discussions.

Thanks, both.
