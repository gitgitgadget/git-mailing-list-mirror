Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C085C71153
	for <git@archiver.kernel.org>; Sat,  2 Sep 2023 18:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjIBSrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 14:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjIBSrb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 14:47:31 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65A9DD
        for <git@vger.kernel.org>; Sat,  2 Sep 2023 11:47:26 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 64A8619C110;
        Sat,  2 Sep 2023 14:47:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Px1eZGDky73CFDFO7IY5JSfRbx5kPdoK+rG89k
        Etdms=; b=SVIB+E6b5k/cOnHAd7742ymWUozbvXrMWo/WpF1zHV+BP47hlqJRuW
        kGiMoFBc3I7vTlx3QfCJL0fGNDEVsQINQy+JnaOwG8hAalY5VfT72do69sEF5XwE
        ewQ9JN0a+1gvPnx0HS7p6ttdatBWEL3tclvrgJsqNM7Zt9EycwYBU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CC1E19C10F;
        Sat,  2 Sep 2023 14:47:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB70919C10E;
        Sat,  2 Sep 2023 14:47:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dragan Simic <dsimic@manjaro.org>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] New configuration option "diff.statNameWidth"
In-Reply-To: <eb8f524eca3975f086715ec32a8a1fbb@manjaro.org> (Dragan Simic's
        message of "Sat, 02 Sep 2023 20:03:11 +0200")
References: <eb8f524eca3975f086715ec32a8a1fbb@manjaro.org>
Date:   Sat, 02 Sep 2023 11:47:22 -0700
Message-ID: <xmqq8r9ommyt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27A6A46A-49C1-11EE-8E83-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dragan Simic <dsimic@manjaro.org> writes:

> I'd like to implement support for a new configuration option named
> "diff.statNameWidth" and submit the patch, so I'd like to check first
> would that patch be accepted and merged.

In general, we do not give promises or estimates.  The devil is in
the details and until we see the design we may not know if an
overall idea is good.  Even when it is obviously a good idea, we
would not know the quality of the implementation until we see it.

 - If something is worth adding, even if we do not accept it in the
   upstream first, it will spread among users and developers, and
   eventually we may realize the mistake of initially not taking it
   and we may come begging to the contributor for upstreaming.

 - On the other hand, a new thing that even the contributor
   themselves are unsure if it is worth investing their work in, if
   it is only to use it for themselves, is very unlikely to be of
   interest to us or our users.

"If this will be accepted, I'll work on it" is a very counter
productive thing to say around here.  It is easily (mis)taken as a
sign that it is the latter case.  "This is a good idea, I believe in
it, and I'll work on it whether you initially show interest or not"
is what we want to see, and such a patch will not need a "check
first" letter.

In other words, make it so good that we would come to you, begging
;-).

Thanks.
