Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC20EC35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 20:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C4E217BA
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 20:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P0+mKCSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgBEUHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 15:07:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58132 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBEUHa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 15:07:30 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB3D13AE1D;
        Wed,  5 Feb 2020 15:07:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cXyLshmkfY+EFNrk9zlg+wII6ew=; b=P0+mKC
        SBwL8bqbHY19uCdP7UjuU6GIKWUMrgTznwZtG/i6kCR0WBOgkQGjIVC//ucm25+l
        hPWenKW7Qs7eo07RVQRnx0L8xVOCehIs2zqq10WJCmwxt+poPL3DoNoh1cgTEGae
        Pn45CY3MnHgJ+92u6G+smF93DWTZ7KoPPlJGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XNsTltfr0IJcHrhtNIktcgcJhaVJs7eh
        0KqK6SDoYEo97XZxywGhrdyCY6tGZT7yxmfBhMlz0Mr4+VKa7nFzeUQujmYBdDsf
        FbG6KgwfbZgnPHHiFVcp70S3d8FTLyDW6Si6ejmSUGyQsRMGyuxsRyMbtZKJzeED
        ++FcjbY9EXA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D368D3AE1C;
        Wed,  5 Feb 2020 15:07:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2CDB63AE1A;
        Wed,  5 Feb 2020 15:07:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        martin.agren@gmail.com
Subject: Re: [PATCH v2 0/3] builtin/commit-graph.c: new split/merge options
References: <cover.1580430057.git.me@ttaylorr.com>
        <cover.1580862307.git.me@ttaylorr.com>
Date:   Wed, 05 Feb 2020 12:07:27 -0800
In-Reply-To: <cover.1580862307.git.me@ttaylorr.com> (Taylor Blau's message of
        "Tue, 4 Feb 2020 16:28:29 -0800")
Message-ID: <xmqqimkk6bnk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22D41C4C-4853-11EA-AAFD-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Here is an updated 'v2' of my series to introduce new splitting and
> merging options to the 'commit-graph write' builtin.
>
> These patches are updated to be based on the latest changes in the
> series upon which this is based (tb/commit-graph-use-odb), and contain
> some other fixes that I picked up during the last round of review. For
> convenience, I included a range-diff against 'v1' below.
>
> Thanks as always for your review.

Thanks, replaced.
