Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0757C20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 04:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbeLIEJu (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 23:09:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63954 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeLIEJu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 23:09:50 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 55413113E21;
        Sat,  8 Dec 2018 23:09:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LvgVH8S6defA8OHcvjxFzfxwgns=; b=RBAZHj
        fE08aHb8DLJl/AtqoukUg5NDzywH3weeMhIOwX4LbMGFzynX+sMChTK6LOCOsdx9
        Dkd4tUG2yON3hHnS1t+kIGQ6O5nHmCMPA+4Di5wgYTuKfVyoCn4/akXXRRPYy+a1
        GX3LAoQMazqQa5LbNlq8e3FX7M+xyXM6SLuYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cg18I+72sHVazB9Uh8GPEuLcExPh0iwh
        TKyv22xdMumdoCCt+6ZAd7JNMZptMbwMcBQPqPV4idUXwjjwOa08o3CnGn54dZvu
        gBcQS7la16TBVqNmn1weInRI8C39iKIQtnr/TtU8rWRe+RV1by9p1p6AZedhL2eA
        +RpjNOprYsE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C0FD113E20;
        Sat,  8 Dec 2018 23:09:48 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8800C113E1F;
        Sat,  8 Dec 2018 23:09:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBR?= =?utf-8?B?dcOibg==?= 
        <vnwildman@gmail.com>,
        Christopher Diaz Riveros <chrisadr@gentoo.org>,
        Minh Nguyen <mxn@1ec5.org>
Subject: Re: [GIT PULL] l10n updates for 2.20.0 round 3
References: <CANYiYbF07DNC=UMm5zKJwzGFyo8UY-Auh+K3khFjCNOftV2KyQ@mail.gmail.com>
Date:   Sun, 09 Dec 2018 13:09:46 +0900
In-Reply-To: <CANYiYbF07DNC=UMm5zKJwzGFyo8UY-Auh+K3khFjCNOftV2KyQ@mail.gmail.com>
        (Jiang Xin's message of "Sun, 9 Dec 2018 12:04:10 +0800")
Message-ID: <xmqqo99v49yt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 444AEACE-FB68-11E8-8159-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Please pull the following git l10n updates for Git 2.20.0.
>
> The following changes since commit 8a0ba68f6dab2c8b1f297a0d46b710bb9af3237a:
>
>   Git 2.20-rc2 (2018-12-01 21:44:56 +0900)
>
> are available in the Git repository at:
>
>   git@github.com:git-l10n/git-po.git tags/l10n-2.20.0-rnd3
>
> for you to fetch changes up to 0688c551a3e0f812e2153b716b9674da5914122c:
>
>   l10n: de.po: fix two messages (2018-12-07 19:43:07 +0100)

Thanks, will do.


