Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D1621F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 00:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfJLAua (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 20:50:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60168 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfJLAua (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 20:50:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 74EB9A0B6C;
        Fri, 11 Oct 2019 20:50:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=33di4WfwMvkBqhUeisIAnwQx9o4=; b=ZgflIw
        i+VKw5V2cdB8RxFjqG0xaXAJc9oEdB0Ejv3hayzfQ2zCX8KFvGrCHOswFULCmEJZ
        E3xTNjKyXoBP5GyscGnaS4KnT94rCk1pqPSDUfHr4mERWSUtzvsf1Qxf5IEjT/05
        +fdERyxn/ecL8PWf0I6J0WiCuNRXy9RKp860k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RCtfQAtOq/dAAkmZ8PrUpeglbJCwnw7Y
        jOQn4OrMT+g2XS8FkQbk6y1OMPSU+FKKNmMFSdOJfFF5w9FHjCyPVZ9rgFQEV4GR
        Vd+/oC6WNXZic2NNJU94tcorqCwRupUdtOUHIYG3a6azerx0dwmxGM3iuCRUiZAd
        HdqcaeM8i8A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6DA8FA0B6B;
        Fri, 11 Oct 2019 20:50:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9E606A0B69;
        Fri, 11 Oct 2019 20:50:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2019, #03; Fri, 11)
References: <xmqq8sprhgzc.fsf@gitster-ct.c.googlers.com>
        <CABPp-BE4f5f3HyZu9wOyq599JN-n0EMF08di+2V51uxDMEwuGQ@mail.gmail.com>
        <xmqq4l0fgroj.fsf@gitster-ct.c.googlers.com>
        <CABPp-BF346QbjCyWP7HSP9Lh7mDRgtwtPC8b4mqNv4znUHoGFw@mail.gmail.com>
        <xmqqwodag7rd.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 12 Oct 2019 09:50:23 +0900
In-Reply-To: <xmqqwodag7rd.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 12 Oct 2019 08:52:22 +0900")
Message-ID: <xmqqblumg52o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 474134EA-EC8A-11E9-B5A6-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> By the way, I think I made a mistake in my calendar math.
>
> This topic was merged to 'next' on the 7th and it is not especially
> tricky; unless I (or somebody else) find glaring issues in it during
> the final sanity check before merging it to 'master' during the next
> batch, it would take the normal course to 'master' before the 18th,
> on which the rc0 is planned.

Unless I lose power or net due to typhoon, I plan to examine topics
that were merged to 'next' to see which ones should be part of the
next batch over the weekend.  This will be among those topics.

Thanks.

