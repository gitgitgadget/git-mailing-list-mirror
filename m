Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6422CCA0FEB
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 16:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347241AbjIAQsz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 12:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239317AbjIAQsy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 12:48:54 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22E910F1
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 09:48:49 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 863DF2597D;
        Fri,  1 Sep 2023 12:48:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=tmYKIKGpvS+9gvKYfw52n0+D/7XVDdxsJDOsxD
        DreOA=; b=WcHspSMGEie4Hn6jylqBA6nNieLtRu3M3P35ts/1slMhH9CEhMdBLP
        jayQloHB4ZyFBZ5Pvyln42DlWmvblRS22hXJdTbzKpG3p/Xf+IIojZyM7b2KpBfk
        /jiIEaOUGS/jxhRPZoF29KGRt/uAWmjL6VRCwshFCmtNJVbJQkDYo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E89E2597C;
        Fri,  1 Sep 2023 12:48:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DE72A2597B;
        Fri,  1 Sep 2023 12:48:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Drew DeVault" <sir@cmpwn.com>
Cc:     "Jeff King" <peff@peff.net>, <git@vger.kernel.org>
Subject: Re: [PATCH v4] format-patch: --rfc honors what --subject-prefix sets
In-Reply-To: <CV7EK073OLB2.3Q4Y31O55ZY9P@taiga> (Drew DeVault's message of
        "Fri, 01 Sep 2023 09:29:00 +0200")
References: <20230830064646.30904-1-sir@cmpwn.com>
        <xmqqsf808h4g.fsf@gitster.g>
        <20230831212950.GA949706@coredump.intra.peff.net>
        <xmqqv8cuswah.fsf@gitster.g> <CV7EK073OLB2.3Q4Y31O55ZY9P@taiga>
Date:   Fri, 01 Sep 2023 09:48:44 -0700
Message-ID: <xmqq1qfhrg9f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6AAA87A2-48E7-11EE-8907-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Drew DeVault" <sir@cmpwn.com> writes:

> +1 to proposed changes

Thanks, let's merge that version to 'next' then.
