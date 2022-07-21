Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9647AC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 23:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbiGUXBc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 19:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGUXBa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 19:01:30 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D632F1D0F5
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 16:01:25 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D6CF13AA99;
        Thu, 21 Jul 2022 19:01:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LTCEZa8PLjzdEo0CDDXvReFbyelwyYrpMhBDzP
        3sqmU=; b=qCLEo687jb3zAk9xv8sqF9dGZfqYzFnDIl4EXJJEYyRe5+yxxv/EBY
        KBQ7m/i4b4qjbX87i8+0v0qxfzfZZwMpaC7tiE2Hp48Oq8V5vrUjTxKojF55tdNh
        fVpPK6cESKOY3f1hjTXzU9e406ETZZmAH/MS5wcv4paAZbPnkWzOs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9328A13AA98;
        Thu, 21 Jul 2022 19:01:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0499713AA91;
        Thu, 21 Jul 2022 19:01:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "tenglong.tl" <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v8 0/6] pack-bitmap.c: optimize error messages
References: <cover.1658159745.git.dyroneteng@gmail.com>
        <cover.1658393855.git.dyroneteng@gmail.com>
Date:   Thu, 21 Jul 2022 16:01:22 -0700
In-Reply-To: <cover.1658393855.git.dyroneteng@gmail.com> (tenglong tl's
        message of "Thu, 21 Jul 2022 17:05:42 +0800")
Message-ID: <xmqq1quedq9p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B03B758-0949-11ED-B3F3-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"tenglong.tl" <dyroneteng@gmail.com> writes:

> From: Teng Long <dyroneteng@gmail.com>
>
> Changes since v7:
>
> Remove [7/7] and will move to another separate topic.

If that is the only change, then I am relieved, as I can safely
ignore this round ;-)

The previous round (without the last step) has been in 'next' since
Tuesday and cannot be replaced.

It seems that both of the topics are in good shape.  Let's plan to
merge the other one about showing the scope of the configuration
variable in trace2 output down to 'next' soonish.

Thanks.

