Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0732C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 00:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiGKAqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 20:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiGKAqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 20:46:16 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2062EB4BB
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 17:46:16 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5837E1A009F;
        Sun, 10 Jul 2022 20:46:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IZtrxB2KyeoZ
        xwTmTN1bdXu+M3ZpFYu2yI4TsWlDZhU=; b=aidBdnRSxLKcCIuKI9h5snoqVyxl
        8Ngi7hDOYpbJKSDhhDu8KBSnAqpL/KvFxksW9qHeay9b96qDoFThh3Xd7qRKog2w
        p0IMV9ny2u23NqiEztRtA9bmO3pt4H6b4ynguuvSpnT4SQbbnLnY02YkdKg7FHjg
        8rtwwDQoDzOUlp0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 449001A009E;
        Sun, 10 Jul 2022 20:46:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DECEB1A009D;
        Sun, 10 Jul 2022 20:46:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     lilinchao@oschina.cn
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2022, #02; Fri, 8)
References: <xmqq4jzquiok.fsf@gitster.g> <202207102031058469922@oschina.cn>
        <xmqq7d4lrkyb.fsf@gitster.g> <202207110151444952947@oschina.cn>
Date:   Sun, 10 Jul 2022 17:46:10 -0700
In-Reply-To: <202207110151444952947@oschina.cn> (lilinchao@oschina.cn's
        message of "Mon, 11 Jul 2022 01:54:10 +0800")
Message-ID: <xmqqfsj8pjcd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DC57DD42-00B2-11ED-8660-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"lilinchao@oschina.cn" <lilinchao@oschina.cn> writes:

> The new input after you fixed "rpc_state=E2=80=9Dinitialization issue i=
s
> just discussing the future work I guess?

Isn't the series broken without the suggested fix-up I queued on
top?  If so, an updated patch that does not need such a fix on top
is what the series needs to come out of the stalled state, I think.
