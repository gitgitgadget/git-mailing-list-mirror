Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C66C433C1
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 17:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 844B36197E
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 17:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhCSRuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 13:50:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56580 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhCSRtg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 13:49:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A280BAC28;
        Fri, 19 Mar 2021 13:49:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G6YeDLf/+99PyBW2GS0ikYg+v9g=; b=nhw/Rn
        tSc32uLD6zoj699uBzPAKwpEIyqSyri38EZj9T19E9hC6mjgvekrr1fG8fhbFVaj
        UuraCu0nX4grj7Z+h24e88rhpQu8KsHUrr5j7lvNp9BzhDO8+ombTy9oOCM5pvRW
        KbO2edWoJ/l3uNowQmZPjOjov3dvUwRW/rHtY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dScCM3+Y/P6RsxY/CF9BT3PZfEuxiTpz
        5gKmYscjLj7urR/b5ZgSDu0Qx01CXH/Zvlb807cr92U194U/fq3B3ARYnDswRLpL
        mfVkdw78kE+h74RkSji75WeZatAZGviDknWpeFEi3wxmKC6IbvxTZecQPryWPcRR
        zxdkkZGE4x4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C462BAC27;
        Fri, 19 Mar 2021 13:49:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8E4EBAC26;
        Fri, 19 Mar 2021 13:49:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Subject: Re: [PATCH v2] INSTALL: note on using Asciidoctor to build doc
References: <20210319110045.15987-1-bagasdotme@gmail.com>
Date:   Fri, 19 Mar 2021 10:49:33 -0700
In-Reply-To: <20210319110045.15987-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Fri, 19 Mar 2021 18:00:45 +0700")
Message-ID: <xmqqzgyzm3te.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76C9FCD0-88DB-11EB-B5FC-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Note on using Asciidoctor to build documentation suite.
> ...
> -   All formats require at least asciidoc 8.4.1.
> +   All formats require at least asciidoc 8.4.1. Alternatively, you can
> +   use Asciidoctor (requires Ruby) by passing USE_ASCIIDOCTOR=YesPlease
> +   to make. You need at least Asciidoctor version 1.5.
>  
>     There are also "make quick-install-doc", "make quick-install-man"
>     and "make quick-install-html" which install preformatted man pages

Thanks.
