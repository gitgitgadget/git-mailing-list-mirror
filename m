Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1E6A1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 21:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754278AbcHWVnk (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 17:43:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53451 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753964AbcHWVmp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 17:42:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 522F236AD8;
        Tue, 23 Aug 2016 17:42:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6qfF4u10O4+wGAjo/gBrR2ZjOUY=; b=vaZk7T
        cSwWxtPoCqGrchxBrv3CqJB8QHNoDqLryRPa9x1E8BKJPEqLzWNE2kJzb01fFF/v
        jvPmwCPzzQs3Kj5M6a1P7W/sZpLGDPTnhtKyGpUIV+Dea2vPHuoMyWz9lh9wLb8W
        n7b32qThHFv3L4hy4LKANgDslt2144PweaG4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JIoA1+Frvs3S9OFeVR5rMiWEY2MmQXUu
        EPhEvEMpTDYTd7KqtBxBrpKHVKhpC+UAM8rpiYWwKUyUY1CMTQcIIuMeJrW+L6ku
        h8VDWMBLDRGHZ94ovsLXFQXI6o/IDvIZxcBW8yu6riOTiLI/BOH6/07ElHy5MTDg
        +OZIlHJr9vE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4ABD436AD7;
        Tue, 23 Aug 2016 17:42:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD99036AD6;
        Tue, 23 Aug 2016 17:42:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Michael J Gruber <git@drmicha.warpmail.net>,
        Duy Nguyen <pclouds@gmail.com>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [git-for-windows] Re: [ANNOUNCE] Git for Windows 2.9.3
References: <alpine.DEB.2.20.1608131214070.4924@virtualbox>
        <xmqqshu8u0px.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1608171507530.4924@virtualbox>
        <xmqqeg5nbehc.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1608181022250.4924@virtualbox>
        <CACsJy8A3tkMY-iLPCDj9sqB4HpAK_cxsUu5Z7fsGcCQEORyxUg@mail.gmail.com>
        <alpine.DEB.2.20.1608231553030.4924@virtualbox>
        <2a6d2230-90ce-0f54-c7ae-a5aa595a2f73@drmicha.warpmail.net>
        <alpine.DEB.2.20.1608231736180.4924@virtualbox>
        <alpine.DEB.2.20.1608231758260.4924@virtualbox>
        <xmqqzio3uw31.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 23 Aug 2016 14:42:34 -0700
In-Reply-To: <xmqqzio3uw31.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 23 Aug 2016 12:25:06 -0700")
Message-ID: <xmqqa8g3uppx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81F3E63C-697A-11E6-9958-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> One way to avoid that risk may be to release the new feature as
> "experimental-and-subject-to-change", so that interested users on
> Windows can actually try it out to see if the feature itself
> (whatever its interface to them is) makes sense, and you can gauge
> the value of upstreaming it, while cautioning these early adopters
> that it has not fully been through the usual review process and may
> have to change while becoming part of the official release.  This is
> no different from various "experimental features" we unleash to the
> wild, either via 'master' or keeping it in 'next' (we tend to do
> more of the latter, marking "see if anybody screams").

In case it was not clear, I am _not_ saying that the port to Windows
must not ship with any feature that is not yet in the upstream (the
same goes for a port to Macs, where it may want to do more about
dealing with Unicode "normalization" gotchas).  The differences in
platforms make it more likely that needs for certain things are felt
earlier and more strongly on a particular platform, and shipping a
new thing as an experimental feature to end-users may be the most
effective way to come up with the best approach to help the users.

