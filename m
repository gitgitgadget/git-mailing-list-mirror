Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5476EC433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 21:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EEE161042
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 21:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhDNVms (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 17:42:48 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60677 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhDNVmr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 17:42:47 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 247A011A3E3;
        Wed, 14 Apr 2021 17:42:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p/wbAZiDZtwP7mc/3tyMT+e9Xg8=; b=PBXTwf
        /FcK98mUeBVRyrRCQy1RxhbKWfZHDuRcJAXhi8h+fqxlMHDtRIPBw7NbYFD55oao
        l/x2o4mwWfOeWXrF6dGMJIE6fwf5wRTkwaOTcoc7cb4LK/x2/paY56oxaCQPt6/j
        XEa+Awlz9KvdZnlvl6tDE3231b7v7552gLXbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Qt5QF/WEZcQ0VwFENQQnVXI0FZ6r0XRC
        6+3NqV3dKIA999cw4FWugKl/3A8V3D6e8Omn4cs6A/L5duwIUE2dVirVmKWBQlv6
        Em5nlPulXgkdAznOUsGgxqh2YYIjoTe2CmpX+jsXQchJZiM8BlZ/6WqSraYHZrR2
        yq3S34eClSg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1A2E611A3E2;
        Wed, 14 Apr 2021 17:42:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 60ACD11A3E1;
        Wed, 14 Apr 2021 17:42:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Raxel Gutierrez <raxelgutierrez09@gmail.com>,
        mricon@kernel.org, patchwork@lists.ozlabs.org,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Pain points in Git's patch flow
References: <YHaIBvl6Mf7ztJB3@google.com>
        <b562e614-add7-575f-3013-1dbc667bc5bf@gmail.com>
        <xmqq7dl5z425.fsf@gitster.g>
Date:   Wed, 14 Apr 2021 14:42:21 -0700
In-Reply-To: <xmqq7dl5z425.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        14 Apr 2021 01:02:58 -0700")
Message-ID: <xmqqzgy0wnk2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C1F050E-9D6A-11EB-B252-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> So, I dunno.  We seem to suffer from the same lack of good starter
> tasks before each GSoC begins.

And long after sending the response, I realize that this has very
little to do with "Git's patch flow" issue that you wanted to
discuss.  Helping newbies wet their toes may be a topic worth
discussing, but that is not the focus of this thread.

Let me send a response to describe my pain points separately.
Sorry for the noise.
