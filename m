Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E80C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 17:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbiF3RGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 13:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbiF3RF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 13:05:59 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288D3338B1
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 10:05:58 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B3EB12E1D3;
        Thu, 30 Jun 2022 13:05:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yFPavXZ2uSzIoUiH7uyZJfsmguJjIq1h8OTeWw
        E+aN4=; b=mQS+y/Rv275ZzaJbGK5Amgoi25rPwpePfKVU+yBO8hWR2c/ppW4QQ1
        2jSfIj3/2EdCC9UERHOunvDq6bkag4OWgAqRJjwdhhDYqPETBbsIH0H26I3G82Vv
        hyJANoItEFx0dWiR98HYkd0DYKd1mtSsTfCVrCEqK0GLiSioOIG1w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4336312E1D2;
        Thu, 30 Jun 2022 13:05:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC60812E1D1;
        Thu, 30 Jun 2022 13:05:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 3/8] rebase-interactive: update 'merge' description
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
        <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <669f4abd59e7dbb13281e85144d085180934fd15.1656422759.git.gitgitgadget@gmail.com>
        <xmqqletgijul.fsf@gitster.g>
        <eb4345ce-8e1c-2f5f-7dfb-41979a89491a@github.com>
Date:   Thu, 30 Jun 2022 10:05:55 -0700
In-Reply-To: <eb4345ce-8e1c-2f5f-7dfb-41979a89491a@github.com> (Derrick
        Stolee's message of "Wed, 29 Jun 2022 09:02:25 -0400")
Message-ID: <xmqqiloif5e4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E844C468-F896-11EC-B349-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> Perhaps I should be a bit clearer that these are appearing in the
> comment section of the todo-file when presented to the user for editing:

Yup, it is good to spell it out for others.

> This does not appear to be used anywhere else.

Nowhere in our codebase.  I do not think we have a way to know if
users (e.g. hooks and scripts) depend on them, but I am reasonably
sure that nobody would complain ;-)
