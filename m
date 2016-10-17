Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A0471F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 19:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758874AbcJQTJI (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 15:09:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54674 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758855AbcJQTI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 15:08:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3915447A60;
        Mon, 17 Oct 2016 15:08:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u6sZaBipV5iGz7qpOiGjL/Fykgs=; b=E01l1+
        LYa+38aHJGRl07+KyZUE8L4PW/Qk1FJmyTdI/y2i1157jey3/dAK8n18/wvLV4nx
        8tfCkQbeLgH4g3oOl6i+PFpoNRJkql3sJYFa168pyvsTA0seUHHgNzWEmR3UudJX
        wcfiohpGu0CzKKObbknz2ezalroOTFBAnB1Wc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pr4lbtyRDnDnvA1SeocVQQ3dYCvn3UJ/
        EZfxO3JujPEa08Dgek+5/CggGU6yiyUfSlov/A7hGk70C52aWW0+VMDgrYghRtfP
        Dcr2oEEYDmi/OQ58lx19N4d/feC3XGBwt3e8dZvDRfeRV1AIpdOeUY4Sbr2HpOsb
        4ESeUR8gfSk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E6ED47A5F;
        Mon, 17 Oct 2016 15:08:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B66947A5D;
        Mon, 17 Oct 2016 15:08:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 00/25] Prepare the sequencer for the upcoming rebase -i patches
References: <cover.1476120229.git.johannes.schindelin@gmx.de>
        <cover.1476450940.git.johannes.schindelin@gmx.de>
Date:   Mon, 17 Oct 2016 12:08:54 -0700
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Fri, 14 Oct 2016 15:15:51 +0200 (CEST)")
Message-ID: <xmqqzim2u721.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26F688EA-949D-11E6-988C-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This patch series marks the '4' in the countdown to speed up rebase -i
> by implementing large parts in C (read: there will be three more patch
> series after that before the full benefit hits git.git: sequencer-i,
> rebase--helper and rebase-i-extra). It is based on the `libify-sequencer`
> patch series I submitted earlier.

The difference between the end results of v3 and v4 looked OK
(except the 08/25 "strip LF" change that is unneeded) to me, so I'll
skip the early part of the series from my review that correspond to
the ones in v3 that I've already reviewed and found good, and
continue from the later ones.

Thanks.
