Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 799891FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 19:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754930AbcHWTaR (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 15:30:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61480 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754656AbcHWTaR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 15:30:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 203B93736C;
        Tue, 23 Aug 2016 15:25:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8z1APT5TdznHjIBgqUKGw3l066g=; b=nDVv1e
        vsCO89zAMRG6/wBQBiBDc0w3fb4ORaBzVBQmehT9O67XQ1zZKNbQJyl7hJ9WPQPR
        peltYOBLOPS4KURp1j16HQ0sdoRnJ7EWv4Bh/ORoFmGCfKHTcwwwsVW331ZzPxCk
        Ivuamd+UuF+LyqjmY46SxCWu2+AtB7LrAx7vo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HyQyROmQymaxyrOKByNzYI+x7vGQDfyx
        lmvs+tL0aj49UWzfIDfAUa0yAPaw3JUcwSeP3eXey+/7fP1Cmddeg7VgI610c9Ep
        +0fcG8/JxVDZ1aU1X7SurekfdEeOtDPtpXAZ/m1SWL8a6iGDT7s8d2cvynRerKYH
        5eUySMZ8bzQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1724E37369;
        Tue, 23 Aug 2016 15:25:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8821C37364;
        Tue, 23 Aug 2016 15:25:08 -0400 (EDT)
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
Date:   Tue, 23 Aug 2016 12:25:06 -0700
In-Reply-To: <alpine.DEB.2.20.1608231758260.4924@virtualbox> (Johannes
        Schindelin's message of "Tue, 23 Aug 2016 18:05:32 +0200 (CEST)")
Message-ID: <xmqqzio3uw31.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D9785FA-6967-11E6-93B2-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In case it is not crystal-clear, let me clarify one very important point.
> It seems that some people mistake the work I do for something I do on a
> whim. This is not so.
>
> The patch series that triggered this entire unfortunate discussion
> introduced the --smudge option, which I have subsequently renamed to
> --filters and submitted as a patch series to the Git project.

As the "--filters" is meant as a new feature, it will not land on
the maintenance track.  It is very likely that it won't be in 2.10,
so it won't appear in 2.10.x maintenance track, either.

I do not agree with Duy that the "port to Windows" needs a separate
distinct name, though.  Having said that, aside from the issue of
handling of bugreports has been already meantioned, which mostly
costs for Git developers, whatever new feature you unleash ahead of
upstream to your Windows port has cost to your end-users.  Its
implementation or its external interface may have to change when you
upstream the new feature that has already been in the field, and
your end-users would have to adjust their scripts and/or muscle
memory.

One way to avoid that risk may be to release the new feature as
"experimental-and-subject-to-change", so that interested users on
Windows can actually try it out to see if the feature itself
(whatever its interface to them is) makes sense, and you can gauge
the value of upstreaming it, while cautioning these early adopters
that it has not fully been through the usual review process and may
have to change while becoming part of the official release.  This is
no different from various "experimental features" we unleash to the
wild, either via 'master' or keeping it in 'next' (we tend to do
more of the latter, marking "see if anybody screams").



