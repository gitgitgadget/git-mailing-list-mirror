Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B38C433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 20:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDEFE2072D
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 20:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oTux3h3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgHXUrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:47:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53330 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXUre (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 16:47:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 21A5EDAA4B;
        Mon, 24 Aug 2020 16:47:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P72FwLqMUkO9ITWtAitFcJFqT8M=; b=oTux3h
        3FWnM/UuyMy7Q+hemSq4wE1gSYGT+tuferjJ+Zw9NpvP3Pa+1x6EOrfbCWNGW24o
        yo2UOwmys81EUQVWJFL1FWCmD7NP4Fdl1fxs0VY4Fzi4qHZs9ffWg9eCJAiVSdl5
        Ik0PnhA558kXbqNPCdm1p1BK2nXr6990YbxXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ixXxwua0VLrlGG3ywMftW9YUs4y7JCaa
        KLuD6DGlb36IzNPcJF0m+7r8UCnHEmcwUzVp09PTyg5DfaDQXS5mH2KnMz2QDt9B
        KuId+aZW5d/KNw9eUz9cqQ5L+20IamI1Ykdnsg1AzTRVei9hbdmANKiqjUxS8H8r
        0kRhoG8TPQ0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1B4C2DAA49;
        Mon, 24 Aug 2020 16:47:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4ADFFDAA47;
        Mon, 24 Aug 2020 16:47:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, steadmon@google.com
Subject: Re: [PATCH 0/7] Better threaded delta resolution in index-pack (another try)
References: <cover.1598296530.git.jonathantanmy@google.com>
Date:   Mon, 24 Aug 2020 13:47:26 -0700
In-Reply-To: <cover.1598296530.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 24 Aug 2020 12:16:30 -0700")
Message-ID: <xmqqwo1n3h5t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05D7F8F2-E64B-11EA-A6C5-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> I'm trying to resurrect [1] and have rebased it to latest master
> (675a4aaf3b ("Ninth batch", 2020-08-19)).

Yay.

Thanks.
