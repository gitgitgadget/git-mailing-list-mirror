Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63122202A0
	for <e@80x24.org>; Sat,  4 Nov 2017 17:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932220AbdKDRPS (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 13:15:18 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:61205 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752565AbdKDRPR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 13:15:17 -0400
Received: from PhilipOakley ([92.31.218.56])
        by smtp.talktalk.net with SMTP
        id B22NeaaqMbjdZB22NexmMj; Sat, 04 Nov 2017 17:15:15 +0000
X-Originating-IP: [92.31.218.56]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=pug4yzhvgUEES/+WXIksbw==:117
 a=pug4yzhvgUEES/+WXIksbw==:17 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8
 a=5rxgeBVgAAAA:8 a=BzkkzcY4AAAA:8 a=NEAV23lmAAAA:8 a=ewZY5grrU-EFgEj4EX4A:9
 a=QEXdDO2ut3YA:10 a=q92HNjYiIAC_jH7JDaYf:22 a=PwKx63F5tFurRwaNxrlG:22
 a=pvJmhOK_uGPH7DBVCMoM:22
Message-ID: <F8E398C660874CFEA872CDB6F841376B@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Jeff King" <peff@peff.net>,
        "Thomas Gummerer" <t.gummerer@gmail.com>
Cc:     "Git Mailing List" <git@vger.kernel.org>,
        <hkleynhans@bloomberg.net>
References: <CALgYhfO=6WfdzfGYwgw+cp2Tb58Yzx6YYvBtMCPNcJto5rMUCg@mail.gmail.com> <20171104092850.5fthdgvnihd3y4fm@sigill.intra.peff.net>
Subject: Re: Git Open Source Weekend London 11th/12th November
Date:   Sat, 4 Nov 2017 17:15:08 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 171104-0, 04/11/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfDnLQt67VMgqT8mv9/M7aA0rFvlI+25EpMw/VicOCXzUn9uiO9zrwBQmrMPA6hucr8hw60T8ePTDQNWIUaYWEiml7J7X2rFZfmdnBmhCdAalGhq5dbbA
 bPtkiYbnC+Xo5wjm5cwpuwT1M4ccnFO4wm8789jMCWWlvbE8N5KVA/ovTFQKl5eQQk2ZDIdmwUtGWCyfyW8KAL3A2AnteJQY/S7g2VKKChcACsvr8hSvkgAb
 4QdY3hOQcJrpNJctWfTTpQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jeff King" <peff@peff.net>
> On Wed, Nov 01, 2017 at 04:36:24PM +0000, Thomas Gummerer wrote:
>
>> Normally attendees work in small groups on a specific task to
>> prevent anyone from getting stuck. Per usual, Bloomberg will
>> provide the venue, mentors, snacks and drinks.  Bring your
>> enthusiasm (and your laptop!) and come share in the fun!  The
>> event is also open to everyone, so feel free to pass on the
>> invite!
>
> I think it will help if the experienced members of the community (both
> those who will be at the event and not) can come up with some possible
> topics to work on (though of course I'd be glad for participants to come
> with their own itch to scratch).
>
> We've started using the #leftoverbits tag to allow searching in the
> archive:
>
>  https://public-inbox.org/git/?q=leftoverbits
>
> Some of those have since been completed, but others are left open.
> There's not really a master list, but it's a potential source for
> digging for gold (well, if you want to call leftover bugs gold :) ).
>
> I started a list over the summer of larger items that people might want
> to pick up. Here it is in no particular order:
>
> - the pager.<cmd> config is mis-designed, because our config keys
>   cannot represent all possible command names (e.g., case folding and
>   illegal characters). This should be pager.<cmd>.enable or similar.
>   Some discussion in (this message and the surrounding thread):
>
>
> https://public-inbox.org/git/20170711101942.h2uwxtgzvgguzivu@sigill.intra.peff.net/
>
>   But I think you could find more by searching the archive.
>
> - ditto for alias.* config, which has the same syntax problems.
>
> - auto-gc is sometimes over-anxious to run if you have a lot of
>   unreachable loose objects. We should pack unreachables into a single
>   pack. That solves the --auto problem, and is also way more efficient.
>   The catch is expiration. Some discussion here (and especially
>   down-thread):
>
>
> https://public-inbox.org/git/20170711101942.h2uwxtgzvgguzivu@sigill.intra.peff.net/
>
> - git-config's "--get-color" is unlike all the other types in that it
>   takes a "default" value if the config key isn't set. This makes it
> annoyingly
>   inconsistent, but there's also no way to ask Git to interpret other
>   values (e.g., you might want it to expand "--path" or an "--int"). It
>   would be nice to have a general "--default" option so you could do:
>
>     # same as git config --get-color color.diff.old red
>     git config --default red --color color.diff.old
>
>   or
>
>     # not currently possible to ask git to interpret "10k"
>     git config --default 10k --int some.integer.key
>
> - git's internal config can parse expiration dates (see
>   parse_expiry_date()), but you can't do so from git-config. It should
>   probably have a type for "--expiry-date" (which would of course be
>   more useful with the --default option above).
>
> - there's no efficient way to ask git-config for several keys with a
>   specific type (or even multiple different types).  You can use
>   "--list" to get their strings, but you can't get any interpretation
>   (like colors, integers, etc). Invoking git-config many times can have
>   a noticeable speed impact for a script. There should probably be a
>   "--stdin" mode (or maybe "--get-stdin" if we would one day want to
>   have a "--set-stdin") that takes a list of keys, optional types, and
>   optional defaults (that "--default" again!) and outputs them to
>   stdout.
>
>
> Those were just sitting on my ideas list. I'm happy to go into more
> detail if anybody's interested in discussing any of them. Some of them
> may be half-baked.
>
> And of course I'd be happy if people wanted to contribute more items to
> the list.
>

A few I've seen recently are:

* The provison of a `git resolve -X <ours|theirs> -- <pathspec>` command to
simplify the manual resolution of remaining conflicts.
https://public-inbox.org/git/8737615iu5.fsf@javad.com/  Sergey Organov: How
to re-merge paths differently?

* (Git for Windows/HFS): Detect directory capitalisation changes when
switching branches, and rename them correctly on case preserving, case
insensitive file systems. Optimisation: If the underlying tree is identical
then do not update the modified dates.
https://github.com/git-for-windows/git/issues/1333 Chuck Lu: Folder name
should be case sensitive when switch branches.

* (Git for Windows/HFS) (long standing):
detect branch name capitalisation issues
- may need a struct to carry both the filename and pathname down the
different parts of the code base so that the FS name of the requested
ref/heads/ can be checked and warned.
e.g. https://github.com/git-for-windows/git/issues/852 "`git checkout head`
inconsistent behavior"
- ('head' finds 'HEAD', but also 'branch' finds 'Branch');
https://github.com/git-for-windows/git/issues/852#issuecomment-239675187 ->
"rambling notes" for partial analysis.

https://github.com/git-for-windows/git/issues/752 "git checkout creating
tracking branch using case-insensitive match?"
- Is this part of the same problem?

* Documentation:

There's always the newby role at the hackathon of collating
all the "what does this command do/mean?" questions that could be resolved
by simple updates, or capturing locally written explanations to improve the
manual pages. (easy patch practice)

Perhaps see how `git rerere` could be better explained and integrated onto
the other man pages so that more folk naturally know of it and use it. (see
also the `git resolve` question above)

Also for case sensitivity documentation
https://github.com/git-for-windows/git/issues/908#issuecomment-325116189

--
Philip

