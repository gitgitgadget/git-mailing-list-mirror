Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A56301F453
	for <e@80x24.org>; Thu,  1 Nov 2018 14:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbeKAXfa (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 19:35:30 -0400
Received: from smtpoutz26.laposte.net ([194.117.213.101]:52752 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728626AbeKAXfa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 19:35:30 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout014 (Postfix) with ESMTP id AA71B160009
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 15:32:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=laposte.net; s=mail0;
        t=1541082734; bh=4Hiy6vkX2pWlMO9a5QOS0SDUhqosqgcHbcFZ3lQlnxI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Ad3CIVSLf2NRkkBK4VGbumRwe0I9L1VszDrphj1lB9xQ32kQLJVyvtYjE7QGHoiPP
         WbNHWJHlAL/aaqFFVuUnpdLSPyfEdlCVI3tWwJJn+LYwNaeYSAvIOHd6hpD5dYnitt
         G/BU9VQKOA/xPqvjl5sdvDgUf+SUaRmdnm8TUzlgYcZ9Nw7NaYVNnTeqSfJI/8LhoH
         I6ZCZpYzRlW5CMaXHxnl4EAKrPT1bqD2+8Kt2R+6b5yHWZLQ5MXJkT1vhXYPien8oY
         JafIpovkiPdvmdQQ5JbP/UN/txy5C/WiuK6aHM6E6V0RZRHko9Qx6bdJcws+D5tHxs
         O8LnN8qKUTtfw==
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout014 (Postfix) with ESMTP id 9CABF1601E0
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 15:32:14 +0100 (CET)
Received: from lpn-prd-vrin001 (lpn-prd-vrin001.laposte [10.128.63.2])
        by lpn-prd-vrout014 (Postfix) with ESMTP id 97AEC1601C0
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 15:32:14 +0100 (CET)
Received: from lpn-prd-vrin001 (localhost [127.0.0.1])
        by lpn-prd-vrin001 (Postfix) with ESMTP id 85FCC3730B0
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 15:32:14 +0100 (CET)
Received: from arekh.ddns.net (unknown [82.64.49.105])
        by lpn-prd-vrin001 (Postfix) with ESMTPA id 6BB50373006
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 15:32:14 +0100 (CET)
Received: from cerebro.okg (box.okg [192.168.0.1])
        by arekh.ddns.net (Postfix) with ESMTPSA id ED3052200D9;
        Thu,  1 Nov 2018 15:32:13 +0100 (CET)
Message-ID: <f188d25c4ae49bd234a52a9200a2caefbb65191c.camel@laposte.net>
Subject: Re: [RFE] Please add a standard ref object to releases
From:   Nicolas Mailhot <nicolas.mailhot@laposte.net>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason 
        <nicolas.mailhot@laposte.net>,
        Nicolas Mailhot <nicolas.mailhot@laposte.net>
Cc:     git@vger.kernel.org
Date:   Thu, 01 Nov 2018 15:32:13 +0100
In-Reply-To: <87y3adj66e.fsf@evledraar.gmail.com>
References: <b639c19a881476be2d4dbdd731cd305384b287a9.camel@laposte.net>
         <871s85kq16.fsf@evledraar.gmail.com>
         <c414f7ae84c763cacd55d14ba68fbf2572b65132.camel@laposte.net>
         <87y3adj66e.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.31.1 (3.31.1-2.fc30) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-VR-FullState: 0
X-VR-Score: 0
X-VR-Cause-1: gggruggvucftvghtrhhoucdtuddrgedtkedrieehgdeiiecutefuodetggdotefrodftvfcurfhrohhf
X-VR-Cause-2: ihhlvgemucfntefrqffuvffgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepkffuhffvffgj
X-VR-Cause-3: fhgtfggggfesthekredttderjeenucfhrhhomheppfhitgholhgrshcuofgrihhlhhhothcuoehnihgt
X-VR-Cause-4: ohhlrghsrdhmrghilhhhohhtsehlrghpohhsthgvrdhnvghtqeenucffohhmrghinhepghhnohhmvgdr
X-VR-Cause-5: ohhrghdpghhithhlrggsrdgtohhmpdhgihhthhhusgdrtghomhenucfkphepkedvrdeigedrgeelrddu
X-VR-Cause-6: tdehnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhinhgvthepkedvrdeigedrgeelrddutdeh
X-VR-Cause-7: pdhhvghloheprghrvghkhhdruggunhhsrdhnvghtpdhmrghilhhfrhhomhepnhhitgholhgrshdrmhgr
X-VR-Cause-8: ihhlhhhotheslhgrphhoshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
X-VR-Cause-9: rdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-VR-AvState: No
X-VR-State: 0
X-VR-State: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le jeudi 01 novembre 2018 à 14:09 +0100, Ævar Arnfjörð Bjarmason a
é

> You're the one trying to ostensibly file some sort of bug report or
> feature request, it's up to you to explain the problem in detail.
> 
> > I’m just asking that when a project releases “x.y.z”
> > 
> > 1. there was a standard git command available to it to create "the
> > release “x.y.z”" ref
> 
> And would these also be annotated tags, or are you proposing that we
> add
> a new "release" object type in addition to blob/tree/commit/tag? If so
> what would that look like?

It could have been done via annotated tags if release annotations, and
the associated porcelain, had been clearly defined and documented from
the start up. The technical implementation would have been fuzzy but
strong convention would have compensated the fuzziness.

This ship sailed a long time ago, at this point not only you do not have
convention to help you but you have all the custom workarounds people
invented to get by to overcome. So, I doubt anything short of a separate
object can work now (but I'd be delighted to be proven wrong).

Of course as long as the porcelain is unambiguous most git users won't
care how it is stored by git.

> > 2. there was a git syntax to say "the release “x.y.z”" ref in all
> > git
> > commands that manipulate refs
> 
> What do you mean "git syntaX"? The rev-parse syntax (see 'git help
> rev-parse`) or something else?

I mean that:
– I give you a repo name and its URL.
– I give you a release name such as 1.2.3.4
 1. write the command to checkout this release
 2. write  the command to diff this release with the latest master
commit
 3. write  the command to declare that master is release 1.2.3.4.5
etc

You’re forbidden to look at the content of the repo to browse its tags
and branches and use human logic to guess human convention. You can only
be sure that 1.2.3.4 is the actual release chosen by the project owner
as stated in its release notes.

And then try to do it for Apache Thrift 0.11 and git 2.19.0
https://github.com/apache/thrift/
and
https://github.com/git/git

(see, I’m nice, I didn’t even fed you Gitlab vs GitHub differences, or
some project released by an illustrious anonymous)

Or alternatively, try
gnome-calendar 3.28.0.1 and git 2.18.1

They’re on
https://gitlab.com/git-vcs/git/
https://gitlab.gnome.org/GNOME/gnome-calendar/

so, latest version of Gitlab for both of them.

> > 3. that this "release “x.y.z”" ref could be used in all the
> > "download
> > release “x.y.z”" on GitLab/GitHub, etc
> 
> So instead of offering a download of annotated tags as they do now,
> see
> https://github.com/git/git/releases and
> https://gitlab.com/git-vcs/git/tags they'd offer a download of whatevr
> this new thing is?

So they could build a
https://github.com/git/git/releases/<x.y.z>/
or
https://gitlab.com/git-vcs/git/releases/<x.y.z>/

and it would just give you the correct release archive, for example. Not
difficult for them to do as long as the mapping from release name “x.y.z
” to git repo object is well defined.

> > 4. that there was no fuziness or human interpretation involved into
> > converting "x.y.z" into the syntax used to select "release “x.y.z”"
> > in git commands
> 
> So since we'd store this in refs/* somewhere since it's (presumably)
> named named ref of some sort, you're suggesting that this thing be
> exempt from the DWYM name resolution of refs, e.g. us resolving
> "master"
> to "refs/heads/master" or v1.0 to "refs/tags/v1.0" (but as you note
> that's ambiguous).
> 
> So you'd always need to do e.g. "git show refs/releases/v1.0"?

It would be nice to have something shorter to type, but the root problem
is the ambiguity and lack of definition of current git releases, so
something unambiguous trumps something short, but fuzzy.

And, in your example, the v is unnecessary.

The v was just shoved in tag names to try to distinguish releases. It
didn’t work. It would have worked if git had blocked any tag starting
with v that was not a release tag, and forbidden branches with a v name.
But that ship sailed a long time ago.

Years of workarounds have brainwashed you into thinking the v is
necessary. But, it does not exist outside git land. Or even in the
release notes filenames git releases itself
https://github.com/git/git/tree/master/Documentation/RelNotes

(Much as I hate the v thing, I could have lived with it if it was
consistently applied by git projects. It isn’t)

> Whereas if you're proposing some mechanism that we draw a line
> somewhere
> in that flow and say "now tag/mark/release stuff as different sorts of
> objects" it's up to you to convince us why that's a realistic view of
> the world.

If it was not a realistic view of the world github wouln’t have had to
define separate sections for releases and tags in its UI.

If tags and release were the same thing one could take random git
projects on github or gitlab and apply release rules like semver to
their tags. Even projects that use semver do not have semver-only tags,
and even their semver tags cant'd be semvered as-is because of random
injections of prefixes like v or version.

Regards,

-- 
Nicolas Mailhot

