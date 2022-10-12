Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F166C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 04:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJLEm7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 00:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJLEm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 00:42:58 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7402562A94
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 21:42:57 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1077F14AA53;
        Wed, 12 Oct 2022 00:42:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M8dnSE84cXXRhFdkv6WaGDTrfnKleKGbQ1DVLk
        zlxEU=; b=CQzZEGrbiI/Cju7//xCp7l+4pywhwoxFQW5AN38qfZwsqdstJmY769
        6B+NPIT3uhsefns8g3PLxIwScM3wyYcprSO1zwIRcblUV8ZZSgN9JarNOLDX5OYN
        MRaROdxRfN/mpvvZR/fzIVNNh9Abc1WAJYE04GCd9zdyOcrTq9Rts=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0755A14AA51;
        Wed, 12 Oct 2022 00:42:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6764714AA50;
        Wed, 12 Oct 2022 00:42:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Luna Jernberg <droidbittin@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Hariom verma <hariom18599@gmail.com>
Subject: Re: [Outreachy] internship contribution
References: <CA+PPyiEvfkqZYq6uESMt3QYnfMDZDmPbGiQ5Qkeb77rtLV5Aug@mail.gmail.com>
        <CAP8UFD1o5qxSvbV05DK_J=zbU=D_+HS0Q2ufEFSQVaBoWw_7Ow@mail.gmail.com>
        <CA+PPyiF5KK6p7rv57YL_wsDO+WPifoRp1oe0F-6mo5NxLAwDWw@mail.gmail.com>
        <CAP8UFD26PY-53vZNZJzCRNiqaVB4fd=AvBtVuvMQP9p8Oqj82Q@mail.gmail.com>
        <9fcfc8b0-772d-08c3-595b-5a5a139d7ecd@github.com>
        <CADo9pHgcfwV53ooyM8Dh5jVO2rxO-tUHeLovd7HYLdTSOkNtyA@mail.gmail.com>
        <CA+PPyiH8EPWpTuOJg1hSthFP1xBxurjN7J0J00g6xvFi_vbcYw@mail.gmail.com>
        <ae8a98d9-eec1-cdcd-67a3-695aaca7f5ae@github.com>
        <CA+PPyiFC0mjvY494AVZMB952Ux-TPyA-Uetu1xQ6FiHA_vaRaA@mail.gmail.com>
        <CA+PPyiEms=f7=rXkvfmaazNkxKS1-VA-XJZOrhieQEut8f7QWA@mail.gmail.com>
Date:   Tue, 11 Oct 2022 21:42:52 -0700
In-Reply-To: <CA+PPyiEms=f7=rXkvfmaazNkxKS1-VA-XJZOrhieQEut8f7QWA@mail.gmail.com>
        (NSENGIYUMVA WILBERFORCE's message of "Wed, 12 Oct 2022 06:31:52
        +0300")
Message-ID: <xmqqleplmz3n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 55855022-49E8-11ED-8F8E-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com> writes:

> Hi team, I am reading through "My first contribution"
> when I run make all doc, I get the following;
>
> SUBDIR git-gui
>     SUBDIR gitk-git
>     SUBDIR templates
> make -C Documentation all
> make[1]: Entering directory '/mnt/c/Users/USER/documents/git/Documentation'
> make[2]: Entering directory '/mnt/c/Users/USER/documents/git'
> make[2]: 'GIT-VERSION-FILE' is up to date.
> make[2]: Leaving directory '/mnt/c/Users/USER/documents/git'
>     XMLTO git-version.1
> /bin/sh: 1: xmlto: not found
> make[1]: *** [Makefile:355: git-version.1] Error 127
> make[1]: Leaving directory '/mnt/c/Users/USER/documents/git/Documentation'
> make: *** [Makefile:2720: doc] Error 2
>
> How should I go about it?

Googling "xmlto: not found", the first result is

    https://command-not-found.com/xmlto

The page lists how to get and install it for various platforms, and
WSL/Windows should be included there.

I believe "My first contribution" recommends to first read the
top-level INSTALL before continuing (and if not, it should be
updated to).  Simpler things first---building and installing the
vanilla source code without any of your changes should be simpler
and you should become confident in doing that, before you start
modifying anything. Otherwise, when you encounter a problem, you
would not be able to tell if you broke it with your change, or your
basic set-up is not complete (e.g. missing necessary tools like
xmlto) and unable to build and install from even vanilla set of
sources.

Have fun.



