Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80D3C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 21:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 740F464F10
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 21:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhCDVFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 16:05:31 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58811 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbhCDVFB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 16:05:01 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 66F8D1179CF;
        Thu,  4 Mar 2021 16:04:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B2OeOv3e/rVGgIamUjxqNE1dUv8=; b=rehJvw
        2xIkiXqPr/uYL39DEy1YABUmTPZwihhB/th+8xecF1qUchDLxiPkr8pBx1XJIWwC
        w/ugYcvCxmA4HZSPEoOesA4UoFJietFvopF8dfwnncHo0zzkm4Cx/O7SLuPwYYCp
        w15PTKMQ5lxRmwosk0LwWAk2HibzHdNGnLVUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fCJPs1xKVeBOIXNeywIJukQJSkOzbHrS
        K3/tyO4ovbhykKYPYzbWq7o+Fk0/dJHzzLP0TS9D5e2E96a5VxlDh6IhKfmm0bvh
        ELeyeMKhXZC5lC9iJEteka1b0dbwB7iaqibQ2ERaa+Wmr74EuqqLfWxwPHd9MFB3
        O7ftVj91wcY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5FDB31179CE;
        Thu,  4 Mar 2021 16:04:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A83111179C8;
        Thu,  4 Mar 2021 16:04:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GIT PULL v2] git-gui pull request
References: <20210304184455.sah45hzavctfnhwa@yadavpratyush.com>
Date:   Thu, 04 Mar 2021 13:04:17 -0800
In-Reply-To: <20210304184455.sah45hzavctfnhwa@yadavpratyush.com> (Pratyush
        Yadav's message of "Fri, 5 Mar 2021 00:14:55 +0530")
Message-ID: <xmqq1rcueilq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F646B28-7D2D-11EB-8A78-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> The following changes since commit 
> b1056f60b63f1bc8226d01881bc829e171fc78bf:
>
>   Merge branch 'py/commit-comments' (2021-02-22 20:19:53 +0530)
>
> are available in the Git repository at:
>
>   https://github.com/prati0100/git-gui.git 
>
> for you to fetch changes up to df4f9e28f64ea97032ec70d9c8894dc87a1b7f9e:
>
>   Merge branch 'py/revert-commit-comments' (2021-03-04 13:59:45 +0530)

Thanks.
