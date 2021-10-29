Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC351C433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 23:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D8660F58
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 23:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhJ2X2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 19:28:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51384 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhJ2X2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 19:28:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 98C90FD1EF;
        Fri, 29 Oct 2021 19:25:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QKGTgTCgm05WOVxT2l6Lp0opkrkx4xdTKZIkw2
        zv5eI=; b=xdbZCf83Z5qGP94v7IHprPpb65PCDsIU/a870qWWpYWgE8UfPx/WdP
        U6b77om6ZMLB+U8MHO1K30Wp5q3pA61Vlx7oJEhduKEnHt7JaN5Qvluqt3Gt9Qhy
        6F7KPaXXZMYlJtFfOTIx+BMvvTTameC8LybMt/5hBd427JP+PsW8g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8EDEDFD1ED;
        Fri, 29 Oct 2021 19:25:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 075EAFD1EC;
        Fri, 29 Oct 2021 19:25:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 0/8] Allow clean/smudge filters to handle huge files
 in the LLP64 data model
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
        <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
        <xmqqk0hvllxp.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2110292239170.56@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.2110292311200.56@tvgsbejvaqbjf.bet>
Date:   Fri, 29 Oct 2021 16:25:44 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2110292311200.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 29 Oct 2021 23:12:16 +0200 (CEST)")
Message-ID: <xmqqh7czfm6f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8AF84664-390F-11EC-9497-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmail.com> writes:

>> Speaking of which, -rc0 is still coming, right? ;-)
>> https://tinyurl.com/gitcal still claims that it was scheduled for
>> yesterday.

Was swamped too deeply to even make noises about the delay.  Sorry
about that.

