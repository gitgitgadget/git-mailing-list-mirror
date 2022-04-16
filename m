Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFFCC433EF
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 17:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbiDPRNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 13:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiDPRNo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 13:13:44 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299C091555
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 10:11:12 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5BC941948D3;
        Sat, 16 Apr 2022 13:11:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xWb8bO+0SA66XNmYhYjNNivw/vK4+wimEMZsNr
        +VOqo=; b=QFrs7acUB+uS+WkJaP2wP6kHpJFhMmXIhq0v1uaHlH0xjDT08OOeAq
        CqTeNcbA9S+GrrON/ZCzRWx4o2HWvCyq9wNsh46B9dqF1Y89SHzVOMsfZsmNEvEd
        pNBFlk8fcxsNiTaEUOb8BgytL/O5aDXjtKXdrFjQyE5WKrIcKtWX8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 526FF1948D2;
        Sat, 16 Apr 2022 13:11:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F2D6D1948D0;
        Sat, 16 Apr 2022 13:11:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Cc:     COGONI Guillaume <cogoni.guillaume@gmail.com>,
        "derrickstolee@github.com" <derrickstolee@github.com>,
        "git.jonathan.bressat@gmail.com" <git.jonathan.bressat@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "guillaume.cogoni@gmail.com" <guillaume.cogoni@gmail.com>,
        "shaoxuan.yuan02@gmail.com" <shaoxuan.yuan02@gmail.com>
Subject: Re: [PATCH v1 1/1] Documentation/ToolsOnGit.txt: gather information
 about tools
References: <CAA0Qn1tZxGR0cUi2JSJtTFYe2Nk9xoGuHkruji1-53-Fhokmig@mail.gmail.com>
        <20220416123433.28391-1-cogoni.guillaume@gmail.com>
        <63d7dc69656e47f7bc7bce4839711f32@SAMBXP02.univ-lyon1.fr>
        <0f8dbbd6-4d7b-4530-ec85-2eddfcdc9825@univ-lyon1.fr>
Date:   Sat, 16 Apr 2022 10:11:05 -0700
In-Reply-To: <0f8dbbd6-4d7b-4530-ec85-2eddfcdc9825@univ-lyon1.fr> (Matthieu
        Moy's message of "Sat, 16 Apr 2022 15:25:39 +0200")
Message-ID: <xmqqlew554ye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 343BD55C-BDA8-11EC-823F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@univ-lyon1.fr> writes:

> Actually, the Linux kernel's CodingStyle contains more relevant stuff
> (for C, not Perl):

True.

> https://www.kernel.org/doc/html/v4.10/process/coding-style.html#you-ve-made-a-mess-of-it
>
> (But aren't all Git devs former kernel developers? ;-) )

It's 2022, Matthieu, not 2005 ;-).

Thanks for a helpful and useful review.

