Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82F2C433B4
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 19:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92075611AF
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 19:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242950AbhDPTNn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 15:13:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59570 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbhDPTNm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 15:13:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53879C856A;
        Fri, 16 Apr 2021 15:13:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2aRctFzDEkX7A9qhk/GAIvYXlY0=; b=k1OSLz
        bk3nws2Z09FYkUQSoTB3LEvZDJ5ZA0810ZviozPrutrgswDsjE5ZsC5OOgS1UYeH
        ePWfTOyTV6Qs+QEHwMX9nrlHl7zrwztPZPruc+x0t5TeUrVLYGQKKgfS0dV+kSnA
        JH02kKKGbHObs/rZrQ7KZ/baC5rZzQj4JihJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QmMldUimLD9RfqiMcGtbDICpz0CuCaub
        zIqgGbOEy+iaTKBjaYgJ3x7mlr2ocAecQpeKX84pboqicZ2KHje7xxAoO6p0usD9
        ZjwxgDQDbn99FyNkAR3/LURwOTB8cOL/L0VSEA3gPyRsFOqPubpR4TJtT+OoFwOo
        ZXByhIrZvYs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4AB49C8569;
        Fri, 16 Apr 2021 15:13:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C4C45C8568;
        Fri, 16 Apr 2021 15:13:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v10 2/2] [GSOC] trailer: add new .cmd config option
References: <pull.913.v9.git.1618245568.gitgitgadget@gmail.com>
        <pull.913.v10.git.1618562875.gitgitgadget@gmail.com>
        <daa889bd0ade1111eb8b1471fe7e953fcb41d12b.1618562875.git.gitgitgadget@gmail.com>
Date:   Fri, 16 Apr 2021 12:13:16 -0700
In-Reply-To: <daa889bd0ade1111eb8b1471fe7e953fcb41d12b.1618562875.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Fri, 16 Apr 2021 08:47:55
        +0000")
Message-ID: <xmqq35vqm4ab.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC5D60CA-9EE7-11EB-B8D0-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hmph, I am getting the following while applying.

.git/rebase-apply/patch:67: trailing whitespace.
> 
.git/rebase-apply/patch:69: trailing whitespace.
> 
.git/rebase-apply/patch:92: trailing whitespace.
> 
.git/rebase-apply/patch:94: trailing whitespace.
> 
warning: 4 lines applied after fixing whitespace errors.
Applying: trailer: add new .cmd config option
