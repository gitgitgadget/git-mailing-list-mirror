Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B60C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 22:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F36D2071B
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 22:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q94Py5Av"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbgC0WIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:08:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59834 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgC0WIS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 18:08:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E88B255AA2;
        Fri, 27 Mar 2020 18:08:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=ZzdzJ/63VX6E5Ls31Dav6a8PSKQ=; b=q94Py5
        Av6zhkyao4TOCT0cGSpxnTFNsBK3YpiGHT4YRauCZwadD0acchdHbnPaqpUsLphF
        CuswJ03nkREn6aNO5qIHnQsa5H9ki59fxnes9ADU3lWPSVuU9zFpj6xCaexmCX8f
        HQoUyoIW8ofFTNl5AazDhaj3ki42NaJN8YD+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d9nYQXJ6YqyVAOkFUwBoBRx2n+xnporu
        T3f5KyC3b5cPuKuG5B4YllNT95zCAB7RS+sPRcQhOWL8nHZmtddzr2ze21rlh+fU
        y1nRv7o1tVNuUfpJsbsggeorwbVgE1IHK9FUUh8Wo+mhK6eP5sCR5Nb1FyeLynGI
        pRRq9s9gt5M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF5C655AA1;
        Fri, 27 Mar 2020 18:08:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 54B3055A9F;
        Fri, 27 Mar 2020 18:08:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/1] remote.c: fix handling of %(push:remoteref)
In-Reply-To: <20200325221614.ekn56wamfgs4bwmq@doriath> (Damien Robert's
        message of "Wed, 25 Mar 2020 23:16:14 +0100")
References: <20200303161223.1870298-3-damien.olivier.robert+git@gmail.com>
        <20200312164558.2388589-1-damien.olivier.robert+git@gmail.com>
        <20200325221614.ekn56wamfgs4bwmq@doriath>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date:   Fri, 27 Mar 2020 15:08:14 -0700
Message-ID: <xmqqblohe9ip.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74F1C776-7077-11EA-AB21-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Robert <damien.olivier.robert@gmail.com> writes:

> IMHO this patch should be good to cook.

Would love to queue it but I haven't had a time to look at it.

Thanks.


