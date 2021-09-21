Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2ACC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 01:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B301261107
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 01:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhIUBUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 21:20:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55698 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhIUBSF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:18:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8FCAF0F80;
        Mon, 20 Sep 2021 21:16:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IbuCetPBMz/ly7tvcGIEksaA5EdFkHxxkKJc7/
        4KLbk=; b=lOd+WKF3PpQxTwl93ZAycqSVVdim3D0YMJld+fruBRYdVyHv6WOL4f
        W7hiPQC0EbbrnLlsRdtL0Exa3eRyUrxXhrBqhtc3n/yzbiLF3RJLJgW7Ce/Q2Ap4
        6Ex+mdYX4PUh6sPUcCFLN8KRnOn+zfBP3tM40pdVY4Q55DuVOHcEs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1F1FF0F7F;
        Mon, 20 Sep 2021 21:16:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3910DF0F7E;
        Mon, 20 Sep 2021 21:16:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2021, #06; Mon, 20)
References: <xmqq1r5iaj9j.fsf@gitster.g>
Date:   Mon, 20 Sep 2021 18:16:36 -0700
In-Reply-To: <xmqq1r5iaj9j.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        20 Sep 2021 17:02:00 -0700")
Message-ID: <xmqqwnna918r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91494CD4-1A79-11EC-81FB-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The seventh batch is out.

By the way, I'll be mostly offline tomorrow (HR has been bugging me
about my accumulated vacation time, which is nearing the cap), so
please do not expect a quick response time until Wednesday.

Thanks.



