Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7C691FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 23:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934439AbcLUXVM (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 18:21:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56214 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934344AbcLUXUk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 18:20:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FAEC58D04;
        Wed, 21 Dec 2016 18:20:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KMMWn/U8FkJmyRBvijKEuyj4qvI=; b=E4fq/V
        98EJ4KkCbpUDHbOuSKLKxVYFFAQW8Yqs8hX9GdP3zliJtMM2mF+HGEXhc0gGIwCb
        iAdlNhgX2KiJXktBlgKBMCU76SfpsqsuQy3ZI2q2Ix2XrNDUhj+nGlvWitisMWhM
        Fa14iBGdUGDvfh2KtBB7cYn1+4uU1iq+SRk5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B2IGiUDH+Zvvt4w8M2OxCdor7K/J9Qtr
        qy7t9LFLWNF0bv76ve2Tmqn/Kvt2WdDTNFjFCT8kWfHSnRN7kEkBIBclaiPh4Yso
        guYrlAUtAfDvMuIicDkqOgprScgejeZ2pVhk8Y+920RL+zR2702qyCyQwgENKhZu
        dhXpKEJmY0s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37D3858D03;
        Wed, 21 Dec 2016 18:20:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B1A3F58D02;
        Wed, 21 Dec 2016 18:20:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephen & Linda Smith <ischis2@cox.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: References to old messages
References: <2284357.IWoC4bU66L@thunderbird>
Date:   Wed, 21 Dec 2016 15:20:37 -0800
In-Reply-To: <2284357.IWoC4bU66L@thunderbird> (Stephen & Linda Smith's message
        of "Wed, 21 Dec 2016 16:12:27 -0700")
Message-ID: <xmqqoa04hnsq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 156692D6-C7D4-11E6-8833-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephen & Linda Smith <ischis2@cox.net> writes:

> I want to pick up work  on a patch that I was working on previously.  
>
> I had been told to reference (i.e. footnote) a gmane URL.  With that service 
> no longer being being online, what is the preferred method footnoting?
>
> sps

The NNTP interface of GMane is still working, so referring to e.g.
$gmane/286483 _could_ identify a message uniquely, but people who do
not usually talk NNTP to GMane won't be able to find the message
with 286483, so it is not very nice.

The same message is referred to like this around here these days:

https://public-inbox.org/git/1455685597-22445-1-git-send-email-ischis2@cox.net/

The point is people know its message id is <14556855...@cox.net> and
refer to other archives with it, even when public-inbox.org is not
available.

