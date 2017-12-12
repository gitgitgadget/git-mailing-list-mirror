Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 297881F406
	for <e@80x24.org>; Tue, 12 Dec 2017 20:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752527AbdLLUix (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 15:38:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53208 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752277AbdLLUiw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 15:38:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E74DC1263;
        Tue, 12 Dec 2017 15:38:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ypGSmsIecW5WdT+PgLHk2A7H1Tg=; b=W3/nXv
        NOeTgu2rTT1oE2f9APOiErQ0rKtlw6Sm4AEt6HWdLnpwyK/onN64CeRa9VqLvByZ
        tey80ydfDhGNUlsjJj/ltY2F6NCGmUbVGmTpUmQbsw3FEMd/YdOzPeN2RIC7VgSW
        96zscnRNVkXrAgTm0ARIxqgReleTd2/YRWphM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=grkqEEzEBDy+Cg6mmHNccLH5yxNU3c2I
        LEn/OFtGU4XMaJhedTRUhF5IxLTwh42jIhaWNDEc9TTHT2Y94CpP3FBb4s0DhpXI
        QHUPPRd6sC1NFqmi92FUKTL9YsUNzCtm+CXBdpnQWnyz2cR7qjGArTWviSAOZdNm
        0wj1S2wiHvQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 76C1BC1262;
        Tue, 12 Dec 2017 15:38:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB388C1261;
        Tue, 12 Dec 2017 15:38:50 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] convert submodule.c to not use the index compat macros
References: <20171212195352.146675-1-bmwill@google.com>
Date:   Tue, 12 Dec 2017 12:38:49 -0800
In-Reply-To: <20171212195352.146675-1-bmwill@google.com> (Brandon Williams's
        message of "Tue, 12 Dec 2017 11:53:49 -0800")
Message-ID: <xmqq7etr1y1y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 762E14E8-DF7C-11E7-95CB-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> This series removes the remaining users of the index compatibility macros and
> ensures that future uses of the macros will result in compiler errors.

Nice.  Will queue.

Thanks.

