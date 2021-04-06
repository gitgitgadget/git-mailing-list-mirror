Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A52C433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 23:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1EF761177
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 23:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbhDFXNe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 19:13:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55793 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbhDFXNd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 19:13:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A9D99B44F8;
        Tue,  6 Apr 2021 19:13:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z1Re0iZmvLiMC045fZ+6yREwGIg=; b=ofrfNF
        o/MSlr9yjJMW2R2q5BfoPhe/eFEeANb2WBzyB/zupEPzblbLAUFGtJ1O7mES6cAX
        5VfFNLbvRvjY6baAj2MUM0ypDqvHMYhoWc1oXfp71gkdjh6CBZP85JHCOvk81tRH
        xe1Od/GXQWWN94Ofc6LThZQuMPd9M6h9UqA8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V8c53Ygg5BblQFQI0/GNE0Z+jbbmmme6
        KNQxrtyHyQfbvAgWVoiTCk9ofaKqw3oXSm95FJXsYPE2Ul0SF7vKOnvVgFbcvf19
        ztoD2e4U+Np4t11ch61Nw/en5XelISXwJOBqRgHhg7Jw4gnVBukDCGx9vLW9Onoq
        fqDj5jiF8do=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E9B2B44F7;
        Tue,  6 Apr 2021 19:13:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 25B45B44F6;
        Tue,  6 Apr 2021 19:13:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org, newren@gmail.com, ross@skydio.com,
        abe@skydio.com, brian.kubisiak@skydio.com
Subject: Re: [PATCH] git-apply: try threeway first when "--3way" is used
References: <20210406025551.25213-1-jerry@skydio.com>
        <xmqqblas2b52.fsf@gitster.g>
Date:   Tue, 06 Apr 2021 16:13:23 -0700
In-Reply-To: <xmqqblas2b52.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        05 Apr 2021 23:13:45 -0700")
Message-ID: <xmqqk0pf0zxo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AFAEB2C4-972D-11EB-8A87-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Will queue.  Thanks.

Just to avoid confusion, "Will queue" does not mean "No further
updates are necessary from you".

It is a short-hand to say "Even though the version I just reviewed
may still want to be improved, it is in good enough shape to be
tested with other topics on the 'seen' branch, so I'll do so
primarily to see if there are any funny interactions with them".

IOW, I expect the patch to be rerolled before it is ready to be
merged to 'next' and below.

Thanks.

