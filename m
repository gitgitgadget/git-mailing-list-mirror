Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333C1C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 19:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245706AbiCJTBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 14:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238947AbiCJTBx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 14:01:53 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E79DCEA05
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 11:00:52 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 114B7182118;
        Thu, 10 Mar 2022 14:00:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=afb2YrYSQLELZylUOqGeCPqjpOzg98S3BLNe+t
        S1QRw=; b=ABplPPdMOXO0a7+ivLW99pFmEYdEBab0bzgd2QJafSJcCbOk1R8w5x
        NUB5hBIRXgGkEzEP1PrtuwCZDVumZDpG3uDqtWKhklmDNf/eRWzH0W2zsyOOGUxM
        +xkbOZPyPumN5nKsmFVBtWz04ZCdVm/C+Eq0FBMa0NGZFzGRk1FkM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 045D4182117;
        Thu, 10 Mar 2022 14:00:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 74E07182110;
        Thu, 10 Mar 2022 14:00:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/4] trace2 docs: a couple of grammar fixes
References: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
        <07f7ee46232b4ccc53787fa2e08887b436ee11c3.1646919331.git.gitgitgadget@gmail.com>
Date:   Thu, 10 Mar 2022 11:00:48 -0800
In-Reply-To: <07f7ee46232b4ccc53787fa2e08887b436ee11c3.1646919331.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 10 Mar 2022
        13:35:28 +0000")
Message-ID: <xmqq8rtheiov.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 666A21BC-A0A4-11EC-8484-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> @@ -34,8 +34,8 @@ Format details are given in a later section.
>  
>  === The Normal Format Target
>  
> -The normal format target is a tradition printf format and similar
> -to GIT_TRACE format.  This format is enabled with the `GIT_TRACE2`
> +The normal format target is a traditional printf format and similar
> +to the GIT_TRACE format.  This format is enabled with the `GIT_TRACE2`

In the same spirit as [2/4] and match the part that [4/4] touches,
this probably is better:

    The normal format target is a traditional `printf()` format and similar
    to the `GIT_TRACE` format.  This format is enabled with the `GIT_TRACE2`

