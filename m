Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A6EC2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 18:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3542072C
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 18:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OCN9+t2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390323AbgAXSnx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:43:53 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55374 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390147AbgAXSnx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 13:43:53 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9FED29D688;
        Fri, 24 Jan 2020 13:43:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=taszLQdFHolB54m2NdSGzJBq8qQ=; b=OCN9+t
        2p6ubgGoppDREXZmfwo4Gc6w/RCKM+YFceA7pR6r/KOPHoBCubipwYoEfH/3dyzx
        nGPBts2k/J/16BFCMSqYggx4Fo5lXbfRvQSmfnc9xtFPF8gMfjgJdjp661WK180D
        kq+fgBjoULGD9DqvtyhBd6klybcA/6GftlKjw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c+/89k2o7X4wkE6Fl8lH2ZkludJ1xC+w
        c7B4DOfm+p+ucfgGuD+yKMj/s9PPBvFLBmWKlwzUuwOE0rwcL48L5ConkBE90Y1/
        uL5XWuVdFBzKiT5+HEfTjkO91eb7L3qaKcU7cR+f/mI8pvGHqHQYPE4eprGuHmFS
        A7iyzXjDd6Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 985809D687;
        Fri, 24 Jan 2020 13:43:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 72EC29D683;
        Fri, 24 Jan 2020 13:43:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v4 2/6] t1300: fix over-indented HERE-DOCs
References: <pull.478.v3.git.1579275102.gitgitgadget@gmail.com>
        <pull.478.v4.git.1579825267.gitgitgadget@gmail.com>
        <1b42f853996565ebb1304701cae6cfde8d5357b1.1579825267.git.gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 10:43:45 -0800
In-Reply-To: <1b42f853996565ebb1304701cae6cfde8d5357b1.1579825267.git.gitgitgadget@gmail.com>
        (Matthew Rogers via GitGitGadget's message of "Fri, 24 Jan 2020
        00:21:02 +0000")
Message-ID: <xmqqblqs1yqm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74B1F4D6-3ED9-11EA-8767-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Matthew Rogers <mattr94@gmail.com>
>
> Prepare for the following patches by removing extraneous indents from
> HERE-DOCs used in config tests.
>
> Signed-off-by: Matthew Rogers <mattr94@gmail.com>
> ---
>  t/t1300-config.sh | 168 +++++++++++++++++++++++-----------------------
>  1 file changed, 84 insertions(+), 84 deletions(-)

This step is new.  It makes sense, I think.

Thanks.
