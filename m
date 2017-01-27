Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E4CD1FAAD
	for <e@80x24.org>; Fri, 27 Jan 2017 20:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbdA0UsG (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 15:48:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63570 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751212AbdA0Urp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 15:47:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 80F7C63801;
        Fri, 27 Jan 2017 15:47:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E6lRrYFG8sAjnR6fdWxguCuoy+Q=; b=oDKjel
        2a0VPppJNfxLJcrnRab+ZAy4HphhsS5LufH1WxYPl71oQIfMbsWb0ZScQDxE5WEU
        5j1eYe7i0Ll6ji75+VM8PeUDHc4phbvPD+abVoVHMsXjc7QFUxRsuGhir1g6Wpkt
        v7P2KYXj1BlHWBk1a0dqgyl15z9u5XpbKoIS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CLAPoiPDDYctE3XZOSZVnpX3/5yLYg5d
        uiVG6Y0t1Ym4IUE97e4sPJkGXvFaTVe95+VFydl43m7+H4L5Cf0IClxZowCJ5aWH
        nMASA4R4RAvabj2rYQPbG+/x+AJK28qzYNIGpqDEeh08z+2wLBqf+dQFNb8Q5Z9E
        HV7D7FGXhhA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78C2163800;
        Fri, 27 Jan 2017 15:47:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D1ED5637FF;
        Fri, 27 Jan 2017 15:47:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: on FreeBSD, look for unzip(1) in /usr/local/bin/
References: <31dce0b28ae094c976890c1604c4ebbcaef0e7ef.1469116960.git.johannes.schindelin@gmx.de>
        <20160721171025.GA30979@plume>
        <alpine.DEB.2.20.1701271502420.3469@virtualbox>
        <xmqq8tpwz6jp.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 27 Jan 2017 12:47:37 -0800
In-Reply-To: <xmqq8tpwz6jp.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 27 Jan 2017 10:44:42 -0800")
Message-ID: <xmqqvat0xmae.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D70F5610-E4D1-11E6-9075-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> On Thu, 21 Jul 2016, Eric Wong wrote:
>>
>>> Thanks, t5003 now works out-of-the-box.
>>> Tested with Info-ZIP unzip installed and uninstalled.
>>> 
>>> Tested-by: Eric Wong <e@80x24.org>
>>
>> Did you forget about this?
>
> This fell off the radar.  
>
> You could have resent with Eric's Tested-by: added, to make it
> easier to apply.  I'll see if I can find the original but it won't
> happen until later this afternoon.

The errand I needed to run earlier in the day turned out to be not
so time consuming---I found the exchange and the patch is now
queued, and will be part of today's pushout.

Thanks, both.
