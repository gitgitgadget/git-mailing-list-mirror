Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19AE11F4C0
	for <e@80x24.org>; Wed,  6 Nov 2019 02:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387403AbfKFCBT (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 21:01:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54496 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbfKFCBT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 21:01:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E435EA4A82;
        Tue,  5 Nov 2019 21:01:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ho/Mxicife/AV4YRiqVbS/IEvyQ=; b=xka1/M
        AuO1IB7ImK838IPow0hFRMEU6CWNOuLOe7qxE/VV0EbIss2ZFACAn5DGrBBq6K+x
        GhfIqnSe2jwYg5L/xGDQ/Is1A5DT/ODAs/srumzjzm/PdQV2o0PZ+OJD/OIMOIqX
        7bMnq8y4CX3A2hB2cwdbrDVI6j9M3ORgPl5/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lwjuI81JVn3VQD3dG0L5sCOemhyE61HZ
        Trk+K/8B8XdNdUBll6yZ02sNeXSpFhtbinb3F32VKNwL6J/tjQVIWGOCJHjZTLOn
        qWicPfZLcq0/6tQygPL8itOx881sJbtx4dS2QmTbhCZwo/am9cO2zyhYoXikzGyC
        VuTO190E2vE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CB429A4A81;
        Tue,  5 Nov 2019 21:01:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 02E4BA4A7E;
        Tue,  5 Nov 2019 21:01:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net, peff@peff.net,
        szeder.dev@gmail.com
Subject: Re: [PATCH v4] pretty: add "%aL" etc. to show local-part of email addresses
References: <20191029120914.14756-1-prarit@redhat.com>
        <b9516269-3c17-1e7d-27f8-83558b56d1bd@redhat.com>
        <xmqqpni8z37z.fsf@gitster-ct.c.googlers.com>
        <2ad15a2d-63c7-51a5-fe1e-64e9b655adca@redhat.com>
Date:   Wed, 06 Nov 2019 11:01:11 +0900
In-Reply-To: <2ad15a2d-63c7-51a5-fe1e-64e9b655adca@redhat.com> (Prarit
        Bhargava's message of "Mon, 4 Nov 2019 07:35:31 -0500")
Message-ID: <xmqqk18dwyoo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FCE72C2-0039-11EA-B500-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prarit Bhargava <prarit@redhat.com> writes:

> On 11/3/19 11:15 PM, Junio C Hamano wrote:
>> Prarit Bhargava <prarit@redhat.com> writes:
>> 
>>> Just re-pinging to make sure this didn't get lost.
>> 
>> I think it has been on 'next' for several days aleady.
>> 
>
> My apologies Junio.  I didn't realize that.
>
> Thanks :)

No apologies needed; we are all human and not perfect, and I do
appreciate the pinging as I often end up saying "I didn't realize I
haven't picked it up".

Thanks.
