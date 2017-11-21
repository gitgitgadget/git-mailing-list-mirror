Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92DC4202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 00:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751594AbdKUAhh (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 19:37:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53260 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751301AbdKUAhg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 19:37:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A584BAF1E;
        Mon, 20 Nov 2017 19:37:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZbQGjruB/Y3F
        8G8lHu5W6ORpli4=; b=u7KJti7cv9HyCtjUkTA/pQQYF0T9nISVPyxgqFQuIvOH
        prHKxnf99fDKgVB4TNX63L4ynOqP64j1hqbwzBP1akdaUXWo8XTAxZDjQNXJqaMG
        NRPFoRtlSXN7893tFVJuCstAlx3DzGiyAILxUeuuIoRU3hjBMmV5gcQE7hxnsm4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=at5/x9
        nK28v4a8UPaI5JqlHDeFhW1ftXNctAIuNb4FRAjX8oRL5jDB0DOL2H/kFyUL83iC
        f4MCd4vzzEWB8qbSNfKLuAj4tH6vlET4Pp1se2VMfi/MxKqnFM75eoVzLyVZ8mty
        iDZm/232V11S93S5IREZkekpTRCDJG7jIYGb8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 329B0BAF1D;
        Mon, 20 Nov 2017 19:37:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A7CA8BAF1C;
        Mon, 20 Nov 2017 19:37:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH 1/6] t4051: add test for comments preceding function lines
References: <790c2344-a71e-7089-9000-f9b37a4a5cd9@web.de>
        <b5815f62-3ed4-58ea-6d32-b156e44cbe3f@web.de>
        <CAPig+cQTzBYLqHw5TRYFajTK2Uq2fE=q=h=b=VA43zdJs0_CMA@mail.gmail.com>
        <bde81d14-a955-4ea4-5799-2a95511d8215@web.de>
        <xmqqine5okeu.fsf@gitster.mtv.corp.google.com>
        <88f46ab2-03ff-3607-c776-25f34715ceda@web.de>
Date:   Tue, 21 Nov 2017 09:37:34 +0900
In-Reply-To: <88f46ab2-03ff-3607-c776-25f34715ceda@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 20 Nov 2017 18:28:54 +0100")
Message-ID: <xmqq7euklb5d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2B4B0FAA-CE54-11E7-8CD3-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> I am slightly in favor of than against the above reasoning, but it
>> probably deserves to be recorded somewhere more readily accessible
>> than the mailing list archive...
>>=20
>> perhaps?
>
> That's fine with me.

As there seems to be no other reason for updating the series, I'll
just amend it in locally.

Thanks.
