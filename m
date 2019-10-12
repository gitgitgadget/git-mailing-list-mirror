Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 912521F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 04:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfJLESs (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Oct 2019 00:18:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60299 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfJLESs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Oct 2019 00:18:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2DD732BA6A;
        Sat, 12 Oct 2019 00:18:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sjRb20dgeZg76+xZYixYyCshbtg=; b=ARs+o0
        eIY2GxluCde6euDv2NiI61OUr2gdmiMDkDl7Jezqkdl/jpDD1FRp4ZRwfcy9iCst
        mVhqqMhnfWceUQBMhBx5EJMNJPzuiiDKY2pTHdp/wN9m8Qu3ty1wh/5sj/R4PoDn
        f1qXJ28VjdqO9AA8I6Hc1b8IeFAUadBCd2jKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LeJ38C5GSOqiq0RT/v1Criohvylqpr1l
        0HvAweYE9bkR1AQIyTqJyEDn95QU+FkD8T+LVeMHbzb9ZqfCO9in+ucWtvGPbQli
        Xv7uSBf2IvxOI+xzWFrZPoog6N4R+GU5EZRHQHjjtxtFfi50xx4BwqOHijIY4Oki
        K9w7hiISd0w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13D512BA69;
        Sat, 12 Oct 2019 00:18:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6362A2BA68;
        Sat, 12 Oct 2019 00:18:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 0/3] format-patch: learn --cover-from-description option
References: <cover.1566285151.git.liu.denton@gmail.com>
        <cover.1570821015.git.liu.denton@gmail.com>
Date:   Sat, 12 Oct 2019 13:18:44 +0900
In-Reply-To: <cover.1570821015.git.liu.denton@gmail.com> (Denton Liu's message
        of "Fri, 11 Oct 2019 12:12:49 -0700")
Message-ID: <xmqq8spqeguz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61B1CEDA-ECA7-11E9-B9E8-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Changes since v3:
>
> * Change --infer-cover-subject to --cover-from-description
>
> * No more test cleanup patches (they were merged in
>   'dl/format-patch-doc-test-cleanup')

With these patches, t4013 and t9902 seem to break, when queued on
top of dl/format-patch-doc-test-cleanup and also when merged to
'pu'.

Thanks.
