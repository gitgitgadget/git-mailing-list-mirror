Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74BA320989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753255AbcJJR6f (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:58:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59614 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753099AbcJJR6e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:58:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C940443914;
        Mon, 10 Oct 2016 13:58:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=nWl9wmH7Z89RXXZzQZmQXWPcKLw=; b=L30mGe
        PQfpqrlEoo19SpbqGGhfC1+EAcgpGzvvkM5m+wjS+PPRwfa6B34w33ec/phXkdFJ
        kM/ca3aBotjVA5qFqyRZc66E5dium9cA0GCz43ygTomd5dp2Jzo8PHZ8YTDu2FtO
        zCkM75aMOaOQO5RR1owxVEPwzniNUjLEMIlpk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JtLUskNDucNUP0SqpsgNRbrrFezUaa2f
        OZ/DtpNoVpLm85NfREhp7TVpsn6zpD2s4f6GP7yX/WPwUQDs6DTLJCGCTApQnqVc
        8vv9rm5fo5CRLoagb55+ui0ZUb8OABxi1iBj4Lau6q048ym+yE81C0k04wKEsa+X
        QlwYq8Cn4VI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0F6E43913;
        Mon, 10 Oct 2016 13:58:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B95343910;
        Mon, 10 Oct 2016 13:58:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
        Alex <agrambot@gmail.com>
Subject: Re: [PATCH v2] gpg-interface: use more status letters
In-Reply-To: <8e496061-ce6c-450f-7c9e-785572d50b79@drmicha.warpmail.net>
        (Michael J. Gruber's message of "Mon, 10 Oct 2016 14:59:49 +0200")
References: <xmqqk2dxp84i.fsf@gitster.mtv.corp.google.com>
        <c4777ef68059034d7ad4697a06bba3cabbdc9265.1475053649.git.git@drmicha.warpmail.net>
        <xmqqshsjiyn4.fsf@gitster.mtv.corp.google.com>
        <24ecc903-3e5a-47f6-f073-00a1c709d5e8@ramsayjones.plus.com>
        <85fa6296-17f0-0e8c-ec1b-54cd48c45223@drmicha.warpmail.net>
        <xmqq60pdbbxh.fsf@gitster.mtv.corp.google.com>
        <xmqqk2dli25w.fsf@gitster.mtv.corp.google.com>
        <8e496061-ce6c-450f-7c9e-785572d50b79@drmicha.warpmail.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
Date:   Mon, 10 Oct 2016 10:58:31 -0700
Message-ID: <xmqqtwckf5mg.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28C60A0E-8F13-11E6-96A0-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Sorry, this got "lost in vacation". Before that, I was looking for an
> easy way to test expired signatures, but gpg1 and gpg2 behave somewhat
> differently in that respect (2 does not allow to create already expired
> signatures).
>
> Is there anything I should or could do now?

I dunno.  It's your itch.

You can say "I'll need more time to figure out the way to test what
I am not testing here, so do not merge it to 'next' yet".

You can also say "This is good enough for now, so go ahead and merge
it to 'next'; more detailed tests can be done as follow-up patches
if needed".

You can also say "Thinking about it again, there is no strong reason
why we need to differentiate EXPSIG and EXPKEYSIG, so don't do this
SQUASH and use my original one as-is".

I'd be happy with any of the above and there may be other ones I'd
be happy with that I haven't thought of ;-)
