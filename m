Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97318EB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 18:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjF2SPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 14:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjF2SPg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 14:15:36 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB442D4E
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 11:15:35 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C55A1984C0;
        Thu, 29 Jun 2023 14:15:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W4AWj0GWrd/7Lf9N4ydPpQkSmpYfk7xG5G207r
        JZh50=; b=q0Ku2JdKXRb64naogBB5VKbs6zVyAVxcrWLN8uM1/F1sQthp57Vytc
        Zmn94RkRVBQ2O5taB97NiJl1gkYnPcc7DLqU9hQ4C4h1VEXdhQut7Qa5GSo64FVJ
        y/CRF99prcUe/WSGeoUnqk6f8l9+631JvsPm1aIhX6VxFOJ7qSZs8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 646D71984BE;
        Thu, 29 Jun 2023 14:15:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BC65F1984BD;
        Thu, 29 Jun 2023 14:15:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3] docs: add git hash-object -t option's possible values
References: <pull.1533.v2.git.git.1687555504551.gitgitgadget@gmail.com>
        <pull.1533.v3.git.git.1688004473941.gitgitgadget@gmail.com>
Date:   Thu, 29 Jun 2023 11:15:31 -0700
In-Reply-To: <pull.1533.v3.git.git.1688004473941.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Thu, 29 Jun 2023 02:07:53 +0000")
Message-ID: <xmqqilb69lto.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFC1F11C-16A8-11EE-9B96-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> The summary under the NAME section for git hash-object can mislead
> readers to conclude that the command can only be used to create blobs,
> whereas the description makes it clear that it can be used to create
> objects, not just blobs. Let's clarify the one-line summary.
>
> Further, the description for the option -t does not list out other types
> that can be used when creating objects. Let's make this explicit by
> listing out the different object types.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---

Looks good.  Queued.  Let's merge it down to 'next' and below.

Thanks.
