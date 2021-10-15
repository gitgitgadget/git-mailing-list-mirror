Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A636C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B7BD604DB
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241295AbhJOQ2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 12:28:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53004 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241294AbhJOQ2d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 12:28:33 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B67E164A24;
        Fri, 15 Oct 2021 12:26:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0/E+TFHMvj63qrzMbDcC7Skqp4ibq6fn8okDoq
        ep3Wk=; b=n1jtKZOTYeEupSEOwPovmcOkLezm5X8E4kYVUOhtcy3iEeVwad49m3
        HIB8p+fVjtmDYjGXmF3HcbKL5YFnP1w8hMd5NU63MjW7274bR+E0lHCjMOnkRvgz
        DfxpIhwaiGszKrZgxNlVgsG96LKx34Egl6nR9EUS/7CiYGJi7NRTs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0471A164A23;
        Fri, 15 Oct 2021 12:26:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6411E164A22;
        Fri, 15 Oct 2021 12:26:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Carlo Arenas <carenas@gmail.com>
Subject: Re: [PATCH] Documentation: specify base point when generating
 MyFirstContribution patchset
References: <20211013122234.448845-1-bagasdotme@gmail.com>
        <xmqq1r4ofz0o.fsf@gitster.g>
        <f25fae40-0313-287b-5482-1c64cbe8cb64@gmail.com>
Date:   Fri, 15 Oct 2021 09:26:23 -0700
In-Reply-To: <f25fae40-0313-287b-5482-1c64cbe8cb64@gmail.com> (Bagas Sanjaya's
        message of "Fri, 15 Oct 2021 13:51:39 +0700")
Message-ID: <xmqqmtna8dao.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3B0F98A-2DD4-11EC-A858-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

>>...
>> 	chose 'master' as the base point (and the existing text
>> 	already says why).
>
> It has been described before:

Yes, re-read what you quoted and you'd find "and the existing text
already says why".

> Leave it as is?

Yes, that section can stay the same, as I said.

In short, everything I said in the message you are responding to
still stands.

Thanks.
