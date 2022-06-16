Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134DAC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 18:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiFPSPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 14:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiFPSPX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 14:15:23 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174ED4F1C0
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 11:15:23 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9BD3E1AF359;
        Thu, 16 Jun 2022 14:15:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wCAianUCj6p/eiFLeVPOQdiBEoXve9yRoyYwuW
        gfAZk=; b=UBs1jBKE0OT9rLai7wtMB1vh+dCcJj3h2PHcTMLQixQIe7sTgF9Um7
        4bpWTz2uRdXkCHJJFSVvin49fVf+OjiNsZKMcGl+88NshNlmitiIGVjnOrHA8Ey8
        8Iu+PPuPHsyVDxEYQUWdaV48ZqX5swOak6JEremRvtMvb6+5LdIxI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 808621AF357;
        Thu, 16 Jun 2022 14:15:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 03FCE1AF356;
        Thu, 16 Jun 2022 14:15:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Fangyi Zhou via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Fangyi Zhou <me@fangyi.io>
Subject: Re: [PATCH] builtin/rebase: remove a redundant space in l10n string
References: <pull.1277.git.git.1655399939066.gitgitgadget@gmail.com>
Date:   Thu, 16 Jun 2022 11:15:17 -0700
In-Reply-To: <pull.1277.git.git.1655399939066.gitgitgadget@gmail.com> (Fangyi
        Zhou via GitGitGadget's message of "Thu, 16 Jun 2022 17:18:58 +0000")
Message-ID: <xmqq7d5gtqyy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 476A0694-EDA0-11EC-BEA4-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Fangyi Zhou via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Fangyi Zhou <me@fangyi.io>
>
> Found in l10n.
>
> Signed-off-by: Fangyi Zhou <me@fangyi.io>

Thanks.

> -			"Note: Your `pull.rebase` configuration may also be  set to 'preserve',\n"
> +			"Note: Your `pull.rebase` configuration may also be set to 'preserve',\n"
