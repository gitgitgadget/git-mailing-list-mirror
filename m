Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2577AC00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 16:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiHOQCd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 12:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiHOQCb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 12:02:31 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E6F1C927
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 09:02:30 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 390BA19C9E2;
        Mon, 15 Aug 2022 12:02:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=58fpsQgJN2c+
        068y2A1skoyrda/JXMw4S/1IOMXarL4=; b=JUcbeb1tYFD4JMiMhJt9iQMnbQkF
        LZV0LMw1UhB9q0ZEHtPp+qb/+ZyDjxpVyug532PXc7yNYX1CGZQAVdYPHkjLLROh
        lznKDmqWGUTAYx7QAS9Om1/6BF6717fbX7BxXadqZtjBXeosk53TtusZpdWDn7rZ
        Hq+XHW//Z0E02dI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 30C8019C9E0;
        Mon, 15 Aug 2022 12:02:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D1E2719C9DF;
        Mon, 15 Aug 2022 12:02:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?5a2Z6LaF?= <16657101987@163.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] doc: add documentation for the hide-refs hook
References: <pull.1301.git.git.1659543457.gitgitgadget@gmail.com>
        <pull.1301.v2.git.git.1660524865.gitgitgadget@gmail.com>
        <e737997eb31088a0ebe58c1db0e393a45170eabb.1660524865.git.gitgitgadget@gmail.com>
        <CAPig+cQ4isWWEkfasdENzZWgUZzmBF9vXMTpM2XcxYaPgQbzSQ@mail.gmail.com>
        <B180C0A0-0628-43D7-B73F-3F39A981A2BA@163.com>
Date:   Mon, 15 Aug 2022 09:02:25 -0700
In-Reply-To: <B180C0A0-0628-43D7-B73F-3F39A981A2BA@163.com>
 (=?utf-8?B?IuWtmei2hSIncw==?= message
        of "Mon, 15 Aug 2022 22:49:43 +0800")
Message-ID: <xmqqedxh4hri.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A86BDCAA-1CB3-11ED-87AF-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=E5=AD=99=E8=B6=85 <16657101987@163.com> writes:

> thanks a lot ! I will update the patches right now.

Not "right now".

Instead of flooding the list with repeated "oops that was wrong"
updates, it may be more effective use of others' time to wait for
more feedback before acting on them, and to take time to proofread
the result of your updates before sending them out.

Thanks.
