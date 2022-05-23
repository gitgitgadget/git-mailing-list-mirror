Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE84DC433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 17:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242192AbiEWRxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 13:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245042AbiEWRwq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 13:52:46 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7BEA0D28
        for <git@vger.kernel.org>; Mon, 23 May 2022 10:42:14 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 92C511821D4;
        Mon, 23 May 2022 13:41:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LoCCEhXnwkjGFFlvib9lvZW2EPcHgjhsrDgje/
        /ruks=; b=QUqtN/OXxGrVZ52cUaKAkW4/u7cRLycG0+OgDUiCHclNJlonQMGRTm
        HQj0CVAhzRzsZ4avaUzTK0e2dhYVnZQzfPwPAbPmNSCS8q1UhsaehJCK3ARnJBgI
        Sod9fdKJpTLyxt1Yc0dNfarpk7NEMBNwb5Fh9yZ1IZeOPwZK4la38=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8B2491821D2;
        Mon, 23 May 2022 13:41:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3224B1821CD;
        Mon, 23 May 2022 13:41:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: js/use-builtin-add-i, was Re: What's cooking in git.git (May
 2022, #06; Fri, 20)
References: <xmqqmtfbcoaa.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205212352540.352@tvgsbejvaqbjf.bet>
Date:   Mon, 23 May 2022 10:41:20 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2205212352540.352@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sun, 22 May 2022 00:02:39 +0200 (CEST)")
Message-ID: <xmqq4k1gtadb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8EDEC2A6-DABF-11EC-81F3-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> As per
> https://lore.kernel.org/git/CAPUEspg1cJC_UwjJFx-jnzWsascY++S3UgM1UCLRcnK_Mv2wOg@mail.gmail.com/,

Yup, I recall that report.  Thanks for a pointer to allow me to
easily double-check.

> I believe that the macOS breakages have been confirmed to be
> addressed by `pw/single-key-interactive` (which was merged in
> 32f3ac26e03, i.e. it was included in v2.36.0).
>
> Therefore, right now might be a good time to advance the
> `js/use-builtin-add-i` series.

Great.  Let's do that.

Thans.
