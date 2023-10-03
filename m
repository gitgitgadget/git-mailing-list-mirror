Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12705E7AD77
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 16:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjJCQmk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 12:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjJCQmh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 12:42:37 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C6CC4
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 09:42:34 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1E6A62CC06;
        Tue,  3 Oct 2023 12:42:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=nyGUol44salCGJqJxuk3cQ4C8wuq7VZNvWxpfP
        QGDvU=; b=pO0Xjepa4QR1LY+9OiLJ0EBBIAMcJ5DfGLrrbdhII/Vh6wQrwt3NhC
        YKupv6rWxdnmzfNdw+BR7uUhd6l+NqUalgJtPhDQycd9UNn6lnfxcFF984PwrgTT
        VFa5Ght+dOGHlFATT1mI7Tz9tLghrtKW/o7lKQ4J/noUyrSY5R42I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 165CB2CC05;
        Tue,  3 Oct 2023 12:42:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 03A122CC04;
        Tue,  3 Oct 2023 12:42:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yuri <yuri@rawbw.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Is git-p4 maintained?
In-Reply-To: <2f9081b4-e34f-38b3-a557-021c54e4384c@tsoft.com>
        (yuri@rawbw.com's message of "Tue, 3 Oct 2023 00:41:39 -0700")
References: <2f9081b4-e34f-38b3-a557-021c54e4384c@tsoft.com>
Date:   Tue, 03 Oct 2023 09:42:27 -0700
Message-ID: <xmqqv8bn1wuk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D73CC802-620B-11EE-8525-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yuri <yuri@rawbw.com> writes:

> Is git-p4 maintained?
> Is there any chance for these problems to be fixed?

The last time anybody touched git-p4 was July last year, but
there is no dedicated area maintainer active even back then, as far
as I know (if not, please raise your hand).

But there may be folks willing to help.  When I saw the patch[*] in
July last year, I was surprised to see it almost immediately got a
review to support it.  Your post may attract attention from others
who are familiar with "git p4" and/or the problem you are describing
and you folks may be able to join forces to improve it.

Thanks.

[References]

* https://lore.kernel.org/git/pull.1285.git.git.1657267260405.gitgitgadget@gmail.com/

