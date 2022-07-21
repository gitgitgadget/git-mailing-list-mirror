Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8BEC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 17:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiGURrW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 13:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGURrV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 13:47:21 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9515B787
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 10:47:19 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A352C1AA0F3;
        Thu, 21 Jul 2022 13:47:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iHEjtbdmhMoW7A/xp1g0wqejGRCuzVQ1wSZm5J
        MPSuo=; b=bt+49NhzE4W1hPM8mmxs4j0KTMp+iB5qqHz6gIG4y6WaA03Ymq+iOq
        rQ2opDuUdB6RTzpE3Ldr2tB1zvRjic0pAPrYEVDVlmPN5i+GognKQWlb6eNIaT0h
        bZeMK1QmALTjFE/EXBX1GQiyhHnSOkbXSw/FJzZrimMIVpWCAbHOs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C4AA1AA0F0;
        Thu, 21 Jul 2022 13:47:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4B59B1AA0EF;
        Thu, 21 Jul 2022 13:47:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Amir Montazery <amir@ostif.org>
Cc:     git@vger.kernel.org
Subject: Re: Coordinated Security Audit for git. Contacts needed
References: <CADKuG0uzh3syzgfiPLepiTLXNzkoYhLFX1h-DE3C7c8j6HXALQ@mail.gmail.com>
Date:   Thu, 21 Jul 2022 10:47:14 -0700
In-Reply-To: <CADKuG0uzh3syzgfiPLepiTLXNzkoYhLFX1h-DE3C7c8j6HXALQ@mail.gmail.com>
        (Amir Montazery's message of "Thu, 21 Jul 2022 11:49:51 -0500")
Message-ID: <xmqq8romicil.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 284D692A-091D-11ED-A0F5-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amir Montazery <amir@ostif.org> writes:

> We would love to collaborate to establish communication channels with
> key maintainers. Would it be possible for one of us to join one of

We do not call people "maintainers", but "developers" and/or
"contributors".

> your community meetings for 5 minutes? Or is there a key person we
> should be engaging?

There is no "community meetings" other than the informal "stand-up"
irc discussion that is biweekly.  The log of the latest is at
https://colabti.org/irclogger/irclogger_log/git-devel?date=2022-07-18
but generally speaking we are not into "synchronous" communication.

You come to this mailing list and start talking, and that is how you
are heard by community members, which you're already doing fine ;-).

In case you are not familiar with Git, you can see output from

	git shortlog --no-merges -s -n --since=2.years | head

to see who have been the active contributors.

Thanks.

