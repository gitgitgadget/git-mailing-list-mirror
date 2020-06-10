Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BAFC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 22:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B88372074B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 22:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gKRZqG1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgFJWsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:48:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51645 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgFJWsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 18:48:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9F5EEDD44F;
        Wed, 10 Jun 2020 18:48:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8HTIQwM7qdmfjWNjPYpI6SsBgsQ=; b=gKRZqG
        1Xn+iUS1vd9jdmDwl2+jPKkKBAi8BN/JPGgJZGbGXRjcot4/q3VmMDsJeROIcfRg
        1gY6GCpc8ELtg8YRMwOtQm7e+5xftm4Hg8BBzEZKBgX5hoWBHNiLOWB1p+xKy+c/
        es9Vk3ORnV7YpK/HATdgPhaTTFFxw4a5KvPl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ioBqGjcF46YFdNB1vMIj8sQzfJXCzrYt
        oOjr/krPCZARpsvyEU57BBActCnK924TtEdwfsIvdETlI3gBfz2qzL7KW/PULia2
        Y/j4rpZaJAW2dljoJkPXrhtKRzEtcWGwL1tVIEi/9gvd7noBWOqfSdaA+dnUi6i2
        nzG/6ThKWDQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 971FFDD44E;
        Wed, 10 Jun 2020 18:48:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DEF53DD44B;
        Wed, 10 Jun 2020 18:48:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        git@vger.kernel.org
Subject: Re: Virtual Inclusion Summit
References: <20200610222719.GE148632@google.com>
Date:   Wed, 10 Jun 2020 15:48:03 -0700
In-Reply-To: <20200610222719.GE148632@google.com> (Emily Shaffer's message of
        "Wed, 10 Jun 2020 15:27:19 -0700")
Message-ID: <xmqqwo4eedwc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72378D10-AB6C-11EA-AA23-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> One note I'd like to make is that the Git community already suffers from
> a lack of diversity; it will be hard for us to make meaningful changes
> if just those of us who already contribute attend, because many of us -
> myself included! - come from privilege and don't have much or any
> firsthand experience with microaggressions (or overt discrimination). I
> think it's a good idea to expand the attendance of this summit beyond
> the current contributor base and try to include more diverse voices and
> experts in building inclusive products.
>
> To that end, I'm going to see what kind of interested parties we can
> find to invite within Google - and I hope others will do the same within
> their own network. I think the risk of us coming up with meaningless
> changes far outweighs the risk of us having too many people in the Zoom
> call. :)

It is OK to have an optional meeting in the hope that a video
meeting may have a better chance to keep those who easily become too
aggressive and confrontational in text-only conversation in check
and instead have civilized conversation.

But I am not sure if it is a good idea to call such a meeting a
"Summit", given that there are those who prefer not to be seen,
heard or recorded how they appear and how they sound in a video
conference.  They would not be able to join the conversation held in
such a "Summit" held only by those who are privileged enough to be
able to attend.

Thanks.
