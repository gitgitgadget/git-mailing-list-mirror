Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CF491F735
	for <e@80x24.org>; Mon, 21 Nov 2016 23:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754610AbcKUXFK (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 18:05:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59564 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753003AbcKUXFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 18:05:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C1B051F8B;
        Mon, 21 Nov 2016 18:05:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DWtgN4ri+HP8jLY59p7rlroq5Os=; b=TyJbwN
        Pai1Ldl+9yNTg4XRGY2Qx94aKFmiqrVjw0h+8TIMF6zuXxhRrlZLZGcaePga1m1j
        ZBhCEHHdvm9mZ9kAnpR8a8Jx9l1sFX1QLqOII6PWhexpSo1LyVoIYt8nCbtF+BeG
        0nOHCVfgyZzpk+H9hMchNRtKurqD4QxqEyLzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mTTAraZCMSZYDgkpYXR1XdM84+3FHg/d
        x/lg02C7RXxhLJW14QSbthDBYIPxsuSdl9RzRD4N3Nn64zY8fVNbTXZtwfM4CrB0
        m4Ch6O4QLdpZ5Fd4wPOACiB/R5lEvV5k6zCFBsYzxjjc89Y/DP5DODmvD0Gw2owN
        fSIBYharF20=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 427FC51F8A;
        Mon, 21 Nov 2016 18:05:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B6C8951F89;
        Mon, 21 Nov 2016 18:05:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Nov 2016, #04; Mon, 21)
References: <xmqqpoloh3xa.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbCebHojPDUdHn2mmjUwRe-FOcnJqtoa828PJwC6P5mNw@mail.gmail.com>
Date:   Mon, 21 Nov 2016 15:05:06 -0800
In-Reply-To: <CAGZ79kbCebHojPDUdHn2mmjUwRe-FOcnJqtoa828PJwC6P5mNw@mail.gmail.com>
        (Stefan Beller's message of "Mon, 21 Nov 2016 14:57:43 -0800")
Message-ID: <xmqqlgwch1st.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F21A23EE-B03E-11E6-84D4-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> * sb/push-make-submodule-check-the-default (2016-10-10) 2 commits
>>  - push: change submodule default to check when submodules exist
>>  - submodule add: extend force flag to add existing repos
>>
>>  Turn the default of "push.recurseSubmodules" to "check" when
>>  submodules seem to be in use.
>>
>>  Will hold to wait for hv/submodule-not-yet-pushed-fix
>
> Which is cooking in next, so we'd want to include this into next as well?

Not really.  One step at a time.

