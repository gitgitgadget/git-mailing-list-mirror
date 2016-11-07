Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1F422021E
	for <e@80x24.org>; Mon,  7 Nov 2016 02:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbcKGCcK (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 21:32:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58843 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751492AbcKGCcI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 21:32:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33EA54E80E;
        Sun,  6 Nov 2016 21:32:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:cc:date:message-id:mime-version:content-type; s=sasl;
         bh=XIWW9Pr3dAnJW2KP7Pg0m5bhvoU=; b=LsdKIMiWyHO/f27xRQF0BLzMI9Bm
        +TrZHzzVoQalbVSjc6tXFGVHmOlhX3TaGa5EwJhjVyF8C52jt3f10fPuS8q5HuER
        F4cok/v3TQ5EY/R/Gb93uwxf8s+4PY0zOKiLhYDUowbRNxtuU+S6RREaodY/OCow
        tRgW2zFsoUY3cMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
        SwhPHcGfm0DnuSJlkx0TnHrhP/du2NkmAMIXYfct+hiO9C6JBbUZpMOq/D+6zP6P
        uSu+gq/0lbD8cZu3Q1M2FMJM6jnqvJVfp0X2rUY72FTCaJwG3vz/xhZoWmM+Wcsa
        DfEYe3cRHRxG7aThxeqY17IdOElwnyoF8YN6nZ3DGQE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C9494E80D;
        Sun,  6 Nov 2016 21:32:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A04444E80C;
        Sun,  6 Nov 2016 21:32:06 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: 2.11.0-rc1 will not be tagged for a few days
cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>
Date:   Sun, 06 Nov 2016 18:32:05 -0800
Message-ID: <xmqqk2cgc95m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6026C17A-A492-11E6-9365-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I regret to report that I won't be able to tag 2.11-rc1 as scheduled
in tinyurl.com/gitCal (I am feverish and my brain is not keeping
track of things correctly) any time soon.  I'll report back an
updated schedule when able.

I'd appreciate that people keep discussing and exchanging patches
that will not be in 2.11 final to give a head-start to topics so
that people can agree on the designs and implementations in the
meantime, but one thing I'd like to see when I come back is somebody
tell me (when asked) what fix-up pathes that are "must to apply, or
there is no point tagging 2.11-rc1 while keeping it broken" are
found on the list.  I am aware of only two right now ("cast enum to
int to work around compiler warning", in Dscho's prepare sequencer
series, and "wc -l may give leading whitespace" fix J6t pointed out
in Lars's filter process series), but it is more than likely that I
am missing a few more.

Thanks.  Going back to bed...
