Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9A5E211B4
	for <e@80x24.org>; Sun,  9 Dec 2018 02:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbeLICHM (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 21:07:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59310 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbeLICHL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 21:07:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 53CB5118764;
        Sat,  8 Dec 2018 21:07:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DFIq5G9OOapjboKXhquxdPaF2rU=; b=vmkL/m
        Vys8x3COloT7OEw+S31PVBFeaajx2dFXHumfcr0vdFGKvH24CZvx8LIarkSD+r3d
        Nwl5uj9Mphn4cmmLOBKYhCm4UxxFPRvzxonK8iNX28MgHWg9jVZ7VcNiuoyr9Ba1
        f8Ho0daWfXjl3T79M4tUCJaD//sYrzIbiCfw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P3suFZX7arXn7fEHcmJKaIgZZ0IIiKNz
        +nYTppG2m7/GYQ+mAUndtlcCsnJsQpcWOK0NP1GtWgKhWF/LVA7yBBblLt/G9xJk
        IFpXyQqfdcKJDD0wj1f+CfTxyChnNiZVjPdWa5nolDQoh/FCOxRGHXOS8pzc7tBl
        TskSFhQ6uLk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C9E4118762;
        Sat,  8 Dec 2018 21:07:09 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 92E04118761;
        Sat,  8 Dec 2018 21:07:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: Documentation: update "man git-add" to include "[]"
References: <alpine.LFD.2.21.1812080958180.26244@localhost.localdomain>
Date:   Sun, 09 Dec 2018 11:07:07 +0900
In-Reply-To: <alpine.LFD.2.21.1812080958180.26244@localhost.localdomain>
        (Robert P. J. Day's message of "Sat, 8 Dec 2018 10:00:06 -0500 (EST)")
Message-ID: <xmqqwooj4fn8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22030548-FB57-11E8-A346-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

> Current "man git-add" emphasizes single letter interactive
> shortcut commands with "[]".

Not for me.  These prefixes are instead painted in colors.
