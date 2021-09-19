Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A97C433EF
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 07:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23FD161056
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 07:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhISHJz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 03:09:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62641 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbhISHJe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 03:09:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C166E2E8F;
        Sun, 19 Sep 2021 03:08:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sew75hM2jkZd/Y3i43oaX4uyH80yBQmwbU5Dmj
        zQazU=; b=kQVpy44MXrJ3t4+nvkFvSsJ3WiMmEOIDO0Vo1rnAJskh2ybqA6eLSk
        Bo6kvtciuzYXRQvXEWrHv7fZN/spsxUTXwcdO24TRA6zoxwlR9k+o3+NV+nk8evW
        e+a8pVNY4va8pgIqz0+S55JVwPd62+4ugXXOAAjFWaEhRVZCQzlSM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5957BE2E8E;
        Sun, 19 Sep 2021 03:08:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 475D7E2E8D;
        Sun, 19 Sep 2021 03:08:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: LANGUAGE instead of LANG respected in git?
References: <8ed06f91-2efc-1816-aa82-beac8e174549@gmail.com>
Date:   Sun, 19 Sep 2021 00:08:06 -0700
In-Reply-To: <8ed06f91-2efc-1816-aa82-beac8e174549@gmail.com> (Bagas Sanjaya's
        message of "Sun, 19 Sep 2021 12:04:04 +0700")
Message-ID: <xmqq7dfdf3ft.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57BBA78A-1918-11EC-90B9-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Supposed that I would like to display `git help` in French
> (`fr_FR.UTF-8`) language. I ran `LANGUAGE="fr_FR.UTF-8" git help`, and 
> indeed the help is displayed in French. But when I instead ran
> `LANG="fr_FR.UTF-8" git help`, the help is in English instead of
> French.
>
> It seems like Git use LANGUAGE to display localized messages instead
> of LANG (like many other tools do). Why?

That's not Git but your system, most likely GNU gettext, is doing.

Learn to use your search engine before asking questions here.

  https://bfy.tw/Rg6H

which will eventually take you to https://superuser.com/a/392466
