Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBB9C4332F
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhK2Wex (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:34:53 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50487 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhK2WeP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:34:15 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B5EC1613F0;
        Mon, 29 Nov 2021 17:30:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ALKynw8I26nvDMFbqFMdYEGIcXitbmY8VYRKP6
        prxio=; b=e9OXTxUQ5Uu2sy1oWQgSX3tsnkPdSjbg1HaLSRaDGdnJvOSrHhS5+b
        RPW8hzm4x+PzdijdwK6lDEemMd/t34CMkNVvwlS2Y+e5/ZzsjlEE66r6t3bGJj6w
        6kHafPjTNAqqfcy0238xNJrBeAzZYYhNa3yN0qpawE3h2jBK1sFXM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 950D51613EE;
        Mon, 29 Nov 2021 17:30:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A5B931613E4;
        Mon, 29 Nov 2021 17:30:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 0/5] Inspect reflog data programmatically in more tests
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
        <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
        <211129.86czmjgtfd.gmgdl@evledraar.gmail.com>
        <CAFQ2z_OioNmOP+_VvP71DTDqkaVLZg01yx5QVNo+mVGXxsUJ9Q@mail.gmail.com>
Date:   Mon, 29 Nov 2021 14:30:51 -0800
In-Reply-To: <CAFQ2z_OioNmOP+_VvP71DTDqkaVLZg01yx5QVNo+mVGXxsUJ9Q@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 29 Nov 2021 19:24:28 +0100")
Message-ID: <xmqq35ne61d0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02C863F6-5164-11EC-AFA5-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

Just this part...

>> Just my 0.02, if you're interested in running with the below assume my
>> SOB.
>
> What is SOB in this context?

"Signed-off-by:"
