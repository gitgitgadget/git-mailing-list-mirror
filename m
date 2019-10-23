Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBE2B1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 02:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387989AbfJWCIU (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 22:08:20 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50199 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731549AbfJWCIT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 22:08:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F0D8FAF8B3;
        Tue, 22 Oct 2019 22:08:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uoEv3jrDjC+7Rpyh/YZWp8cr0xg=; b=SLffHM
        O20335eL/6XUrzYi6hlo/H9mkwQHXOkg54i7Ao2SFKyn8W9YUMDY5MlPR+18lCQj
        hH4twEah/mtqzPNAZmWeXRdLON+nqIIHYmMz7ey+NtJ2wcglInEedx+0lqmk6pp+
        uwugkrlg5k0htaE2hYRWGJ8WyyX1wI5JkF3aQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FRG4+F92ZxVc80JNKQvZE894WYW1S2xG
        UQXdNC/uhZBkEstlrwkAAtR9XlBOJbISPr0WF1ObtExHCLEAVd56N6Uqk6nqQBUn
        bhx5ZLt/jneh9ODvR6sqz86LwcrmhYshVENe+xYuL8oz/y/+/9fp4n6ge9G+W6rg
        ejdg7uzAk3k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EA9C7AF8B2;
        Tue, 22 Oct 2019 22:08:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 233CFAF8B1;
        Tue, 22 Oct 2019 22:08:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] format-patch: create leading components of output directory
References: <ac3cc3df4452355dc41c58fe94961c37ca09ebec.1571653441.git.bert.wesarg@googlemail.com>
        <CAKPyHN3QQuX4Z8-sySU3DbQYj1mfTqGjzgX8RFw_H6UFA07ohw@mail.gmail.com>
Date:   Wed, 23 Oct 2019 11:08:12 +0900
In-Reply-To: <CAKPyHN3QQuX4Z8-sySU3DbQYj1mfTqGjzgX8RFw_H6UFA07ohw@mail.gmail.com>
        (Bert Wesarg's message of "Mon, 21 Oct 2019 15:20:39 +0200")
Message-ID: <xmqqh840jjsj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F90954C0-F539-11E9-B7CA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> Please ignore this. Will rebase on 2.24-rc0 and will only include the
> test changes.

Thanks.
