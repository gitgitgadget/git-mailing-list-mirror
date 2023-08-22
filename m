Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220FEEE49AB
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 23:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjHVX1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 19:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjHVX1w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 19:27:52 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1BBCF
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 16:27:50 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 182193F445;
        Tue, 22 Aug 2023 19:27:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=olKmxRobiutxxBUPlpv+c/nLCgkTJgAiQHZ/NV
        oh7NU=; b=HEpLZthvRQoNa3e3/mL34MwleeutpIzjTd+kGVE6toTYum7nKoXB4c
        FqNit7KdgiArWwGz8w66cJmklreYn/cvnLoaKRJ9m9penDbj6lWJy0Eu8wZIpdlE
        EPkZOsmKZPh52KEZZmdqZ69dhCpNYNMF8O+ySgtnwOHwRVSd9N/O8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1092B3F444;
        Tue, 22 Aug 2023 19:27:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 479AB3F443;
        Tue, 22 Aug 2023 19:27:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Romain Chossart <romainchossart@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 4/7] diff: die when failing to read index in git-diff
 builtin
References: <20230821201358.GA2663749@coredump.intra.peff.net>
        <20230821201727.GD1798590@coredump.intra.peff.net>
Date:   Tue, 22 Aug 2023 16:27:46 -0700
In-Reply-To: <20230821201727.GD1798590@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 21 Aug 2023 16:17:27 -0400")
Message-ID: <xmqq7cpmirnx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80B602C0-4143-11EE-AA1D-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> lib-ification purposes, at which point this code would already be doing
> the right thing).

Yup, I very much like that approach and attitude.  Proactively doing
the right thing even if the other parts of the code is not yet
ready.  Good.

Thanks.
