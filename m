Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7EF7205C9
	for <e@80x24.org>; Mon,  9 Jan 2017 02:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758886AbdAICEj (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 21:04:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53947 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753158AbdAICEh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 21:04:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 571865FD8A;
        Sun,  8 Jan 2017 21:04:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+NRpGcgHabaSC58sqzAZwOtLzIM=; b=taleWB
        oJeR+PWzFr2YVNVMEE7ALFLqoQ2IMKNRQNUHjhkYMwEpN0/5JWmDXTv9JbhMrUI6
        211LCdYqi3pRmU65xzAGSALtHU+ZyGQZJ1pmcGO9IodPrglxgUA2SmICEHqxLSLy
        EMGBAXQmc6aROCweNCEXSEGETNyTqlFh0DU5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c9G1Tux4t+q2de6QIJVnC4gtDznp2DpM
        qmElFT7NjyYOqYCKaC6u4wjcPPby4ZvUUrlFEI+rOYgrTPRpIp34O9pRljf6OY5e
        j4hssV3YlK1hUmPB9koG0ILApwwgDqv9uMVaAwIfyeCzW1VlHUcb/4IFu8dOFsho
        6Pbgoai/Ruo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D36F5FD88;
        Sun,  8 Jan 2017 21:04:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 97BCC5FD87;
        Sun,  8 Jan 2017 21:04:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v5 00/16] pathspec cleanup
References: <20170103184241.128409-1-bmwill@google.com>
        <20170104180411.150000-1-bmwill@google.com>
        <CACsJy8CM6FfHpVuqby=hjPmiYAxvJjzr1W6LdO5B82KQnTmmog@mail.gmail.com>
Date:   Sun, 08 Jan 2017 18:04:33 -0800
In-Reply-To: <CACsJy8CM6FfHpVuqby=hjPmiYAxvJjzr1W6LdO5B82KQnTmmog@mail.gmail.com>
        (Duy Nguyen's message of "Sat, 7 Jan 2017 16:29:31 +0700")
Message-ID: <xmqqlgulyoni.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F77CBB0C-D60F-11E6-B2A5-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Jan 5, 2017 at 1:03 AM, Brandon Williams <bmwill@google.com> wrote:
>> Changes in v5:
>> * Move GUARD_PATHSPEC to prevent checking if pathspec is null twice.
>> * Mark a string containing 'mnemonic' for translation.
>
> Argh.. I've run out of things to complain about! Ack!

Thanks ;-)  Will queue with your reviewed-by.
