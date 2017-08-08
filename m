Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF86E20899
	for <e@80x24.org>; Tue,  8 Aug 2017 21:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752196AbdHHVEl (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 17:04:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50992 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752145AbdHHVEl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 17:04:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DB8D966CC;
        Tue,  8 Aug 2017 17:04:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Uluwt765iIq0AMoXHo9Ux6cLvb0=; b=Aip8Hp
        7GKNrrNQ9eUPgy4Ojt5gV6AvarEEPFQnoL4U+ffy5s/3ddsqoWeNHUSYsXbPzunw
        dRF83DeVbN3JwmCwlR5Mpo91ElpbYbbZ2N6lU2dsr+eVlT69wqr6p0tz+3hB2RsR
        4MOR+j5dElDlYv4hcAf0Anqe9D0TrKIkmF8/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qer8poQNLUqruwqIsBakJia1BidBFp1z
        yhaDQ8T228mPpRJppMFgjDitFPNrhRlEohP70DCmOh5G8hkBw6NfD/synY0GpSYe
        7oXrGCaIE6r8TQEgpCZaRzIkfITQQxyjleGPzq8xiZtsNtNhfzaylNnXUu3fjtpc
        zDbjI5mTvxM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75820966CB;
        Tue,  8 Aug 2017 17:04:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C437E966CA;
        Tue,  8 Aug 2017 17:04:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 00/10] An attempt to move packfile funcs to its own file
References: <cover.1502220307.git.jonathantanmy@google.com>
        <xmqqd185bzbi.fsf@gitster.mtv.corp.google.com>
        <20170808134335.2834cb3d@twelve2.svl.corp.google.com>
Date:   Tue, 08 Aug 2017 14:04:38 -0700
In-Reply-To: <20170808134335.2834cb3d@twelve2.svl.corp.google.com> (Jonathan
        Tan's message of "Tue, 8 Aug 2017 13:43:35 -0700")
Message-ID: <xmqqvalxahzt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 315036A6-7C7D-11E7-8BD1-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> What do you mean by "keep the exposed surface area small enough"? If you
> mean the total number of exposed functions in sha1_file and pack (once
> everything is done), I think it will be almost the same as that
> currently in sha1_file.
> ...
> During this patch set, there might be some functions that need to be
> temporarily made global, but those are reverted to static in the end.

That is exactly what I meant.

> As stated above, I don't think so, but I'll make a list of the functions
> needing to be made global.

Good.

Thanks.
