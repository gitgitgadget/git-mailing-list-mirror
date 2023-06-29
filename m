Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74719EB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 20:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjF2U5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 16:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjF2U5A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 16:57:00 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5131719
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 13:56:59 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB27D1994D6;
        Thu, 29 Jun 2023 16:56:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/6A5FjKj9FHLPKWMuhoRw34Hejr926w+doWGxR
        5+poY=; b=tJmHNjSDpIfo4JToF1S+DThMrYiCemG9Z9QFBtwoFC+cwzu9glJpyL
        2lw9d1SQQO0Siwdv81LdVpfaCm8ruYYhnMeMEeplFo+MMYJKJ764Yf+IRGkqrI0Y
        6/use4N6O6UsLRMdJUOy1Bwq7RKMvqnGRkvakstuYGekcJ50eaD6c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D300E1994D5;
        Thu, 29 Jun 2023 16:56:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 458CF1994D4;
        Thu, 29 Jun 2023 16:56:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Majer <adamm@zombino.com>
Cc:     git@vger.kernel.org
Subject: Re: SHA256 support not experimental, or?
References: <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>
        <xmqqmt0iajww.fsf@gitster.g>
        <65148753-7071-d5d5-3b4e-bad020e6ab63@zombino.com>
Date:   Thu, 29 Jun 2023 13:56:57 -0700
In-Reply-To: <65148753-7071-d5d5-3b4e-bad020e6ab63@zombino.com> (Adam Majer's
        message of "Thu, 29 Jun 2023 12:53:16 +0200")
Message-ID: <xmqqpm5e7zs6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CC64C6E-16BF-11EE-8DA9-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Majer <adamm@zombino.com> writes:

> So maybe my question should be reworded to "is sha256 still considered
> early stage, for testing purposes only with possible data-loss or can
> it be relied on for actual long lived repositories?"

My understanding is that they are in a happy place where they are
just as usable as SHA-1 based repositories have been.  As we have
well-worked out interoperability design but no implementation, it
may have to change once we discover something missing in the design,
though.  But without such clarification, you already know the answer
to the above question in the message you are responding to.  Having
a migration path means "possible data-los" is not in the picture.

> The scary wording should be removed
> though, as currently it sounds like "data loss incoming and it's your
> fault" if one chooses sha256

Good.

THanks.

