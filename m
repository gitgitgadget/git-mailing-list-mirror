Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D1C21F461
	for <e@80x24.org>; Tue,  2 Jul 2019 19:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfGBTOY (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 15:14:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64004 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGBTOX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 15:14:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D263376A12;
        Tue,  2 Jul 2019 15:14:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BcGoZ/XZddHHdu/fucey+NrPNkw=; b=S3F2YH
        5/FKEV1Fc3FzKcwH+4jMmBaDgaIqiesHy0f7qiOLsoOx16ExkLB3KrYIqycvkR5K
        84UzrnOAeYf49Y4ZaNV+IYEg+fHC0KG9s0cDidCdORjXgtM30XwJC5mVhWDhgQtW
        OMTxT03f5LvY1Dfr7yHFM0o8ioJjNUgbVpNfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DsKTMA6pOy1gHJ7sVf7V9Yzu8N+lT/w5
        ZSbI1E30kci5AABwGMATQTd1lAvermnq7TiGjcpq8/KtF196Z4w2OtUly/6My9LX
        SZCEOn7WAfiiaLI7bIy8SRorkjrvQdEEfkdvOizygDJkYkdwQHYRJMr2hIR7Z5JI
        N5RLgU6RSk4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CA8B576A11;
        Tue,  2 Jul 2019 15:14:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0091276A10;
        Tue,  2 Jul 2019 15:14:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Quentin Nerden via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Quentin Nerden <quentin.nerden@intel.com>
Subject: Re: [PATCH v2 2/2] docs: git-clone: list short form of options first
References: <pull.277.git.gitgitgadget@gmail.com>
        <pull.277.v2.git.gitgitgadget@gmail.com>
        <c562cf681f5c1c47cd77eead30ec9ae1eb7ca9e0.1562078259.git.gitgitgadget@gmail.com>
Date:   Tue, 02 Jul 2019 12:14:16 -0700
In-Reply-To: <c562cf681f5c1c47cd77eead30ec9ae1eb7ca9e0.1562078259.git.gitgitgadget@gmail.com>
        (Quentin Nerden via GitGitGadget's message of "Tue, 02 Jul 2019
        07:37:41 -0700 (PDT)")
Message-ID: <xmqqwoh02qrb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97471568-9CFD-11E9-99E1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Quentin Nerden via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Quentin Nerden <quentin.nerden@intel.com>
>
> List the short form of options (e.g.: '-l') before the long form (e.g.
> '--local').
> This is to match the doc of git-add, git-commit, git-clean, git-branch...
>
> Signed-off-by: Quentin Nerden <quentin.nerden@gmail.com>
> ---
>  Documentation/git-clone.txt | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Much easier to follow ;-)  Thanks.
