Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AACC433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 21:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66D08207DD
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 21:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ofb.net header.i=@ofb.net header.b="xWMq1Jlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbgFOVM3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgFOVM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 17:12:28 -0400
X-Greylist: delayed 445 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 Jun 2020 14:12:28 PDT
Received: from egnor-li.ofb.net (egnor-li.ofb.net [IPv6:2600:3c01:e000:283::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3B8C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 14:12:28 -0700 (PDT)
Received: from ofb.net (163.242.197.104.bc.googleusercontent.com [104.197.242.163])
        by egnor-li.ofb.net (Postfix) with ESMTP id 1691F117FBA;
        Mon, 15 Jun 2020 21:05:02 +0000 (UTC)
Received: from ptolemy (135-180-145-134.fiber.dynamic.sonic.net [135.180.145.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by ofb.net (Postfix) with ESMTPSA id D20273F06E;
        Mon, 15 Jun 2020 14:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ofb.net; s=ofb;
        t=1592255101; bh=k1iIziJx3+UQu+0M8dLGC+wUdmZ1SB1cGF1q6xTAAIw=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=xWMq1JlkoriaZPwRmLQz0jlwRJltt/qGtA9BTvRsIXGO6M0OizMpryi7F7PEUZLIU
         aTVVH7cg+G0mkv2Omq6iAUhXKpOM7uOgjIi/NELGdGL1T4AWkm1W2K7PSCvgWijexO
         GnCrd8R1ni1YEUhAIftRy9ZeMDXPrgp3V83KIQQ2+AzyQiPtzvNGG9fiFBg2lMFsfa
         81j+lAU86oBbN9Z3mC+FmqaLa+WVb6aGo+mSGhBBmZSn8BA7X9H9aHDZkbJIgnYg83
         nHPkvmgaIoKNFdktY/toGSbp8B5T7Io5e+B2oq7ZbVbPkOrvq2Vdg9VTZ5kH7wPVTN
         ZYhFkJUsHOPdw==
Received: from frederik by ptolemy with local (Exim 4.93)
        (envelope-from <frederik@ptolemy>)
        id 1jkwHt-002FsT-3l; Mon, 15 Jun 2020 14:05:01 -0700
Date:   Mon, 15 Jun 2020 14:05:01 -0700
From:   frederik@ofb.net
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200615210501.GA526224@localhost>
Reply-To: frederik@ofb.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It sounds like the proposed changes are not going to be very
disruptive. However, legitimizing the inherent offensiveness of terms
like "master" and "slave" seems short-sighted to me. Any time that one
person has to work for another, a relationship exists which could be
abused, and the words describing this relationship would gradually
become "emotionally loaded". However, computers are full of instances
where one component is doing work for another component. Consider the
fact that the word "server" comes from "servus", meaning "slave" in
Latin. While "master" comes from "magis" meaning "greater". Are we
going to be able to eliminate the situations where one part of a
software system is greater than another part, or accepts commands from
it?

Furthermore, as someone already pointed out, who on this list speaks
for former slaves? I think someone who spoke for former slaves in my
country is the Honorable Elijah Muhammad. His books are full of
references to his teacher "Master Fard Muhammad" who came to American
in 1930 with a message of freedom, justice and equality for the Black
people of America. He taught his followers to pray to a God who is
"Master of the Day of Judgment", and to accept a 7th century prophet
who is "slave and messenger of God". For us to take offense at these
terms could signify greater racial awareness, or it could betray our
ignorance of the leadership of people, like Elijah Muhammad, who have
been trying to change the system for longer than we have.

If Git developers are interested in helping disadvantaged members of
our society, then I would suggest applying my patch from two years
ago, which de-alphabetized git(1), making it readable for novices.



On Sun, Jun 14, 2020 at 09:06:18PM +0000, Junio C Hamano wrote:
>Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:
>
>> - having a branch named "master" is already not required, so any
>>   existing software that expects there to always be a "master" branch is
>>   already broken and wouldn't get any more broken by the move away
>>   towards more descriptive terminology
>
>The above is mostly true but not entirely, I have to remind you.
>
>There certainly is the concept of the primary branch in each
>repository.  With the current version of Git, it is hardcoded to be
>the 'master' branch, and we are going to make it configurable with a
>configuration variable [*1*].  There are a few examples that the
>primary branch is treated specially:
>
> - When merging into the primary branch, the auto-generated merge
>   message is different from a merge into any other branches.  This
>   was because most of the merges, especially in early days of Git,
>   were into the primary branch (there weren't many cross-branch
>   merges made) and we did not want to see repeated "Merge X into
>   'master'", "Merge Y into 'master'", etc.---we just say "Merge X",
>   "Merge Y", etc. when merging into the primary branch.
>
> - "gitk" gives preferencial treatment to 'master' when there are
>   too many references it has to choose which ones to make visible.
>
> - "git fast-export --anonymize" redacts the name of all the
>   branches, but the name of the 'master' branch is left intact in
>   its anonymized output (which is done in order to make the primary
>   line of work identifiable even in the redacted output stream).
>
>There may be others.  Software that assumes that 'master' is special
>is *not* broken as you stated (we will break them when we allow
>changing the default---that is the cost those of us who are working
>on the transition plan thought worth paying).  The concept of "there
>is one thing that is special among others" can serve useful purpose.
>
>It of course opens a different can of worms ;-) Even though we can
>please master-slave-haters by moving away from the particular word
>'master', those who cannot stand the very idea of one thing being
>special among others will not be satisfied (and we shouldn't even
>try to please them, IMO).
>
>
>
>[Footnote]
>
>*1* There is a related but separate concept of the "default name"
>for the primary branch in newly created repositories, which also is
>hardcoded to be 'master'.  We are going to make it configurable,
>too.  This controls the name used by "git init" (possibly we will
>also add a command line override "git init -b name" to countermand
>the configured default) and "git clone" (which tries to use the
>name of the branch pointed at by HEAD of the other side but has to
>fall back to something when it cannot figure it out).
>
