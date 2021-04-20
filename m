Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E57C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81F7A61418
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhDTXcB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 19:32:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63085 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbhDTXcB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 19:32:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D843ED1793;
        Tue, 20 Apr 2021 19:31:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6Ex3CEBqpkjtG1RUTnijVzkOR6c=; b=oJrGmC
        WeNYAkCNs4rw0NLxw9qF9Y3pDIIvZ8EOEOo/h/WO2aDJxBQbh/z11WDtb4TSgBnz
        vURTsS4xauxLLmpGuqy8l0XagECGL2I3Tx0q+mYGuGfrDYAjZfe5qOqx3PQcOeGR
        MEUx1WwznYGAuNxZwKoifbwNQe3vlKp++sGs4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mKrtXJAjHvQHyBOKy9GphZ3ijHnHtM8/
        IUAmUokIriZgPLNm+QmW/nPZTtpDnL6hd+14sA2hpNdFmG6j1QVRhQFae3oTUC4t
        QGxDsL9D1b7c0XQFJjTHfyrjJ6uF8SfUUqDRwc5rbgkSLeb3/zVD1ZLL77ZRBPvi
        Ad0268wM5B4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D0959D1792;
        Tue, 20 Apr 2021 19:31:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 67781D1791;
        Tue, 20 Apr 2021 19:31:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Document how we do embargoed releases -
 improving mail template
References: <pull.917.git.1616796767.gitgitgadget@gmail.com>
        <pull.917.v2.git.1617025385.gitgitgadget@gmail.com>
        <565d7982d870fb1b7644a9777aef6be7ee174dba.1617025385.git.gitgitgadget@gmail.com>
        <robbat2-20210420T193302-520335089Z@orbis-terrarum.net>
        <xmqq5z0g4oc9.fsf@gitster.g>
Date:   Tue, 20 Apr 2021 16:31:27 -0700
In-Reply-To: <xmqq5z0g4oc9.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        20 Apr 2021 14:51:02 -0700")
Message-ID: <xmqqwnsw1qk0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87BD19A0-A230-11EB-987B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> HTMLdocs and Manpages are as far as I am concerned part of SOURCES.

Sorry, NOT part of sources.
