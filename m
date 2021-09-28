Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B13C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BD8861357
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243293AbhI1Xaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:30:35 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65367 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhI1Xaf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 19:30:35 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E3FCC14C0BA;
        Tue, 28 Sep 2021 19:28:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UajvsocDkMvYR5NQjwH/k8UYfjoM69vwItiLuc
        omT0w=; b=GfpGIyeu3wZzciRCta7d+KY917PdUGMDG06d1xUqOWTgckdvqKxUJL
        yVSq62ZcNeI4UjKodm7n4sCAo04rZ6YbRlCZ+jYdyjFCPDJZXLcJhQ1iRnFxH/Bf
        A4ZHVMZbkI0iA8EQEdrrE3TrrkTMfNSTcNk0k2IFjiETqn44VMJ74=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DC70814C0B8;
        Tue, 28 Sep 2021 19:28:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5343514C0B7;
        Tue, 28 Sep 2021 19:28:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Orgad Shaneh <orgads@gmail.com>
Cc:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] doc: fix capitalization in porcelain v2 section
References: <pull.1095.git.git.1632628082841.gitgitgadget@gmail.com>
        <xmqqsfxppylh.fsf@gitster.g>
        <CAGHpTBKkET3dcsjq0oQshMmxDRoA6rMOhUoPsAaG634_sHizRg@mail.gmail.com>
Date:   Tue, 28 Sep 2021 16:28:51 -0700
In-Reply-To: <CAGHpTBKkET3dcsjq0oQshMmxDRoA6rMOhUoPsAaG634_sHizRg@mail.gmail.com>
        (Orgad Shaneh's message of "Tue, 28 Sep 2021 23:42:23 +0300")
Message-ID: <xmqqczosi8jw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7369536-20B3-11EC-B915-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Orgad Shaneh <orgads@gmail.com> writes:

> Fine with me. Should I resubmit the patch, or will you push it with
> the revised subject?

I have (at least for now)

 doc: fix capitalization in "git status --porcelain=v2" description

on 'seen'; if you want to tweak it further, do not hesitate to send
updates.

Thanks.
