Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B97FC433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 15:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E016620663
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 15:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dGiUzjAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgGGPKM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:10:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65185 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgGGPKL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 11:10:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E3EADD1E45;
        Tue,  7 Jul 2020 11:10:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FpnSbDVb21txvndAEkzxtPsVjQs=; b=dGiUzj
        ABB4yqZZA3lHiA2jJuwj7Fs7YALlW9UpMNVs/NmWgMEZL1PT80A5LgE0/kRW2mmV
        PZZkUvBrI+fG+ay3z6x3pMPBrC0HqJQoxm7TBAMluHRWdlKV3Z5QngMeYqd2/7Om
        G08kCYfL1kiL1ulS1Qk5VRIA3EA2+gvK+nz/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hsAfSSwLqnTXxQst9CEJYel4QVdTywDo
        +ng+NxeZG60ilk2QEs16aUvv454rgTiI5TlA7AhKLADmkZ6YgkVuKfOG1Ll/wF3a
        nR1WfeIfMd2+8DyfDJwbB+uTUVSwJXnOp3m0C2tAOJ5eEcJQdQNr7KDVwe7QONh1
        aTA0Yc3d+GE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB262D1E44;
        Tue,  7 Jul 2020 11:10:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DE90CD1E42;
        Tue,  7 Jul 2020 11:10:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: sg/commit-graph-cleanups (was Re: What's cooking in git.git (Jul 2020, #01; Mon, 6))
References: <xmqqh7uj7tqn.fsf@gitster.c.googlers.com>
        <90cf9ac2-1ab0-1c9b-706b-6c5176ab47dd@gmail.com>
Date:   Tue, 07 Jul 2020 08:10:04 -0700
In-Reply-To: <90cf9ac2-1ab0-1c9b-706b-6c5176ab47dd@gmail.com> (Derrick
        Stolee's message of "Tue, 7 Jul 2020 09:29:29 -0400")
Message-ID: <xmqq4kqj744z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F09C40B8-C063-11EA-91BA-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Perhaps the "Under review" status for sg/commit-graph-cleanups
> should be modified to match ds/commit-graph-bloom-updates?

Thanks.  Will do.
