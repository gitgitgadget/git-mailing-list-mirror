Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31591C433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 17:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16E0961101
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 17:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhKCRZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 13:25:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54163 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhKCRZU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 13:25:20 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 79736E36C7;
        Wed,  3 Nov 2021 13:22:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QrR6DrTdMuUrLw8BTG2gOopaEMZwsNdYchEelh
        cUdMQ=; b=vGKzbbwSK1yLVIAhZA0zBA9aPfqv7UEj2J9W5a4QGMYB6eYz+/ru3l
        h1UTaZNDPmmxiyxMOd1NesdoxaN0VHopzflqgV5sGFF9FG/KwRITAykYOpm2Qu7G
        yvn+hDxnmGXJCmX2SgQyoqRimlTn1VWJR5csINbAh5TJx0XbZoFbc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FFFCE36C5;
        Wed,  3 Nov 2021 13:22:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CDA76E36C4;
        Wed,  3 Nov 2021 13:22:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] builtin: add git-default-branch command
References: <20211030140112.834650-1-thomas@t-8ch.de>
        <nycvar.QRO.7.76.6.2111021433010.56@tvgsbejvaqbjf.bet>
Date:   Wed, 03 Nov 2021 10:22:41 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2111021433010.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 2 Nov 2021 14:39:27 +0100 (CET)")
Message-ID: <xmqqy2656tni.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A73ED8D8-3CCA-11EC-8768-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> But we do have prior art in Git how to display similar information: `git
> var -l` will list e.g. `GIT_PAGER`, even if it is not configured
> explicitly.

Nice.  I was hoping that somebody would remember this one.

GIT_AUTHOR_IDENT and such that do not even exist as a variable is
part of "git var -l"; the name for the default initial branch falls
into the same category.

Thanks.
