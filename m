Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA62C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 18:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D216C60FBF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 18:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhJYSLT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 14:11:19 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55932 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhJYSLS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 14:11:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E60EF16EDDC;
        Mon, 25 Oct 2021 14:08:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6auu5ph2Kr9Z
        vvivYwNahtufRAsI+01clGn+eZYCHFA=; b=hF200AJDdwq0l4MUJlTcZsNU90cv
        xy5G8Vt9aGmCyIqPQZISaYRgq3FchlG/n9bqup3Znr/KmB1QFjPzWrAlJ1f7PwNP
        gi7qB8pS9jaJJxYFvjNk39fSYqDZoVvGsZQmQLrc6upjJMM7uwSRcC8aK/HTGRTh
        4KIz4XONMSRuhPs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DE39216EDDB;
        Mon, 25 Oct 2021 14:08:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0B79316EDDA;
        Mon, 25 Oct 2021 14:08:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        "Dr . Adam Nielsen" <admin@in-ici.net>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH 0/3] Documentation: change "folder" to "directory"
References: <cover.1635094161.git.martin.agren@gmail.com>
Date:   Mon, 25 Oct 2021 11:08:51 -0700
In-Reply-To: <cover.1635094161.git.martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Sun, 24 Oct 2021 19:09:14 +0200")
Message-ID: <xmqqo87d0yfg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9CB2A330-35BE-11EC-B592-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> It is my understanding that we prefer "directory" over "folder" when
> discussing the file system concept. (Whereas "folder" is commonly used
> for the GUI view of such a directory, or for an IMAP folder.)
>
> I stumbled on a mention of the ".git folder" when going through the
> doc-diff between v2.33.0 and 9d530dc002 ("The fourteenth batch",
> 2021-10-18), and started looking around. This series is the outcome.
>
> Based on master.
>
> Martin =C3=85gren (3):
>   git-multi-pack-index.txt: change "folder" to "directory"
>   gitignore.txt: change "folder" to "directory"
>   gitweb.txt: change "folder" to "directory"

Thanks.  Being consistent is good.

We should have been a bit more careful when we reviewed the changes
that introduced these.
