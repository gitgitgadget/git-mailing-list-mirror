Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73102C4727E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 22:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1644020866
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 22:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N4NGXhB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgIYWVj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 18:21:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52619 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbgIYWVj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 18:21:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 090A872C5E;
        Fri, 25 Sep 2020 18:21:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uv9UX18FjJa9JU+5IxSEGnyQzXM=; b=N4NGXh
        B2bCUYftkkZ9NxcDaQwu6SDvQ2hysUfX6iOTbnrSuBJvC1D7VRZEh92pM0iKSfeD
        Ihyk6fnbMeMiZa0Ytuu60tjPCn7BnM28Gn31Lxz8f9QVIkXhrAs8PD7Y5fs1TdTe
        qsCHwh5b1l7jps3EcnGOHQPxaOaldR/05/nPg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=agQYFim3UHJPLbKtvjY4CJwgCQV2szcm
        EwhADOdg4jFIFvqWyEYzcRMzYJ1qYAy0BVLFAB1sWJ7RQZyWLk5h1ObuoprqeH08
        CiQiI7/lqLGfItrqot+OVo2QxqQhw1Lht9vwoN9t7SYaO+si/TWD5BCDrzU05q7J
        0kZDGAgiwf4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF25A72C5B;
        Fri, 25 Sep 2020 18:21:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DA38772C5A;
        Fri, 25 Sep 2020 18:21:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 02/26] t5411: add basic test cases for proc-receive hook
References: <20200925221944.4020954-1-gitster@pobox.com>
        <20200925221944.4020954-2-gitster@pobox.com>
Date:   Fri, 25 Sep 2020 15:21:34 -0700
In-Reply-To: <20200925221944.4020954-2-gitster@pobox.com> (Junio C. Hamano's
        message of "Fri, 25 Sep 2020 15:19:20 -0700")
Message-ID: <xmqq8scxjy4x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 794BFC84-FF7D-11EA-ACDA-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Ditto.  An operator error.  Please disregard.
