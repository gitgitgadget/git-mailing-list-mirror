Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C791C433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 20:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5647C23A57
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 20:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbhAOU7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 15:59:52 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57966 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbhAOU7w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 15:59:52 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F748104948;
        Fri, 15 Jan 2021 15:59:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=68NzRQVYxzLttnvQe4CAApY4+OM=; b=bXHTwq
        CMX3PrjK//VPdbhXwLYF7njt7efOmM6ei57jehWmoJivnu/RLoVhtkVGGOiwkVHp
        zT55s9MN0iDfAgIuvT6zyGUy4cUPtlVLcmORAr7O5+v/qjrjNfqaoHPjRP8whFiD
        zJrYR5LA0f9mMCbSFq+eSrHB1E3KZo+NTrMOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OgoEHr9h69wmFUktmOMFh5Q3cp++3xwM
        bSqBtzvK7/3+YmZM+TK1kt8FnpSi/UoAQCB1aOj7TXwox4eHsBk2ASt6ZMLis8MZ
        60PchUuv3WD7TgEM3yIebPSjgh/Zz3desy1KeLj0MZ8N3mAE9hCGAxgZUzaOcuqj
        lAlOK6TlxoQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 729A9104943;
        Fri, 15 Jan 2021 15:59:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9EB8D104942;
        Fri, 15 Jan 2021 15:59:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
        <YADOf41CcaRuToD7@google.com>
        <15237c6c-98eb-0d1f-e6d5-2dda91c0ce09@gmail.com>
        <xmqqr1mmu2nx.fsf@gitster.c.googlers.com>
        <xmqqmtxau2kj.fsf@gitster.c.googlers.com>
        <49a151f1-a04c-703b-cf18-90cc503b0c80@gmail.com>
        <xmqqturirnm5.fsf@gitster.c.googlers.com>
        <YAH2Qc/ad+P9Pf26@google.com>
Date:   Fri, 15 Jan 2021 12:59:06 -0800
In-Reply-To: <YAH2Qc/ad+P9Pf26@google.com> (Emily Shaffer's message of "Fri,
        15 Jan 2021 12:08:33 -0800")
Message-ID: <xmqqczy5syqt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82C447E0-5774-11EB-87F7-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Thanks for the action on this, glad to see it resolved in 'next' when I
> pull today.

Thanks for double checking.
