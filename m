Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 242191F437
	for <e@80x24.org>; Fri, 27 Jan 2017 18:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750803AbdA0Sqr (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 13:46:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51520 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750708AbdA0SqI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 13:46:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8EF9C61758;
        Fri, 27 Jan 2017 13:44:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m3fGotWrk8TKvKZ/lNEL7XSRd6E=; b=vuNw6Q
        naX4F6LXVkGlZ+33PsOTic1NaXc1wIZ/2/ofYOGIhbXSwwCKx4g1V1jSqk8w2SmF
        gFOpeAo1+R+sbLrxGsu1eFyTGlcdc7RpLM660hW45b4W1BJZhABJ5ZCMWoEDKX+T
        fw+NZklXXredhCoBYIzRG9rHZTl685MCpPhgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DwYZJ/ic+LLt6wRgec5K8NW38LmRMZiX
        6KHvRlUPtnTRHwXx1t58wMoMj7k7G2wOAzXrgnEwL0qDizQjotVmox9d3KbLKjrl
        uUs3QL5Xmqk1zFUfsfG3oARyPl7K4MGBaNfyoc4rFZNszx13WRYSngqdafT9iLAY
        16mkoBh+ODc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85CC561757;
        Fri, 27 Jan 2017 13:44:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E351F61756;
        Fri, 27 Jan 2017 13:44:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: on FreeBSD, look for unzip(1) in /usr/local/bin/
References: <31dce0b28ae094c976890c1604c4ebbcaef0e7ef.1469116960.git.johannes.schindelin@gmx.de>
        <20160721171025.GA30979@plume>
        <alpine.DEB.2.20.1701271502420.3469@virtualbox>
Date:   Fri, 27 Jan 2017 10:44:42 -0800
In-Reply-To: <alpine.DEB.2.20.1701271502420.3469@virtualbox> (Johannes
        Schindelin's message of "Fri, 27 Jan 2017 15:03:18 +0100 (CET)")
Message-ID: <xmqq8tpwz6jp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB421772-E4C0-11E6-A222-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Thu, 21 Jul 2016, Eric Wong wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
>> > The common work-around is to install Info-Zip on FreeBSD, into
>> > /usr/local/bin/.
>> > 
>> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> 
>> Thanks, t5003 now works out-of-the-box.
>> Tested with Info-ZIP unzip installed and uninstalled.
>> 
>> Tested-by: Eric Wong <e@80x24.org>
>
> Did you forget about this?

This fell off the radar.  

You could have resent with Eric's Tested-by: added, to make it
easier to apply.  I'll see if I can find the original but it won't
happen until later this afternoon.
