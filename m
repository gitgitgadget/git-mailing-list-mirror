Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75B921F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 03:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389968AbfJYDpA (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 23:45:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57983 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfJYDo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 23:44:59 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AEA859772A;
        Thu, 24 Oct 2019 23:44:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r05W4HLtki4TkwHuDgrokJPXmZk=; b=FdZoYk
        KE4L2A1LFG/Mk7IYk5r0CdszLFXP/pGO9QSJQ65z9bidvyAFdjpmJQSJ5JUAI9XQ
        CqbYYjmXsyOPZOnmBA4sYPyPwCcXRsRsBvK/L02VlVQsTMBi1mSJ0DGpGyWJRwGr
        NAuRE9fmRXcYxMahbrvDGHX5z3xD5zovsFq6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K5+KvKy/+DJpnWsgYCDT2X3eLKU28zUB
        koQ6erhZ7HmuReyM0CMpO5doVg9Tur6wyXPW/9KPLeex0mrwtGINSBc2Gx0hDg4P
        eRIh4fP1EEFd/GuNA6103TLZmqxyKcv3LrAwhev1EIYGVmHPOZgwkfTENKLss63s
        P6huDjgY/D8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A6CE297729;
        Thu, 24 Oct 2019 23:44:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D32DB97727;
        Thu, 24 Oct 2019 23:44:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 00/14] t5520: various test cleanup
References: <cover.1571435195.git.liu.denton@gmail.com>
        <cover.1571739459.git.liu.denton@gmail.com>
        <20191024232139.GA76771@generichostname>
Date:   Fri, 25 Oct 2019 12:44:52 +0900
In-Reply-To: <20191024232139.GA76771@generichostname> (Denton Liu's message of
        "Thu, 24 Oct 2019 16:21:39 -0700")
Message-ID: <xmqq5zkdebez.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CEC42162-F6D9-11E9-88C9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> There haven't been any comments in a couple days so I think this
> patchset is ready for inclusion.

It's not like we are in a hurry that we need to fast-forward a topic
like this one (i.e. general improvement and clean-up, rather than
fixing regressions introduced in the cycle), so "a couple of days"
is probably being too impatient.

We'd prefer a positive ack or two.  

Thanks.
