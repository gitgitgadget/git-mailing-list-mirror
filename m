Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64A6C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 22:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 810DD6128C
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 22:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbhJGWkC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 18:40:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59295 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbhJGWkC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 18:40:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2292BE7F57;
        Thu,  7 Oct 2021 18:38:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7uS9najzJ9cFEfQCRG+WPr3di+XDmo9Eg5XCrG
        JEMD8=; b=CQ+4I0XZ6m+0rVUGpdmMhbNCmVHqzhncJxnOIfDb39KwfO8w6t64cQ
        6XtxWuVKnzfp81+hsuH3gBa0kXrMKzPAG5zYgsddKd3hc51iXnTl3A5MSaudWR4D
        pmUiknD/e8qPs0omGh7uxLz7vtW+xvagkPsFmqZY+M1nR4/7ANcrE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 08044E7F56;
        Thu,  7 Oct 2021 18:38:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2C1DCE7F54;
        Thu,  7 Oct 2021 18:38:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/10] leak tests: mark more tests as passing
References: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
        <CABPp-BEpCa7dxYqe2R82N_eVzx5e17C2w+d1zD9XWzyEXCDbPw@mail.gmail.com>
Date:   Thu, 07 Oct 2021 15:38:04 -0700
In-Reply-To: <CABPp-BEpCa7dxYqe2R82N_eVzx5e17C2w+d1zD9XWzyEXCDbPw@mail.gmail.com>
        (Elijah Newren's message of "Wed, 6 Oct 2021 09:26:48 -0700")
Message-ID: <xmqqmtnko3zn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D47F204-27BF-11EC-A8CA-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I like the series.  It does have the potential to annoy folks who want
> to add additional tests which make use of git commands outside the
> area they are modifying and which happen to have pre-existing leaks.

True on both counts.

Except for the t000-*.sh thing being a separate, and s/white//
everywhere, I think all of them looked sensible and almost ready to
be picked up.

Thanks.
