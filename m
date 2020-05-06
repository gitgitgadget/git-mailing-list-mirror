Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690E5C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 18:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39E0620747
	for <git@archiver.kernel.org>; Wed,  6 May 2020 18:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pFy3Izsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgEFSPU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 14:15:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50461 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728619AbgEFSPU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 14:15:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A6345FF07;
        Wed,  6 May 2020 14:15:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JD74E443zK3pQAoOSkLrv/LMLZM=; b=pFy3Iz
        sdhJ378P8cwUAWB3wRy0qfuChQGK2gnSv+G2tVNNpkAWYx8CIzT1gbP4fCr/VPFV
        tpTyGY9DqwvUo24NWsP0Z4onwrSXSmTrEgeFyNnvULorEp6vvjPjJhMGSNqE4dW4
        rAQ5nzP4/8ywvECYbizg1BUFYWghWXw35qQNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uG1dhnidvGKD3gRPCuGwn+GV+btkClav
        587oC2iPmMFcnrKgh2WO0i3/hlzv1tyb/FKzMX9HsAzma0NqCQVuF5geBS55k5Vo
        IR7R1JCHH4g1liO6EdTcO0odvX7nPDSkWVmmrFoRRRcL0dPXs8kosCfHBQd6Rw2F
        PZxz8aDysAU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 134FA5FF05;
        Wed,  6 May 2020 14:15:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 97B915FF04;
        Wed,  6 May 2020 14:15:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, sandals@crustytoothpaste.net
Subject: Re: [PATCH v7 1/4] gitfaq: files in .gitignore are tracked
References: <20200506171110.23124-1-shouryashukla.oo@gmail.com>
Date:   Wed, 06 May 2020 11:15:16 -0700
In-Reply-To: <20200506171110.23124-1-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Wed, 6 May 2020 22:41:07 +0530")
Message-ID: <xmqq1rnx6ibv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A17C8D6-8FC5-11EA-BA97-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Add issue in 'Common Issues' section which addresses the problem of
> Git tracking files/paths mentioned in '.gitignore'.
>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---

I'll queue only 1/4 and 4/4 for now, as these two among four haven't
changed in the last few rounds.  The remaining two are *not* rejected;
just are not yet in a shape ready to be queued.

Thanks.


