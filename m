Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDF161F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 02:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbfJ2C0L (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 22:26:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59038 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbfJ2C0L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 22:26:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 47988A9375;
        Mon, 28 Oct 2019 22:26:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+ylmzMSpM8PE1zmzvzdfk0b2t4k=; b=cnfVfm
        HSD0FPTbXxr+1RVhWfO1l7weTLzOfVL0Wa7VpnUf6cmjq/5SC6s0O8TNDjoCKlDZ
        fMVm4SsOLFqtACPh+JhP4ljc2lwSW0u7jKZORQUAUSbzKkjbWhz2t3Bc+AMUfUvt
        L0ydV7a2oOBlqp+0T1/XSjqxjOt1AH/ABMSgE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FceeV+KKihIkGvjlhFS9vgyqcyOoFiPb
        MeXn2XkLBAFLQV0/NY9rqoMgsHJ0Doe1TSe6GTIZ7q2tDO+UcRhgSd23HFQcEk/c
        jGM74CRdXQDLwV92Qs5JVTDOEO0P8gpBbVnz6+TGO3RoA0vsnlt7QZ9udqWDRLVU
        yiOyzMRcwr4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 40024A9374;
        Mon, 28 Oct 2019 22:26:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 70243A9373;
        Mon, 28 Oct 2019 22:26:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 00/15] SHA-256 test fixes, part 6
References: <20191028005907.24985-1-sandals@crustytoothpaste.net>
Date:   Tue, 29 Oct 2019 11:26:06 +0900
In-Reply-To: <20191028005907.24985-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 28 Oct 2019 00:58:52 +0000")
Message-ID: <xmqqv9s870e9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7742CB56-F9F3-11E9-9A34-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This series consists mostly of additional test fixes for SHA-256, plus
> some test framework improvements and a new option to rev-parse.

All of them looked good to me.  Queued.
