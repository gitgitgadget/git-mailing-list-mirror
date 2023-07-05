Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52449EB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 17:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjGERfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 13:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjGERfP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 13:35:15 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4011188
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 10:34:46 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 923601A2E49;
        Wed,  5 Jul 2023 13:33:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7YUXnHnuYaFQykpwfUWMET+QZaMzAJxjKYaEGr
        iXdrk=; b=yHbTe2Cgw+8R6eyS9HbYEZYdKmLXMHUO6sjuHVfo38304H2Q5xM5YY
        9aUeISwlQFmNP+mLVgc6OlXxjIBdi/t+IdTxch3LqZcj+A/cSrf7bwh5y1ye18b2
        67s481Wa7/cJp18z0EpfLu8vS1Y23Qi4FUK4qc/1AI1wq+CB7v+xA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A50C1A2E48;
        Wed,  5 Jul 2023 13:33:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E7A1B1A2E47;
        Wed,  5 Jul 2023 13:33:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v4 6/6] common: move alloc macros to common.h
References: <20230630202237.3069327-1-calvinwan@google.com>
        <20230630202346.3069950-6-calvinwan@google.com>
        <xmqqfs685zw1.fsf@gitster.g>
        <CAFySSZBDur-1+XG2AetS6jZ=mkv0esFFT5HgQnQ-SVsrpgKXew@mail.gmail.com>
Date:   Wed, 05 Jul 2023 10:33:51 -0700
In-Reply-To: <CAFySSZBDur-1+XG2AetS6jZ=mkv0esFFT5HgQnQ-SVsrpgKXew@mail.gmail.com>
        (Calvin Wan's message of "Wed, 5 Jul 2023 09:25:57 -0700")
Message-ID: <xmqqpm561cw0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C3A04EA-1B5A-11EE-A7BF-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

>> Is this step mistitled?  There is no "common.h" in this round.
>
> Ahhhh my pre-vacation brain managed to correctly edit the commit
> message, but not the header
>
>> For that matter, when the series makes a big change like this round,
>> please update the cover letter so that those who are reading it
>> without having seen the prior rounds can understand what the series
>> is about.  It will equally help those who have seen prior rounds,
>> too. what is going on.  E.g. The cover letter of v1 emphasized why
>> moving many things to common.h was a great thing (and promised to
>> talk about it more in patch 3), but that focus certainly has shifted
>> in this iteration that no longer even creates "common.h", right?
>
> That's correct. I'll reroll this series with an updated cover letter
> and fixed commit header.

That will help others, but in the meantime I'll just tweak the
commit log message to say "to common.h" -> "to git-compat-util.h";
otherwise the series is ready for 'next', right?

THanks.
