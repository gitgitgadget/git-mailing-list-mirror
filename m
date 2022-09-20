Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B69C6FA8B
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 00:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiITA1W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 20:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiITA1U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 20:27:20 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD49F5
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 17:27:16 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 45F141A1B6F;
        Mon, 19 Sep 2022 20:27:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iWkclm9wydPKXD9VArqmeY2aafS9QTI5dtr6+X
        5ZTYI=; b=xfLUvE0XHaVnZnQbb9udVrCQoZacMZPnomi68Agb5dTxzdAGt+M3J0
        T5+voyC61T2nKARNeQChLeEYGZsKzsbofeGkU46SEN6TbytslKioE98/tc7qtH9c
        vN83aUziDMIHSykbmf1lzlrhrrhayZs9j988tjIjU7VI98icQjecQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E9F81A1B6E;
        Mon, 19 Sep 2022 20:27:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 327ED1A1B6D;
        Mon, 19 Sep 2022 20:27:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 0/2] check-docs: fix 'diagnose' and 'version'
References: <pull.1360.git.1663633195.gitgitgadget@gmail.com>
Date:   Mon, 19 Sep 2022 17:27:10 -0700
In-Reply-To: <pull.1360.git.1663633195.gitgitgadget@gmail.com> (Victoria Dye
        via GitGitGadget's message of "Tue, 20 Sep 2022 00:19:53 +0000")
Message-ID: <xmqqbkra99gh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F7C23492-387A-11ED-B31C-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> While locally verifying an unrelated documentation change, I noticed that
> the 'check-docs' target displayed two warnings on the 'master' branch:
>
> no link: git-diagnose
> removed but documented: git-version
>
>
> The first message was due to the introduction of 'git diagnose' [1] not
> including a corresponding update to 'command-list.txt'; the latter was due
> to 'git-version' not being built as a standalone builtin executable. This
> series corrects both, adding 'git-diagnose' and 'git-version' as
> "ancilliaryinterrogators" to 'command-list.txt' and building a 'git-version'
> executable.

Very much appreciated.  I agree that making it an error would have
helped us a lot, and I also agree with you that it can be left for
the next cycle.

Will queue.  Thanks.
