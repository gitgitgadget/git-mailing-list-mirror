Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326C3C433FE
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 17:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242360AbiAFRsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 12:48:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59569 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242347AbiAFRsN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 12:48:13 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A0D5E107771;
        Thu,  6 Jan 2022 12:48:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w+koVhz7OT8ryF0VcUpA3s422w8zCyNW/Sz7Gr
        +NA4s=; b=mtAXmtaMeDbG3vyrrrGoti2dZitS9tZkd4qPGo+ELle5FjRw7ReW8k
        7XwXwJgzLPitgb7MnnIDJs831ReHnKJ3wiF/jUY8g0vbGBUkhvIwbtgizGyLDrWE
        kkrJ2OO/s+LKZc5OjaHtDb/lVRAoFv08tNnJk6UFtOIBUgLhyaXjE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9898810776F;
        Thu,  6 Jan 2022 12:48:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F85010776E;
        Thu,  6 Jan 2022 12:48:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marc Strapetz <marc.strapetz@syntevo.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Marc Strapetz via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] t/README: fix typo
References: <pull.1110.git.1641338224631.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2201051701120.7076@tvgsbejvaqbjf.bet>
        <9f74fc04-ea68-6bdd-3341-ecf7a2aed6cd@syntevo.com>
        <b265de46-9ccd-4f31-d51c-1df1b39606d5@syntevo.com>
Date:   Thu, 06 Jan 2022 09:48:10 -0800
In-Reply-To: <b265de46-9ccd-4f31-d51c-1df1b39606d5@syntevo.com> (Marc
        Strapetz's message of "Thu, 6 Jan 2022 07:17:42 +0100")
Message-ID: <xmqqwnjceox1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D12AED5A-6F18-11EC-8D18-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marc Strapetz <marc.strapetz@syntevo.com> writes:

>>  > find the "dotsh" typo in the same file (it should be "dots", I
>> think)?
>> I wouldn't have noticed that, but I agree that it should be 
>> "test_name_without_dots".
>
> Please disregard my last statement. "test_name_without_dotsh" means
> "test name without .sh extension". For 
> "t2109-update-index-index-version.sh", the directory will be "trash
> directory.t2109-update-index-index-version".

Yup.  "without_dot_sh" might have been a better way to spell it, but
"without_dotsh" certainly is better than "without_dots".

Thanks for being extra careful.  In any case, the original fix is
good and has already been queued.

