Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8A532095B
	for <e@80x24.org>; Sat, 18 Mar 2017 18:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751708AbdCRSOm (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 14:14:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61653 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751666AbdCRSOm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 14:14:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C0D4887856;
        Sat, 18 Mar 2017 14:14:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=87Iv8+OE5P+L
        5uBybk2oLjYpNCM=; b=mMvv2ovCezIvQNLAFrJ6VmWd23cPFHQ+qxUZ2/rE+nuk
        vQE8JTHjGTluANcUKprETZCDa+mUbMz/a5UDIEFBl+FLcVJhP59W3OvjB/P9VG7j
        ossIgtLkymlCktKXE7+Zk978KmmL4Ucsj+/qvwdVdx14AzYbCgcI4jdhs4lpevw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Z4+JMs
        ULP/olq77DiiSp65pl/IidG68FOwc0N/ZDV5EFZG2YLdaAFiH6uXTqV86eI5LJT4
        f3e+7R2bh6+7wWMXtS+nQPGSalVJvHdK12MNcMGxhBkPmQLGfkLSIPAWziw1L1Uj
        eBzu8/z6Ti0ZQIM+mWn6CqAsPHmpGCqRKhK7A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B804F87855;
        Sat, 18 Mar 2017 14:14:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D055387852;
        Sat, 18 Mar 2017 14:14:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCH 1/8] tag: Remove a TODO item from the test suite
References: <20170318103256.27141-1-avarab@gmail.com>
        <20170318103256.27141-2-avarab@gmail.com>
Date:   Sat, 18 Mar 2017 11:14:38 -0700
In-Reply-To: <20170318103256.27141-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 18 Mar 2017 10:32:49 +0000")
Message-ID: <xmqqvar6310x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C0A2943A-0C06-11E7-8BC3-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the test for "git tag -l" to not have an associated TODO
> comment saying that it should return non-zero if there's no tags.
>
> This was added in commit ef5a6fb597 ("Add test-script for git-tag",
> 2007-06-28) when the tests for "tag" were initially added, but at this
> point changing this would be inconsistent with how "git tag" is a
> synonym for "git tag -l", and would needlessly break external code
> that relies on this porcelain command.

Makes sense.

I'll retitle s/Remove/remove/ so that "git shortlog --no-merges"
would look more consistent, though.

Thanks.
