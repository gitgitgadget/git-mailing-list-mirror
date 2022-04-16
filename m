Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B2AC433F5
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 06:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiDPGlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 02:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiDPGli (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 02:41:38 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF57100E11
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 23:39:07 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2654112180D;
        Sat, 16 Apr 2022 02:39:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YIX/2yADapNVnEcorqxiT8/vzZRmIBbXs2lphq
        VFVAw=; b=XNXoivYSKvOo6C18tt6caveRDBldma2KTfGJRmbKfcWM9iK0i+MS/5
        jauJHmnq51RS8nPvywRrkIGwfie/hSnW9cAV0ZqpgmlbfM8UcMRPqZGfJeyPMV7C
        9XVrJ3F3aU7+NPPdtotAADBCu93fp/yG3nTTMtWPKKtVJ/q1L/Eb4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D30612180A;
        Sat, 16 Apr 2022 02:39:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4DD47121809;
        Sat, 16 Apr 2022 02:39:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [RFC] introducing git replay
References: <20220413164336.101390-1-eantoranz@gmail.com>
        <xmqq4k2wap8g.fsf@gitster.g>
        <CAOc6etYvOhqQn3icWj3Ny1m+J_60h7aiqW-gvm=dQyDLgG=6NA@mail.gmail.com>
        <xmqqbkx2ccj4.fsf@gitster.g>
        <CAOc6etYwMtfytbw6iRfnJnsexJhe7UydVu0OFUbWP0byS9i=MQ@mail.gmail.com>
Date:   Fri, 15 Apr 2022 23:39:03 -0700
In-Reply-To: <CAOc6etYwMtfytbw6iRfnJnsexJhe7UydVu0OFUbWP0byS9i=MQ@mail.gmail.com>
        (Edmundo Carmona Antoranz's message of "Sat, 16 Apr 2022 07:35:46
        +0200")
Message-ID: <xmqq7d7p7cs8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E88F2DD2-BD4F-11EC-AD05-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> Let me work a little bit on your workflow to see what I can do. Tip:
> It will probably come out in the shape of a script. We can talk about
> what to do with it later.

Heh, I have a script to do what I have to do every day multiple
times already, can be viewed in my 'todo' branch.
