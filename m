Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D4CC433EF
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 02:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhLXCPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 21:15:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63866 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350906AbhLXCPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 21:15:16 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 01B1FF1149;
        Thu, 23 Dec 2021 21:15:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lN6h7cB/01g27FSVPABZGrwaL08EKmDGo8Nsqu
        kf6z4=; b=Y3vKx1vSgKvdbuonGPUXLYJ+jyos6AuBNw6HvQAJ7nUz6FezQIxxo3
        Fl6QEonpQ8VVXVN3RqUnCIXHK6BThmtB/f5mC0QUfKdq3AuwYq87OF2yWLautYt+
        GQQMWEc9KYGH700jb5JwhMB3OEhthgMqths4UD/xEotltYsj2suOE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ECD4FF1148;
        Thu, 23 Dec 2021 21:15:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58E09F1145;
        Thu, 23 Dec 2021 21:15:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 0/3] preliminary fixes for reftable support
References: <pull.1164.git.git.1640287790.gitgitgadget@gmail.com>
        <xmqqk0fv83sk.fsf@gitster.g>
Date:   Thu, 23 Dec 2021 18:15:14 -0800
In-Reply-To: <xmqqk0fv83sk.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        23 Dec 2021 12:27:55 -0800")
Message-ID: <xmqqa6gq6959.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5515869E-645F-11EC-A7A4-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> What is going on here?  We have the same fix in two series?  Are
> these two series meant to be applied, or is this a beginning of
> splitting and resubmitting the other larger series into smaller
> chunks?
>
> I am not opposed to having two identical fixes to a high priority
> problem, one in a long series that may take longer to graduate and
> the other one in a short series that is trivial to verify.  I am not
> opposed to retract a longer series and trickle a number of series'
> that replace it, either.  I just wanted to know what is happening
> here.

I guess the answer is neither.

An unrelated change in this topic needed to touch a line that is
close to a line that was changed in the other topic, and you made
the same change as the latter in the same hunk---which in this case
helps with the merge of these two topics into the integration
branches.

Thanks.
