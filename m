Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9E5C35242
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 03:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CA722522
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 03:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZvYit7+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgBQD2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:28:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57134 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgBQD2G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 22:28:06 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CBA7A59287;
        Sun, 16 Feb 2020 22:28:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vFJPU7YBMCgV0qeI7g4gETzLQ68=; b=ZvYit7
        +Tp2dtFPvQmj0ClHcG0xn8B2x2ETC8Qd6VO70mrSgJMvcwytxQH7qm6BvC4neZIX
        IwDocg9s1hlOsmj9VX9i75J9U8CXouTgykPMEPUCJbTzw3b3C+F/5Gz7btr6RsTx
        8f3ImS2XA4yOtt8ImJtJjcuuGvNJgqn4jOGos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fAcjprC8AUfnW9L2knu7ZBq0NHl5C7uM
        jEkMjq8QC2IH6DnPgi3jVHdOJt2gqDXSkF12rdfhLHBD+No2TAZz3JpKWoJN5il+
        zU6c6XD6Q51n6gr9yiGwKOxt5Ys3AjOdC9u8tufzznrJGvyyQ/VQZz8Y1Dcj8Jvv
        781YGyrM9gw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C19E659286;
        Sun, 16 Feb 2020 22:28:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EF2A259285;
        Sun, 16 Feb 2020 22:28:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v2 1/2] advice: refactor advise API
References: <pull.548.git.1581311049547.gitgitgadget@gmail.com>
        <pull.548.v2.git.1581889150.gitgitgadget@gmail.com>
        <080d12b5c696d61ac1052d5863f7260a4005346e.1581889150.git.gitgitgadget@gmail.com>
Date:   Sun, 16 Feb 2020 19:28:03 -0800
In-Reply-To: <080d12b5c696d61ac1052d5863f7260a4005346e.1581889150.git.gitgitgadget@gmail.com>
        (Heba Waly via GitGitGadget's message of "Sun, 16 Feb 2020 21:39:08
        +0000")
Message-ID: <xmqq8sl1nb98.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8263A476-5135-11EA-A0F0-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There seem to be a handful of lines with trailing whitespaces.  I
think I've fixed them all on the receiving end, but please proofread
before you come up with the next round.

Thanks.
