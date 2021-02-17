Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF454C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 01:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67AEB64E02
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 01:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhBQByz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 20:54:55 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54386 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhBQByy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 20:54:54 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6DA2011C4BE;
        Tue, 16 Feb 2021 20:54:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LLHcCoXS6LvWkpmO7tvj8spMJX8=; b=HBGK15
        yeCGjfZ0TSRq3X2a6MuZGfJa6v/Lg2pcNeY0rXjGztMVIQyur0+zTmNyjUrbP8fD
        L5bPT15hyKTG8QwZKC/YLRFsomsbEbci9cHkb8CLNTDrJ8vROjTEsc3Iot0TEa67
        UPJnAtoPwJl6/nRcWdHndb8fO2ocgMnDkxiiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HIiXbYsF6ep7s5ybFGQN+vzQMYBrAnPw
        HHZs0VtDJ9/2fgkW+Mtz4bRHOwEVRG4vnRazMaus/mK7T6NtyGa3/h9gp2a+0UX5
        RnPNh0/qViTh2RN6g5bMIG8yA3J8dcuuueGqUr6NHunrA6HoJ04taSexavg4+/qT
        2ci64+xTK64=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 564CA11C4BD;
        Tue, 16 Feb 2021 20:54:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 902DF11C4BC;
        Tue, 16 Feb 2021 20:54:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 00/11] FSMonitor Preliminary Commits
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
        <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
        <42714a3b-cccc-d61b-1dc1-5f2f8fcaa0dd@jeffhostetler.com>
Date:   Tue, 16 Feb 2021 17:54:08 -0800
In-Reply-To: <42714a3b-cccc-d61b-1dc1-5f2f8fcaa0dd@jeffhostetler.com> (Jeff
        Hostetler's message of "Tue, 16 Feb 2021 14:00:05 -0500")
Message-ID: <xmqqmtw3mpbz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 072A28DA-70C3-11EB-BEB6-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 2/3/21 10:34 AM, Jeff Hostetler via GitGitGadget wrote:
>> Here is version 2 of this series.
>
> I didn't see this series in the "what's cooking" emails and
> was wondering if there was something that I still needed to
> attend to.

I think it fell through the cracks.  It seems that Taylor gave a
reviewed-by for the whole set in v2 but as a reply to the cover
letter of the original series, and no messages in v2 saw any
comments.

I just picked them up and queued.  Thanks for pinging.

