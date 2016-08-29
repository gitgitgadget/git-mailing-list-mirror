Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24EFD1FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 21:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754207AbcH2VDE (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 17:03:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53090 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753436AbcH2VDD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 17:03:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A9C633AF80;
        Mon, 29 Aug 2016 17:03:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pW5whGorlvU7hjaWArEbbOiGNFQ=; b=nUQzu6
        7bA0Gp72VeS2BtGqP3bbFxzW9dv+tbaspKsKNnpSIOfJI6b6sFotIOYEDRJ2rZcz
        /F/+HlbRS2gc6T+rQGClZDH4P8SA1CvrHAQA57POqQtw3nP42Ah/Y3i6xY4fLctu
        hPPACk+017jcgdDaZhrh6bsDplyKdipP0aDok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rSQsRs7U/RBsJaq7v/kVgF13ZZYbRwAn
        C83ZYPFr2FQtaZgamTQbLSNeV9cOimS5qWu89uSPL8fq9oJZQ8dGOd6mmVdooQcz
        y/jKiaLPNH70QTuT5Y/kjftZi+yYhsSawBSjdPnoNtv5CCn+PQ6r7aA2CQZXAvK+
        8oI1IIX/eYQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 989DF3AF7F;
        Mon, 29 Aug 2016 17:03:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BFAA23AF7E;
        Mon, 29 Aug 2016 17:03:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/4] cat-file: optionally convert to worktree version
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
        <cover.1472041389.git.johannes.schindelin@gmx.de>
Date:   Mon, 29 Aug 2016 14:02:58 -0700
In-Reply-To: <cover.1472041389.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Wed, 24 Aug 2016 14:23:30 +0200 (CEST)")
Message-ID: <xmqqpoor8f0d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F832AC56-6E2B-11E6-892C-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When third-party tools need to access to contents of blobs in the
> database, they might be more interested in the worktree version than in
> the "clean" version of said contents.

Just a friendly reminder before you completely shift your attention
to unrelated topics.  I think this topic is almost there; let's not
stretch ourselves too thin by nibbling-here-nibbling-there and leaving
loose ends untied.

Thanks.

