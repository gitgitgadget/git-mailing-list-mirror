Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328C1C47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 23:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06D062070B
	for <git@archiver.kernel.org>; Mon, 11 May 2020 23:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="umfnJcIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgEKXpw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 19:45:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62240 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgEKXpv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 19:45:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C43C51E22;
        Mon, 11 May 2020 19:45:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aCwDjkPoBw6ckjtjb+N/+2lAnH8=; b=umfnJc
        IfM+bHyiHJ9HIrrhsyK6JyuVC22c6Q49oR4mjez3Q9pvz1w2gAlYF6QOLvpO2o0f
        V8JeCdQp4qHeqG66qtyWHkrBHl0Rms+U3vjkq6PB728B6Cd1UrSCU5NBJzEi3jy6
        caxx5y3sh5KFev/rwRFv/SW+MTHKG25S1Tj7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dD7ev9LxSS/9Osw5H3ECvIOE70wH5o9z
        z+whcQMFTdKzfcY7MBtk4Ipp8L0x21I0vmCAUAjVg3PFhGCFIOiHtu3TERsHv5c+
        Kh9ZGVoGe+9vibO03REhSTPMWXRSpCbY81ZW21Iy7NzsZEoPANtf3B/HIX6rXJrV
        rOZwDbFnvLM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 845E251E21;
        Mon, 11 May 2020 19:45:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 06FF451E20;
        Mon, 11 May 2020 19:45:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Subject: Re: [PATCH v5] bugreport: collect list of populated hooks
References: <20200511221430.174122-1-emilyshaffer@google.com>
Date:   Mon, 11 May 2020 16:45:48 -0700
In-Reply-To: <20200511221430.174122-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Mon, 11 May 2020 15:14:30 -0700")
Message-ID: <xmqqd07aqbmb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A99D996-93E1-11EA-BDCC-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> The only change since v4 is to uncomment the heredoc, meaning the hook
> names will be correctly injected into the test hooks.

Which means that this is identical to what we had in 'pu' for a
couple of days already ;-)

Let's mark it as ready to be merged to 'next' and move on.

Thanks.
