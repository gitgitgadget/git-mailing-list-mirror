Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8658C43219
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 18:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 940CE61107
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 18:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbhIVSzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 14:55:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57966 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhIVSzs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 14:55:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F4CEE90F2;
        Wed, 22 Sep 2021 14:54:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T/K9JqY5LPmdwuDRCyB0WY8WX8hhEuSY/Hoq5f
        k66Yc=; b=CIRWT8wHVNbKj0MZVlTPUqnHMaj1woSKzNENv0DQK4N2tcS63WP0Fo
        i6CfePUQtPQw3jlNfQTZW2yPNKKww81FQu95zS5SC9/ftcBEV91cu9k2npB9vGHp
        a4qCaeGLAv3Q3UGXWFxqWOHDQN5J0hoEMIAmj+wYsPZyhB9/+UQ0M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 08304E90F1;
        Wed, 22 Sep 2021 14:54:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 716F8E90F0;
        Wed, 22 Sep 2021 14:54:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] MyFirstContribution: Document --range-diff option
 when writing v2
References: <20210913194816.51182-1-chooglen@google.com>
        <20210920223226.25877-1-chooglen@google.com>
        <00f94ddf-7019-a5e0-8fd5-a88a4b1cc5c3@gmail.com>
Date:   Wed, 22 Sep 2021 11:54:16 -0700
In-Reply-To: <00f94ddf-7019-a5e0-8fd5-a88a4b1cc5c3@gmail.com> (Bagas Sanjaya's
        message of "Tue, 21 Sep 2021 12:33:59 +0700")
Message-ID: <xmqqr1dg786f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CF17776-1BD6-11EC-A7F1-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

>> +----
>> +$ git checkout psuh
>> +$ git branch psuh-v1
>> +----
>>   
>
> Alternatively we can branch off psuh-v2 from the original psuh:
> ----
> $ git checkout psuh
> $ git checkout -b psuh-v2
> ----

It would lose the continuity in "git reflog @{now}" while continuing
to work on the psuh feature.  So it may be an "alternative", but I
do not think why anybody wants to recommend ti as an alternative
when "tag the end of the v1 iteration and keep using the same" was
already given.  If the original said "stop working on psuh and start
a new branch called psuh-v2", and then "no, mark the notable point
and keep using the same" is offered as an alternative, it might be
worth sending a message about, though.
