Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DC4C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D29A64DCF
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbhBIWZ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 17:25:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50352 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbhBIWL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:11:58 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F2C8996F6;
        Tue,  9 Feb 2021 17:11:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xYooHP97ZIfYG6YVbD4+CJ7QdLI=; b=tayLH3
        O8rw/sC1eTLfJZGTVp7Mkxusnd+YWy9EMf4dXR8g4mOyEXa4XqxWuBPTCHoKMjs9
        GOEJre6UnkAERVfI3AiEt883GWBdpzayBFqM9IFCaAyx1/zDQ/mD48bpc1UPmepC
        CL+F/xqACxpwluMTZ4zT0UKa3TPrkFFwMg72A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qn2yyiEHcIWe0k65Xi/YnKsiLmbSG1kG
        3yPc+S241kUxmuEEqQbQBZNcMf0dl0Q0hFxydYMoN8KZQvGPDo1Gp24FFy3BrB+G
        I5ycomGF9nz9IB3ItfcxWiccZlCm3wFxEbUCEYiGam2pEgOjBgnPNmwnYrdl0Z7h
        5D+VPpe4/OY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA755996F5;
        Tue,  9 Feb 2021 17:11:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB671996F4;
        Tue,  9 Feb 2021 17:11:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v11 0/3]  mergetool: add hideResolved configuration (was
 automerge)
References: <20210130054655.48237-1-seth@eseth.com>
        <20210209200712.156540-1-seth@eseth.com>
Date:   Tue, 09 Feb 2021 14:11:05 -0800
In-Reply-To: <20210209200712.156540-1-seth@eseth.com> (Seth House's message of
        "Tue, 9 Feb 2021 13:07:09 -0700")
Message-ID: <xmqqeehozybq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4F29AB0-6B23-11EB-9868-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House <seth@eseth.com> writes:

> Changes since v10:
> Seth House (3):
>   mergetool: add hideResolved configuration
>   mergetool: break setup_tool out into separate initialization function
>   mergetool: add per-tool support and overrides for the hideResolved
>     flag

Thanks for all these iterations.  The resuling series looks good to
me.
