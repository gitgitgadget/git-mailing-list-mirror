Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428F9C433EF
	for <git@archiver.kernel.org>; Sun, 22 May 2022 19:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350192AbiEVTKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 May 2022 15:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiEVTKt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 May 2022 15:10:49 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53956366B0
        for <git@vger.kernel.org>; Sun, 22 May 2022 12:10:48 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E2EA31AADF8;
        Sun, 22 May 2022 15:10:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9GXMYUMp2MtOJpI2IoJq4h61VWvVuyCW96nZ4L
        NfCJE=; b=f5qkv0q4hiVOgyKkXcwjBYaZXrmXy1ZKYMt7+iY806k5MI/gn3Ic5H
        DyChR4FALs62Z1lFLCh6j2z7VDT4kPOIbmY8CTs6Zmz9WFk/gU2P02acJzca0qdP
        WXDDWfWOOwQpgIyHmq48ktH0kxKoe3aLekDM2koNtptOF238kjG9s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DCD891AADF7;
        Sun, 22 May 2022 15:10:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 93D811AADF6;
        Sun, 22 May 2022 15:10:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 0/9] ci: make Git's GitHub workflow output much more
 helpful
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
        <6b83bb83-32b9-20c9-fa02-c1c3170351c3@github.com>
        <nycvar.QRO.7.76.6.2205212307090.352@tvgsbejvaqbjf.bet>
        <xmqq35h2cwrm.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205222045130.352@tvgsbejvaqbjf.bet>
Date:   Sun, 22 May 2022 12:10:41 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2205222045130.352@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sun, 22 May 2022 20:48:30 +0200 (CEST)")
Message-ID: <xmqqfsl1bcy6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E019C020-DA02-11EC-AEDC-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I see that this is still with the previous iteration, and therefore
> exposes the same speed (or slowness) as was investigated so wonderfully by
> Victoria.
>
> So I really do not understand why you pointed to that run, given that it

Simply because your updated version came to my tree a lot after I
prepared two trees that are otherwise identical for comparison to
write the message you are responding to.  If the new round is much
improved than the previous one, that is a very good news.

I do not appreciate that you have to always talk back to others in
such an aggressive tone, and I do not think it is only to me, by the
way.

You could have said the same thing in a lot more cordial way,
e.g. "There is a newer version than those being compared---could you
look at this run instead for comparison, even though admittably
there probably are changes in other topics in flight so the exact
failures may be different?"

