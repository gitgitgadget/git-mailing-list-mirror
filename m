Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5FFC433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 19:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09BB661181
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 19:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242946AbhKITGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 14:06:36 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61143 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhKITGg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 14:06:36 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C471C15466D;
        Tue,  9 Nov 2021 14:03:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vQpU/WiUKZEf1vdxk22u0pErjLR1BTx6EbIx0I
        ziEE8=; b=GnbqjMLOD3FzmZWJGx8xJA2238o0h73RzQn7HoUz7+xkLGX+F5BQHc
        i7kMVNl4CYZmqBUnwggtmpV1RVPCHSz+3B7lemdNaNG6rtGiLF/BSzAiAt9nydDQ
        6suFiLY3LdDPeKYYlg+M9bK5JwBLMnmu5CAsbSZntxbaxve1eeXN4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BDE2615466C;
        Tue,  9 Nov 2021 14:03:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A891615466B;
        Tue,  9 Nov 2021 14:03:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Description of github.com/git/git, was Re: [PATCH]
 builtin-commit: re-read file index before launching editor
References: <pull.1127.git.git.1636423586620.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2111091732040.54@tvgsbejvaqbjf.bet>
Date:   Tue, 09 Nov 2021 11:03:45 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2111091732040.54@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 9 Nov 2021 17:41:39 +0100 (CET)")
Message-ID: <xmqq5yt12lta.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C40E74CC-418F-11EC-AA99-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I would be in favor of changing this description. How about:
>
> 	Git Source Code Mirror - Pull Requests can be submitted via GitGitGadget

Presense of GGG does not change the fact that the repository is
publish only.  But "all pull requests are ignored" is not correct
anymore.

    Git Source Code Mirror - This is a publish-only repository but
    pull requests can be turned into patches to the mailing list via
    GitGitGadget. Please follow Documentation/SubmittingPatches
    procedure for any of your improvements.

I didn't double-check but I presume SubmittingPatches these days
talk about GGG?
