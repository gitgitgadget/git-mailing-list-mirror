Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CB2B1F463
	for <e@80x24.org>; Fri, 20 Sep 2019 18:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406488AbfITS2P (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 14:28:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50874 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406342AbfITS2P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 14:28:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A4842F8F5;
        Fri, 20 Sep 2019 14:28:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=m++HZeBja//j
        O/5q9K+5cgBefc8=; b=kXcWwQ4B7xwlMtrGcxDUFsijkkubPR5zn+Z1VM+wuYGb
        T1LU6xCLhVMKXpMhpEbq2XJoEkB70QABwzhdfXTKG/r2H6KZiwwHP35oIXEXEBwp
        5xpIW/rnvP4qRZLR1q/cQmhejeVBk5jCwrQSK9oVg9Perp84M4GrRZPwELH1oeg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=VkboVm
        K4EyMPb/THxIBtmTtKhSVUehZTotD1V7R+IFSLekuWrgTDSdle4udJBwYaV/Gkkg
        yXDWjOyckWC/4E+bKLjhENlm7uvXVB5zRqyn9leiBh5eLQRR8JLnSTXr8tvOzbI+
        4u0x2PJLDjmHWOzIOBZrYtV4Cl0DdyNxGEKLs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3251E2F8F4;
        Fri, 20 Sep 2019 14:28:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B0242F8F3;
        Fri, 20 Sep 2019 14:28:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] travis-ci: ignore already tested trees in debug mode
References: <20190919173514.24074-1-szeder.dev@gmail.com>
        <xmqqftkqvo8r.fsf@gitster-ct.c.googlers.com>
        <20190920181732.GC26402@szeder.dev>
Date:   Fri, 20 Sep 2019 11:28:11 -0700
In-Reply-To: <20190920181732.GC26402@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Fri, 20 Sep 2019 20:17:32 +0200")
Message-ID: <xmqqblvevn44.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6770DDE0-DBD4-11E9-83D9-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> But in the larger picture, I would expect that readers would more
>> immediately grasp what it is about if it were titled "do not skip
>> versions that have already tested good in debug mode"
>
> Will try to come up with a better subject line, but I don't have any
> usable ideas at the moment.

Subject: [PATCH] travis-ci: do not skip already tested trees in debug mod=
e

???
