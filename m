Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94351C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 18:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF63610A6
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 18:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbhJ0Suh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 14:50:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55669 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbhJ0Sud (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 14:50:33 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D9F38159982;
        Wed, 27 Oct 2021 14:48:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=Zl2FVAeGeFCUJG4GFbwr3IuK0
        1xMdxD2gYEPw8ERsW0=; b=ML8VMePD9hzdf5EPH1tayuX5N15Or7CaNeMJqWlmo
        WPTOvHCw+BlH4Wk5CR/a2cMRe7TYxsT8Dy93P3P48KsKU3pjDHDkQDNHfh7HSk/L
        PG/T+/lJsX5bvzYuQjCT+gVWUqCci/OrXpuMYsn0jf1bOGX/Zjun6qFnTRIf45J6
        oQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D236C159981;
        Wed, 27 Oct 2021 14:48:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3C18715997D;
        Wed, 27 Oct 2021 14:48:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        "Dr . Adam Nielsen" <admin@in-ici.net>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH 0/3] Documentation: change "folder" to "directory"
References: <cover.1635094161.git.martin.agren@gmail.com>
        <481447f9-7222-d9fc-269f-2de50299fb09@gmail.com>
        <CAN0heSrco2P9cwhDNkXeO1xNMAr4+Mo1+0Y-UEhF5vgrkBOa3A@mail.gmail.com>
Date:   Wed, 27 Oct 2021 11:48:04 -0700
Message-ID: <xmqqh7d2wbh7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6B8A73A2-3756-11EC-A4C3-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Old habit, I guess. :) I tend to find that having multiple patches aids
> reviewing. Within reason, obviously. Reviewers don't have to go "I agre=
e
> with everything except that particular hunk", but can just say "I agree
> with everything except patch two", making tracking things a bit easier.

In this case, changes to three separate files are presented in three
separate patches, which was a quite pleasant read.  I do appreciate
that you said "within reason" ;-)
