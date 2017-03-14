Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 666C5202C1
	for <e@80x24.org>; Tue, 14 Mar 2017 10:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750876AbdCNKjQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 06:39:16 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37926 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750861AbdCNKjQ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Mar 2017 06:39:16 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 823F120A26;
        Tue, 14 Mar 2017 06:39:14 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 14 Mar 2017 06:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=1mIeFCWCrjoZ8iI
        vGvyaQncXmjo=; b=pyB7QYk3Uqkbrt1jj0zJhSzuPS9C6OqMShlWSWS1eoyQJyQ
        SV7nbkvWoKa3tY4AKPbAdTrON/hgFvOpVYCpvYZkE6pTpS4BqS9b9KzNM625go1I
        MZUz+80nPtQ0UVJscdnAFC/Z6k5jaYYIIQjYJnbsRV2d9B8ekgAXFcSE8DTE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=1mIeFCWCrjoZ8iIvGvyaQncXmjo=; b=Zu7t9IT4D2mPzJuVk2tp
        cUnduZQBX7DFfWYhn1LuNTbZ+P8GdEDMktw+e3RtOq8JdxT6bxCVdqeDZFo/RirR
        YeWCdEi1hBYJObIGow3vMjxUz9if13bFCud4bPjOc0KlRE2KBaZ+QnpXWeSA7kMM
        mdTmKtTE/1wd1d963UJnnLw=
X-ME-Sender: <xms:UsjHWNaeXtDm_lLiX1Ohg8ukZhCxY7vzbJskmoRKCaBj8VhzfcVF9Q>
X-Sasl-enc: 3DGle/CqmcNpvRMYoz5b5xqOia2IuuCyZODrNBkrNkgK 1489487954
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id AF0837E050;
        Tue, 14 Mar 2017 06:39:13 -0400 (EDT)
Subject: Re: Stable GnuPG interface, git should use GPGME
To:     "Bernhard E. Reiter" <bernhard.reiter@intevation.de>
References: <201703101100.15214.bernhard.reiter@intevation.de>
 <CACBZZX4Av-D6hxE9ceDFPuG-_qUQbH_6KW5JKsJf0SuH62jkuQ@mail.gmail.com>
 <a5161dd2-977b-8195-e558-01787fb3f01b@drmicha.warpmail.net>
 <201703131350.00139.bernhard.reiter@intevation.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        gnupg-devel@gnupg.org, Lukas Puehringer <luk.puehringer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <13c66211-9671-5bd3-f3eb-96ffd5c39975@drmicha.warpmail.net>
Date:   Tue, 14 Mar 2017 11:39:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <201703131350.00139.bernhard.reiter@intevation.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bernhard E. Reiter venit, vidit, dixit 13.03.2017 13:49:
> Am Montag 13 März 2017 11:14:57 schrieb Michael J Gruber:
>> Ævar Arnfjörð Bjarmason venit, vidit, dixit 10.03.2017 15:23:
>>> On Fri, Mar 10, 2017 at 11:00 AM, Bernhard E. Reiter
> 
>>>> please consider using libgpgme interfacing to GnuPG, because the gpg
>>>> command-line interface is not considered an official API to GnuPG by the
>>>> GnuPG-devs and thus potentially unstable.
> 
> [example of gpg2 vs gpg option incompatibility cut]
> 
>>> Using the library sounds good, but a shorter-term immediate fix would
>>> be to figure out what bug you encountered in our use of the
>>> command-line version, and see if we've fixed that already or not.
> 
>> As far as I know, Git handles different GPG versions just fine.
> 
> As mentioned before: explicitely setting gpg.program to gpg2 helps if gpg
> chokes on the new config. Trying the `gpg2` binary first can be a simple fix. 
> Using libgpgme potentially solves this and other compatility options.
> 
>> The problem is the "difficult" upgrade path and mixed installations with
>> gpg and gpg2.1+ that some distributions force upon you:
>>
>> As soon as you start gpg2.1, your (secret) key store is migrated to a
>> new format without technically invalidating it. Similarly, users may
>> enter gpg2.1+-only comand in the config that is actually shared with
>> gpg, throwing off any use of gpg - not just by git, but also by anything
>> that your distro requires gpg for (such as packaging tools and the like).
> 
> Yes, this is another example why trying `gpg2? first by default or using 
> libgpgme keeps trouble away from users.

No, not at all. On the contrary: Using gpg2.1 without being asked to by
the user will migrate his key store! This can lead to tremendous
problems when a user manages his secret key store using gpg and git uses
the other secret key store (via gpg2.1)!

>> In short: Users will run into problems anyway; git provides the quick
>> way out (git config gpg.program gpg2), users won't be as lucky with
>> other things that require gpg.
> 
> Application using libgpgme will behave fine and many user facing components 
> use it already. 
> 
>> As for the library: While - technically speaking - the command line is
>> not a stable API for gpg, it does work across versions of gpg, and gpg
> 
> ... to some extend.

I have no idea what you're implying here - but I have a pretty good idea
of what works in current git and what not, including gpg usage (which is
the qualifier that you cut out).

>> 2.2 will be the first real stable branch that uses the new key store
>> layout. So I'd rather wait for that to stabilize before going away from
>> what turned out to be most stable so far.
> 
> It is not just about the key-store change as mentioned before. However
> I agree that a potential switch should be done with a current version of gpgme 
> that already has support for GnuPG 2.1/2, e.g. gpgme v1.8.0.

Unfortunately, gpgme does not solve the interoperability problems
between gpg (1, classic, stable maint mode) or gpg2.0 (stable) and
gpg2.1 (modern) key stores, and gpg2.2 (modern, stable) is not released yet.

>> Note that we (git) refrain from parsing ordinary output/return codes of
>> gpg and use status-fd as we should (and as documented).
> 
> It is good to use --status-fd and --with-colons when calling gpg, you still 
> have to parse the results of status-fd as described in doc/DETAILs. 
> https://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git;a=blob;f=doc/DETAILS;hb=HEAD

Again, have you checked what we are doing in git land?

Your agenda is pretty clear. It's also pretty clear from the above that
gpgme is not the solution to the problem which is introduced by the
migration path to versions of gpg which are not declared stable by the
gpg project, away from a gpg version which is not obsoleted by the gpg
project (2.0, maybe 1).

And, really, key store migration was the only "major" thing we had to
think about to cope with gpg 2.1+ - it affected the test suite setup.

So, once 2.2 is out and stable and mainstream and we don't risk
migrating users' secret key store sneakily I'm all for defaulting to
gpg2, and then is a good time for us to look into gpgme.

Michael
