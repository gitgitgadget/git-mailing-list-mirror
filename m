Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61541C433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 18:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242234AbiAQStj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 13:49:39 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52501 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiAQStj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 13:49:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 159C8186D2F;
        Mon, 17 Jan 2022 13:49:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bCbyBXKeSdokJtnoItNHhWImQG6ORE9KRiwjyK
        sbAMY=; b=U0RiBstIfyYYidKpsi1bNLVFpMVVQT1zQIl22tNdU9l1u9xl6PtIPx
        JvvdJWlZiG0BoIRaFJVdmN+7mDQLF807vPShzxaR+Rk79HkPfhY1qIIEC5v6WtY9
        FykYJOPAonT2w79MdhaX5wm98avZNdeVGU2C8Psrg6MBpq7lJMtBo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F3AE186D2E;
        Mon, 17 Jan 2022 13:49:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7C8A3186D2C;
        Mon, 17 Jan 2022 13:49:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2] README.md: add CodingGuidelines and a link for
 Translators
References: <pull.1115.git.1642182615339.gitgitgadget@gmail.com>
        <pull.1115.v2.git.1642349490723.gitgitgadget@gmail.com>
        <6271ff4b-1821-0086-167c-b273ab252eb9@gmail.com>
Date:   Mon, 17 Jan 2022 10:49:35 -0800
In-Reply-To: <6271ff4b-1821-0086-167c-b273ab252eb9@gmail.com> (Bagas Sanjaya's
        message of "Mon, 17 Jan 2022 16:00:32 +0700")
Message-ID: <xmqqtue2uri8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37D0752E-77C6-11EC-94D8-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 16/01/22 23.11, Philip Oakley via GitGitGadget wrote:
>> +Those wishing to help with error message translation (localization L10)
>> +should see [po/README.md][] (a `po` file is a Portable Object file that
>> +holds the translations).
>> +
>
> I mean not just error messages are in po/*.po, but also usage and informational
> strings. We can say "Those wishing to help translating message strings
> (localization or l10n)...".

Yup, that sounds more correct.

Thanks.
