Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6DDC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 06:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbiBJGrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 01:47:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbiBJGrP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 01:47:15 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44439DC5
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 22:47:17 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 83436102E39;
        Thu, 10 Feb 2022 01:47:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kYfzeWDXa64gJCSBatSYM4NTwEQ1wtYOyzf+Km
        o4BPQ=; b=ZZhBxR1mBgiLGK7raWViBsIekX9lMkLlg0KeVcUzjX+c77sRBFUS0O
        Ac+exdbuBTXV3pqg1pIsGwaIlOS4iPqY5bnOFeBeknOk9XbkmSQYLJACaZgBP0nF
        8rCRTOcHRLDLK4WvS8v8tgrTSHk+sV0orCm+RPFzLyLrfkasDgZl0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B55D102E37;
        Thu, 10 Feb 2022 01:47:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E61F7102E36;
        Thu, 10 Feb 2022 01:47:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     jaydeepjd.8914@gmail.com
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] t/t0015-hash.sh: removed unnecessary '\' at line end
References: <20220208092339.651761-1-jaydeepjd.8914@gmail.com>
        <20220208092339.651761-2-jaydeepjd.8914@gmail.com>
        <81e8a217-356d-65cd-3a89-f20ef9c1a5d7@gmail.com>
        <xmqqleyjxzs4.fsf@gitster.g>
        <c64e52e1-3916-dc7a-60d7-98c324814f0e@gmail.com>
Date:   Wed, 09 Feb 2022 22:47:14 -0800
In-Reply-To: <c64e52e1-3916-dc7a-60d7-98c324814f0e@gmail.com> (jaydeepjd's
        message of "Thu, 10 Feb 2022 11:22:40 +0530")
Message-ID: <xmqq4k57xlot.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48BC6D5A-8A3D-11EC-B8CD-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

jaydeepjd.8914@gmail.com writes:

> Thanks for the feedback.
>
> I have a few more questions regarding contributions. 
> I have seen that some command documentations lack consistent synopsis compared to other commands.
> Is it on purpose or are improvements to those documentations welcome ?

That's hard to answer, as what you perceive as "lack consistent" may
or may not be consistent from other people's perspective, without a
concrete "here is the comparison I am talking about, and this makes
the two comparable" patch.

> Also, I have read some mails about "noise" in the mailing list. What
> does that mean? Does it mean very small patches (like mine)? I just
> want to make sure so that I donot repeat any mistakes :)

"noise", "churn", etc. are used to refer to low value changes that
would interfere, by touching the same area of code or documentation,
other topics that have greater impact.  t0015 seems to be quiescent
right now (no topic in flight fixes or modifies it), so a small-ish
change that does not substantially improve it would not count as
one, at least right now ;-)
