Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B41D71FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 22:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758058AbcLAWUv (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 17:20:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62636 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757993AbcLAWUu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 17:20:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 67C6053416;
        Thu,  1 Dec 2016 17:20:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=txh8u30F2vcbH6AYg6DCQ9hWFJg=; b=d2q2Fs
        BlIHVdxZLEJj3qZf9IYpS/yS2zuvf714BqTgDxkGIrkb5MLcZgiB/+9FDg2d5LXx
        5HrmIPhV+r3jtp9GkNxJ6dR7bb5NqDWZw8RUaVrxgvG74wMc9CCIy/tuFUEXv9U0
        yfx5MPQ9fRJ397XKqivR3vS3Z5WvrMr8oqp70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OJgYGyxoHy0IqAI7GOTHigWGvk5jKGMl
        ST8XKHlxc+4+XEmlBzpytj9vXZGpytp4fjYdDLD7jHiRLv280L8mSctWj0XBP9cq
        DqL/MD/VsR24Y2SfLZecPx85OBI+1WwpBdA8kOWeLkXSBakganjYzwNhGcwbnJbV
        c/qCeTH6q+4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C7D353415;
        Thu,  1 Dec 2016 17:20:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DE6CD53414;
        Thu,  1 Dec 2016 17:20:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alfonsogonzalez\, Ernesto \(GE Digital\)" 
        <ernesto.alfonsogonzalez@ge.com>
Cc:     Jeff King <peff@peff.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: EXT: Re: "Your branch is ahead of 'origin' by X commits"
References: <D465DC74.B911%ernesto.alfonsogonzalez@ge.com>
Date:   Thu, 01 Dec 2016 14:20:47 -0800
In-Reply-To: <D465DC74.B911%ernesto.alfonsogonzalez@ge.com> (Ernesto
        Alfonsogonzalez's message of "Thu, 1 Dec 2016 22:03:33 +0000")
Message-ID: <xmqqy3zz70lc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 69710796-B814-11E6-A98B-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alfonsogonzalez, Ernesto (GE Digital)"
<ernesto.alfonsogonzalez@ge.com> writes:

> I'm still not sure what it means for the branch upstream to be 'origin'
> only.

If only you checked who the upstream of your 'master' was before
doing the set-upstream-to, it would have been trivial to answer that
question, but that is water under the bridge now.

A wild guess is that the upstream of your 'master' was 'origin/HEAD'
(whose name, when fully spelled out, is "refs/remotes/origin/HEAD"),
which pointed to something other than "refs/remotes/origin/master"?

