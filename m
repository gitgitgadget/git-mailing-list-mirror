Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68226C433FE
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 22:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351337AbiBKWiw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 17:38:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348124AbiBKWiv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 17:38:51 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E51D61
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 14:38:49 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1AE9A12469B;
        Fri, 11 Feb 2022 17:38:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Bucm0GveW4N/
        bqu79HU/mr50Mt7ZIPA4k42Bvr9gA1k=; b=VwzX9HecFZZ/u8shu0QlYWsLpCx5
        ILs0fHkz1eKeeqhx8IyWCzjQsAJgYY35gXbeySmVNUzjdcf8byMwr/f7/ZEqyJoQ
        JFdvwUngf+mJ6HjqlF24BdLqTXhMYEQKYhgK2V5KFdT/CduULI+0g2ZbUr24Ci7T
        D4yPOqSEv2G5f7Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12FC912469A;
        Fri, 11 Feb 2022 17:38:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 80BD1124699;
        Fri, 11 Feb 2022 17:38:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2022, #02; Wed, 9)
References: <xmqqa6ez60l8.fsf@gitster.g> <1886649.yonrKIyjYj@cayenne>
Date:   Fri, 11 Feb 2022 14:38:47 -0800
In-Reply-To: <1886649.yonrKIyjYj@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
        "Fri, 11 Feb 2022 22:01:44 +0100")
Message-ID: <xmqq8ruh9gg8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 60FB4E8C-8B8B-11EC-84CB-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

> On Thursday, 10 February 2022 01:12:51 CET Junio C Hamano wrote:
>> * bs/forbid-i18n-of-protocol-token-in-fetch-pack (2021-12-22) 2 commit=
s
>>  - fixup! fetch-pack: parameterize message containing 'ready' keyword
>>  - fetch-pack: parameterize message containing 'ready' keyword
>>=20
>>  L10n support for a few error messages.
>>=20
>>  Expecting an ack for fixup.
>>  source: <20211222075805.19027-1-bagasdotme@gmail.com>
>
> Looks good to me.

Thanks for an ack from sidelines.
Will squash and merge down without waiting further.

Thanks.

