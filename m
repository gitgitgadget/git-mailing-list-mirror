Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B39331F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 15:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754954AbdKNPIg (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 10:08:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53001 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754225AbdKNPIe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 10:08:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C2A2B3E55;
        Tue, 14 Nov 2017 10:08:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/ob2s9cv92+U+aSK8F2PVUOqSqA=; b=f8LZET
        HYw35Y68aeWRAPir1Mu9I6zHBuLX7PGVt/tiUahYZeCFWfWC96090GvAdBfCF7Pn
        xU7eNFZhYBlIooWA4fsQrsZ/L9qYZAGni9rfBBHEFJ6R7TOI1tQYGxuDGHf9gpkV
        e1/eph9Pw9r3JpbXaj6pfeDtgrROTZxO/4nTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pQYSG2wiKvRutihz+iFOjAgo+kgiwkrR
        sWm9YCJ4FEgHtoLyAQDoumbo/S+5CRoeoxmAMWrdl8VOLGkJu9w8vcie0XkT/Pk+
        yxEeCVBqfEoWLXfTQXrxBP7HWITFvoRYS0Ef0ExwiLknWZJQVGG/Iy8QQT2FaYOe
        yh0go8bv/qs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 526E2B3E54;
        Tue, 14 Nov 2017 10:08:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C1EB7B3E53;
        Tue, 14 Nov 2017 10:08:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] branch: forbid refs/heads/HEAD
References: <20171013051132.3973-1-gitster@pobox.com>
        <20171114114259.8937-1-kaartic.sivaraam@gmail.com>
        <0f8166ab-7955-aa78-7d32-0ec80944f007@gmail.com>
Date:   Wed, 15 Nov 2017 00:08:32 +0900
In-Reply-To: <0f8166ab-7955-aa78-7d32-0ec80944f007@gmail.com> (Kaartic
        Sivaraam's message of "Tue, 14 Nov 2017 17:30:11 +0530")
Message-ID: <xmqq375g3nkf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AEA99BD4-C94D-11E7-999E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> I should have been a little more clear with the numbering, sorry. The
> correct prefix should have been as follows,
>
>    * [PATCH v2 1/2] --> [PATCH v2 3/3]
>
>    * [PATCH v2 1/2] --> [PATCH v2 4/3]
>
> Sorry for the inconvenience.

I assume that the second one above actually talks about what was
sent as "v2 2/2" (not "v2 1/2") being "4/3"?

Are these two patches follow-up fixes (replacement of 3/3 plus an
extra patch) to jc/branch-name-sanity topic?

Thanks for working on these.
