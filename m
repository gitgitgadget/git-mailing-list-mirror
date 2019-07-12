Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 127E71F461
	for <e@80x24.org>; Fri, 12 Jul 2019 14:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfGLOtd (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 10:49:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56245 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfGLOtd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 10:49:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3F1E77163D;
        Fri, 12 Jul 2019 10:49:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zuVfamQo8on2ZlUK2BC4Fn4fvKQ=; b=nU6l9D
        y+muJr2OL+sjS4ygOxvCJzjSAT1D/TiVNBYLzLBhrV2wZ7wwXhiVP/nAA42umIRb
        EbzaTkc12n6hKROp5Fw4nCc7cvPwG/Qz5RUMvh3wKzsm31xpHBpO31eQMpD+fVht
        kuKjT1yLICrgduVB1gSS45xmBqTWnX/4ZKxSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QKwwaepHDxX7wTkzQoxkLzWajX5Pv/Fz
        2DWAq0bX+IR53F5oi3EUQWh2G9PHHtjuzss4LVdikd/6C601bnMH2aoRneprAJQN
        pUpAbse39OG+wY9yNCS+VBVeDKMrfDiqrUDkX7w9ndBvCvyb3gud9Oj8jzzAd6Oh
        JYZEQdjG0XU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 37AF67163C;
        Fri, 12 Jul 2019 10:49:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 634E47163B;
        Fri, 12 Jul 2019 10:49:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] use mailmap by default in git log
References: <20190711183727.8058-1-ariadne@dereferenced.org>
        <xmqqy314qsgp.fsf@gitster-ct.c.googlers.com>
        <xmqqtvbsqs9x.fsf@gitster-ct.c.googlers.com>
        <CAAOiGNwGqtSoG8vsy+3gb0=tDVvA1YcA3FcDP0KQMa0=xp5j9w@mail.gmail.com>
        <xmqqblxzqqw3.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 12 Jul 2019 07:49:26 -0700
In-Reply-To: <xmqqblxzqqw3.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 12 Jul 2019 07:17:00 -0700")
Message-ID: <xmqq7e8nqpe1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FE032C8-A4B4-11E9-A873-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I do not think we usually do this without having to say "at this
> release" in such a warning.

Sorry for horrible copy-editing that made the result say 100%
opposite of what I meant.  I am bad at negations.

But I hope the mistake and the message I wanted to convey were
obvious enough ;-) We've done this without giving exact timeframe in
the message.

