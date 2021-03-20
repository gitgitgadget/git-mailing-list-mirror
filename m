Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD56C433DB
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 21:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A26D661938
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 21:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhCTVLE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 17:11:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58885 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhCTVKn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 17:10:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5EA7AC2F8D;
        Sat, 20 Mar 2021 17:10:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R0afNJvU5rnmgty/+OYiaxlVFM4=; b=yLbK2c
        ZmzE9zCtpTdAHITMO8b99IrnlEOcpYVtzr6LNbU7UIGRAESDJ6ADiUWUsBLdd17d
        AdYXVqeGfiMjD+hyF3hF2vzh3wT+eQl5hYjAuwd8+kRrcm843Tpz/HJ0WghlO3lT
        BJoVr2l+aQ8Exy1ZE9iME+VxTxTE549ekTxaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SW2orRT0IR+XHsnyQkSKcpDAzgDdMpj1
        8f2R0tokpcsQ3CZb/9KGRRS5NaQds2f+x89mxV5pJ7ib7laSVqTsmiffYT8K7e+V
        dkJSybzgsHzq//NiKIO+sSqK23BTscBkNPJmaaROAOQbx55FWCALtbpKY8H63bS7
        Yw1IYOtirP0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 55B05C2F8C;
        Sat, 20 Mar 2021 17:10:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CEB40C2F8B;
        Sat, 20 Mar 2021 17:10:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/8] rev-parse: implement object type filter
References: <cover.1614600555.git.ps@pks.im> <cover.1615813673.git.ps@pks.im>
Date:   Sat, 20 Mar 2021 14:10:41 -0700
In-Reply-To: <cover.1615813673.git.ps@pks.im> (Patrick Steinhardt's message of
        "Mon, 15 Mar 2021 14:14:26 +0100")
Message-ID: <xmqqblbdjzu6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA6201FA-89C0-11EB-86BC-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> this is the second version of my patch series which implements a new
> `object:type` filter for git-rev-parse(1) and git-upload-pack(1) and
> extends support for bitmap indices to work with combined filters.
> ...
> Please see the attached range-diff for more details.

Any comment from stakeholders?

Thanks.
