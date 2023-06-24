Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58806EB64DA
	for <git@archiver.kernel.org>; Sat, 24 Jun 2023 23:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjFXXfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jun 2023 19:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjFXXfq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2023 19:35:46 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9225610F4
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 16:35:45 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 311CF21CF7;
        Sat, 24 Jun 2023 19:35:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OxCpZrjZNVkV9SLksJgjRwWTtbfNO78svrXhWw
        mxZr0=; b=A4Q+/vyYguYWKix9PqwEDnk/zubWBYFNGgwIvZnNGovKRK0QaUxij5
        fmnDzYkMfd6nDcIgjBqnUrDpDQ/r3m34eNdh+Q3tRC1Gq8Ir9DWsc98czaTrau95
        kiSHXgbA1F9i7vJ/b+uGH18dyD230Q3gZmCeXAzQ/1N4uEFPX/7s4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A1FD21CF6;
        Sat, 24 Jun 2023 19:35:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DC19B21CF2;
        Sat, 24 Jun 2023 19:35:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mark Levedahl <mlevedahl@gmail.com>
Cc:     git@vger.kernel.org, adam@dinwoodie.org, me@yadavpratyush.com,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH v0 0/4] Remove obsolete Cygwin support from git-gui
References: <20230624212347.179656-1-mlevedahl@gmail.com>
        <xmqq8rc8781p.fsf@gitster.g>
Date:   Sat, 24 Jun 2023 16:35:39 -0700
In-Reply-To: <xmqq8rc8781p.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
        24 Jun 2023 16:30:10 -0700")
Message-ID: <xmqq4jmw77sk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4A1D524-12E7-11EE-8A6E-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> patch 1 removes the obsolete Makefile code
>> patch 2 removes all obsolete git-gui.sh code, wrapped in is_Cygwin...
>
> As it has been quite a while since I had access to any Windows box
> or Cygwin, but the earlier two patches look obviously correct to me.

Ehh, in an early draft, I had "I cannot comment on patches #3 and
#4" before that "but", but I ended up commenting on them anyway, and
ended up with such a garbled construction.  I should have copyedited
the above to "Even though it has been ... or Cygwin, the earlier...".

Sorry for the noise.
