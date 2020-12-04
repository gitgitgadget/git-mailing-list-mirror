Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A857EC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56FF622C9C
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgLDUEr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:04:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56402 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDUEr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:04:47 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1989F97FD3;
        Fri,  4 Dec 2020 15:04:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lb9oq95zDGDEVwIzQavgvIRXKk0=; b=tv6Qmr
        QCMyLyfP2Nu6WdNOmmem369uvgkR+yitTpznQIkvaundYZ6LuQGEWBzxxbV+UhdN
        ZWEW1gV8QSJos5r+fsOV6V8ensAywikmCImS3kjI3JxO1HsfitjvpT00qrzQ00Oz
        iGLeIXQAvyvC2jw1vh/VuqSJ7/g4X8o3K8eHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HmmeVaeekKR6lfFcAKngRzrRuc2RdGoG
        cLtH6LatXR9xOM1kQt/eX1Zj7PQd9j/YNy7R1+WXoPyiskUxxL9Dd6K4Tgb6etDO
        uqZ9FqaAvrhuPg+WTdHUywCNwGuMUxO6bar2tD739oFAXhHL6lYmeHi1/4YdDTws
        9v+mWdccetc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A183A97FD2;
        Fri,  4 Dec 2020 15:04:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC4D997FD0;
        Fri,  4 Dec 2020 15:04:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Make t5526 independent of the default branch name
References: <pull.806.git.1607092462.gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 12:04:02 -0800
In-Reply-To: <pull.806.git.1607092462.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Fri, 04 Dec 2020 14:34:20
        +0000")
Message-ID: <xmqqr1o5e3t9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB85D602-366B-11EB-86C2-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This patch series addresses that by overriding the initial branch names
> explicitly in t5526, and then removing the no-longer-needed prerequisite.

Nice.

Will queue; thanks.
