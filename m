Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8414DC2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 23:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46EF02078B
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 23:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FyaJgiNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgI1Xl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:41:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63694 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgI1Xl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 19:41:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 604A1EFDBC;
        Mon, 28 Sep 2020 19:41:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=FyaJgi
        NHtSOQGQXKwpiamQluwSpZbIDv0G54sGzh4qCqDqn7XeFWA5+3UoMHEM0UCzRqwx
        wdVkjU0qYSr4YMBk2+5H4ybNSyU15LfPVByjJjedyQLtA/ZpqS/BOsp89/YOtu0Y
        8AIfx8HiHjOw4MDKXDOVRkDm93wtE+1rG2Gig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZvIysS3FgibUUdA7M3bZs74MELyZdTCS
        1i15cUhJElg0uMBFqsAOXIdRcTDX4gDb8Cz0hmQLkgmbl4l9fCmHOHPpQpQZbWKZ
        nxR1bv4rVQUkanRjBUG7rnqQJiqSeShKJKL7TJAymYF0Suu9MpRcav9UTFPMARqr
        Usl4artbYds=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 590CAEFDBB;
        Mon, 28 Sep 2020 19:41:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 746E9EFDBA;
        Mon, 28 Sep 2020 19:41:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Evan Gates <evan.gates@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] Doc: show example scissors line
References: <20200928202035.24218-1-evan.gates@gmail.com>
        <20200928225108.22634-1-evan.gates@gmail.com>
Date:   Mon, 28 Sep 2020 16:41:49 -0700
In-Reply-To: <20200928225108.22634-1-evan.gates@gmail.com> (Evan Gates's
        message of "Mon, 28 Sep 2020 15:51:08 -0700")
Message-ID: <xmqq8sctjwoy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2ED68ACA-01E4-11EB-AB03-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.
