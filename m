Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58F88202F2
	for <e@80x24.org>; Fri, 24 Nov 2017 00:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753003AbdKXAkK (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 19:40:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60082 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751663AbdKXAkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 19:40:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 08092A8921;
        Thu, 23 Nov 2017 19:40:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z4PmBNZ1slz9HGPT2qgmQ5GdV8s=; b=yfTNQa
        655vfjGTSRfIbqnn5NXI7Fdjrl543sOJwtBGvdRL7pC8Rn9AZUBAFT/izbzw/mW8
        xSf2hIVFJj3zU5pkN2rV48WjmCfbkzEEIIshPKiHO7qVo9lSNEkRVyDlvsMEKRsG
        ktq2ivZe3WfZ6OycqCbtx9g2Fh1QiXJVHn81o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WgWpqXTalzBRs1FmF0X+Wbzd6Ejok5Wl
        I/VlP0mrKvIgSDnDTivvx+SiF9/0wG0CsHibAKOylvbDAaIhdE9jyoJVlhPItOxs
        vxh4HrR1V48x4jZEinj5qagSByHyAZxfuGUr4/NltuLKy2htVfKyZeMWZZjkeEjU
        lcuSrOJSiIU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F11A5A8920;
        Thu, 23 Nov 2017 19:40:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72D3BA891E;
        Thu, 23 Nov 2017 19:40:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Ann T Ropea" <bedhanger@gmx.de>,
        "Git Mailing List" <git@vger.kernel.org>,
        "Daniel Barkalow" <barkalow@iabervon.org>
Subject: Re: [PATCH v3 5/5] Testing: provide tests requiring them with ellipses after SHA-1 values
References: <20171119184113.16630-1-bedhanger@gmx.de>
        <20171113223654.27732-1-bedhanger@gmx.de>
        <83D263E58ABD46188756D41FE311E469@PhilipOakley>
        <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com>
        <20171113223654.27732-3-bedhanger@gmx.de>
        <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com>
        <20171119184113.16630-5-bedhanger@gmx.de>
        <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com>
        <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley>
        <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com>
        <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley>
Date:   Fri, 24 Nov 2017 09:40:07 +0900
In-Reply-To: <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley> (Philip Oakley's
        message of "Wed, 22 Nov 2017 23:41:35 -0000")
Message-ID: <xmqqd148qzko.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0599673A-D0B0-11E7-80EF-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

>> We do not know until this change is released to the wild, at which
>> time we will hear noises about the lack of expected ellipses their
>> (poorly written) scripts rely on and tell them to set the workaround
>> environment variable.  We may not hear from such people at all, in
>> which case we may be able to remove it within a year or so, but it
>> is too early to tell.
>
> I was wondering if there should be a small documentation change for
> the env variable and states that it is a temporary measure for short
> term compatibility. Though I'm not sure where the 'right' place would
> be for it.

We list environment variables that applies git-wide in git(1), I
think.  If this is going to be only applicable for the "diff"
family, Documentation/diff-format.txt may be a better place, and
in that case the name of the environment variable may need to
include a word DIFF somewhere.


