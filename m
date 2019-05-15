Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3F381F461
	for <e@80x24.org>; Wed, 15 May 2019 01:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfEOBPc (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 21:15:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51817 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfEOBPc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 21:15:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A7AC4139F05;
        Tue, 14 May 2019 21:15:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HHJpJflcs1+N
        KSKhU5cUiVlmZWs=; b=Ziv1fE4GIJjyGJA4K0G7XtWIRV/0hIumik4JX/UVyCLM
        XZ0ymkZA5Mm9sUK30KumG840+kddQa+8n4XcxbQvnnKX7bqP7vYHPvyKJk/T0Lat
        3hI8n2lgQ6g52ZzWMM2nw39zbFigVjndTPYlKP9JHWZrmagBuxKr8g6POqJXaUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vLYyY0
        oEa842ASjCs2ghhlJJaia0AuN4qwW/Co4ZDmx4bbhmSGd9SG7ugH0OizY1ewcgIE
        S6ZyaQATx62LL2WFNbwrlA/RmdADx7icvpFd841MV805DV6Z8s7fdlEwKQGrFsLS
        p8ONOgT05DQqRWaE56+nzMcayCRlHS3ceEGfM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E12C139F04;
        Tue, 14 May 2019 21:15:31 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 13461139F03;
        Tue, 14 May 2019 21:15:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] stash: document stash.useBuiltin
References: <pull.193.git.gitgitgadget@gmail.com>
        <6c250451658f34c1415bfcba35ee6303cecac0dc.1557825553.git.gitgitgadget@gmail.com>
        <87k1etwesp.fsf@evledraar.gmail.com>
Date:   Wed, 15 May 2019 10:15:30 +0900
In-Reply-To: <87k1etwesp.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 14 May 2019 11:44:54 +0200")
Message-ID: <xmqqk1es8qml.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EE996304-76AE-11E9-8CE4-E828E74BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Thanks for following up on this. LGTM.

Yeah, thanks, both.
