Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE5012047F
	for <e@80x24.org>; Mon,  7 Aug 2017 21:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751799AbdHGVsK (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 17:48:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53300 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751589AbdHGVsK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 17:48:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 84DCCA5CAC;
        Mon,  7 Aug 2017 17:48:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fwkz++1TzIFIpjucOT5g4VteKcY=; b=ezI/u5
        c8CetlTGWxmZ0z02dUnol8GoNrDX8/Xx5wk8oc68wVOhphcwGVbLmOH9I91rl9EM
        1hCY5H7Ees8kDiTLOgIG3Cq76QswEgtpuy1b1e1b9UwfCMRKOyFrHMvWoJ8YRG9k
        8WxB63owyYOSsmK/VIALvST9qGpdhoNd6tBV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=auwMbxO0kta3TzV+VRc2wfwOZOiCJfHR
        rfxuDwt9jDe2p0D3SRGfQzFsU2NAFBdSoNQYw9zfMvnGDOhoyqJ0E3RTKOnw4FSb
        SvyOwtCmec2aSBaVfsJjm3Hff1clPjyNWocSQzgo7skuhM+xmo2+zDCxBoLXBSSc
        ijdrNzpw780=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE3D4A5CAA;
        Mon,  7 Aug 2017 17:48:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 07E30A5CA8;
        Mon,  7 Aug 2017 17:47:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Michael Forney <mforney@mforney.org>, git@vger.kernel.org
Subject: Re: [PATCH] Drop some dashes from built-in invocations in scripts
References: <20170805064905.5948-1-mforney@mforney.org>
        <xmqqshh3qqs4.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1708072300310.4271@virtualbox>
Date:   Mon, 07 Aug 2017 14:47:58 -0700
In-Reply-To: <alpine.DEB.2.21.1.1708072300310.4271@virtualbox> (Johannes
        Schindelin's message of "Mon, 7 Aug 2017 23:07:04 +0200 (CEST)")
Message-ID: <xmqqshh3nj75.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14C1D594-7BBA-11E7-9074-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I feel a bit talked to my hand, as the only reply I was graced was a "I
> think I already did". So this will be my last reply on this matter for a
> while.

Ah, I meant this thing:

  https://public-inbox.org/git/xmqqo9rrqp3l.fsf@gitster.mtv.corp.google.com

I got an impression that you didn't read it before you typed the
message I gave that response to.

There are a few more exchanged, including Michael's response to that
message on that thread.
