Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81839C33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 05:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551C720720
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 05:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hgodsjoM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgA2F3P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:29:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57966 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgA2F3P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 00:29:15 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 50F8F3CCB0;
        Wed, 29 Jan 2020 00:29:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SbllZVZR+d1DYpLD67WhCAFM4Cc=; b=hgodsj
        oMxRJY5UZdWSj3rm+G2Kfg7WrJ+/GjwDPpBQHauoTsHnbnh4AgkI1KUL/8nHXJLw
        WLZQwzuC5pThJX+hCVoZasvG6GxEb+on5foPRU1fYPmH6Gfx1bipEXf6VqWXgpt6
        IC+B5JGpmxfxOWhxDFQt6eFptNgnmy5Wdc1To=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mQ9lA9dKD1yFSOis9V/R6tCEYsyZjt5n
        QaXI36BuHRU6mZi2jEf5O0Po7TBTQWpvyb9Zn1/WNlZwBYc9TsU4obZLYIBNc/d0
        prvV5otdcQwKMi+vO11FHM+DJf3UWHJ38fyXBF2ZDnamdouxgKFZ99qRjg3F/rur
        dm2RwbVcxp4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 491673CCAF;
        Wed, 29 Jan 2020 00:29:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A9D243CCAE;
        Wed, 29 Jan 2020 00:29:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v6 0/6] config: allow user to know scope of config options
References: <pull.478.v5.git.1579912764.gitgitgadget@gmail.com>
        <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
Date:   Tue, 28 Jan 2020 21:29:12 -0800
In-Reply-To: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com> (Matthew
        Rogers via GitGitGadget's message of "Wed, 29 Jan 2020 03:34:19
        +0000")
Message-ID: <xmqqzhe66dav.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48FA5D10-4258-11EA-9AEB-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This was originally a pull request to the git-for-windows repository
> [https://github.com/git-for-windows/git/pull/2399]. It adds a new option
> --show-scope which would allow a user to see what scope a given
> configuration value has (sytem, local, global, etc.).
>
> changes since v4:
>
>  * final cleanups

Indeed.  This round looks good.

Thanks.
