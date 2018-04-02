Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7F8D1F424
	for <e@80x24.org>; Mon,  2 Apr 2018 11:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754330AbeDBLj0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 07:39:26 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36370 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754303AbeDBLjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 07:39:25 -0400
Received: by mail-wm0-f49.google.com with SMTP id x82so26469542wmg.1
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 04:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=rtKkGgcKdVIAb8vWCWVjtTvtV8EfTjBkSYkm00jD2gQ=;
        b=JB12h/Py3rTkgmpxFE6d0SJuFf+LvJVJnWOFZ7CwutCT+e3jDUCVmTcg0/suaaWro8
         2QEfvxHzYjf+wNSQ55pMDE2qyjdd7pOjhW25STUl7zns9wj8kVQxpEEJM1cx33B6NxWp
         XlZckQMnyxVZJV9+ZR2KJnF/XtkVX9PIwgFIOXF24kXxyQqfBcHW4vJSKOKdyNzidMqI
         Qp0IhArSYoFOQ6r35MsCYQATPiMZ0p84EyQ721VYXB2oUQWJ+NoMflOZMlffcBzZuiDW
         nl110pSvw2088w5msyzQxZ1EwHWzxaNBVR/OyPL1l88rMJWsox6VUKaWlje65hgstMiR
         JMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=rtKkGgcKdVIAb8vWCWVjtTvtV8EfTjBkSYkm00jD2gQ=;
        b=sxyHp3iwWbq/e/ZPBN5SL3+F1bdl9rbVqVl/ckUZpa89lOrcVUFK9SnAtpZG0QI+fZ
         TTjGfHESMsynpp/7fNRCaW6bLrmdZ0O0Qu6CWMEBNZkm6LhSANZnQ6+o0SABblQKHnox
         GCpMr5vZ/VdNjoeGwWpTgP2rzkZkJkeqaycL13mL7/4+NG/1bHhmaqZ/P4zhgpaHJab2
         guvpuf2MI2eLEOSfuhpQ3SOUnKrfsChAdZI+CqiZTK/ciXEFGfuApZEerXnsXPFs1QFK
         ZxSuujUUU9rIUDsceQDWUQ/Wbk0KQSsTDjb4aFLvPaS5tu476bU3OfpViHCWvkpFR7K3
         9zMw==
X-Gm-Message-State: AElRT7GSA1gR/RkeWGlVSbJwK4aVEXB4YRyZ6WirCHDykM1YzvqwFSZB
        kusmhia6arR0fyIHq8WGsph61/rX
X-Google-Smtp-Source: AIpwx4+zPHUWE/GLTrUMAfLCQB4Iab8DT0bIj3cUwi0aleOeQByGWe2OGwpxkOEHm/XFuX5xrRVfzg==
X-Received: by 10.80.144.120 with SMTP id z53mr12038517edz.163.1522669164050;
        Mon, 02 Apr 2018 04:39:24 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id b31sm273714eda.70.2018.04.02.04.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 04:39:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Gustavo Leite <gustavoleite.ti@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Fernando Vezzosi <fv@repnz.net>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/3] add -p: select individual hunk lines
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
        <20180316101346.7137-1-phillip.wood@talktalk.net>
        <xmqq1sg27mwf.fsf@gitster-ct.c.googlers.com>
        <a8dd262b-8b0c-8632-bf28-e03f9405317f@talktalk.net>
        <878ta8vyqe.fsf@evledraar.gmail.com>
        <1e8daa35-3749-fec7-ae88-541169dd0b2a@talktalk.net>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <1e8daa35-3749-fec7-ae88-541169dd0b2a@talktalk.net>
Date:   Mon, 02 Apr 2018 13:39:21 +0200
Message-ID: <87370dx2fq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 02 2018, Phillip Wood wrote:

> On 31/03/18 20:20, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Fri, Mar 30 2018, Phillip Wood wrote:
>>
>>> On 29/03/18 19:32, Junio C Hamano wrote:
>>>> Phillip Wood <phillip.wood@talktalk.net> writes:
>>>>
>>>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>>>
>>>>> Since v2 I've updated the patches to use '-' instead of '^' to invert
>>>>> the selection to match the rest of add -i and clean -i.
>>>>>
>>>>> These patches build on top of the recount fixes in [1]. The commit
>>>>> message for the first patch describes the motivation:
>>>>>
>>>>> "When I end up editing hunks it is almost always because I want to
>>>>> stage a subset of the lines in the hunk. Doing this by editing the
>>>>> hunk is inconvenient and error prone (especially so if the patch is
>>>>> going to be reversed before being applied). Instead offer an option
>>>>> for add -p to stage individual lines. When the user presses 'l' the
>>>>> hunk is redrawn with labels by the insertions and deletions and they
>>>>> are prompted to enter a list of the lines they wish to stage. Ranges
>>>>> of lines may be specified using 'a-b' where either 'a' or 'b' may be
>>>>> omitted to mean all lines from 'a' to the end of the hunk or all lines
>>>>> from 1 upto and including 'b'."
>>>>
>>>> I haven't seen any review comments on this round, and as I am not a
>>>> heavy user of "add -i" interface (even though I admit that I
>>>> originally wrote it), I haven't had a chance to exercise the code
>>>> myself in the two weeks since the patches have been queued in my
>>>> tree.
>>>>
>>>> I am inclihned to merge them to 'next' soonish, but please stop me
>>>> if anybody (including the original author) has further comments.
>>>>
>>>> Thanks.
>>>>
>>> Hi Junio, if no one else has any comments, then I think it's ready for
>>> next. I've not used this latest incarnation much but I've used the
>>> previous versions quite a bit.
>
> Ah it seems I spoke too soon.
>
> Thanks for taking a look at this Ævar
>
>> First of all thinks for working on this. Something like this is a
>> feature I've long wanted to have and have just been manually using edit.
>>
>> As for the code, one comment: For reasons of avoiding something like the
>> 2.17.0-rc* bug I just sent a patch for, I think you should change your
>> use of the implicit $_ to something where you explicitly create lexical
>> variables instead.
>>
>> It's bad style in Perl to use $_ for anything except a one-liner, and
>> similar to the $1 bug with your other patch, you'll get buggy code
>> (regardless of your use of local $_) if one of the functions you're
>> calling in these >10 line for-loops starts doing something to set $_
>> itself, as demonstrated by:
>>
>>     $ perl -wE 'sub foo { local $_; for (1..3) { bar(); say } } sub bar { $_ = $_ ** 2; } foo()'
>>     1
>>     4
>>     9
>>
>> Let's just name these variables, even if it wasn't for that caveat it
>> would still be a good idea, since for any non-trivial use of $_ you've
>> got to mentally keep track of what set $_ where, so it's hard to read.
>
> Right, I'll use lexical variables.
>
>>
>> As for the implementation, I *want* to love this, but it seems the way
>> it works is just fatally flawed, consider. *The* use-case I've had for
>> something like this (maybe yours differs?) is something where I do e.g.:
>
> I've used it for selecting a subset of additions or deletions when my
> work has run ahead of a logical commit boundary. I've also used it in
> cases such as
>
> 	-original
> 	+modified
> 	+new stuff
>
> To separate the modification from the addition of new stuff, but I've
> not used it on a list of modifications as in your example.

Right. I was wrong in saying that it wouldn't work as expected for hunks
with removed/added lines, but only for a subset of those cases.

>>     $ perl -pi -e 's/git/Git/g' README.md
>>
>> Which gives me (among other things):
>>
>>     -See [Documentation/gittutorial.txt][] to get started, then see
>>     -[Documentation/giteveryday.txt][] for a useful minimum set of commands, and
>>     -Documentation/git-<commandname>.txt for documentation of each command.
>>     -If git has been correctly installed, then the tutorial can also be
>>     -read with `man gittutorial` or `git help tutorial`, and the
>>     -documentation of each command with `man git-<commandname>` or `git help
>>     +See [Documentation/Gittutorial.txt][] to get started, then see
>>     +[Documentation/Giteveryday.txt][] for a useful minimum set of commands, and
>>     +Documentation/Git-<commandname>.txt for documentation of each command.
>>     +If Git has been correctly installed, then the tutorial can also be
>>     +read with `man Gittutorial` or `Git help tutorial`, and the
>>     +documentation of each command with `man Git-<commandname>` or `Git help
>>
>> Which to me, is a perfect use-case for this feature. Here I
>> hypothetically want to change "git" to "Git" in prose, so I only want to
>> change that "If git has been" line, the rest are all references to
>> filenames or command names.
>>
>> So I would manually edit the hunk via "e" to:
>>
>>      See [Documentation/gittutorial.txt][] to get started, then see
>>      [Documentation/giteveryday.txt][] for a useful minimum set of commands, and
>>      Documentation/git-<commandname>.txt for documentation of each command.
>>     -If git has been correctly installed, then the tutorial can also be
>>     +If Git has been correctly installed, then the tutorial can also be
>>      read with `man gittutorial` or `git help tutorial`, and the
>>      documentation of each command with `man git-<commandname>` or `git help
>>      <commandname>`.
>>
>> Yay, but very tedious. Now let's use your feature to do this:
>>
>>      1 -See [Documentation/gittutorial.txt][] to get started, then see
>>      2 -[Documentation/giteveryday.txt][] for a useful minimum set of commands, and
>>      3 -Documentation/git-<commandname>.txt for documentation of each command.
>>      4 -If git has been correctly installed, then the tutorial can also be
>>      5 -read with `man gittutorial` or `git help tutorial`, and the
>>      6 -documentation of each command with `man git-<commandname>` or `git help
>>      7 +See [Documentation/Gittutorial.txt][] to get started, then see
>>      8 +[Documentation/Giteveryday.txt][] for a useful minimum set of commands, and
>>      9 +Documentation/Git-<commandname>.txt for documentation of each command.
>>     10 +If Git has been correctly installed, then the tutorial can also be
>>     11 +read with `man Gittutorial` or `Git help tutorial`, and the
>>     12 +documentation of each command with `man Git-<commandname>` or `Git help
>>         <commandname>`.
>>
>>     select lines? 4,10
>>
>> So what I was expecting this to do was some automagic where it would
>> pair up the 4 line, and based on the removed/added count figure out
>> which line I'm also adding corresponds to that. I.e. both selected lines
>> are the 4th line removed/added, so it should transpose the 10th to the
>> 4th, but instead I get a patch that looks like this:
>>
>>     diff --git a/README.md b/README.md
>>     index f17af66a97..7234756e64 100644
>>     --- a/README.md
>>     +++ b/README.md
>>     @@ -18,9 +18,9 @@ including full documentation and Git related tools.
>>      See [Documentation/gittutorial.txt][] to get started, then see
>>      [Documentation/giteveryday.txt][] for a useful minimum set of commands, and
>>      Documentation/git-<commandname>.txt for documentation of each command.
>>     -If git has been correctly installed, then the tutorial can also be
>>      read with `man gittutorial` or `git help tutorial`, and the
>>      documentation of each command with `man git-<commandname>` or `git help
>>     +If Git has been correctly installed, then the tutorial can also be
>>      <commandname>`.
>>
>> I.e. it just grepped out the removed line from the removed chunk, and
>> the same for the added bit, which of course means that now the added
>> line doesn't get injected into the correct place, but added to the end.
>>
>> I can see *why* that happens, but I can't imagine a case where this
>> behavior isn't useless.
>
> I agree it's useless here I've got some suggestions on how to fix it
> though I've not spent much time thinking them through - any comments
> would be most welcome.
>
> I think we want something that pairs up groups of selected deletions and
> insertions rather than lines, so that it can handle cases where the
> number of inserted lines differs from the number of deletions but there
> are the same number of groups. For example given
>
> 	1 -* first
> 	2 -* second
> 	3 -* third
> 	4 +* a longer description of the
> 	5 +  first item
> 	6 +* the second item
> 	7 +* the third item
>
> 1,3,4-5,7 would give
>
> 	-* first
> 	+* a longer description of the
> 	+  first item
> 	 * second
> 	-* third
> 	+* the third item
>
> If the number of deletion groups differs from the number of insertion
> groups then there is no way to automagically pair them up so we'd need
> some syntax to do that. We could make the order of the numbers given by
> the user significant so that 1,6,7,2,4,9 would pair line 1 with 6 & 7
> and line 4 with 9 and delete line 2. It would then be an error if the an
> earlier deletion was pair with a later insertion, so in the example
> above 1,6,7,4,9,2 or 2,4,9,1,6,7 would be valid but 1,9,2,4,8 wouldn't).
> We could also use brackets to group things e.g. [1,6,7],2,[4,9] which
> makes the groups clearer visually.
>
> Thinking further there is a problem with
>
> 	1 -original
> 	2 +a new paragraph before
> 	3 +original
> 	4 +
> 	5 +modified original
>
> if the user wants to commit the new paragraph before the modified
> original then they need a way to specify that the insertion should come
> before the deletion. At the moment giving 2-4 will put the new paragraph
> after the unmodified original. To solve that there needs to be a way to
> indicate that a group of insertions needs to come before the context
> lines created by not staging the deletions - perhaps ^[2-4] or [^2-4]?
> (we could distinguish between commas and spaces so that ^2,3,5 is
> different to ^2 3,5 but that is then different to how lists work in the
> rest of git)
>
>
>> What this seems useful for now is for chunks that only consist of lines
>> that are added or removed, maybe there's similar edge cases with those,
>> but I can't think of any, there I think we should do the obvious and
>> intuitive thing.
>>
>> But I think that as this stands we really should at least disable this
>> where we present the user with a hunk that consists of both removed &
>> added lines, since I think the desired behavior I've described above
>> should be the default, and once we pick one we're going to have to
>> support it forever, so it's important to get it right to begin with.
>>
>
> Thanks for your feedback it's been really useful, let me know what you
> think about grouping things.

All of that makes sense to me. Yes as you noted earlier there's only so
far we can get in this case by automatically trying to pair up
removed/added lines, and actually your example wasn't even very
pathological, consider:

    1 -* a longer description of the
    2 -  first item
    3 -* second
    4 -* third
    5 +* first
    6 +* a longer description of the
    7 +  second item
    8 +* the third item

There the naïve heuristic I initially noted for selecting 4,8 would
work, but not we couldn't in the general case rely on the removed/added
lines being equal in number as some fallback for the simpler transpose
behavior.

It sounds like you're interested in hacking more on this, great. I'll be
happy to review & add tests once you have something.

I'll just say that I wonder if we should simply leave some of these more
complex cases on the table, and only handle some subsets of simple cases
in liue of coming up with a syntax that handles everything. there's
always "edit" as the fallback for the complex cases.
