Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360CCC00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 16:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243745AbiHHQsJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 12:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244083AbiHHQru (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 12:47:50 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28175167CE
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 09:47:42 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C16D41B2CB5;
        Mon,  8 Aug 2022 12:47:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3JiHyyXt02/L07Me0XRxPGXsByYntAeVMcOF1+
        8QDug=; b=LN8e8qSsZb13L7FnUvyG8ffc9NCOLvMWQgIFoQBhoJNJNB+gnBqaVU
        jLTQabnzWOiXrk1EFGAn4zbUyFwncpAzqnAcjd9+GqiELK9lRyt0cvUF6PIi0cC1
        zQT3s11bRIJ9i3SFdqVRwY55Z5HQoFe75l7ja+TRgbP6/r3JWYXlg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BA1821B2CB3;
        Mon,  8 Aug 2022 12:47:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6BD6E1B2CAE;
        Mon,  8 Aug 2022 12:47:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tests: fix incorrect --write-junit-xml code
References: <pull.1288.git.1657789234416.gitgitgadget@gmail.com>
        <xmqq35f38yeb.fsf@gitster.g>
        <s4s2qr56-2948-p025-rrq7-qq56p9oo844r@tzk.qr>
Date:   Mon, 08 Aug 2022 09:47:36 -0700
In-Reply-To: <s4s2qr56-2948-p025-rrq7-qq56p9oo844r@tzk.qr> (Johannes
        Schindelin's message of "Mon, 8 Aug 2022 15:40:09 +0200 (CEST)")
Message-ID: <xmqqv8r2smvr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF29F022-1739-11ED-B258-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I still think that we need to slow the heck down with refactoring for
> refactoring's sake because it's not only the CI builds that are affected.
> I pay a lot of time to accommodate for those refactorings, and so do
> others, and the benefit of most of those refactorings escapes me.

Absolutely.

> You asked me in private to provide more reviews for those refactorings so
> that they see some push-back, but I lack the bandwidth for that.

I do remember telling you to push back what you do not want to see
in 'seen' and advance to 'next'.  If everybody lacks the bandwidth
for shooting down bad ideas and only has time to promote their own
ideas, which are not guaranteed to be good ones, it does not lead
to a good place X-<.

