Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481CAC433E0
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 00:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3D9F225AB
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 00:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732476AbhAZACk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 19:02:40 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57767 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732085AbhAZABv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 19:01:51 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EF63210CEFB;
        Mon, 25 Jan 2021 19:01:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xe4wW34qBuvP5YekB9zXm9x3Qns=; b=XoMbvZ
        J/VNKIahABTyi9ARQRK4tnCtWQM0I5B0CQjiY5GULNlM9I6rSw0YI/EjV/HUA5Fy
        ymRXNrF9dEw8kEdDz9cNqm6QZwWDkHyCVnG7e+KDWmiddejxNXvWoCG2jLNz57qc
        S+8H/detAEqktmacBtn08zdCh6gKhNK7FjaZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yaL2TeE0gJwAS7B1Fw8pd0CKi6Md6MyN
        ZdntMNp403h/g1KGwrg2ouZ3ipAUDpxlM2kStezkQlUoV/2mzSPe0RdEQC1qIekx
        TOqTUIP42fcfxguacq9eG8nLtd/KkuHRqWD3KrHKkzgVovDeVOQ0fg73j+JaSvAX
        LLougqEt5LM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E8C7310CEFA;
        Mon, 25 Jan 2021 19:01:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3C19710CEF9;
        Mon, 25 Jan 2021 19:01:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     peff@peff.net, git@vger.kernel.org, jeffhost@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 0/1] upload-pack.c: fix filter spec quoting bug
References: <YA81LEon1RPzT0T9@coredump.intra.peff.net>
        <20210125230952.15468-1-jacob@gitlab.com>
Date:   Mon, 25 Jan 2021 16:01:05 -0800
In-Reply-To: <20210125230952.15468-1-jacob@gitlab.com> (Jacob Vosmaer's
        message of "Tue, 26 Jan 2021 00:09:51 +0100")
Message-ID: <xmqqy2ggwoqm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96E3503E-5F69-11EB-8FC2-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Vosmaer <jacob@gitlab.com> writes:

> Now with sign-off. Thanks for the reviews and comments!
>
> Jacob
>
> Jacob Vosmaer (1):
>   upload-pack.c: fix filter spec quoting bug
>
>  t/t5544-pack-objects-hook.sh | 9 +++++++++
>  upload-pack.c                | 9 +--------
>  2 files changed, 10 insertions(+), 8 deletions(-)

Thanks, will queue.
