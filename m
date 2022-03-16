Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCF2C433FE
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 22:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349138AbiCPWGc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 18:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243684AbiCPWG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 18:06:29 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F149727B
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 15:05:14 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1959E129296;
        Wed, 16 Mar 2022 18:05:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KQwz+0PbO/+bsv7A4NTV3HeF4jK9PiNuBYq98C
        kqaYI=; b=jjtbCJrezbpRbY2At9g9uTDwR0tThw51rhYNAcsq/cmIc9xoEw2X6p
        R+QinM5HxpxkPHJFAo4HiGHqjhJbkHDPSEwhD5ZfT/ssQ/n2NeVzL04gKV2tB/GN
        /ux2U2eNSOaYwKiHkQdu4bimcGcoXBGSD2fsJ4kyJqfxCw0DGwEBc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11534129294;
        Wed, 16 Mar 2022 18:05:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A730129293;
        Wed, 16 Mar 2022 18:05:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        Alice Merrick <amerrick@google.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Let's have a user experience workshop
References: <CA+Yb-VSaeKy-g_ywkZzQuEX=k3EXM+Ky-rHOb2az0SHGVbdaVw@mail.gmail.com>
        <20220316201058.GI163591@kunlun.suse.cz>
        <CAJoAoZnKebM4m3AXW6+RBY7dBsQhAcReqd61VtXHNjcnPBeemQ@mail.gmail.com>
Date:   Wed, 16 Mar 2022 15:05:12 -0700
In-Reply-To: <CAJoAoZnKebM4m3AXW6+RBY7dBsQhAcReqd61VtXHNjcnPBeemQ@mail.gmail.com>
        (Emily Shaffer's message of "Wed, 16 Mar 2022 13:41:59 -0700")
Message-ID: <xmqqk0ctk0yv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27910D9A-A575-11EC-9CE7-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Git already uses Google Groups for the security list (e.g. for fixing
> pre-disclosure security issues) and for the mentoring list, and it's
> fine to subscribe to one with a non-Google account; it acts just as a
> normal mailing list in your inbox.

I think the groups.google URL is not the one that acts just as a
normal mailing list.  <git-ux@googlegroups.com> address may be what
needs to be advertised.

I would prefer to see such a discussion on this list, too, not on a
separate place people need to subscribe to, though.

Thanks.
