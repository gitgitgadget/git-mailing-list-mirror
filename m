Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C8BC433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 01:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241019AbiFCBTZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 21:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241020AbiFCBTN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 21:19:13 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6814C3B016
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 18:19:11 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A1482181268;
        Thu,  2 Jun 2022 21:19:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=9tgyo60neMm5v6tAYTVHzM+nj
        leYNpeEO75PZyDoQBg=; b=VnuQSacGZuaTBpzShjwWNKA3bgd1xlf/VucGd98zt
        BXPVJMdOLSjpdXfslECna7aoP8xhFyggQHJDvKghOUZl9aNb+3odffJrN3fhId2L
        Tas2LaHgBWwHH+wrOJDy/PGHem0K2yHu8SF2kjIxe9bYRAfmoqLlxpPVlolDV6WM
        EE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 99A2D181266;
        Thu,  2 Jun 2022 21:19:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 49CB3181263;
        Thu,  2 Jun 2022 21:19:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v3 1/6] common-main.o: move non-trace2 exit() behavior
 out of trace2.c
References: <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
        <cover-v3-0.6-00000000000-20220602T122106Z-avarab@gmail.com>
        <patch-v3-1.6-9c4f8d840e9-20220602T122106Z-avarab@gmail.com>
Date:   Thu, 02 Jun 2022 18:19:04 -0700
Message-ID: <xmqq5yliilx3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2A1270F6-E2DB-11EC-8B2B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Subject: Re: [PATCH v3 1/6] common-main.o: move non-trace2 exit() behav=
ior out of trace2.c

.o, not .c?
