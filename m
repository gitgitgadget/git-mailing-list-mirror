Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB72C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 23:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2A19610CA
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 23:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhJ1XJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 19:09:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52141 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhJ1XJw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 19:09:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D84CC163FC5;
        Thu, 28 Oct 2021 19:07:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ab82+FxtHwQWNqAVY4ZAKLFs4RcANuX9+MlLGl
        HPmaA=; b=FivM4lQKR5sRJpl6etFGxg3VUUmlnnYz24MHs1tvOMXmGYrpLEoSpu
        IBGKQvE3iZJJkoTAfG0V7/7GuDwu1qd/hxE03d76Qoqzz0moYl4vcmLcvAU1zmHf
        kSrKY8lmfQNPLgEtnPECqpbWp7bWF2tHOTlE8lEACdzQdoZKQtU54=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B85ED163FC4;
        Thu, 28 Oct 2021 19:07:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 22B4F163FC2;
        Thu, 28 Oct 2021 19:07:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/7] Allow clean/smudge filters to handle huge files
 in the LLP64 data model
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
        <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
        <YXsk8XBwmErf2I3I@camp.crustytoothpaste.net>
Date:   Thu, 28 Oct 2021 16:07:21 -0700
In-Reply-To: <YXsk8XBwmErf2I3I@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Thu, 28 Oct 2021 22:32:18 +0000")
Message-ID: <xmqqmtmsoija.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE9666FC-3843-11EC-8571-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This series seems sane to me.  I'm delighted we can fix this issue with
> so little code, since it's a been a very inconvenient problem for a lot
> of Windows users.

Yup.  I do find the goal this series aims is quite worthy, and the
size of the series is "reviewable in a single sitting" bite-size,
which was pleasant.

Thanks.
