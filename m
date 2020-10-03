Return-Path: <SRS0=BObu=DK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B174EC41604
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 22:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43675206CD
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 22:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zg9H9ZG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgJCWWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Oct 2020 18:22:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60479 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgJCWWA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Oct 2020 18:22:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 904CD683D5;
        Sat,  3 Oct 2020 18:21:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r0+b6CJ2fpnNLJN1Rl4W8zAuJbI=; b=Zg9H9Z
        G0CN2M1LOz4RlQ2yIRp1gkGOKC9qi6IpwVJPbc4tlcUcQUX7FKucRCrXqJ4v+uny
        JMx5bwfn322PCj2hoXQ8YztG7esODHZQd6hP7aVQGS511+ShFiE2NaisNCVxAQf4
        L51ZdTOqLJEEpjNmiwvybs432w++wrRY13Eqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dbAMIZgXI339ja9YabRBKuxx1oyPl23t
        /jXpVH6vySh9R1e2zrH9et21aDttvMVSlzR9Sd6lNTU/o3/mD5rKHz1+nvkzCHvh
        upDUHq9/kTn07H2QKixB+aq3ZNbWZsExYPv50pNbCLRd+OYxIbENKWmlLKzGYhZu
        bgRed+vnkRU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 797E3683D4;
        Sat,  3 Oct 2020 18:21:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E50DF683D3;
        Sat,  3 Oct 2020 18:21:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] po: adjust for the recent change in
 send-pack/transport-helper
References: <pull.742.git.1601763568860.gitgitgadget@gmail.com>
Date:   Sat, 03 Oct 2020 15:21:57 -0700
In-Reply-To: <pull.742.git.1601763568860.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Sat, 03 Oct 2020 22:19:28
        +0000")
Message-ID: <xmqq1rif7xx6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9BB7366-05C6-11EB-9015-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>     po: adjust for the recent change in send-pack/transport-helper
>     
>     I hope that I am being helpful here... Please let me know if I should
>     just leave the translations alone instead.

I think you should.  The i18n coordinator needs to update all the
entries anyway and that process is quite mechanical.  Accepting a
handful manually edited entries now would mean that the later
automated process to scan all the sources and pick up updated
messages will need to be audited to ensure these manual entries are
not overwritten/dropped.

