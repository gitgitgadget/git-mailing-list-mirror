Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487D6C433DF
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 18:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF75206C3
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 18:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgFASrd convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 1 Jun 2020 14:47:33 -0400
Received: from smtp-1a.his.com ([216.194.196.25]:42204 "EHLO smtp-1a.his.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730370AbgFASr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 14:47:29 -0400
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jun 2020 14:47:29 EDT
Received: from cuda201.his.com (cuda201.his.com [216.194.196.22])
        by smtp-1a.his.com (Postfix) with ESMTPS id 4E7722A47
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 14:38:49 -0400 (EDT)
X-ASG-Debug-ID: 1591036728-061c413ab012650001-QuoKaX
Received: from smtp-nf-202.his.com (smtp-nf-202.his.com [216.194.196.20]) by cuda201.his.com with ESMTP id wHqF5xpXAz2c8zB5; Mon, 01 Jun 2020 14:38:48 -0400 (EDT)
X-Barracuda-Envelope-From: keni@his.com
X-Barracuda-RBL-Trusted-Forwarder: 216.194.196.20
Received: from zproxy101.his.com (zproxy101.his.com [18.218.2.49])
        by smtp-nf-202.his.com (Postfix) with ESMTPS id BF54460109;
        Mon,  1 Jun 2020 14:38:48 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id 8A2CE178055;
        Mon,  1 Jun 2020 14:38:48 -0400 (EDT)
X-Barracuda-RBL-IP: 18.218.2.49
X-Barracuda-Effective-Source-IP: zproxy101.his.com[18.218.2.49]
X-Barracuda-Apparent-Source-IP: 18.218.2.49
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3z4V8omXastJ; Mon,  1 Jun 2020 14:38:48 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id 72288178056;
        Mon,  1 Jun 2020 14:38:48 -0400 (EDT)
X-Virus-Scanned: amavisd-new at zproxy101.his.com
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4IOypBB1zAwR; Mon,  1 Jun 2020 14:38:48 -0400 (EDT)
Received: from [192.168.1.168] (pool-74-96-209-77.washdc.fios.verizon.net [74.96.209.77])
        by zproxy101.his.com (Postfix) with ESMTPSA id 3E3C8178055;
        Mon,  1 Jun 2020 14:38:48 -0400 (EDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [RFC PATCH v2 3/6] doc: Add namespace collision guidelines file
From:   Kenneth Lorber <keni@his.com>
X-ASG-Orig-Subj: Re: [RFC PATCH v2 3/6] doc: Add namespace collision guidelines file
In-Reply-To: <xmqqy2pb3new.fsf@gitster.c.googlers.com>
Date:   Mon, 1 Jun 2020 14:38:47 -0400
Cc:     git@vger.kernel.org, Kenneth Lorber <keni@his.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <B170FDD5-0B2C-48AB-92F4-223394823754@his.com>
References: <1589681624-36969-1-git-send-email-keni@hers.com>
 <20200525232727.21096-1-keni@his.com> <20200525232727.21096-4-keni@his.com>
 <xmqqy2pb3new.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Barracuda-Connect: smtp-nf-202.his.com[216.194.196.20]
X-Barracuda-Start-Time: 1591036728
X-Barracuda-URL: https://spam.his.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at his.com
X-Barracuda-Scan-Msg-Size: 5677
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.82257
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On May 28, 2020, at 2:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Kenneth Lorber <keni@his.com> writes:
> 
>> +Git uses identifiers in a number of different namespaces:
>> +
>> +* environment variables
>> +* files in $GIT_DIR
>> +* files in the working trees
>> +* config sections
>> +* hooks
>> +* attributes
> 
> The names of the subcommands "git" can spawn is a shared resource.
> You can install "git-imerge" program in one of the directories on
> your $PATH and say "git imerge" to invoke the program.  
> 
> Two third-party developers may have to coordinate to avoid giving
> the same name to their totally-unrelated tools, if they hope that
> both of their tools to be useful in the larger Git ecosystem.

So similar to the aliases case.

> 
>> +In order to reduce the chance of collisions between names Git uses
>> +and those used by other entities (users, groups, and extension authors),
>> +the following are recommended best practices.
> 
> OK.
> 
>> +Names reserved to Git:
> 
> s/to/by/ perhaps.

I don't believe so.  For example, under this proposal, the "my" items are
reserved by Git for the user, while the items in this section are reserved
to git itself.

s/to/for/ might be clearer?

> 
>> +Names reserved for individual users:
>> +
>> +* The directory `$GIT_DIR/my`
> 
> So an individual user is allowed to store anything in that
> directory, and "git" or any third-party tools won't care.  OK.
> 
>> +* Environment variables starting with `GIT_MY_`
> 
> Likewise.  But then the users can use MY_FOO_BLAH without GIT_
> prefix in the first place, so there isn't much gain there.  Downside
> for "git" and third-party tool authors is not so big (just the loss
> of a single prefix "_MY"), so perhaps it is OK.

The environment variable namespace is a mess in general; subdividing
something well known (GIT_) seemed safer then hoping for MY to be available.

Also, and this applies to some of the other cases below, one goal was
to make the rules as simple and therefore as consistent as possible.  So
we reserve the same names everywhere we can - little cost, added simplicity.

> 
>> +* Configuration section `my`
>> +* Files or directories in `$GIT_DIR/hooks` starting with `my_`
>> +* Attributes starting with `my_`
> 
> The last one does not make much sense.  You have to forbid defining
> my_attributes in .gitattributes files that are tracked in-tree;
> otherwise I cannot work with you on the same project, because I
> cannot use my_attributes for my own purpose in that project.

Yes, but they can be useful in $HOME/.config/git/attributes.

>  For
> the same reason, reserving attributes for individual repositories
> does not make much sense, either.

I may not be following you on this one.  What about the use case
of a filter written specifically for a project-specific
file type?  That would be a "this" attribute so it doesn't collide
with anything else.

> 
>> +Names reserved for individual repos:
>> +
>> +* The directory `$GIT_DIR/this`
> 
> It is unclear what it means to have $GIT_DIR/my and $GIT_DIR/this
> and how to choose which one of these two ought to be used for each
> occasion a user finds a need to store something in these places.

$GIT_DIR/my would be something a user installs to their local clone
to do something they want personally (contrived example: it's a good 
place to put their non-standard editor's temp files so they don't have to
touch the shared .gitignore files).

$GIT_DIR/this would be used for things that everyone working on that one
repo needs, but only for that one repo.

More generally, I'm not hoping to guess every possible use case, I'm trying
to specify a policy that can accommodate all possible use cases - so
generality over specific justifications.  

> 
>> +* Environment variables starting with `GIT_THIS_`
> 
> The utility of this one is dubious.  
> 
> 	$ export GIT_THIS_BLAH=value
> 	$ cd repo1 ; work work work
> 	$ cd ../repo2 ; work work work
> 
> Unless you arrange to reset GIT_THIS_* environment variable every
> time you visit a separate repository, it would not be pratical to
> use.

If you only consider env vars being passed in from the user or shell
initialization, I think you are correct.  However they could be useful
for passing information from one program to another.  Passing information
into a custom editor invoked from git commit might be a use case.

But again, being uniform is better than not. 

> 
>> +Names reserved for the lowest level group of people:
> 
> What's lowest level group of people?

Purposefully unspecified, but I can understand if I can't get away with that.

The lowest level group of people could be two people doing agile development,
everyone with a particular supervisor, a college class, a family, a department.
It's the last chance to be informal, before you either use the third-party
guidelines or go to the mailing list to ask for help.

Which brings us to:

> 
> Also, where did the guideline for third-party tools go?

That was in response to a comment from Abhishek Kumar; it was a
mistake on my part to take silence from both of you as agreement on my
compromise (which involved dropping the third-party section).

I'll put it back if I get enough encouragement to cut a v3.

> 
> At this point I need to say that this is not very well thought out
> (yet), or that this is not very well explained, or perhaps both,
> so I'll stop commenting on it for now.
> 
> Thanks.

You're welcome.  I've got 3 more emails from you to reply to but it may
not happen today.
