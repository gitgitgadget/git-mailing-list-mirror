Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78205EB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 16:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjF1Q0X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 12:26:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60190 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjF1Q0V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 12:26:21 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C534918FEE0;
        Wed, 28 Jun 2023 12:26:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z8TNxo6EdXg1pkVC6tRQlS3/By4+k26mZYBkrk
        hWy+U=; b=JcYkiDDv7f4IQtLj15Y4aEiOcGxG16aNfbYkTRQQ8PikgehF3V5v7A
        JU/VkDRMzJsnv2Ezucs2XJnmlY5UJLuzBv3JJYHW95mQF6Ycagy2lO5VDhAewqUN
        B4eNyZOHVl8AjYs5muMkc1DWZRMaXOjekJxiD4m6BFO3vcj9DeSPc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB65618FEDF;
        Wed, 28 Jun 2023 12:26:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0E57818FEDE;
        Wed, 28 Jun 2023 12:26:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2] fix cherry-pick/revert status when doing multiple
 commits
References: <20230627224230.1951135-1-jacob.e.keller@intel.com>
        <743b17ee-2c5b-be7e-70f3-76d0f9d0ff5e@gmail.com>
Date:   Wed, 28 Jun 2023 09:26:19 -0700
In-Reply-To: <743b17ee-2c5b-be7e-70f3-76d0f9d0ff5e@gmail.com> (Phillip Wood's
        message of "Wed, 28 Jun 2023 12:11:03 +0100")
Message-ID: <xmqqfs6beeok.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83A0CFFE-15D0-11EE-8AC5-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Jacob
>
> This version looks good to me
>
> Thanks for re-rolling
>
> Phillip

Thanks Jacob for writing and Phillip for reviewing.  Queued.

