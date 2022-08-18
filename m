Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D15C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 21:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346023AbiHRVfH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 17:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244045AbiHRVfG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 17:35:06 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE98BC814
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 14:35:06 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CBB6A1C188F;
        Thu, 18 Aug 2022 17:35:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vMlHvHoEhBFcSkEYgNPJPYYCAJJMzJtkxdufxW
        //GGk=; b=B0WXaluHW3xVqDuFBbKL0u0ajs7P+npiIlSxKgVVLhlT9os8E1N3cX
        yqyxJ3AvQyxp0R9HKnxWlYNvNaqMZoBKuTZRKrwQHOqlavsOd0Ruv4BvYlsxm4iq
        FVwcN0gKTD/Lq338YjSYIDuyQfRVjwff2DJPuN0HMdgUxPkGBinT8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C44961C188E;
        Thu, 18 Aug 2022 17:35:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5BFCA1C188C;
        Thu, 18 Aug 2022 17:35:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
References: <pull.1326.git.1660855703816.gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 14:35:01 -0700
In-Reply-To: <pull.1326.git.1660855703816.gitgitgadget@gmail.com> (Eric
        DeCosta via GitGitGadget's message of "Thu, 18 Aug 2022 20:48:23
        +0000")
Message-ID: <xmqq5yipnsl6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E13DB54-1F3D-11ED-B315-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Eric DeCosta <edecosta@mathworks.com>
>
> Though perhaps not common, there are uses cases where users have large,
> network-mounted repos. Having the ability to run fsmonitor against
> network paths would benefit those users.
>
> As a first step towards enabling fsmonitor to work ...

Didn't we already see the first step and got it reviewed?  I think
I've already merged the last round to 'next'.

Puzzled...
