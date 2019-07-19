Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0A341F461
	for <e@80x24.org>; Fri, 19 Jul 2019 21:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfGSV0k (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 17:26:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51778 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfGSV0j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 17:26:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A884A865CD;
        Fri, 19 Jul 2019 17:26:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wwbWviUzW11loF+D9xDX6imkkp0=; b=g0FhLi
        OdtJn0zcG1fU9siVDd9IP31kr33DCREZlJCceGRiKBeV6m7Q5ZZn6gvYDntLMpYA
        Ql1tD4TK97URbloqrKrYgQkyka1YfS8sxI4o1UAs+KX0SC6Eg48rxOGNoi05I4tG
        lou5cGTUJdughLPqghGyYX3fvaszOp4JMgOPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NIxL1uit5Jkbp+ruSwwtOUgajf39yk2H
        ten1UIz0Iri/jkWzwd2BYJa7KEFmjOwW5ZZduVzisQUjwy5vfNCewAUZKYsaBrI9
        DxkjlfpsexbsDugIYKi9337KBhqxu8PWR6H0ZSE8llwp9WkZ/EubiERGX7kY8GEU
        etI1ZdhCUGc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A0683865CC;
        Fri, 19 Jul 2019 17:26:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CB2A6865CB;
        Fri, 19 Jul 2019 17:26:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Dscho <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Martin <martin.agren@gmail.com>,
        Phillip <phillip.wood123@gmail.com>,
        Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>
Subject: Re: [GSoC][PATCH v2 0/2] rebase -i: support --committer-date-is-author-date
References: <20190712185357.21211-1-rohit.ashiwal265@gmail.com>
        <20190718190314.20549-1-rohit.ashiwal265@gmail.com>
Date:   Fri, 19 Jul 2019 14:26:31 -0700
In-Reply-To: <20190718190314.20549-1-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Fri, 19 Jul 2019 00:33:12 +0530")
Message-ID: <xmqqa7d9vhq0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E26CBB6C-AA6B-11E9-8F32-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> Another revision to keep this thread alive.

And on top of what commit have these two been built on?
