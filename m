Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D25911F424
	for <e@80x24.org>; Mon,  2 Apr 2018 10:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754317AbeDBKzb (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 06:55:31 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:14650 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754209AbeDBKza (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 06:55:30 -0400
Received: from [192.168.2.201] ([92.22.2.239])
        by smtp.talktalk.net with SMTP
        id 2x7TfHRlOwhea2x7UfwltU; Mon, 02 Apr 2018 11:55:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1522666528;
        bh=yv22IZ/m0OWzjhimCuPYaj3mIBGQZma8oUiLUJrCmr0=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jb1SbQsfQExERVeutQU+SnMuku/Y053F3HJzQ7TvMWm9VrMLdbQUkCk/ANP1+1pHW
         qHe93qacwHK+qPGTIMJFkuSICEkwnX7MuMPMdPeg2gtBDVUCcyBzQh973qi7k8FdNp
         uFj2SRseHsLhQWRHwyakWHLDJDVVClcluMAF5AJA=
X-Originating-IP: [92.22.2.239]
X-Spam: 0
X-OAuthority: v=2.3 cv=ZJr5Z0zb c=1 sm=1 tr=0 a=DfadFKZD44sSo9UiDFPfnA==:117
 a=DfadFKZD44sSo9UiDFPfnA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=vXZAFr5fX_CbpY93rfEA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
 a=vXP6tmRF-EkzJhAw:21 a=RxYl7vswPSpixDIA:21 a=QEXdDO2ut3YA:10
 a=SHUmGpGg8TAA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/3] add -p: select individual hunk lines
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Gustavo Leite <gustavoleite.ti@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Fernando Vezzosi <fv@repnz.net>, Jeff King <peff@peff.net>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180316101346.7137-1-phillip.wood@talktalk.net>
 <xmqq1sg27mwf.fsf@gitster-ct.c.googlers.com>
 <a8dd262b-8b0c-8632-bf28-e03f9405317f@talktalk.net>
 <878ta8vyqe.fsf@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <1e8daa35-3749-fec7-ae88-541169dd0b2a@talktalk.net>
Date:   Mon, 2 Apr 2018 11:55:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <878ta8vyqe.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJZt9l8OTSbIh/bmOYJItcbVcThD8eXwUBI4IWNzSUhM7lmlPQnDX8o51pudYLFheA2TmGOXVyYnS0TLzf+ISuCJ5j/N3tGs5r9BKLbNMN23rkCWVt9C
 /NSSpRuFN4FDXQwZ0sYHYdNI6yKNUDRdweLBU6MmxAbr86hZ/k19P6VXG8LILpiaVYUzOKI9SwaqlCBKObNodcV5qnVDHG9CXGASA1bsM/QGm/oog6YHKhkR
 CWBHlemXkNKXTaMSlDHFO4me6rRPTYw4T9tMOaG5CP2oqQZ7incxEyarLkrcPQ8J5jC8CAbDoU0OJfMJzDpYz9GtMIz8QeRa/w1NXIivznEe54IHO5E3H4c8
 gDAbC3P/dtVrcWexZ2ZYrqYj4OEr2QTfXHp0CAI+6prZEU4glNQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/03/18 20:20, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Mar 30 2018, Phillip Wood wrote:
> 
>> On 29/03/18 19:32, Junio C Hamano wrote:
>>> Phillip Wood <phillip.wood@talktalk.net> writes:
>>>
>>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>>
>>>> Since v2 I've updated the patches to use '-' instead of '^' to invert
>>>> the selection to match the rest of add -i and clean -i.
>>>>
>>>> These patches build on top of the recount fixes in [1]. The commit
>>>> message for the first patch describes the motivation:
>>>>
>>>> "When I end up editing hunks it is almost always because I want to
>>>> stage a subset of the lines in the hunk. Doing this by editing the
>>>> hunk is inconvenient and error prone (especially so if the patch is
>>>> going to be reversed before being applied). Instead offer an option
>>>> for add -p to stage individual lines. When the user presses 'l' the
>>>> hunk is redrawn with labels by the insertions and deletions and they
>>>> are prompted to enter a list of the lines they wish to stage. Ranges
>>>> of lines may be specified using 'a-b' where either 'a' or 'b' may be
>>>> omitted to mean all lines from 'a' to the end of the hunk or all lines
>>>> from 1 upto and including 'b'."
>>>
>>> I haven't seen any review comments on this round, and as I am not a
>>> heavy user of "add -i" interface (even though I admit that I
>>> originally wrote it), I haven't had a chance to exercise the code
>>> myself in the two weeks since the patches have been queued in my
>>> tree.
>>>
>>> I am inclihned to merge them to 'next' soonish, but please stop me
>>> if anybody (including the original author) has further comments.
>>>
>>> Thanks.
>>>
>> Hi Junio, if no one else has any comments, then I think it's ready for
>> next. I've not used this latest incarnation much but I've used the
>> previous versions quite a bit.

Ah it seems I spoke too soon.

Thanks for taking a look at this Ævar

> First of all thinks for working on this. Something like this is a
> feature I've long wanted to have and have just been manually using edit.
> 
> As for the code, one comment: For reasons of avoiding something like the
> 2.17.0-rc* bug I just sent a patch for, I think you should change your
> use of the implicit $_ to something where you explicitly create lexical
> variables instead.
> 
> It's bad style in Perl to use $_ for anything except a one-liner, and
> similar to the $1 bug with your other patch, you'll get buggy code
> (regardless of your use of local $_) if one of the functions you're
> calling in these >10 line for-loops starts doing something to set $_
> itself, as demonstrated by:
> 
>     $ perl -wE 'sub foo { local $_; for (1..3) { bar(); say } } sub bar { $_ = $_ ** 2; } foo()'
>     1
>     4
>     9
> 
> Let's just name these variables, even if it wasn't for that caveat it
> would still be a good idea, since for any non-trivial use of $_ you've
> got to mentally keep track of what set $_ where, so it's hard to read.

Right, I'll use lexical variables.

> 
> As for the implementation, I *want* to love this, but it seems the way
> it works is just fatally flawed, consider. *The* use-case I've had for
> something like this (maybe yours differs?) is something where I do e.g.:

I've used it for selecting a subset of additions or deletions when my
work has run ahead of a logical commit boundary. I've also used it in
cases such as

	-original
	+modified
	+new stuff

To separate the modification from the addition of new stuff, but I've
not used it on a list of modifications as in your example.

>     $ perl -pi -e 's/git/Git/g' README.md
> 
> Which gives me (among other things):
> 
>     -See [Documentation/gittutorial.txt][] to get started, then see
>     -[Documentation/giteveryday.txt][] for a useful minimum set of commands, and
>     -Documentation/git-<commandname>.txt for documentation of each command.
>     -If git has been correctly installed, then the tutorial can also be
>     -read with `man gittutorial` or `git help tutorial`, and the
>     -documentation of each command with `man git-<commandname>` or `git help
>     +See [Documentation/Gittutorial.txt][] to get started, then see
>     +[Documentation/Giteveryday.txt][] for a useful minimum set of commands, and
>     +Documentation/Git-<commandname>.txt for documentation of each command.
>     +If Git has been correctly installed, then the tutorial can also be
>     +read with `man Gittutorial` or `Git help tutorial`, and the
>     +documentation of each command with `man Git-<commandname>` or `Git help
> 
> Which to me, is a perfect use-case for this feature. Here I
> hypothetically want to change "git" to "Git" in prose, so I only want to
> change that "If git has been" line, the rest are all references to
> filenames or command names.
> 
> So I would manually edit the hunk via "e" to:
> 
>      See [Documentation/gittutorial.txt][] to get started, then see
>      [Documentation/giteveryday.txt][] for a useful minimum set of commands, and
>      Documentation/git-<commandname>.txt for documentation of each command.
>     -If git has been correctly installed, then the tutorial can also be
>     +If Git has been correctly installed, then the tutorial can also be
>      read with `man gittutorial` or `git help tutorial`, and the
>      documentation of each command with `man git-<commandname>` or `git help
>      <commandname>`.
> 
> Yay, but very tedious. Now let's use your feature to do this:
> 
>      1 -See [Documentation/gittutorial.txt][] to get started, then see
>      2 -[Documentation/giteveryday.txt][] for a useful minimum set of commands, and
>      3 -Documentation/git-<commandname>.txt for documentation of each command.
>      4 -If git has been correctly installed, then the tutorial can also be
>      5 -read with `man gittutorial` or `git help tutorial`, and the
>      6 -documentation of each command with `man git-<commandname>` or `git help
>      7 +See [Documentation/Gittutorial.txt][] to get started, then see
>      8 +[Documentation/Giteveryday.txt][] for a useful minimum set of commands, and
>      9 +Documentation/Git-<commandname>.txt for documentation of each command.
>     10 +If Git has been correctly installed, then the tutorial can also be
>     11 +read with `man Gittutorial` or `Git help tutorial`, and the
>     12 +documentation of each command with `man Git-<commandname>` or `Git help
>         <commandname>`.
> 
>     select lines? 4,10
> 
> So what I was expecting this to do was some automagic where it would
> pair up the 4 line, and based on the removed/added count figure out
> which line I'm also adding corresponds to that. I.e. both selected lines
> are the 4th line removed/added, so it should transpose the 10th to the
> 4th, but instead I get a patch that looks like this:
> 
>     diff --git a/README.md b/README.md
>     index f17af66a97..7234756e64 100644
>     --- a/README.md
>     +++ b/README.md
>     @@ -18,9 +18,9 @@ including full documentation and Git related tools.
>      See [Documentation/gittutorial.txt][] to get started, then see
>      [Documentation/giteveryday.txt][] for a useful minimum set of commands, and
>      Documentation/git-<commandname>.txt for documentation of each command.
>     -If git has been correctly installed, then the tutorial can also be
>      read with `man gittutorial` or `git help tutorial`, and the
>      documentation of each command with `man git-<commandname>` or `git help
>     +If Git has been correctly installed, then the tutorial can also be
>      <commandname>`.
> 
> I.e. it just grepped out the removed line from the removed chunk, and
> the same for the added bit, which of course means that now the added
> line doesn't get injected into the correct place, but added to the end.
> 
> I can see *why* that happens, but I can't imagine a case where this
> behavior isn't useless.

I agree it's useless here I've got some suggestions on how to fix it
though I've not spent much time thinking them through - any comments
would be most welcome.

I think we want something that pairs up groups of selected deletions and
insertions rather than lines, so that it can handle cases where the
number of inserted lines differs from the number of deletions but there
are the same number of groups. For example given

	1 -* first
	2 -* second
	3 -* third
	4 +* a longer description of the
	5 +  first item
	6 +* the second item
	7 +* the third item

1,3,4-5,7 would give

	-* first
	+* a longer description of the
	+  first item
	 * second
	-* third
	+* the third item

If the number of deletion groups differs from the number of insertion
groups then there is no way to automagically pair them up so we'd need
some syntax to do that. We could make the order of the numbers given by
the user significant so that 1,6,7,2,4,9 would pair line 1 with 6 & 7
and line 4 with 9 and delete line 2. It would then be an error if the an
earlier deletion was pair with a later insertion, so in the example
above 1,6,7,4,9,2 or 2,4,9,1,6,7 would be valid but 1,9,2,4,8 wouldn't).
We could also use brackets to group things e.g. [1,6,7],2,[4,9] which
makes the groups clearer visually.

Thinking further there is a problem with

	1 -original
	2 +a new paragraph before
	3 +original
	4 +
	5 +modified original

if the user wants to commit the new paragraph before the modified
original then they need a way to specify that the insertion should come
before the deletion. At the moment giving 2-4 will put the new paragraph
after the unmodified original. To solve that there needs to be a way to
indicate that a group of insertions needs to come before the context
lines created by not staging the deletions - perhaps ^[2-4] or [^2-4]?
(we could distinguish between commas and spaces so that ^2,3,5 is
different to ^2 3,5 but that is then different to how lists work in the
rest of git)


> What this seems useful for now is for chunks that only consist of lines
> that are added or removed, maybe there's similar edge cases with those,
> but I can't think of any, there I think we should do the obvious and
> intuitive thing.
> 
> But I think that as this stands we really should at least disable this
> where we present the user with a hunk that consists of both removed &
> added lines, since I think the desired behavior I've described above
> should be the default, and once we pick one we're going to have to
> support it forever, so it's important to get it right to begin with.
> 

Thanks for your feedback it's been really useful, let me know what you
think about grouping things.

Best Wishes

Phillip

