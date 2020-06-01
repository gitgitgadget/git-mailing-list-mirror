Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A3EC433DF
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 23:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E065B2071E
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 23:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgFAX4X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 19:56:23 -0400
Received: from smtp-1a.his.com ([216.194.196.25]:59863 "EHLO smtp-1a.his.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbgFAX4W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 19:56:22 -0400
Received: from cuda201.his.com (cuda201.his.com [216.194.196.22])
        by smtp-1a.his.com (Postfix) with ESMTPS id 795CF2AEC
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 19:56:21 -0400 (EDT)
X-ASG-Debug-ID: 1591055721-061c413ab036f70001-QuoKaX
Received: from smtp-nf-202.his.com (smtp-nf-202.his.com [216.194.196.20]) by cuda201.his.com with ESMTP id V5Insh7TufnEDREM; Mon, 01 Jun 2020 19:55:21 -0400 (EDT)
X-Barracuda-Envelope-From: keni@his.com
X-Barracuda-RBL-Trusted-Forwarder: 216.194.196.20
Received: from zproxy101.his.com (zproxy101.his.com [18.218.2.49])
        by smtp-nf-202.his.com (Postfix) with ESMTPS id 0512F6095B;
        Mon,  1 Jun 2020 19:55:21 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id C282617806C;
        Mon,  1 Jun 2020 19:55:20 -0400 (EDT)
X-Barracuda-RBL-IP: 18.218.2.49
X-Barracuda-Effective-Source-IP: zproxy101.his.com[18.218.2.49]
X-Barracuda-Apparent-Source-IP: 18.218.2.49
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id iVrhqNZ1OuIs; Mon,  1 Jun 2020 19:55:20 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id AA4A317806B;
        Mon,  1 Jun 2020 19:55:20 -0400 (EDT)
X-Virus-Scanned: amavisd-new at zproxy101.his.com
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id N4KPSw34jC09; Mon,  1 Jun 2020 19:55:20 -0400 (EDT)
Received: from [192.168.1.168] (pool-74-96-209-77.washdc.fios.verizon.net [74.96.209.77])
        by zproxy101.his.com (Postfix) with ESMTPSA id 808A9178069;
        Mon,  1 Jun 2020 19:55:20 -0400 (EDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [RFC PATCH v2 3/6] doc: Add namespace collision guidelines file
From:   Kenneth Lorber <keni@his.com>
X-ASG-Orig-Subj: Re: [RFC PATCH v2 3/6] doc: Add namespace collision guidelines file
In-Reply-To: <xmqqo8q73lkf.fsf@gitster.c.googlers.com>
Date:   Mon, 1 Jun 2020 19:55:20 -0400
Cc:     git@vger.kernel.org, Kenneth Lorber <keni@his.com>
Content-Transfer-Encoding: 7bit
Message-Id: <4654CD5E-6802-4277-AFDE-0DD09A40986B@his.com>
References: <1589681624-36969-1-git-send-email-keni@hers.com>
 <20200525232727.21096-1-keni@his.com> <20200525232727.21096-4-keni@his.com>
 <xmqqy2pb3new.fsf@gitster.c.googlers.com>
 <xmqqo8q73lkf.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Barracuda-Connect: smtp-nf-202.his.com[216.194.196.20]
X-Barracuda-Start-Time: 1591055721
X-Barracuda-URL: https://spam.his.com:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Scan-Msg-Size: 2415
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.82261
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On May 28, 2020, at 3:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Kenneth Lorber <keni@his.com> writes:
>> 
>>> +Git uses identifiers in a number of different namespaces:
>>> +
>>> +* environment variables
>>> +* files in $GIT_DIR
>>> +* files in the working trees
>>> +* config sections
>>> +* hooks
>>> +* attributes
>> 
>> The names of the subcommands "git" can spawn is a shared resource.
>> You can install "git-imerge" program in one of the directories on
>> your $PATH and say "git imerge" to invoke the program.  
>> 
>> Two third-party developers may have to coordinate to avoid giving
>> the same name to their totally-unrelated tools, if they hope that
>> both of their tools to be useful in the larger Git ecosystem.
> 
> Also names of worktrees that are attached to a single repository.
> If a third-party tool wants to make it "easy" for its users by
> automatically taking a name to do its job (instead of forcing the
> users to come up with a name and giving it to the tool), the name
> must be chosen in such a way that it does not collide names in use
> and names the user (or other third-party tools) will pick in the
> future.

One more, but only as an issue to be documented - you don't need to
convince me that trying to handle this should simply be declared
"left as an exercise for the reader" and that's extensions that
require being compiled in to git (so file names, global variables,
functions, test names, etc).

I'd propose "Do something similar to the above or ask for help on
the list" if that's acceptable (where "above" is whatever the current
proposal turns into).


> 
> I (or others) may come up with other things that must be named and
> name collisions must be avoided.  Even though I already said that I
> didn't think the "suggestions to avoid name collisions" given by the
> RFC PATCH are well done, I do think it is worth being aware of the
> problem space, and enumerating what kind of names are shared and
> limited resource is the first step to become so.

Each message seems less enthusiastic than the last.  I'm not sure I see any
point in creating a v3 until I have time and inspiration to write
something significantly different.

> 
> Thanks.

You're welcome.

PS - nothing to reply to in the next 2 messages from you.  Saved them for v3.
