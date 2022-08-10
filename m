Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ED9C25B07
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 21:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbiHJVyv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 17:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiHJVyu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 17:54:50 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2355E80507
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 14:54:50 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2539314CF8B;
        Wed, 10 Aug 2022 17:54:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W0/NcJIMhOyq7U41ABUTn/0WEC+D+24eUunhsA
        zJsOo=; b=bOaxJFFAk+VsJ02kw4QcCPB7dwvoakQGSLOurWoRwQcX3iPp/wWZpc
        tDdfOEK2O6vhDjkUvyAXhRX+wjBBRi8/7GhQ2owpPQkb1nabg/aJS5EvSiGivn4w
        UVdgJpe2b3Mad26i0daoFqFHC60uHaps7dLmb3lik3U7g5lVNPdEY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DE4214CF8A;
        Wed, 10 Aug 2022 17:54:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6E8CB14CF89;
        Wed, 10 Aug 2022 17:54:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Xavier Morel <xavier.morel@masklinn.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] fsck: actually detect bad file modes in trees
References: <YvQcNpizy9uOZiAz@coredump.intra.peff.net>
        <YvQc9egGzwFomQbw@coredump.intra.peff.net>
        <xmqq4jyjkcij.fsf@gitster.g>
        <YvQnIuVzMrOaM589@coredump.intra.peff.net>
Date:   Wed, 10 Aug 2022 14:54:47 -0700
In-Reply-To: <YvQnIuVzMrOaM589@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 10 Aug 2022 17:46:10 -0400")
Message-ID: <xmqqsfm3ix20.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DBAB98E-18F7-11ED-962D-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Outside the scope of my patch, though. :)

Absolutely.
