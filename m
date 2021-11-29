Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1CDC433FE
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 20:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbhK2UyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 15:54:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51237 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbhK2UwE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 15:52:04 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D51BBF0630;
        Mon, 29 Nov 2021 15:48:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MeEEhWSBJIR8O3ze0WBOfxNKAJAlZL5GbpY7D5
        +5vbI=; b=ZqZJx4ObFl9JqGaRXhqpfIcCqk85yn9r5nwkv+2mk4X4xO/a9bPgO4
        SAFU0EkXiS15d0yAiRQzR4GQfq+SeepxTRfdyXlzzvRusMS2aPvtRGyEKE9TFU6J
        cRha2LX6cxzCmyarliy50t6SciiQ7lDoYRtMnVCAD0eBhqQ4CGtrU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB97CF062F;
        Mon, 29 Nov 2021 15:48:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 421F2F062E;
        Mon, 29 Nov 2021 15:48:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org
Subject: Re: vd/sparse-reset
References: <xmqqlf1caica.fsf@gitster.g>
        <dc976377-6c2d-2d82-a128-a4316c3bcee2@github.com>
Date:   Mon, 29 Nov 2021 12:48:44 -0800
In-Reply-To: <dc976377-6c2d-2d82-a128-a4316c3bcee2@github.com> (Victoria Dye's
        message of "Mon, 29 Nov 2021 10:56:17 -0500")
Message-ID: <xmqqo8626637.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE90DE24-5155-11EC-AEB0-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> Junio C Hamano wrote:
>> * vd/sparse-reset (2021-10-27) 8 commits
>>  - unpack-trees: improve performance of next_cache_entry
>>  - reset: make --mixed sparse-aware
>>  - reset: make sparse-aware (except --mixed)
>>  - reset: integrate with sparse index
>>  - reset: expand test coverage for sparse checkouts
>>  - sparse-index: update command for expand/collapse test
>>  - reset: preserve skip-worktree bit in mixed reset
>>  - reset: rename is_missing to !is_in_reset_tree
>>  (this branch is used by ds/fetch-pull-with-sparse-index and ld/sparse-diff-blame.)
>> 
>>  Various operating modes of "git reset" have been made to work
>>  better with the sparse index.
>> 
>>  Will merge to 'next'.
>> 
>
> I submitted one last change to this series in response to Elijah's review
> (threads: [1], [2]). I don't think there's any other outstanding feedback to
> address, so that version (V6) should be the one to merge to 'next' (unless
> any issues arise from the update itself). Thanks!
>
> [1] https://lore.kernel.org/git/c97e4252-b17a-c8c1-3bde-cbfe22a6e4d5@github.com/
>
> [2] https://lore.kernel.org/git/b3f33d40-d418-f285-4a32-1db7a2c4c465@github.com/

It is always a pain to have a topic that is still being rerolled to
be depended upon by other topics.  Once we merge this to 'next', it
would hopefully become easier to manage.

Thanks.

