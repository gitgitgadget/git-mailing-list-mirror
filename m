Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEA0C433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 02:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADFA9206A4
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 02:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LfcqTSVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgFKCOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 22:14:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50058 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgFKCOE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 22:14:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 69373C0A7E;
        Wed, 10 Jun 2020 22:14:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c0rBkm7HqLT2oF5kGYHENKsUYZI=; b=LfcqTS
        VvxGrnji3FRcnsyO+wqNwZZTXWHZhNpbILB4gIAURzLtGbBfuKesWiRvvtS9c3hK
        /0er6zZt5QbqJ/8rAy+4yPxmZ/qLBLXFv1d5D3t2Y6WfFBlitVyTXqiP6eETKCCw
        n2ipXZmKJDPKD8m5YFJWlh4Jm6Jcl59aH+k64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TRUaJGrYXxKf2k4yTbGqXLnqa1IiDYK7
        kJAdjjIYvbxOaynxIa8Esks8+VlG/hMAKr8D1WqhD2rkJjqhrwrNVaGF4h3O4apS
        Xbpr6+jnG65KMkbq4+1PDDcwgnoOuJVj8OLuGyEEDCFSm+S5yypAYc1zqSa9d5Ee
        38dAeOVzkU4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 60B09C0A7D;
        Wed, 10 Jun 2020 22:14:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9D251C0A78;
        Wed, 10 Jun 2020 22:13:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        git@vger.kernel.org
Subject: Re: Virtual Inclusion Summit
References: <20200610222719.GE148632@google.com>
        <xmqqwo4eedwc.fsf@gitster.c.googlers.com>
        <20200611011040.GB21728@syl.local>
Date:   Wed, 10 Jun 2020 19:13:58 -0700
In-Reply-To: <20200611011040.GB21728@syl.local> (Taylor Blau's message of
        "Wed, 10 Jun 2020 19:10:40 -0600")
Message-ID: <xmqq7dwecpsp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3636545A-AB89-11EA-9641-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> It is OK to have an optional meeting in the hope that a video
>> meeting may have a better chance to keep those who easily become too
>> aggressive and confrontational in text-only conversation in check
>> and instead have civilized conversation.
>>
>> But I am not sure if it is a good idea to call such a meeting a
>> "Summit", given that there are those who prefer not to be seen,
>> heard or recorded how they appear and how they sound in a video
>> conference.  They would not be able to join the conversation held in
>> such a "Summit" held only by those who are privileged enough to be
>> able to attend.
>
> I think that this is a very reasonable concern, stated in a very
> reasonable fashion. Let's call it something else, sure, and avoid
> recording/publishing the event (as we have done in the past at other
> in-person events--such as the last Git Merge--which seems like a
> lifetime ago ;-).)

I am not opposed to recording and publishing for wider dissemination
of what was said and agreed on among participants, who join with the
full understanding of how the video meeting will later be consumed.

What I am hesitant to see is that such an opt-in meeting becomes
"you got a chance to attend and have your voice heard---if you
didn't come, that was your choice, and whatever objection you give
after it does not count" summit.

