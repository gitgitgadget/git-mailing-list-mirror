Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5368CC282DD
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 19:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E1820848
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 19:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xV2AUYmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgAGT6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:58:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50948 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbgAGT6M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 14:58:12 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B2AB339E5;
        Tue,  7 Jan 2020 14:58:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s/kzDEiOoGV+0j4Ae/D9fCgXkts=; b=xV2AUY
        mg1yZcpa0TWuMgJkd3J8x2toyH7de/8FFC0uJFpYrRt3wcxviMhU2SaIdgH2OxtL
        WUiiSx8Eui+m/LJtdyjVc/tftKOZuiD8BSifkv7p56lGDVDJDr6kV5XUfOE90k7f
        N3siZDzRoyfAXFjbgkFOMXI2RmOIT5ksDfkx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xJNKvVvfiZeWUvAkGLzWv+ZSs62496ev
        tKfLk2cK1kkIi22PBTqjJm8QVg0fizbiUWrrkg26dCUtcPjWjFXOT7BhYZptTkkC
        37r1g5+zLLGOVKKlT7TnkcpHJRZYmCWEj3JL1oJfk5ulweYfEnUhIGXTd2rmPS8P
        cvEaAeqyAso=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 61C4E339E3;
        Tue,  7 Jan 2020 14:58:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C417B339E2;
        Tue,  7 Jan 2020 14:58:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH 1/1] doc: fix a typo in gitcore-tutorial.txt
References: <pull.515.git.1578391553.gitgitgadget@gmail.com>
        <ee8636e0ed40888b2a132cff2dacc97754550ba1.1578391553.git.gitgitgadget@gmail.com>
        <CAPig+cTv5SOxEjjVQ7QvqJ1WbZGbcXegcCP4d5CK+nSdJvkNdQ@mail.gmail.com>
Date:   Tue, 07 Jan 2020 11:58:08 -0800
In-Reply-To: <CAPig+cTv5SOxEjjVQ7QvqJ1WbZGbcXegcCP4d5CK+nSdJvkNdQ@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 7 Jan 2020 06:35:23 -0500")
Message-ID: <xmqq36cr599r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 076E6372-3188-11EA-A33D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> To save reviewers the time and effort of having to figure all this
> out, use the commit message to explain the situation. For example, you
> might say:
>
>     doc/gitcore-tutorial: fix prose to match example command
>
>     In 328c6cb853 (doc: promote "git switch", 2019-03-29), an example
>     was changed to use "git switch" rather than "git checkout" but an
>     instance of "git checkout" in the explanatory text preceding the
>     example was overlooked. Fix this oversight.

Thanks for a ncie educational session ;-)
