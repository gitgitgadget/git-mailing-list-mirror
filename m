Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73798C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F221222B3
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbgLHW1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:27:35 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62628 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730547AbgLHW1f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:27:35 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CD32FEFD11;
        Tue,  8 Dec 2020 17:26:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3usbgg+hWHhm5Casi2qPcAWdQPI=; b=KHhgLv
        2sEdyZjv44KsNdZM1h+L3gu9L49inAgDc5Vg3RceRNo+H0s+dFprZYzk/nfGEWJO
        eQ5YnWQ0lY5uexBzXYtNTX0NFNkvZ/y2UEHbirys3c0MUPhTlucJq+gSOHn/MVw6
        Xn44iYXTqPA7usrXrHvbHx6zym2gcaamvs0yM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k8qnpl62bhCR7MPlb51AQ3+uQLrIAnYC
        L0ADRXpNQpEHabSzf2U9yeAPzkpUrp30l2hJEli8QJAS3uG9zAByBLJ4jj0BsII7
        N4KrbWvfSqOZ5zZfYcJUhMlV1UpmeeqdsbAxEj962GrZYkKqnX2iIfnN05zeN+cp
        QqZVHz8xAVM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C6F3BEFD10;
        Tue,  8 Dec 2020 17:26:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0C9F5EFD0A;
        Tue,  8 Dec 2020 17:26:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sangeeta <sangunb09@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [Outreachy][PATCH v7] diff: do not show submodule with
 untracked files as "-dirty"
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
        <20201110083900.88161-1-sangunb09@gmail.com>
        <CAHjREB7_BScE3zZVUZho4xi0OTdpsJTqLAbqhS0Tcd_xF6gqHA@mail.gmail.com>
Date:   Tue, 08 Dec 2020 14:26:50 -0800
In-Reply-To: <CAHjREB7_BScE3zZVUZho4xi0OTdpsJTqLAbqhS0Tcd_xF6gqHA@mail.gmail.com>
        (Sangeeta's message of "Tue, 8 Dec 2020 19:06:57 +0530")
Message-ID: <xmqqczzk53yt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 784D2C98-39A4-11EB-A7F7-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sangeeta <sangunb09@gmail.com> writes:

> Hey Junio,
>
> In the "What's cooking in git.git" you mentioned that this patch is
> left on doc update and some adjustments in "git status".

Ah, thanks for reminding.  I do not think I've picked the updated one
up yet.

Will find time to take a look later.
