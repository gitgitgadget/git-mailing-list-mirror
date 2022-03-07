Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC63C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 21:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239342AbiCGV16 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 16:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiCGV15 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 16:27:57 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAA660CDA
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 13:27:02 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AB97619273F;
        Mon,  7 Mar 2022 16:26:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=a/qTkppI/01g
        svMV2QRs8xuosHL5FeG0jXeRMJANxIU=; b=mOEkiLB6DCcXan7RGlj9yVDiBQE8
        MxjYX5LKlWzV5wNwfVI1+AZ8EX/o8pxVu1QdqCVqK7LtEqSBxRdYinOvI7liReqV
        FEQtwy9G1EQlH2s9/tcq31bSsb+ixvbXRPb5bAdoscovyFkoyjpW/uwBmSlfLg3a
        gwFrD/nXYRWWjWg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A539119273E;
        Mon,  7 Mar 2022 16:26:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1B8AB19273D;
        Mon,  7 Mar 2022 16:26:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/10] tests: add and use a "test_hook" wrapper +
 hook fixes
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
        <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com>
Date:   Mon, 07 Mar 2022 13:26:56 -0800
In-Reply-To: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 7 Mar
 2022 13:43:31
        +0100")
Message-ID: <xmqqtuc9qwrj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 51176BCE-9E5D-11EC-8CF7-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Junio also suggested re-arranging this to do this migration in fewer
> steps. I started doing that but doing so would have taken a lot of
> time solving conflicts, re-writing commits etc. I think given that

Given how much reviewer bandwidth you consume, it may be a good
thing to slow you down, I would have to say ;-)

> there's agreement on the end-state that doing so wasn't worth the time


Somebody needs to take another look at the end-state, as I do not
recall if there was any firm agreement, but in any case the series
must bisect well.

In any case, the new "test_hook" helper, together with many places
converted to use it by this patch, look quite nicely done.

Will replace.

Thanks.

