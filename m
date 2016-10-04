Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9275720986
	for <e@80x24.org>; Tue,  4 Oct 2016 18:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753243AbcJDS4T (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 14:56:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55470 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752027AbcJDS4S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 14:56:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1B3142449;
        Tue,  4 Oct 2016 14:56:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i25eQNohqFPfyWDzTQZzFtsuOlU=; b=LASMdt
        MDqlTxDu7w5gtHHA35f58l9lrKe0IwgRSNOhTMpz8DaHqxjBRaZkCoe0nbmXJQJO
        TQ1JLG3lu+8qLihmUiHcuq1AoQ7MP6um7tCj8LxQ5P4H0lj6l2GMf9xOkE8zT0SF
        r4idDCb1kj3xkGr5d0C4OFQbIMTJs5eEYhGVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UmTloVYkTg9zelGzDjpnlces08ZUrM5/
        gs+Okt6HSDJniIr85KsEDtpdDrQjlZqJeceGGYrLOkGv5aS6C3sMyOf4/XwrZwDn
        EWfJ5H6hOQbuEh9GsbDy0c9ilkJFinEJ4+gotC/cfchdLlQ1f4ZxJs9SKX4Zqd0w
        Ka3mRWg6sig=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A85AB42448;
        Tue,  4 Oct 2016 14:56:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 23ADE42447;
        Tue,  4 Oct 2016 14:56:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Pull out require_clean_work_tree() functionality from builtin/pull.c
References: <cover.1473580914.git.johannes.schindelin@gmx.de>
        <cover.1475586229.git.johannes.schindelin@gmx.de>
Date:   Tue, 04 Oct 2016 11:56:15 -0700
In-Reply-To: <cover.1475586229.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Tue, 4 Oct 2016 15:04:44 +0200 (CEST)")
Message-ID: <xmqqpongt034.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3AF08A32-8A64-11E6-AC77-50B112518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This is the 5th last patch series of my work to accelerate interactive
> rebases in particular on Windows.

Offtopic, but I am always confused by what you might mean by this
"nth last patch series".  Is this series 5th from the last and we
have four more to go?

In any case, after a quick re-read and comparison with the last
round, I think this is in a good shape.  I'd say that we would wait
for a few days for others to comment and then merge it to 'next' if
we missed nothing glaringly wrong.

Thanks.
