Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD8FB20899
	for <e@80x24.org>; Fri, 11 Aug 2017 19:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753242AbdHKTAH (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 15:00:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51047 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752995AbdHKTAG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 15:00:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A7D31AD0A1;
        Fri, 11 Aug 2017 15:00:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=THDgaHhPCvDf99TYbicrvwkUJS0=; b=mdcuCK
        FWca7zcHGAm09X2C1detGecXQujDawDFvjeK1ilBqO122M6EvVXbAb1A/Vei/lPf
        jWA+ijdm7MvD+O5fWT0afF1KGJLrRb93o9wNi83cTBuiiRVnr6DMdp6HrzXyju0r
        FrqoWCb0SO9VJVqpK4bQcgc8hwRMUXPdBAZFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pxUg5YLuCS6WJ37UivrX1LIZg7zfbp/c
        FZ59OFFJGbgAHZ+pkhSTIRwAVeaqdufZt4XBZ65mARmN1Ui50ERUIWPdrea/5RZX
        Sp8qIXKLcB3W1uB7dqsp0FLvPfpsYjEctxez4uqb730FUlfO0yy99pp3Fml1wEe9
        osHaLbejbHA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F304AD0A0;
        Fri, 11 Aug 2017 15:00:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F3F2AD098;
        Fri, 11 Aug 2017 15:00:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] clang-format: outline the git project's coding style
References: <20170808012554.186051-1-bmwill@google.com>
        <xmqq3792c5sb.fsf@gitster.mtv.corp.google.com>
        <20170808180317.GA73298@google.com>
        <xmqqy3qtc3x4.fsf@gitster.mtv.corp.google.com>
        <xmqqpoc56x27.fsf@gitster.mtv.corp.google.com>
        <20170811174958.GB59325@google.com>
Date:   Fri, 11 Aug 2017 12:00:01 -0700
In-Reply-To: <20170811174958.GB59325@google.com> (Brandon Williams's message
        of "Fri, 11 Aug 2017 10:49:58 -0700")
Message-ID: <xmqqpoc2ylou.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48DB2974-7EC7-11E7-89E2-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> checkpatch.pl also warns a SP immediately before HT, which I do pay
>
> I'm sorry what's 'HT'?

Horizontal tab.

"man ascii" or http://man7.org/linux/man-pages/man7/ascii.7.html
