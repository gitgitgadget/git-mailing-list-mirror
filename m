Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60DC6202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 04:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbdJQEFg (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 00:05:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52778 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751828AbdJQEFf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 00:05:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7F19B1771;
        Tue, 17 Oct 2017 00:05:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SCe/LwWWKLm+MuZf32Jt5/CknUo=; b=FdIvN4
        2xmADLks66f1tnNlxYYtL3DwwEEBDP52LaxeTUjkxV29p5GCbg2F94pgcH+y2RrN
        w1goM1ZnZaym7IyGOqSOI/mRiVHqnkRjp7Au5U2XDAuj2MZjoUMSihRGEcMqSPE9
        +l1ZS1X/4YIL34uhQte7JobHf0Lw2iNsasq+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tcVzEW+y3yoRa2a5EtgkOBpxWvtNdOOB
        ot47ucRbyRqdSXoZ/QABgXOjJMefeQmIUyiMrhBsKeMfgob0PAnWb3A9HUKFCV87
        Wlw1jOaWKA0kfYyI/nX85RPHrS4ghvi8DN90Tz5OUZBbadc7ZxzABEhz4VVBRIvC
        it9M2YaZsZo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BFBA3B1770;
        Tue, 17 Oct 2017 00:05:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 30CD3B176F;
        Tue, 17 Oct 2017 00:05:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] pre-merge hook
References: <cover.1506081120.git.git@grubix.eu>
Date:   Tue, 17 Oct 2017 13:05:33 +0900
In-Reply-To: <cover.1506081120.git.git@grubix.eu> (Michael J. Gruber's message
        of "Fri, 22 Sep 2017 14:04:11 +0200")
Message-ID: <xmqqbml6pgfm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C9C49E4-B2F0-11E7-A50D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> This series revives an old suggestion of mine to make merge honor
> pre-commit hook or a separate pre-merge hook....

This seems to have become an abandoned loose end, so I'll drop the
topic from my tree for now; revival of the discussion is _not_
unwelcome (aka "dropping without prejudice").


