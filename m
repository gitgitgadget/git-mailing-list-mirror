Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA0151F404
	for <e@80x24.org>; Wed,  7 Mar 2018 13:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754418AbeCGN1W (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 08:27:22 -0500
Received: from mail.javad.com ([54.86.164.124]:57299 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754279AbeCGN1V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 08:27:21 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 2C8F43E8AB;
        Wed,  7 Mar 2018 13:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520429240;
        bh=4LNAZApKvdMEdY/fOtCcZ/q4toW4mYvuWsppB582jVY=; l=1892;
        h=Received:From:To:Subject;
        b=WyqNqdk4N1HGazUCSAQCYzcaezTA4Sh79FJOZnmQfz/sBOED8e5iJgQmBkLFCTHLo
         4TrXNYZ1Riu4MXaH4qIeLyneqBECsyuHk9Tbyr8bOxx7s0Ny4fkp8CT9rmflb0OUN6
         TuXgh2ITnRRywKCBDrGzAfBeM9FKk1s9WFmGYEVc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520429240;
        bh=4LNAZApKvdMEdY/fOtCcZ/q4toW4mYvuWsppB582jVY=; l=1892;
        h=Received:From:To:Subject;
        b=WyqNqdk4N1HGazUCSAQCYzcaezTA4Sh79FJOZnmQfz/sBOED8e5iJgQmBkLFCTHLo
         4TrXNYZ1Riu4MXaH4qIeLyneqBECsyuHk9Tbyr8bOxx7s0Ny4fkp8CT9rmflb0OUN6
         TuXgh2ITnRRywKCBDrGzAfBeM9FKk1s9WFmGYEVc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520429240;
        bh=4LNAZApKvdMEdY/fOtCcZ/q4toW4mYvuWsppB582jVY=; l=1892;
        h=Received:From:To:Subject;
        b=WyqNqdk4N1HGazUCSAQCYzcaezTA4Sh79FJOZnmQfz/sBOED8e5iJgQmBkLFCTHLo
         4TrXNYZ1Riu4MXaH4qIeLyneqBECsyuHk9Tbyr8bOxx7s0Ny4fkp8CT9rmflb0OUN6
         TuXgh2ITnRRywKCBDrGzAfBeM9FKk1s9WFmGYEVc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520429240;
        bh=4LNAZApKvdMEdY/fOtCcZ/q4toW4mYvuWsppB582jVY=; l=1892;
        h=Received:From:To:Subject;
        b=WyqNqdk4N1HGazUCSAQCYzcaezTA4Sh79FJOZnmQfz/sBOED8e5iJgQmBkLFCTHLo
         4TrXNYZ1Riu4MXaH4qIeLyneqBECsyuHk9Tbyr8bOxx7s0Ny4fkp8CT9rmflb0OUN6
         TuXgh2ITnRRywKCBDrGzAfBeM9FKk1s9WFmGYEVc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520429240;
        bh=4LNAZApKvdMEdY/fOtCcZ/q4toW4mYvuWsppB582jVY=; l=1892;
        h=Received:From:To:Subject;
        b=WyqNqdk4N1HGazUCSAQCYzcaezTA4Sh79FJOZnmQfz/sBOED8e5iJgQmBkLFCTHLo
         4TrXNYZ1Riu4MXaH4qIeLyneqBECsyuHk9Tbyr8bOxx7s0Ny4fkp8CT9rmflb0OUN6
         TuXgh2ITnRRywKCBDrGzAfBeM9FKk1s9WFmGYEVc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520429240;
        bh=4LNAZApKvdMEdY/fOtCcZ/q4toW4mYvuWsppB582jVY=; l=1892;
        h=Received:From:To:Subject;
        b=WyqNqdk4N1HGazUCSAQCYzcaezTA4Sh79FJOZnmQfz/sBOED8e5iJgQmBkLFCTHLo
         4TrXNYZ1Riu4MXaH4qIeLyneqBECsyuHk9Tbyr8bOxx7s0Ny4fkp8CT9rmflb0OUN6
         TuXgh2ITnRRywKCBDrGzAfBeM9FKk1s9WFmGYEVc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520429240;
        bh=4LNAZApKvdMEdY/fOtCcZ/q4toW4mYvuWsppB582jVY=; l=1892;
        h=Received:From:To:Subject;
        b=WyqNqdk4N1HGazUCSAQCYzcaezTA4Sh79FJOZnmQfz/sBOED8e5iJgQmBkLFCTHLo
         4TrXNYZ1Riu4MXaH4qIeLyneqBECsyuHk9Tbyr8bOxx7s0Ny4fkp8CT9rmflb0OUN6
         TuXgh2ITnRRywKCBDrGzAfBeM9FKk1s9WFmGYEVc=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1etZ6E-000196-HX; Wed, 07 Mar 2018 16:27:18 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Wed, 07 Mar 2018 16:27:18 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Wed, 7 Mar 2018 07:46:17 +0100
        (STD)")
Message-ID: <87vae8yq15.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Sergey,
>
> On Tue, 6 Mar 2018, Sergey Organov wrote:
>
>> This is v2 of my "Rebasing merges" proposal.
>
> Didn't we settle on Phillip's "perform successive three-way merges between
> the original merge commit and the new tips with the old tips as base"
> strategy?

It seems you did, dunno exactly why.

The main problem with this decision is that we still don't see how and
when to stop for user amendment using this method. OTOH, the original
has this issue carefully discussed.

> It has the following advantages:
>
> - it is *very simple* to describe

The original is as simple if not simpler:

"rebase sides of the merge commit and then three-way merge them back
using original merge commit as base"

No problems with octopuses, and no virtual merge bases of recursive
merges to reason about.

> - it is *very easy* to reason about, once it is pointed out that rebases
>   and merges result in the same trees.

The original is as easy to reason about, if not easier, especially
as recursive merge strategy is not being used there in new ways.

I honestly don't see any advantages of Phillip's method over the
original, except personal preferences. At the same time, I have no
objection of using it either, provided consistency check problem is
solved there as well.

>
> ... and BTW...
>
>> 3. I now use "True Merge" name instead of former "Trivial Merge", to
>>    avoid confusion with what Git documentation calls "trivial merge",
>>    thanks to Junio C Hamano <gitster@pobox.com> for pointing this out.
>
> "True Merge" is probably also a candidate for improvement. If what you
> refer to is a "true" merge, that means all others are "untrue"
> merges???

[d]evil merges, obviously.

Seriously, it's pure history joint. Just "joint' will do.

-- Sergey
