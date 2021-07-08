Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C66C07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 18:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 477436143B
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 18:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhGHSOe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 14:14:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58542 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhGHSOe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 14:14:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0073BD8665;
        Thu,  8 Jul 2021 14:11:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tj6gayG87uZbW/oBwHaWDzaTjOkvt5dizfaiQr
        2Mn64=; b=NpMCm/utVwl8JqXHv+nKf1wjsYpLt8R3SSzhOuFFEIaa+mj8HZF/O0
        5Hfri7axlJEk5p5IxIVWwe0fnkiRJodOt6eBOHYLeIsCcLQa5UQxpDy5glai9hEn
        M1gfMtKMvktNr96o2qQHZp3NB2wQMMHT9wak0SqgIzUho1/uXqYfA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4E52D8664;
        Thu,  8 Jul 2021 14:11:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 00BD6D8663;
        Thu,  8 Jul 2021 14:11:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [Question] worktree vs. gitdir in [includeIf]
References: <003701d7741e$550b6510$ff222f30$@nexbridge.com>
Date:   Thu, 08 Jul 2021 11:11:50 -0700
In-Reply-To: <003701d7741e$550b6510$ff222f30$@nexbridge.com> (Randall
        S. Becker's message of "Thu, 8 Jul 2021 13:25:59 -0400")
Message-ID: <xmqqk0m0brq1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F7BDE660-E017-11EB-B34C-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> I am wondering whether there is, or are plans for, something
> analogous to [includeIf "worktree:path"] with a similar semantic
> to [includeIf "gitdir:path"].

I do not think there currently is an implementation, nor a plan, but
I offhand do not see downsides in a feature to let you conditionally
enable some configuration based on the location of the worktree.

Thanks.
