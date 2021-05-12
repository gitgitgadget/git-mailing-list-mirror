Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F5BC433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF3B661176
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhELXxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:53:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56150 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhELXde (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 19:33:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C3E9145848;
        Wed, 12 May 2021 19:32:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RBQDlG54TvbQ
        j9vTfZ24a6SGOFsBX4nrlNmhI5OdBiY=; b=t/u6td7cVVRaWVEk3OLchgNvoVbg
        HbPN5foKCTb9VHDgRkC9vtDBgHDVNfKA5O8oYRZBaialelDEAR64pO2PYkQ+HBjU
        XB8hI5XnLh0c+3wtAsbwvxDFKsfZrOv+Q4hK2i9WXFSsJYUmqiaqHZ2exNfaJzGt
        5dO/uLcCu9uKOqI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 450A8145847;
        Wed, 12 May 2021 19:32:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 80266145846;
        Wed, 12 May 2021 19:32:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Long Teng <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2] packfile-uri.txt: fix blobPackfileUri description
References: <xmqq4kffy224.fsf@gitster.g>
        <20210511064554.59924-1-dyroneteng@gmail.com>
        <xmqqpmxxknaa.fsf@gitster.g>
        <CADMgQSQfvacwfnhz=taR5904AJp=CWgiq50+5F0A=hN4jGo9pg@mail.gmail.com>
Date:   Thu, 13 May 2021 08:32:18 +0900
In-Reply-To: <CADMgQSQfvacwfnhz=taR5904AJp=CWgiq50+5F0A=hN4jGo9pg@mail.gmail.com>
        (Long Teng's message of "Wed, 12 May 2021 22:10:29 +0800")
Message-ID: <xmqq7dk3edfh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4BE190D6-B37A-11EB-A557-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Long Teng <dyroneteng@gmail.com> writes:

>>It seems that the above needs a bit more polishing?
>>
>>I am not sure if moving the sign-off higher and inserting a
>>three-dash line before "Jonathan Tan writes" would be sufficient,
>>but with everything under that quoted material does not seem to
>>belong to a proposed commit log message proper.
>
> Sorry, I misunderstood.
>
> I looked at some patches in the community. If I reply to the
> reviewer=E2=80=99s suggestion separately and then submit a new patch, i=
s it
> the recommended way? (Distinguish between the =E2=80=98reply=E2=80=98 a=
nd the
> 'patch').

Yes.  Some people seem to omit the final response to reviewer
suggestions on the previous round and just send a revised patch, but
it is much nicer to cleanly conclude the review cycle for the
previous round with a separate response (it could just be "yes,
you're right---I'll incorporate your suggestions in the next round,
thanks") before starting a new cycle.

And the "patch" side should be written to be understandable even by
those who do not have access to the review history of the previous
round(s)---imagine how it appears in "git log" output to those who
did not read the discussion on this mailing list, and write for
them.

Thanks.
