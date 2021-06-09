Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB49C47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 04:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D32260234
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 04:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhFIEuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 00:50:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63830 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhFIEuP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 00:50:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F25AABD97E;
        Wed,  9 Jun 2021 00:48:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+i5ZR5NgBZgObR3zu3fpjZB+IgAzK5pjdg9inx
        oS7ac=; b=UnE7Inys/psvk0ay/h27ODlBD/3o3+RwOXG2f/N8k7y7zVHfSM7Udf
        L6WlFYfrtMOKvH8FPVlET/Ih2sc40d5olJnT55LsnDVKtYCftfs/TztYRBMoRfZV
        ZORvYePdGAdNX8RVMVPKQtE4LGnLGYHUstGSZPWzuIpztmtfCB3fs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E77C8BD97D;
        Wed,  9 Jun 2021 00:48:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7CC06BD97C;
        Wed,  9 Jun 2021 00:48:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        stolee@gmail.com, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/4] Documentation: use singular they when appropriate
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
        <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
        <YL+p+MlgJ754YoqB@google.com>
Date:   Wed, 09 Jun 2021 13:48:19 +0900
In-Reply-To: <YL+p+MlgJ754YoqB@google.com> (Emily Shaffer's message of "Tue, 8
        Jun 2021 10:33:44 -0700")
Message-ID: <xmqq5yynlk30.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA120DC6-C8DD-11EB-954A-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> There is value in intentionally defaulting to "she/her", especially in
> settings where women are underrepresented. It can be a nice way to
> shake the foundations of unconscious bias in the reader's head.

Heh, I used to refer to a hypothethical user in my writing as a
female and a male on alternate days (Tuesdays and Thursdays were
male day).  It quickly got confusing when I had to compose my reply
on an even day to a response to my earlier message that was written
on an odd day, and I had to abandon the practice ;-)
