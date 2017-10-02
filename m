Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E62B720A2C
	for <e@80x24.org>; Mon,  2 Oct 2017 00:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751092AbdJBA3p (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 20:29:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59688 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750943AbdJBA3p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 20:29:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7813DA0D7A;
        Sun,  1 Oct 2017 20:29:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G74Zorvpu6+VYUKonGnaLG+uZQM=; b=iaYkV4
        0daR2FV9nmftz4MWYSMoDrVQz9j1jU+NSm4c2kXubZdnSbFCoeBF/Dkck5M+C5Gg
        hZl3i3enVmtcNrxRJwRm0vuZYBsH23TXjjxuCundRIvRsdRY4AIrFA/M8IWJeAf5
        qpde0n5bkJHMDsUpzs+tGv/+3tqVldGNTUV+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U3IWZv92x43rhpI7y1klBRXGGOzHOO7G
        iZPuM+QHDrV9/UFyr0KgiYKjVaUL+wpzlAvSkhIC4GTkD2q3Ka2zEqvq7Bu9lSyj
        jFKdFIZ5KTySFgt6Wb2R5IGct2zngPm068CZeDa/FNqeM8RZeaeY560A383CvOFi
        ZJbE1Jz41CI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F25AA0D79;
        Sun,  1 Oct 2017 20:29:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D8B01A0D78;
        Sun,  1 Oct 2017 20:29:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Kevin Daudt <me@ikke.info>, Git Mailing list <git@vger.kernel.org>
Subject: Re: "man git-checkout", man page is inconsistent between SYNOPSIS and details
References: <alpine.LFD.2.21.1709300523190.27819@localhost.localdomain>
        <20170930143258.GA20886@alpha.vpn.ikke.info>
        <alpine.LFD.2.21.1709301800060.7869@localhost.localdomain>
        <xmqqo9prv86l.fsf@gitster.mtv.corp.google.com>
        <alpine.LFD.2.21.1710010603340.17338@localhost.localdomain>
Date:   Mon, 02 Oct 2017 09:29:37 +0900
In-Reply-To: <alpine.LFD.2.21.1710010603340.17338@localhost.localdomain>
        (Robert P. J. Day's message of "Sun, 1 Oct 2017 06:05:44 -0400 (EDT)")
Message-ID: <xmqqtvzis87i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6720A74-A708-11E7-BEE7-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

> ok, i'm going to have to digest all that; pretty sure someone else
> will need to change the man page to clarify the apparent inconsistency
> i was referring to:
>
>   SYNOPSIS
>        git checkout [-p|--patch] [<tree-ish>] [--] [<paths>...]
>   DESCRIPTION
>        git checkout [-p|--patch] [<tree-ish>] [--] <pathspec>...

Yes, and a short-version of my answer is that they both are wrong
;-)
