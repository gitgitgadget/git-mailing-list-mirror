Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32351EB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 16:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjF1QY4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 12:24:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55656 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjF1QYp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 12:24:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E180818FEB2;
        Wed, 28 Jun 2023 12:24:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UbgKBcHIHGOtc+3FVJ1Fr4Uj6Szy2ecpaJegbl
        /AlUY=; b=oD4oLzTsMOgxdVtuDb1T+9UR+9oEw6FS6oyG5F7wsL9jEnZxKlJfqf
        ZGGmSnb+Qu11L3RD1BfriFvEVSbJ5+J3WKjUrw9ABP+UnvXwm3VcouYbg2BPr3+N
        8XTJo4cxE96771gMSr++sPIEypNe2dHMIkp6eYtQ57Opu9o24aWTw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6D9818FEAF;
        Wed, 28 Jun 2023 12:24:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3ABA518FEAE;
        Wed, 28 Jun 2023 12:24:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2023, #07; Tue, 27)
References: <xmqqcz1gftdn.fsf@gitster.g>
        <20230628095421.7249-1-tenglong.tl@alibaba-inc.com>
Date:   Wed, 28 Jun 2023 09:24:42 -0700
In-Reply-To: <20230628095421.7249-1-tenglong.tl@alibaba-inc.com> (Teng Long's
        message of "Wed, 28 Jun 2023 17:54:21 +0800")
Message-ID: <xmqqjzvneer9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49EACA3A-15D0-11EE-8F93-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * tl/notes-separator (2023-06-21) 7 commits
>>  - notes: introduce "--no-separator" option
>>  - notes.c: introduce "--[no-]stripspace" option
>>  - notes.c: append separator instead of insert by pos
>>  - notes.c: introduce '--separator=<paragraph-break>' option
>>  - t3321: add test cases about the notes stripspace behavior
>>  - notes.c: use designated initializers for clarity
>>  - notes.c: cleanup 'strbuf_grow' call in 'append_edit'
>> 
>>  'git notes append' was taught '--separator' to specify string to insert
>>  between paragraphs.
>>  source: <cover.1685174011.git.dyroneteng@gmail.com>
>
> There are no pending issues I think ;-)
>
> Please let me know if there are some obstables to merge.

Yes, please do (this is not a message to Teng, but to others) ;-)

Thanks.
