Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACDDC43381
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81373652AC
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhCHS2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:28:24 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57235 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbhCHS2G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 13:28:06 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 59C76136078;
        Mon,  8 Mar 2021 13:28:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RRzx/RCTYi0kX60l610cijF1L3A=; b=dUF3RC
        oVF0wQ5mQLJBifSAtVxcegLSpvX+YYdIN+qJBgoPDPBSzGo0bKfrSs4sTHwcjqdE
        FPPhc9DT1qvE3qcLH+KXQCA8+1Bd/ExGGHV7ZhYo1FrP+GJwpoAIXAoPfrnfRXGz
        A9cqJDeJr18wjy6AfjZDxyIy4weOxBwxEvHJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LOC4Ywx2hPIxkPR/Hf44ED4M7Icy7+qb
        W6PinAVS78ByvnLKxfYCUJWHI4xBcrLJBlJXzgR7gRvSBzbSu3ggIBk9poq2qhrf
        QCjYIDtciIp2cQlKTXFrQxftWA05LJWbn2usXHevRo1t2jtzj0BS3quAjCL11Soe
        eSPINc9HIRk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5093D136077;
        Mon,  8 Mar 2021 13:28:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 95B35136076;
        Mon,  8 Mar 2021 13:28:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH v2] Update 'make fuzz-all' docs to reflect modern clang
References: <pull.889.git.1614514959347.gitgitgadget@gmail.com>
        <pull.889.v2.git.1614871707845.gitgitgadget@gmail.com>
        <xmqqlfb2cz8c.fsf@gitster.c.googlers.com>
        <defff7a3-2104-4fa1-7750-0b13ca5cdf59@ahunt.org>
Date:   Mon, 08 Mar 2021 10:28:01 -0800
In-Reply-To: <defff7a3-2104-4fa1-7750-0b13ca5cdf59@ahunt.org> (Andrzej Hunt's
        message of "Mon, 8 Mar 2021 18:05:08 +0100")
Message-ID: <xmqqsg555wlq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0510D462-803C-11EB-B26A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrzej Hunt <andrzej@ahunt.org> writes:

> However I would prefer to wait for Josh's feedback before making such
> a change, as he is the owner of oss-fuzz's git integration [1], and as 
> such is most likely to be affected by any changes to this target.
>
>
> In the meantime I'll prepare an updated patch with a fixed commit message!

Makes sense.  Let's wait and see what Josh says before going forward.
