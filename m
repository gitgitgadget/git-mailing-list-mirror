Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4E6C0015E
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 17:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjGERZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 13:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjGERZr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 13:25:47 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6867F1981
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 10:25:46 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B44481A2C6A;
        Wed,  5 Jul 2023 13:25:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RQY3dzuesqi3aaTJzXNgZrU9DFJXGpG8h3u7sy
        qgiiI=; b=Ilf+J83jmvHsIyzHg5BZmLvwEpoHTrXVpgwE9vkYe69oRTXMpcOOoB
        U1zOQLSNS1PoJxyY1cQJxabdMiNOxcgoFNHgpo0quwsrBpOrGS1OfuDqiQ+Ya4zg
        yTZdgDeB+4TKTgI7dL4Y41JUWAZpZi1Co4nhwddLKNFgtUGfdEGM8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC1D71A2C69;
        Wed,  5 Jul 2023 13:25:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F53C1A2C68;
        Wed,  5 Jul 2023 13:25:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] imap-send: drop unused parameter from imap_cmd_cb
 callback
References: <20230703063247.GA3524302@coredump.intra.peff.net>
        <20230703063402.GB3524421@coredump.intra.peff.net>
Date:   Wed, 05 Jul 2023 10:25:44 -0700
In-Reply-To: <20230703063402.GB3524421@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 3 Jul 2023 02:34:02 -0400")
Message-ID: <xmqqy1ju1d9j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F96D42B6-1B58-11EE-A1F9-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We could just mark the parameter as UNUSED. But since this is the only
> such function, and because we are not likely to share code with the
> upstream isync anymore, we can just simplify the interface to remove
> this parameter.

Sensible.  Thanks.
