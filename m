Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E6CC433F5
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 20:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE6860F9E
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 20:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhJRUb0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 16:31:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54144 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhJRUbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 16:31:25 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 26B3914761D;
        Mon, 18 Oct 2021 16:29:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vi1oV0H6jKzMtqmqgpU5uy/WUeHpuNpmdnCqyv
        93RYk=; b=ZQVmlRdBh3FdxWVQ3mKFj91u+060zcjK5IChfzqK/sy6To9r1Nxy3g
        z5A8xPyWZS74yo09YX97RkQcNDh5BodsBOQPCMDg/He5lnHwXX3Uf7JfUA32BuC4
        gIgBawMxR7WQTr91Bmg/92slWc5MNrJCIy1Hv9HsR3SJN3n5rJwFY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1FD1D14761C;
        Mon, 18 Oct 2021 16:29:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 63D54147618;
        Mon, 18 Oct 2021 16:29:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANN] git-branchstack: make pull-requests without switching
 branches
References: <20211018195755.pcdpx6xyjeawttyu@gmail.com>
Date:   Mon, 18 Oct 2021 13:29:10 -0700
In-Reply-To: <20211018195755.pcdpx6xyjeawttyu@gmail.com> (Johannes
        Altmanninger's message of "Mon, 18 Oct 2021 21:57:55 +0200")
Message-ID: <xmqqo87mulex.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D8A0D5E-3052-11EC-8135-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Altmanninger <aclopte@gmail.com> writes:

> I wonder if there are more use cases for creating/updating commits that are
> not on the current branch.

I think the canonical answer to that question is "git worktree add"?
