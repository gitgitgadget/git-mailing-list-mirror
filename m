Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260C9C433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 17:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347960AbhLBRHV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 12:07:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51949 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbhLBRHU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 12:07:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8215E100FC8;
        Thu,  2 Dec 2021 12:03:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IssMj4wZeScm
        ehwzbJP/JxG1cG9ozRS/E+oISqZMZRU=; b=oXl9M8Hsx5lKwva4EVglUNh0x4Jo
        qA3M/pwOoL9wQ8IjXZDkTk0s5xZVLOD+s+E7kbSvOpSQT8RltDOFScivpOWlA9Wh
        p4BK4MzLujuVINRagQ0NbY9t1di+iW4l45agzIiMN/cTC5b8evpVFL60Z/217pS0
        o7iuICoJyaTut1o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78D68100FC7;
        Thu,  2 Dec 2021 12:03:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB455100FC6;
        Thu,  2 Dec 2021 12:03:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v9 00/17] Upstreaming the Scalar command
References: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
        <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <211130.86mtlleqhm.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2111301450030.63@tvgsbejvaqbjf.bet>
        <xmqqtufs1a39.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2112021549330.63@tvgsbejvaqbjf.bet>
Date:   Thu, 02 Dec 2021 09:03:55 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2112021549330.63@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 2 Dec 2021 15:53:32 +0100 (CET)")
Message-ID: <xmqq1r2vvszo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D61C2DC6-5391-11EC-9807-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> No, it was not intended. It was not even intended to integrate Scalar t=
his
> tightly with Git's CI, but since you did not move along `js/scalar` int=
o
> `next` for the past weeks, when no reviewer had anything to add to the
> actual code in `contrib/scalar/` nor were there any objections to
> integrate it, I made the mistake of assuming that you agreed with =C3=86=
var
> that such a tight integration into Git's CI was desired.

OK, sorry to hear that we had miscommunication. =20

I took the lack of comments an indication that people are not either
interested in it, or viewing it as not-quite-ready-yet and waiting
for a "more or less done" version.

I think the CI updates from =C3=86var would be one of the things we'd
have early in 'next' in this cycle, so if the topic does not play
nice with it, the perception that it is not yet part of the regular
CI testing would continue, I am afraid.

Thanks.
