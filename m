Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2EFC20756
	for <e@80x24.org>; Fri, 13 Jan 2017 20:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751171AbdAMUFa (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 15:05:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59167 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750789AbdAMUFa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 15:05:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93C715E21B;
        Fri, 13 Jan 2017 15:05:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=gdsmVGUCwIiFoDroVF3RhZxIqRg=; b=Z8K1V9pOf4In/wKsUQtU
        XF0yblq4uP5P0YS9ibmtSLEaoANQ2JBZZPvA4sL2eg/nJ6evlZglamJnctmLFyN8
        ljtPcLHC9VBeT7r4vlXYIKAiHKAImfRr7zcRBwM0F9i2MhRV+GoQiH5Wco8FmafC
        wDuOGvioFvUB82VjtzueTC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=KhfSE2ibwsetJrh4xuSSRFJkhmXyobwmzNdDZD0yfFWzaz
        VpSDO6D64kHeFR+QjqSsDUFVwm6BYdb5BRCSg9ImciAhwXTNfXEaviWBP+TRPp3z
        Y7olTPsWtXe2NWdbRgv08io3iNDefElwEUBEg8OFpKOaNw6FCVhPyC4h11A6k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C76A5E21A;
        Fri, 13 Jan 2017 15:05:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D7F585E219;
        Fri, 13 Jan 2017 15:05:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Philip Oakley <philipoakley@iee.org>, GitList <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] updates to gitk & git-gui doc now gitview has gone
References: <20170112213240.7972-1-philipoakley@iee.org>
        <alpine.DEB.2.20.1701131622510.3469@virtualbox>
Date:   Fri, 13 Jan 2017 12:05:26 -0800
Message-ID: <xmqqo9zag1yx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A14AB058-D9CB-11E6-9A18-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Lets remove the reference in the gitk man page, and do some other
>> fixups while in the area.
>
> These changes all look sensible to me.

To me, too.  Thanks, both.
