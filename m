Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E39C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 01:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhLCBPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 20:15:55 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65465 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhLCBPx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 20:15:53 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F58A15DC3F;
        Thu,  2 Dec 2021 20:12:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2SmvSZ78gBCB8TdVQpjEjL6TLTRXZ4e/ch3Cdb
        tsXy8=; b=hDWj8oMlHnQgJHa2v+T4/1pEAvKbRUhErhW9p/CTLO1EzA1xuGepbD
        VBwf8Vguwt1BIK1J3NPy5RkxnHipS5EtV7GEhTssQOE2Nj+AV0QvvpdM4IUWFk9r
        9AOugJ8jVMnP63ttxAQ0dqHJR0c/z71yS++jJ0bxIftx8omh3phEQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0846015DC3E;
        Thu,  2 Dec 2021 20:12:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B5E2515DC3C;
        Thu,  2 Dec 2021 20:12:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2021, #07; Mon, 29)
References: <xmqqzgpm2xrd.fsf@gitster.g>
Date:   Thu, 02 Dec 2021 17:12:22 -0800
In-Reply-To: <xmqqzgpm2xrd.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        29 Nov 2021 18:16:54 -0800")
Message-ID: <xmqqa6hitrt5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 12F1AA02-53D6-11EC-87C5-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As of this evening, my tree is not yet in a good enough shape to
issue the next iteration of "What's cooking" report, but I've
managed to merge some topics to 'next'.  No, nothing exciting is in
there.  This first batch of topics consists of stuff that would have
been in 'next' or even in the release if the previous cycle were
longer by a week or two.

I plan to reserve time for picking and trial-merging other topics
that we want to have in 'next' tomorrow, so that I can finish the
"What's cooking" report with more topics marked for 'next'.

To make sure I can make progress, I'll promise that I will not look
at or comment on patches that are sent to the list tomorrow (or in
the coming few days), except that a reroll of an existing topic will
be taken as a sign that the stale version I have in my tree needs to
be replaced before it can be merged to 'next' (but I won't pick the
new iteration up---I know from experience that it would stall and
delay me).



