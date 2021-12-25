Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B76FC433EF
	for <git@archiver.kernel.org>; Sat, 25 Dec 2021 00:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhLYAiz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 19:38:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63958 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhLYAiz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 19:38:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6A0C1127E4;
        Fri, 24 Dec 2021 19:38:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8g5UhSAQokCWyZNRHr65JRCmDQfh01Nk8s+Ivj
        X/7zI=; b=MWd8zc5nRgSJ7sgqJfy8vmcyDeXb0MWw2iF4MDI/n0ZpNGnJ8HiaS7
        3u0HbDCoLPVBMzYXXiOUxPYUYMEq7u6P6ouHv2KkTJfTHnyutvWdqIB+U7knO12d
        STYp8FY6msVdN1QAboxibbuVghVW4Rr1uCwgTRHuB4ahsafx234c0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDE191127E3;
        Fri, 24 Dec 2021 19:38:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 30AA31127E2;
        Fri, 24 Dec 2021 19:38:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [RFC] squelch log4j inquiries
References: <xmqqmtkq6frf.fsf@gitster.g>
        <01d201d7f85b$4bffb2c0$e3ff1840$@nexbridge.com>
Date:   Fri, 24 Dec 2021 16:38:52 -0800
In-Reply-To: <01d201d7f85b$4bffb2c0$e3ff1840$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Thu, 23 Dec 2021 19:14:57
        -0500")
Message-ID: <xmqqo8551psz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09A7AAD6-651B-11EC-9D5A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

>> +No part of Git is written in Java, hence it is not susceptible to the
>> +log4j vulnerability that has been causing sensation recently.
>> +
> ...
> This is a good idea. I have had to reassure a whole bunch of people in my
> community about this, not really because of git itself but because of the
> Maven build associated with EGit/JGit that may (do) have this issue if the
> wrong version of log4j is available. I would rather not discuss the
> particulars of the attack vector in this mailing list.

As you can point those people at the message that started this
thread at the lore archive, I actually think that I already have
done enough to achieve our goal ;-)



