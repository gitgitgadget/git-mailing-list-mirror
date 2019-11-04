Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED8D71F454
	for <e@80x24.org>; Mon,  4 Nov 2019 04:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfKDEPt (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Nov 2019 23:15:49 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50341 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbfKDEPt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Nov 2019 23:15:49 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3A74CAE307;
        Sun,  3 Nov 2019 23:15:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i419vBdPGFDVplPaz6wmeaNZCtU=; b=Dbm8AI
        J2WtaigV5w8mqp7thNnlQjAu+4opMvZuSraFWBlvlC3seTvmJUVn7p6MbHgWwXIr
        Fk/Rx0vC4oYqu+Qna3EptCjyT2PRsvKRtnGFknJ8/g32uSqkt3Y+yxj4VQTv/l7e
        o5hwlpUxPwA+GkxyxG6gcwKrp77UND8NJCH4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rWK9WCXCZ8weRG0kLOAORL0TfxwMbhV3
        k7HrLbtCOP1T36U+eBKz4OHb3rb63JtNKYVMvHkW8rr0mwLJuSS6h0n7U0dTf53E
        CFJ0jCzbZkzImulfXl7dmYKLCT6d34sLxInuhw11uC6TQwe6spwuYXQfE2g8wK8O
        ybaxXLVWux0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 33764AE306;
        Sun,  3 Nov 2019 23:15:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4851DAE305;
        Sun,  3 Nov 2019 23:15:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net, peff@peff.net,
        szeder.dev@gmail.com
Subject: Re: [PATCH v4] pretty: add "%aL" etc. to show local-part of email addresses
References: <20191029120914.14756-1-prarit@redhat.com>
        <b9516269-3c17-1e7d-27f8-83558b56d1bd@redhat.com>
Date:   Mon, 04 Nov 2019 13:15:44 +0900
In-Reply-To: <b9516269-3c17-1e7d-27f8-83558b56d1bd@redhat.com> (Prarit
        Bhargava's message of "Sun, 3 Nov 2019 08:28:46 -0500")
Message-ID: <xmqqpni8z37z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C66FD50A-FEB9-11E9-B3F1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prarit Bhargava <prarit@redhat.com> writes:

> Just re-pinging to make sure this didn't get lost.

I think it has been on 'next' for several days aleady.

