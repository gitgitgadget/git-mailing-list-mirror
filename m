Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B419EB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 17:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjGLRym (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 13:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjGLRyX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 13:54:23 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA3C26B1
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 10:54:17 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 38B0433D0B;
        Wed, 12 Jul 2023 13:54:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GPaouCrDgETGUEGIJ/DWq/R/Yll5wlrTCGLAee
        JWLI8=; b=xybjqlLRefu2sjDfCj4gccbyWOrFM7b4Dc//Kc4p0WdlkFtRmk8xhO
        6/58vMOrE43oIJpB5e417KZlJBVecJxasrkB16jeC5UEWfn/2hf6Y4Oi3gT10XDY
        AlQxebdXhpg/KpErFiGXeGJJylob9WqblCZEYpPfwA8nnMT/Uzjo8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 31E5233D0A;
        Wed, 12 Jul 2023 13:54:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BE2C133D09;
        Wed, 12 Jul 2023 13:54:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Petar Vutov <pvutov@imap.cc>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: remove mentions of .gitmodules !command syntax
References: <20230712160216.855054-1-pvutov@imap.cc>
        <xmqqleflt75z.fsf@gitster.g>
        <d775437e-7fa3-189b-a1c3-4fd358dd9768@imap.cc>
Date:   Wed, 12 Jul 2023 10:54:12 -0700
In-Reply-To: <d775437e-7fa3-189b-a1c3-4fd358dd9768@imap.cc> (Petar Vutov's
        message of "Wed, 12 Jul 2023 19:30:50 +0200")
Message-ID: <xmqqfs5tt3qz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1CCA15F2-20DD-11EE-8EAA-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Petar Vutov <pvutov@imap.cc> writes:

> Perhaps the term "configuration variable" in
>
> "The following update procedures are only available via the
> submodule.<name>.update configuration variable:"
>
> is more specific and technical than immediately obvious - I would have
> expected the contents of .gitmodules to be a form of (repository)
> configuration. But that is just bikeshedding.

Not necessarily.  It is always good to learn how "normal people"
(read: those other than who develop and write documentation for Git)
would react to and understand what we write in the manual pages, as
that is the only way we can find what is confusing, ambiguous and
can be improved.

Perhaps

    "... available via the ... configuration variable, and cannot be
    used in the .gitmodules file"

would have helped you?

Thanks.
