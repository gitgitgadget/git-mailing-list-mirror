Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC40CE79A4
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 22:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjIYWVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 18:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIYWVc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 18:21:32 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ADA107
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 15:21:26 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AFC91CC135;
        Mon, 25 Sep 2023 18:21:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=js7Sspk2va0ZB0qvlGGtuRodCMQBfcMbcSz0MM
        n6ZkA=; b=mua1WOnwDsM/3t51aCntHWr1j/L3UKNbiZ1eZ14gj0iv159nTNzd9H
        sVw7KUWNezxFLRKQD3ryXNwqJrw1ZOynpFN7cUaUGxv92agBGSUODO3xnKmI1XPG
        ifw4BRpj9MGsNqzPkp9bEi7S5jt8BpHhB3LiTWS7Nsd4gdQ1oNMZg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 250481CC133;
        Mon, 25 Sep 2023 18:21:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 75D2D1CC132;
        Mon, 25 Sep 2023 18:21:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 0/3] support remote archive from stateless transport
In-Reply-To: <20230923152201.14741-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sat, 23 Sep 2023 23:21:58 +0800")
References: <xmqqy1h2f5dv.fsf@gitster.g>
        <20230923152201.14741-1-worldhello.net@gmail.com>
Date:   Mon, 25 Sep 2023 15:21:22 -0700
Message-ID: <xmqq5y3xrj19.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DCD0B5BE-5BF1-11EE-BEBA-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> Enable stateless-rpc connection in "connect_helper()", and add support
> for remote archive from a stateless transport.
> ...

Administrivia.  Please make sure that your patches [1..N/N] appear
as a follow-up to the cover letter [0/N], instead of each of them
being individually a response to somebody else's message.

Thanks.
