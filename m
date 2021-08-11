Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71593C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 17:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 452646101D
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 17:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhHKRak (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 13:30:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55199 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhHKRaj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 13:30:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E7D4D280F;
        Wed, 11 Aug 2021 13:30:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b0cfGBAbcTXgQlMq3SbEAh3WwjgCYsK+UV9TAs
        ATzlc=; b=Qmi7P5lXYqDFZt7A7Iw6L5VJuEToSgJdx3+avsHM4cNnS8i/18Wti8
        f2po8OKa+gqjcg0UADdN8+HE61wukjOAzAUrq044ii3Mdcguz0mGQY6+ax8O0yan
        WNDFyKhJNe0CDEGkz+Unuy6HVL8OLgV4xWL4PdwpAXjfAU42X83Lc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 63907D280E;
        Wed, 11 Aug 2021 13:30:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 80AC3D280C;
        Wed, 11 Aug 2021 13:30:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2021, #04; Tue, 10)
References: <xmqqh7fwbx86.fsf@gitster.g> <m2mtpo9s4e.fsf@gmail.com>
Date:   Wed, 11 Aug 2021 10:30:13 -0700
In-Reply-To: <m2mtpo9s4e.fsf@gmail.com> (Atharva Raykar's message of "Wed, 11
        Aug 2021 16:15:53 +0530")
Message-ID: <xmqq1r6zanyy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9C668AA-FAC9-11EB-AD5F-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Here are the topics that have been cooking in my tree.  Commits
>> prefixed with '+' are in 'next' (being in 'next' is a sign that a
>> topic is stable enough to be used and are candidate to be in a
>> future release).  Commits prefixed with '-' are only in 'seen',
>> which means nothing more than that I have found them of interest for
>> some reason (like "it may have hard-to-resolve conflicts with
>> another topic already in flight" or "this may turn out to be
>> useful").  Do not read too much into a topic being in (or not in)
>> 'seen'.  The ones marked with '.' do not appear in any of the
>> integration branches, but I am still holding onto them.
>>
>> [...]
>>
>> --------------------------------------------------
>> [New Topics]
>
> Kaartic Sivaraam had sent a patch to fix a cosmetic bug introduced by my
> add-clone conversion series which has already been merged to master:
>
> https://lore.kernel.org/git/20210805192803.679948-1-kaartic.sivaraam@gmail.com/
>
> I think it will be re-rolled soon. Just wanted to ensure this did not
> get lost among the other topics.

Thanks.  Will (try to) keep an eye on it.
