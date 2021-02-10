Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6042EC433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 07:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 287E664E53
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 07:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhBJHTY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 02:19:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59408 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbhBJHTX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 02:19:23 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E77A4B45D7;
        Wed, 10 Feb 2021 02:18:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4PtT54xPtqe143s1eaT1XfX7zc4=; b=hy9qRD
        z96JMOtUfKgnVaHp4wnfBmxpvOhmci0/XT+BCHvJGyslERDwAVLsw2xqFDYxY0lr
        kf5HBEg4r0nfKI23xbfeq0B5P0gH4rTGhgeuncqUBOCym5HJC9CUs55BLIa/bjFz
        Ov4W8uL5bWAkI8I37ZHZsrEANPpkg1F+CfJ0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cJa91kkwJN/2dZD32uZi4ruXmMxoVHpN
        FIo42tAGnI+b9uF021RgzyVeIwGk9IOBvaW0CyPI4efdLcUYpwS6yb1jlXXlfCMe
        UIy7JPatBq20+70UicGKJKsU8LTjH2Oes7sboaU0eN9J/YLGEpksE3s8MsNoe1aS
        mog2qUQsmD4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE36BB45D5;
        Wed, 10 Feb 2021 02:18:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4E73AB45D4;
        Wed, 10 Feb 2021 02:18:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/9] t3905: remove spaces after redirect operators
References: <cover.1612258145.git.liu.denton@gmail.com>
        <cover.1612855690.git.liu.denton@gmail.com>
        <45ed17bfe2dad4702904a07a4a77a8d219df8379.1612855690.git.liu.denton@gmail.com>
Date:   Tue, 09 Feb 2021 23:18:41 -0800
In-Reply-To: <45ed17bfe2dad4702904a07a4a77a8d219df8379.1612855690.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 8 Feb 2021 23:28:48 -0800")
Message-ID: <xmqqr1lo4cha.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34544032-6B70-11EB-8A04-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> For shell scripts, the usual convention is for there to be no space
> after redirection operators, (e.g. `>file`, not `> file`). Remove these
> spaces wherever they appear.

OK.
