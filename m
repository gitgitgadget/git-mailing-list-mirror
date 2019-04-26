Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC4F81F453
	for <e@80x24.org>; Fri, 26 Apr 2019 02:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfDZCUe (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 22:20:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56519 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDZCUe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 22:20:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E89967295;
        Thu, 25 Apr 2019 22:20:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EMb9uzdIN8fX
        eEJg1fwx5iZmbus=; b=ZhW1aJpuk5MYtCSRq9GfkWYe4qwXJAQihRUDx0tqqIwq
        +/r+wjOsU0EsHOIx9Z2ovoHMHkcuRwi4pvtrP4F+LGhm3eCJ0a8rRl/0yw879WJZ
        S4jGfkn9cBMd4wuAcOhWXs+2fuXfgd4k7E4BoR/J+4Wa+3roRfSWbtiuRSCFtAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=b+2JWN
        JnPek5dV1r3KUenUqmW45F0S3vZEFEae6qJW75KCuIdYYgxzyL1yI/Tk5mN/+aA/
        miAG58p0QcKPpwBEYNoXUOiXNjT4SR3UoZIVSBHOA084UqArSYzno6ezhg/9M7vj
        UlvTP2jbOwx6O1cqe+EmBxu6VDNGOgwqVRzkI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 96CC467294;
        Thu, 25 Apr 2019 22:20:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C9B0F67290;
        Thu, 25 Apr 2019 22:20:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        Derrick Stolee <dstolee@microsoft.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/5] commit-graph: create new version flags
References: <pull.112.git.gitgitgadget@gmail.com>
        <pull.112.v2.git.gitgitgadget@gmail.com>
        <4ddb82916321f093d88282ef4bcab99993339fb5.1556135881.git.gitgitgadget@gmail.com>
        <87bm0tsrf0.fsf@evledraar.gmail.com>
Date:   Fri, 26 Apr 2019 11:20:28 +0900
In-Reply-To: <87bm0tsrf0.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 25 Apr 2019 23:31:31 +0200")
Message-ID: <xmqqimv1wlqr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DD2E8C78-67C9-11E9-AF56-D01F9763A999-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> It doesn't make sense to start saying "version A" here when we make it
> to version 10, however unlikely that is :)

;-)
