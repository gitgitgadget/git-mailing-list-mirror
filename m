Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D61B20958
	for <e@80x24.org>; Mon, 20 Mar 2017 17:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754443AbdCTRIx (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 13:08:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58815 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753575AbdCTRIv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 13:08:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3CFE7A267;
        Mon, 20 Mar 2017 13:05:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=KF3Hgt
        V2UfP//Q7rZvS36wO7fjyJn3MvbWThyUS+Jqyh0DOG/lR5jFSiJ9TPPXkX33qfnl
        munUcnD7YWkQz1yxucXYQsofZ1TyI6q1ZtPkWhHaAtY8e4PDQrDD5jI9XCTXmUDT
        QcUiTnHDf5upeIAXreFaRLLfRti2G9fFZobcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K5vrgllKoHqr6o8cKALq6JM0sIMekJV9
        FJJIbJfK3AQ1mfDkKy8wcN99Jiinv2TX9wfeJzkZL6RD9BCiExe66hatqRqoWg93
        kbNLAUIOemji1WzMCRIEJJYv8xUqBCBVzbdu/Vyow6IJGn54zOTLsOxpfSTAHUNZ
        dLRiaxeQXgg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D31C7A265;
        Mon, 20 Mar 2017 13:05:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 97E9C7A264;
        Mon, 20 Mar 2017 13:05:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: change erroneous --[no]-whatever into --[no-]whatever
References: <20170320132029.24604-1-avarab@gmail.com>
Date:   Mon, 20 Mar 2017 10:05:04 -0700
In-Reply-To: <20170320132029.24604-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 20 Mar 2017 13:20:29 +0000")
Message-ID: <xmqqwpbjx4jj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D62BBD6-0D8F-11E7-9450-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.
