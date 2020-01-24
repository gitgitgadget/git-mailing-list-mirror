Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BD0C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5232072C
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yTYZ3RQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgAXVL1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:11:27 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64164 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgAXVL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 16:11:26 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C002C9EB74;
        Fri, 24 Jan 2020 16:11:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+dcjy4XEfQyzPp0JqX5kxiIgL4k=; b=yTYZ3R
        QRC1nsOJgi8lTgzNoEpa90N8M3JvNQg3il4Og2unF9IRiTfKaCsj2X0Y83NO330X
        jVZnFDHoQE38JxXGXIjhSLVFm5mmDxw9RggfA2HWL00MxLLp3IGuXJkyhULbG+ZK
        ztZpHLRR4i3SbDivltb27NRm54LTtv+mUJXC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x8Ofep26CDT5R+I6HK6z4lObV6oP1IIj
        E1CufNUvRuSYABcis37F6ksfuMO7iTqQvL+p7RbcnYX2uLGIyKnhRcT8jsRjW2y1
        E2bCoxHYI27S9Q418edn0muU6a1gY0iW5E1+g9HTb3Q8vsCgbgmMCimPLN89A1WG
        5BpruBXek1g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B6FFF9EB72;
        Fri, 24 Jan 2020 16:11:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DA67B9EB70;
        Fri, 24 Jan 2020 16:11:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>,
        Richard Kerry <richard.kerry@atos.net>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v5] MyFirstContribution: add avenues for getting help
References: <20200124200915.249473-1-emilyshaffer@google.com>
        <xmqq7e1gzj73.fsf@gitster-ct.c.googlers.com>
        <20200124205025.GA140846@google.com>
Date:   Fri, 24 Jan 2020 13:11:19 -0800
In-Reply-To: <20200124205025.GA140846@google.com> (Emily Shaffer's message of
        "Fri, 24 Jan 2020 12:50:25 -0800")
Message-ID: <xmqqy2twy2yw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 12583BA0-3EEE-11EA-82A7-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Fri, Jan 24, 2020 at 12:35:28PM -0800, Junio C Hamano wrote:
>> emilyshaffer@google.com writes:
>> 
>> > From: Emily Shaffer <emilyshaffer@google.com>
>> 
>> Hmm, unlike folks who use GGG, your From: address seem almost usable
>> without having to waste two extra lines (which matters when one has
>> to review many patches a day).
>
> Blame an unhealthy appreciation for being able to write emails in Vim.
>
> I generate patches with 'git format-patch' - what's the unusable part of
> "almost" usable here?

Compare your message I am responding here, with your message with
the patch in it.

This one has a perfectly usable "From:" address,

    From:   Emily Shaffer <emilyshaffer@google.com>

while the patch e-mail has

    From:   emilyshaffer@google.com

which cannot be quite usable as the author identity.
