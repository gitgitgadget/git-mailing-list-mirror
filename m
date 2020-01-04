Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2609C32767
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 23:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D72C2464E
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 23:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P4Rbu9lT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgADXNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jan 2020 18:13:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57456 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgADXNu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jan 2020 18:13:50 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D3E861830C;
        Sat,  4 Jan 2020 18:13:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eVN2Ozs+QqBXStOgAH7lGNBBT6A=; b=P4Rbu9
        lTp37OYHJ+0CgUr11uyLXfrVTu4gv8TjIhoKvAcx0ijPIxLt060Tf3Ftpe5jhEC+
        a7+gZ+OM1udvsRrBZGEsPRg9VCMSW+97moubfL7Oi6e2zqIeUUTb/2XMbon95Ahh
        easEbI+AYe1gmHcRwbPRnDgTVPJnpAXZoELn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OJWigyrDAYwEBBTnco1ccpmlc3UIgNqG
        jN7vskDNYQXGoFrLL/jiYIjOYhKNcvFRELTlu/zgwKeteSPAzFCoyMQyzAyzqiob
        la6sRzyur7z9K+ISsXqw7+CX/OJWa/aVJrgFqdZE74kA7sv0Okce16A8OM/19k5v
        1e3WaBtjfkc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CCB091830B;
        Sat,  4 Jan 2020 18:13:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4157B18309;
        Sat,  4 Jan 2020 18:13:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.25.0-rc0
References: <xmqqblrwm65l.fsf@gitster-ct.c.googlers.com>
        <20200102221921.GA81596@syl.local>
Date:   Sat, 04 Jan 2020 15:13:46 -0800
In-Reply-To: <20200102221921.GA81596@syl.local> (Taylor Blau's message of
        "Thu, 2 Jan 2020 15:19:21 -0700")
Message-ID: <xmqqmub2bys5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC43D9B2-2F47-11EA-A278-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I'm not sure if this is intentional, or if this was added twice during
> the merge(s) of and f7998d9793 (Merge branch 'js/builtin-add-i',
> 2019-12-05) and 3beff388b2 (Merge branch 'js/builtin-add-i-cmds',
> 2019-12-16).

It's the latter.  Thanks.
