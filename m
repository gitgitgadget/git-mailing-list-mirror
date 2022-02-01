Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85C7C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 23:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243034AbiBAX5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 18:57:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60820 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241096AbiBAX5h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 18:57:37 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 564C2FC859;
        Tue,  1 Feb 2022 18:57:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ago1a+gyscHTmOpIhj76tAZCnDje2+x0Xoocgg
        Xms/c=; b=cndI0s/ywd+rTF2gMijw8jDcRQfFul6SQQ86kjdvh070o211pq5ZW2
        pSp38hJ6rklChgPV+waKf5UiHI3oHdPhkpJVUQTxctiYP4T42x3kkPDuhfqDhNCL
        jA/QRCVfdMclxt1e6w5YBZ+GUS1E/GVhvdxMapVFT5mBU8pgDl9yE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4CA6CFC855;
        Tue,  1 Feb 2022 18:57:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF13AFC852;
        Tue,  1 Feb 2022 18:57:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Subject: Re: [PATCH v2 2/2] t/lib-read-tree-m-3way: replace spaces with tabs
References: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
        <20220130094357.515335-1-shaoxuan.yuan02@gmail.com>
        <20220130094357.515335-3-shaoxuan.yuan02@gmail.com>
Date:   Tue, 01 Feb 2022 15:57:35 -0800
In-Reply-To: <20220130094357.515335-3-shaoxuan.yuan02@gmail.com> (Shaoxuan
        Yuan's message of "Sun, 30 Jan 2022 17:43:57 +0800")
Message-ID: <xmqqv8xy87io.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB123D00-83BA-11EC-8F29-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:

> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
>
> This commit simply replaced indentation spaces with tabs.
> e.g.
>
> -    git update-index --add SS
> +	git update-index --add SS

The same comment applies wrt where the message is placed.

I'd view "replace spaces with" as a way to achieve "indent with
tabs".

    t/lib-read-tree-m-3way: indent with tabs

    As Documentation/CodingGuidelines says, our shell scripts
    (including tests) are to use HT for indentation, but this script
    uses 4-column indent with SP.  Fix this.

or something like that, perhaps?
