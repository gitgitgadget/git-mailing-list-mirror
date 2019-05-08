Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D2551F45F
	for <e@80x24.org>; Wed,  8 May 2019 06:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbfEHGTC (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 02:19:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63928 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbfEHGTB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 02:19:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 231F3148225;
        Wed,  8 May 2019 02:18:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WQ9ap0AtjJkKf28S24tfRg4zO48=; b=c5C0zG
        jbnAijkOfFzpErpvQNZ74HBH8QU7y9ukgtZ5KlC52GZvwWodiD1GWRa3JiIxTOWQ
        kN2J5E/oPUM0uzNCaacMQxEUMdlDMnoTiar9aTpAO2ho+mHSL0wtSI2AQt6i03PG
        vAqEXxw4h5+7EC7FYTB+61Od+gemJSNNjSdfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C+cOJD8YG/JgVUQ+FkTsNwopfyuCRU1r
        WT8n/uDNW2jZEx/chozH2EgNA2Owi6SACj1mve2BmQNTfcR0QfJPfolD01QXB6su
        yu9euY67ebOS64ZZaoi0qW3aTS6nYmSQdVspA6YtTcV0uiBeRa9C/UqfZRpzKIWN
        XWNCgoq+/J0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 18CC2148224;
        Wed,  8 May 2019 02:18:59 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7C805148223;
        Wed,  8 May 2019 02:18:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] t6500(mingw): use the Windows PID of the shell
References: <pull.185.git.gitgitgadget@gmail.com>
        <ba78a47b873c5f044cbfb147b30a801cc90fb0ac.1557265888.git.gitgitgadget@gmail.com>
        <CAPig+cQG4+A+G+i+8RqpDAY2PveULVJ5iNR4HYEUPAd_4Ub04w@mail.gmail.com>
        <xmqqef59iou2.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 08 May 2019 15:18:57 +0900
In-Reply-To: <xmqqef59iou2.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 08 May 2019 12:53:41 +0900")
Message-ID: <xmqqr299h3ji.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A2EC608-7159-11E9-9DED-E828E74BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Tue, May 7, 2019 at 5:51 PM Johannes Schindelin via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>>> [...]
>>> Let's fix this by making sure that the Windows PID is written into
>>> `gc.pid` in this test script soo that `git.exe` is able to understand

I amended s/soo/so/ while queuing; I did not make any other changes,
as I described why in the message I am responding to.

Thanks.
