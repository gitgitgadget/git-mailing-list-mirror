Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B85C432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 16:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E649205ED
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 16:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g1XhBtBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfLCQiu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:38:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62376 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfLCQiu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 11:38:50 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 997C52808A;
        Tue,  3 Dec 2019 11:38:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2z3ZnlUo4sMl
        18hrTgjSG2rn+VQ=; b=g1XhBtBiXuDDZr5iZISOhqGWLM+Hzb0qPJOh0IJB2OKA
        2CrmZ1cewRXqnyw+aRgWXFEBgvXl451Zlu9qcWmJCSt0JafIT6OW+0CeWD409Qn6
        uKes2Xg673Gb2ucmAGJKBCUwG7WOnFEk6WaGqMcZnxN/dAwQiK+02uiEu4/O8MQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=B/qHDx
        OgXxGUDS4I+Vl/LcLdxAq5BgVTcS0A9HndP1eRUbp+ii9PBv7++5O3qinNDgFCdD
        2dZ68Iqf7v+cAcr5tH98/Us5H8VRa/HjPbbtaQGDUAYG9bTQJnKahfdfWXj732ps
        WGLX66lybc0T3zKSdZoYsuroVxbZsRUiwQr7Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 90FDA28088;
        Tue,  3 Dec 2019 11:38:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB89C28087;
        Tue,  3 Dec 2019 11:38:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2019, #01; Mon, 2)
References: <xmqqpnh6yfrl.fsf@gitster-ct.c.googlers.com>
        <20191202210534.GA49785@generichostname>
Date:   Tue, 03 Dec 2019 08:38:47 -0800
In-Reply-To: <20191202210534.GA49785@generichostname> (Denton Liu's message of
        "Mon, 2 Dec 2019 13:05:34 -0800")
Message-ID: <xmqqy2vt5ppk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 61C1BC74-15EB-11EA-BC4C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Ren=C3=A9 sent a v2 for the above commit here[2].
> ...
> [2]: https://lore.kernel.org/git/a56a4b33-61f8-d3a5-d85f-431c70b8f3e7@w=
eb.de/

That is what has become ed254710 ("test: use test_must_be_empty F
instead of test_cmp empty F", 2019-11-27), I think.
