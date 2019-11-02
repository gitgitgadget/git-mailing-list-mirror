Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93BD51F454
	for <e@80x24.org>; Sat,  2 Nov 2019 06:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfKBGSe (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 02:18:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62851 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfKBGSe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 02:18:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5FD22A6EDC;
        Sat,  2 Nov 2019 02:18:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SEEys2mRdYrabMPUiNz95x+kk8I=; b=DCFKmZ
        +PVyPjKCiRqAQcTynDox5N5wj2daKe7TYaiRPv/urMa2RFNm8LbEeputVcZGKhld
        ETBEWeUPSbzwzvho6h8W+FJ6M4g98yF0CRTP9EdsLWIyvKxXEAij1RTsm+hynUCE
        R9pIFdZsksTGNffDYN/V8WSnPIxyn0S8uUzcw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OwHtv602W7XkqIqpyA2iZRJtY1784CcJ
        o30TQOUNWGIY/LA0tIycV38ragMfNukN/5Orv9B58yOoVOgoGVw7hoXnuIzt6Vov
        bSHIqVlKsNrk1J5tP5Z05havvszH1m9PgJTs8wLNE15tY+zfXhPmF7O+O7p3l8p0
        0DdU4+Rh/E8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 58A7CA6EDB;
        Sat,  2 Nov 2019 02:18:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8A686A6ED4;
        Sat,  2 Nov 2019 02:18:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] RelNotes/2.24.0: fix self-contradictory note
References: <pull.440.git.1572466878.gitgitgadget@gmail.com>
        <0f3aa67e4aafbb7befd37d83a8c0d53a0a186259.1572466878.git.gitgitgadget@gmail.com>
        <20191102033236.GB93209@syl.local>
Date:   Sat, 02 Nov 2019 15:18:27 +0900
In-Reply-To: <20191102033236.GB93209@syl.local> (Taylor Blau's message of
        "Fri, 1 Nov 2019 20:32:36 -0700")
Message-ID: <xmqqh83m3ioc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96761B02-FD38-11E9-B667-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> ... It's--as Elijah notes--confusing to say that
> we recommend against using a tool but haven't 'officially' deprecated
> it. This works nicely around that issue by not using the phrase
> 'deprecated' at all, and instead being clear about what the state of
> 'git filter-branch' is.

Sounds sensible.  Thanks, both.

