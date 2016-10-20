Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AC211F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 20:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754817AbcJTU25 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 16:28:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63740 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753319AbcJTU24 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 16:28:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 582F1465CA;
        Thu, 20 Oct 2016 16:28:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=aa3resyMbB+M
        URYTfBFhCKXsnNo=; b=sp4l4sly1EwzDY6HjxaMpv1ylYRk/DCdM2JfXcHIy+MJ
        ugKCh2bb2zHX49DUxJY1ugCyx7v8G5WyqpS2W/LtU99uz/A17LvrBf4g6pVOR6GD
        gZI7go8SKVaOExlb3b22cGNoqPz0Dwpmh3jWM+OzRZhRboZCP9vdBNhJWx2BD6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LKSpXP
        +UVQLcaeHskNSwmd2BKX6XZS8TXBI3zI6ChUGeq2YdvDYnhHNFHCp/w8PK9cG17a
        J3Xe8was5c41UVA5G6b3Q/FPHvQO7LZfn2cK6El0FOs6nM/LMiiB1GyNfK93wgci
        Ciy+L+El/UA4Pcwuo+F4DkwQJAzsaaZbxkoCw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F273465C9;
        Thu, 20 Oct 2016 16:28:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BED19465C8;
        Thu, 20 Oct 2016 16:28:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 23/25] sequencer: quote filenames in error messages
References: <cover.1476120229.git.johannes.schindelin@gmx.de>
        <cover.1476450940.git.johannes.schindelin@gmx.de>
        <930ea31d6f10973807276c7a9f35f0d692d1ada6.1476450940.git.johannes.schindelin@gmx.de>
        <xmqq8ttig3zn.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 20 Oct 2016 13:28:52 -0700
In-Reply-To: <xmqq8ttig3zn.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 20 Oct 2016 13:27:56 -0700")
Message-ID: <xmqq4m46g3y3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D2290AEA-9703-11E6-9646-987C12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> This makes the code consistent by fixing quite a couple of error messa=
ges.
>>
>> Suggested by Jakub Nar=C4=99bski.
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>
> These finishing touches in 21-23 look all sensible to me.

Make that 21-25.  I finished reading to the end and it was mostly a
pleasnt read, except for a few things I noticed and sent reviews
separately.

Thanks.
