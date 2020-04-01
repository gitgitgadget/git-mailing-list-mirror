Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2893C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 16:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC8C20714
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 16:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YUyE4s5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732879AbgDAQ7G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:59:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59721 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732833AbgDAQ7F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 12:59:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8647A561C9;
        Wed,  1 Apr 2020 12:59:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VDl2Yvk4ZN3gRBOSaABulvyXfUQ=; b=YUyE4s
        5cnEAquVCHdbgkIZcgiyTd/EF7adb3NxNUwqRQW0JQ+/yZ4tl0vuX8uk2xHxYpsZ
        XGHR7EjyO/LwwlcEJiPRtrnkDlj37rJ6KRiuUamc/LRUHjCL3GKOrCLUwNkhvqa7
        s186jHuzSgKf9pfcyCPPcpsCOu2i/iOTtirnE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JUiYCcEC5Vo6n635MDkieKW+K//0M7+x
        TC/aenxnAcO3BM/y5wZcKz6/VOYReIkkV5pqKmyyJk7mU7G52+bjRKJowiCzCulw
        f0xIV3vw8iYKus1FnJ5/wzevY1fLVCD/BM2Z3bO5CIM2is/nNSeW42jjaUTmvpOP
        Y3GDtl50mS4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7BD09561C8;
        Wed,  1 Apr 2020 12:59:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CB38E561C5;
        Wed,  1 Apr 2020 12:59:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.ath.cx>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/6] Doc: drop support for docbook-xsl before 1.74
References: <20200330094513.GB1735224@coredump.intra.peff.net>
        <20200331192600.588-1-martin.agren@gmail.com>
        <20200401101716.GC60227@coredump.intra.peff.net>
Date:   Wed, 01 Apr 2020 09:59:02 -0700
In-Reply-To: <20200401101716.GC60227@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 1 Apr 2020 06:17:16 -0400")
Message-ID: <xmqqzhbv5ei1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1773536E-743A-11EA-8D08-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Subject: [PATCH 7/6?] user-manual.conf: don't specify [listingblock]
>
> Yeah, this looks good to me (and it looks like Junio already picked it
> up on top of your series).

Yup, thanks, both.
