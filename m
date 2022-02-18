Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E403C433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 16:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiBRQvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 11:51:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbiBRQvB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 11:51:01 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E098D15A227
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 08:50:44 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F4B718CE9E;
        Fri, 18 Feb 2022 11:50:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ToRK5I5gFZYhDBqS0dVw6fqA8iKmfxaQkoplri
        agEVA=; b=mly+HOTg1280maZpanaqlYJntTXBU0nx1lhEawkNW8MEWiAhxpoGJ0
        cSK/NqYbR0djYvN0M781FCtiMxzptKksYP7iehp0HrSpv1lAx6HzOfjnAXQfNenQ
        gVzZeBWo0UkQTP+5FpKj3uF71ocQHzFgS66ctVf5ceYU/uQCzGW+8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 485B818CE9D;
        Fri, 18 Feb 2022 11:50:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AF96C18CE9C;
        Fri, 18 Feb 2022 11:50:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: ds/core-untrac[k]ed-cache-config
References: <xmqqley93rkw.fsf@gitster.g>
        <CABPp-BEcUt-q4vXok=FqZSswPbdUT38=X3kUocbBKO5ydDPrQg@mail.gmail.com>
Date:   Fri, 18 Feb 2022 08:50:40 -0800
In-Reply-To: <CABPp-BEcUt-q4vXok=FqZSswPbdUT38=X3kUocbBKO5ydDPrQg@mail.gmail.com>
        (Elijah Newren's message of "Thu, 17 Feb 2022 21:19:40 -0800")
Message-ID: <xmqqbkz43yqn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E85D054C-90DA-11EC-9585-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Thu, Feb 17, 2022 at 5:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * ds/core-untraced-cache-config (2022-02-17) 1 commit
>>  - dir: force untracked cache with core.untrackedCache
>>
>>  Setting core.untrackedCache to true failed to add the untracked
>>  cache extension to the index.
>>
>>  Will merge to 'next'.
>>  source: <pull.1058.v2.git.1645131630140.gitgitgadget@gmail.com>
>
> Any chance we could first rename the branch to insert a missing 'k'?
> 'untraced' and 'untracked' may only differ by a character, but their
> meaning differs a bit more...

Wow, embarrassing.  Thanks.
