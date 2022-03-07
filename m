Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F55AC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 16:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244371AbiCGQ7D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 11:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237432AbiCGQ66 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 11:58:58 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35022A25D
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 08:58:03 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 066BA12BF92;
        Mon,  7 Mar 2022 11:58:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YBOfq//GWO0T2VK8kR+Cr52eDkHdandSvhoYRR
        Sjy5A=; b=GQKdwAlBLe5YQwk9PYUrvSkLesqwqHRhAzQuUkwJUUwHO3nuZKcoNK
        zv8Dh4V1+xCkX4eF24Znw4DqDQJcsJU4boaSu0/8oAL/NftbX1FLy5T0Hr6e/wH8
        I7APrPX1OFSQtogjVl6DheA+n6Nctr492cTNqTY3+EOTKSmddOEjc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C418F12BF91;
        Mon,  7 Mar 2022 11:58:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A5A5E12BF8F;
        Mon,  7 Mar 2022 11:58:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: win+VS environment has "cut" but not "paste"?
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>
        <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet>
        <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>
        <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com>
        <nycvar.QRO.7.76.6.2202251440330.11118@tvgsbejvaqbjf.bet>
        <xmqqv8x2dd7j.fsf@gitster.g> <xmqqee3i2mlw.fsf_-_@gitster.g>
        <nycvar.QRO.7.76.6.2203071646500.11118@tvgsbejvaqbjf.bet>
Date:   Mon, 07 Mar 2022 08:58:00 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2203071646500.11118@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Mon, 7 Mar 2022 16:48:44 +0100
        (CET)")
Message-ID: <xmqqr17du2cn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BFA0630A-9E37-11EC-8F99-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> GitHub CI seems to fail due to lack of "paste" for win+VS job.  This
>> was somewhat unexpected, as our test scripts seem to make liberal
>> use of "cut" that goes together with it.
>> ...
> I added it:
> https://github.com/git-for-windows/git-sdk-64/commit/e3ade7eef2503149dfefe630037c2fd6d24f2c14

Thanks.
