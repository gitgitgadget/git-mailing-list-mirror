Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7662DC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 22:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CCFB613A1
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 22:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243264AbhI1W0Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 18:26:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63651 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243210AbhI1W0T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 18:26:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63D48E209E;
        Tue, 28 Sep 2021 18:24:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4OTxW2lNQu9Rf+ale7bEg8SG4mIyFIZfRpoTfB
        Z0KAc=; b=EDVdrTGbGlI3L0HlrrlNjCO54EJAS3o0XW7uMw9MuphwfWgFqB1zoG
        /PrlaKC6TFBRzWzcsuT9IT/Z7f4gFdH8pS7rBs07EtIkXBffCa2ni2M4GG8dBac9
        99SlICXne09ymNn2gbIFAkRSsfWi8YLf/+2MlCdfXltt5Zhv3+Dl4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A439E209D;
        Tue, 28 Sep 2021 18:24:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BC0F0E209C;
        Tue, 28 Sep 2021 18:24:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, newren@gmail.com
Subject: Re: [PATCH v2 1/9] refs: plumb repo param in begin-iterator functions
References: <cover.1632242495.git.jonathantanmy@google.com>
        <cover.1632859147.git.jonathantanmy@google.com>
        <e364b13a3772da761fc8a4d1ab574cdbdfbc8aa0.1632859148.git.jonathantanmy@google.com>
Date:   Tue, 28 Sep 2021 15:24:37 -0700
In-Reply-To: <e364b13a3772da761fc8a4d1ab574cdbdfbc8aa0.1632859148.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 28 Sep 2021 13:10:47 -0700")
Message-ID: <xmqqr1d8ibiy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE4E8B52-20AA-11EC-96AE-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> In preparation for the next 2 patches that adds (partial) support for
> arbitrary repositories, plumb a repository parameter in all functions
> that create iterators. There are no changes to program logic.

Makes sense.
