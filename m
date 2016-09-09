Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47EE120705
	for <e@80x24.org>; Fri,  9 Sep 2016 16:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbcIIQKF (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 12:10:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54492 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751212AbcIIQKE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 12:10:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B6F13C545;
        Fri,  9 Sep 2016 12:10:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+5Q7VskIIlzFysAN5qSYQrNGh5I=; b=bPaMGd
        uswG1tfP8kECA0W/BZgNCCnrF0TIR49M6Hn2MV69uBKVFBpccAbKCuPy5m7nxNqr
        KGrYDW/Ubg0yhwYjRGJxXpfNE+xRMHaneyQ1bc5ipB0ad4a4+tfef23p0fmbdd93
        Rx+AqqTw6j81S6nCi2kkGonosd7BtfCv1qh88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UUdDzlDF2hX6VXMi3VuBTbBMw7Jv36w3
        CY/NWJzepXQAD85yBDimCsQ2x8EQwCISmszkcUZGppfysKpcWN1eftkqxaeVrkWk
        7POd4fEqp2bQkYzOqFW95Lt9+VWdrZqu8KJ+2iygX0J8EMEmq30AAY7C2YuaNnOV
        ZrqyHTAT6mE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C1873C542;
        Fri,  9 Sep 2016 12:10:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 479A43C540;
        Fri,  9 Sep 2016 12:10:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Dakota Hawkins <dakotahawkins@gmail.com>, git@vger.kernel.org
Subject: Re: Issue with global config defaults "user.useConfigOnly = true" + "pull.rebase = preserve" - "user.email"
References: <CAG0BQXnVAYdpk9EM_uiD+=UKSKmK=z1YEar5MresTr5XfDCxHw@mail.gmail.com>
        <xmqqoa5gnxow.fsf@gitster.mtv.corp.google.com>
        <20160729181121.GB14953@sigill.intra.peff.net>
        <xmqq1t2cnvco.fsf@gitster.mtv.corp.google.com>
        <20160729223134.GA22591@sigill.intra.peff.net>
        <xmqqvaz7x6vv.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1609091731540.129229@virtualbox>
Date:   Fri, 09 Sep 2016 09:09:58 -0700
In-Reply-To: <alpine.DEB.2.20.1609091731540.129229@virtualbox> (Johannes
        Schindelin's message of "Fri, 9 Sep 2016 17:32:28 +0200 (CEST)")
Message-ID: <xmqq7faldpgp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBFB787C-76A7-11E6-9C00-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 11 Aug 2016, Junio C Hamano wrote:
>> 
>> Do you have a preference either way to help us decide if we want to
>> take this change or not?
>
> I have no strong preference. I guess that it does not hurt to go with the
> patch, and it would probably help in a few cases.

OK.  Let me dig the change back and how well it still fits ;-)

Thanks.
