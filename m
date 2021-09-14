Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F7BC433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 16:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C653610A6
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 16:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhINQjH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 12:39:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58062 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhINQiw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 12:38:52 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ACE9EEE4FF;
        Tue, 14 Sep 2021 12:37:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=R894zY2BYMjL
        73JeTxmUkOfvRENTPgwVl45ss+exvv4=; b=hL6hXN4SyaHz0Tzdg1Zb8BaY0d0b
        FgUIVf9FfouwVLNX8d1vNw626bXwEoebOHRnKih/jBcPrNlHxjwbOEl3XDx+SZuX
        0mDBo8yQvPSMn3AibYHK4HUwoNpgC0hS2224ryKrmxvWeulEyEhTPJy4V4gP49b2
        eiocgRJL91PW2CE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5281EE4FE;
        Tue, 14 Sep 2021 12:37:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 335F1EE4FD;
        Tue, 14 Sep 2021 12:37:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH v3 0/3] windows: allow building without NO_UNIX_SOCKETS
References: <20210913085600.35506-1-carenas@gmail.com>
        <20210914072600.11552-1-carenas@gmail.com>
Date:   Tue, 14 Sep 2021 09:37:32 -0700
In-Reply-To: <20210914072600.11552-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 14 Sep 2021 00:25:57 -0700")
Message-ID: <xmqq7dfj3ygj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0F861E10-157A-11EC-99A8-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> Eventhough NO_UNIX_SOCKETS was specifically added to support Windows,
> it might not be necessary in the future, because Windows added support
> for Unix Sockets in late 2017.

Thanks.  I found that this round was a pleasant read.

Will queue, and let's merge it down to 'next' soonish.
