Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90487C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 20:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 727416115B
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 20:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhIIUEJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 16:04:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50971 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345078AbhIIUEG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 16:04:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 62174155E46;
        Thu,  9 Sep 2021 16:02:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GPgQmptiAzgh
        iuojKhpo07vhD6OkKJtQw9CuaN3ZnxE=; b=dSjT0abyvRo8TEGScnG53bOKze2h
        pxuJ4Cx+G7XPfX1th6E30ZV9vhpqSQBNd4U64SEifDe2jAgCgz2YDw7UnixJUtSo
        L/pEoktD4G16GjFMmORLCUUEnQr+fMHpWx7rPzAX3kY2DCWYzc9i+0XGcKuNTLwH
        66bGLhTsEW+T9Jw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5AA5B155E45;
        Thu,  9 Sep 2021 16:02:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 89C3E155E42;
        Thu,  9 Sep 2021 16:02:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 00/19] Adds reftable library code from
 https://github.com/hanwen/reftable.
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
        <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
Date:   Thu, 09 Sep 2021 13:02:51 -0700
In-Reply-To: <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Thu, 09 Sep 2021 18:47:25
        +0000")
Message-ID: <xmqqczphy0t0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EAF5CDFE-11A8-11EC-9A88-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The reftable format is described in Documentation/technical/reftable.tx=
t.
>
> This is a fully reentrant implementation of reading and writing the ref=
table
> file format, and should be suitable for embedding in libgit2 too. It do=
es
> not hook the code up to git to function as a ref storage backend yet.
>
> v2:
>
>  * fold in OpenBSD fixes by Carlo Bel=C3=B3n.

Thanks, both.  Will replace.
