Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A1941F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 00:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406664AbfJRApG (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 20:45:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52295 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfJRApG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 20:45:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 989829574F;
        Thu, 17 Oct 2019 20:45:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cBzjaxyll+Xwdbr2V4LLWZQdxtA=; b=vX8uQ4
        1sH6l93gEdRW3/M02Bm9zfosJgXs8WYdiF1qNqBlrW7wu6E/PCw9q9dvV2TzZVUL
        oTsvKeQ7UMztH5jazsEc2FYwgGFX7IT9ebzeIUq1TeQNP7X4UaEQ4MrCKukTS1XQ
        tp5qJ/R6L73CSfcz6qIM4axzJK6rckzfq6h4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aFXuHnRBygO4Ylcgw9pjY5qK4hBsIe1v
        82EHz7H0Tq6JC879J11dw3gz+DLgk3ZKGq8MyNsw4l/KUCjgbG3zrNjdXzX6zqA8
        A56+2FATLYYEFkEkueIiG4K+HMSywt5a+r++3H5uhDtowLsvCfo7WNqtCZAq3oVU
        AP4pKeWbXGg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 908709574E;
        Thu, 17 Oct 2019 20:45:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9FF699574B;
        Thu, 17 Oct 2019 20:45:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] notes: fix minimum number of parameters to "copy" subcommand
References: <20191015163631.21808-1-congdanhqx@gmail.com>
        <20191016051841.19896-1-congdanhqx@gmail.com>
        <20191016051841.19896-2-congdanhqx@gmail.com>
Date:   Fri, 18 Oct 2019 09:44:59 +0900
In-Reply-To: <20191016051841.19896-2-congdanhqx@gmail.com> (Doan Tran Cong
        Danh's message of "Wed, 16 Oct 2019 12:18:41 +0700")
Message-ID: <xmqqa79y7ugk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 849E10E6-F140-11E9-AEA6-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Doan Tran Cong Danh <congdanhqx@gmail.com> writes:

>  Documentation/git-notes.txt |  6 +++---
>  builtin/notes.c             |  2 +-
>  t/t3301-notes.sh            | 40 +++++++++++++++++++++++++++++++++++--
>  3 files changed, 42 insertions(+), 6 deletions(-)

Thanks, makes sense.

