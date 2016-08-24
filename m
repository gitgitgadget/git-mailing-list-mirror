Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58B811FD99
	for <e@80x24.org>; Wed, 24 Aug 2016 05:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752376AbcHXFK3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 01:10:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64754 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751056AbcHXFK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 01:10:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D3FFA39F64;
        Wed, 24 Aug 2016 01:09:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Fpinc9Q8rGkh9appG170zIObeEQ=; b=PHlJRK
        uusbIxahohf9adxQhO6I5Eqjyl8ykDTFNuIABLQEABrFQ7AjB32FSXZxqaQ0jQmr
        ZhKdgmSjrdFDneZRd6ZUUCur5pLNZg5i2eo8BQq3e88UJIrc4ATlLJUy2BHJPRJP
        xYgNQ6TxNWaFFdoTrfS4z+IJZcNq3/cotSpWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YhDDkZqC9m83DCbrdsCO2IjId1Ar9eO8
        i6ThOp5AAyp/mXkWy5maBq+2FnCsxHFt6f88dKSjw1fVNsJ5+BHHPUp/Yb6I/2rV
        OJY39/vLgnu1WOL7BybBecltYSGIgR8NiUQo14HRGp8cNqBNMp7GIWfbvvjADnDJ
        UuT4g/Rtc5Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB8CB39F63;
        Wed, 24 Aug 2016 01:09:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4F0D039F62;
        Wed, 24 Aug 2016 01:09:59 -0400 (EDT)
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
Date:   Tue, 23 Aug 2016 22:09:57 -0700
In-Reply-To: <alpine.DEB.2.20.1608231758260.4924@virtualbox> (Johannes
        Schindelin's message of "Tue, 23 Aug 2016 18:05:32 +0200 (CEST)")
Message-ID: <xmqqbn0iu50a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0151C3E8-69B9-11E6-AE13-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The feature in question is also highly unlikely to be used as much by
> non-Windows users as by Windows users due to the unfortunate choice of the
> default setting for core.autocrlf.

My vague recollection from some years ago was that even among those
who were active in msysGit development there were people who
advocated for straight-thru and others who wanted core.autocrlf as
the default, but I do not know the current state of the affairs.

In any case, in the ideal future, I would imagine that we would want
to have "cat-file blob" to enable "--filters" by default; that would
make cat-file and hash-objects a pair of symmetric operations.

That certainly will not happen within 2.x timeframe, and the new
"cat-file --filter" feature can appear in 2.11 at the earliest, but
I think by that time (or with a few more cycles) we may have a
handful other improvements that are backward incompatible lined up
to urge us to think about bumping the version number to 3.0.  I
recall writing "Will keep in next to see if anybody screams" a few
times already, and they are all good excuses to invite a version
bump.

To prepare for that future, we would probably want to start updating
in-tree scripts (including the tests) so that they call "cat-file
--no-filter blob" whereever they currently say "cat-file blob" in or
soon after 2.11.  Of course, if some of them currently pipe
"cat-file blob" output to munge it to produce what --filters would
have done (I didn't check), we would want to rewrite them to use the
new feature "cat-file --filter blob" when we do so.  In short, there
won't be any "cat-file blob" call that does not have either --filters
or --no-filters, except the ones we write specifically to check the
updated default behaviour when that happens.

Would that sound like a good longer-term plan?
