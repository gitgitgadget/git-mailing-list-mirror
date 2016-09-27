Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85EBA20986
	for <e@80x24.org>; Tue, 27 Sep 2016 18:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935287AbcI0SI6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 14:08:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54563 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S964969AbcI0SIX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 14:08:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 389ED3D58F;
        Tue, 27 Sep 2016 14:08:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4yk9lfNVcpvkmSfK89lal0CP50Y=; b=ZmH4Wi
        5tjgJmWnGqkJKr/+TxsoyF40ifqJnWsITuNhWbdQZsl+IHxtSIS0UaULkKqA1Wxq
        NjREz2xoVBkoqRHD0Lqj71aRdNCVRtZib1k7yXNFAhK86xZ4bghLwSQs+uHBGhjk
        Tpb+d9C+hQfsvEIp6TrBRF59V1dBo4rSkP+hY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RABJIYn44tcG/EOugHzm+95+KLLMa6n6
        EYbisbCQw9i01xdotqb1NBPTxZ5uTDHg0lfMvtZWXD/r6kuKeb4E1eWsALiWycOK
        SPdB+ZvgEHKUswQvdVgOU001ybXaOoLDAdoP3/ZOwhxRZqw6fB9FfilshNIsSv2a
        qdwLoBGBzQM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 319FE3D58E;
        Tue, 27 Sep 2016 14:08:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 844F43D58D;
        Tue, 27 Sep 2016 14:08:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     git@vger.kernel.org,
        Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>,
        Kevin Bracey <kevin@bracey.fi>,
        Philip Oakley <philipoakley@iee.org>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5] revision: new rev^-n shorthand for rev^n..rev
References: <20160927083249.31869-1-vegard.nossum@oracle.com>
Date:   Tue, 27 Sep 2016 11:08:19 -0700
In-Reply-To: <20160927083249.31869-1-vegard.nossum@oracle.com> (Vegard
        Nossum's message of "Tue, 27 Sep 2016 10:32:49 +0200")
Message-ID: <xmqqy42dnrl8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 601833BE-84DD-11E6-B29C-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vegard Nossum <vegard.nossum@oracle.com> writes:

> "git log rev^..rev" is commonly used to show all work done on and merged
> from a side branch. This patch introduces a shorthand "rev^-" for this
> and additionally allows "rev^-$n" to mean "reachable from rev, excluding
> what is reachable from the nth parent of rev". For example, for a
> two-parent merge, you can use rev^-2 to get the set of commits which were
> made to the main branch while the topic branch was prepared.
>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>

Very nicely done.  Thanks for a pleasant read.

Will queue.
