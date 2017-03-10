Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2248C1FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 18:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755526AbdCJSrr (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 13:47:47 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34444 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755402AbdCJSrp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 13:47:45 -0500
Received: by mail-pf0-f178.google.com with SMTP id v190so44903050pfb.1
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 10:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BG3wPRj5bEyB1/3GaSKV2FK9T6kzOctyQD/B2LmQXeQ=;
        b=QtnrvC4WPTu63THa8rp+KXK9+uGOOxC6QtxVbK8HAatgdMjmdUYKyqTlpV4Auwg278
         iSEXVo0XcU1YDEDPqLLk3UhJH3dDhxo8fv0dL/oYDBA6Ilgg3n3+reFEKObN9RYVAIEa
         r7/YmP8E6uFdBRz3EbSvUHbQE7RB0r07fy6xtz2Wl4NhBOWfaLsIGqqki7arbxLn3pN/
         hgjCBtSRmYOo6Zo6q2XJ4X97IVWypLs47nPjC7VopjUsr5zja4D52ss8Vcgj2bLamqoQ
         LAZgWoGiFQ8ZbnZPjQ854V3wLjoi6cJfz3vAOdfBX5KdWSZFKeEcWsigSDhGM0XV5qi0
         XPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BG3wPRj5bEyB1/3GaSKV2FK9T6kzOctyQD/B2LmQXeQ=;
        b=uXzMQLPwCbSiGkGCHdL4KNzDk07rUhcc35rEtLI3CkxeYzoopae+REAw3Vr5sljD3o
         3bbl6akht+t9js67YWp8pg3rkDxTaLT1AyIXZQi+FLyw6/8zclUuYGW55O50Nx9k5RCc
         RQJxp6kQiZnO/KQ9yWJU3cIXEEWP/1wa7t51saWktPN8HIl72KkkgM4bi3oZrG2GjwPt
         gWYeccMpADSco4xriBjYmuFCrUhLIDNiNBc8Z89GtN6Y14gPkII0FwRKu7QAxKjwTQry
         f1HAsEJPZ+7VwDRWRKb5kRkdHJj8XcloXJm5D3UxD7cGJio9jmcG8JsKY3J6qpMhkVCc
         nqbA==
X-Gm-Message-State: AMke39kiOKt3jqs38yNmCJbc43kGcyMueirhCIKI7TK+KXVieGZzsoUOC/1e0+2AHL+LHPC03hCEXomYn6EOGuQs
X-Received: by 10.84.239.8 with SMTP id w8mr27461809plk.73.1489171664251; Fri,
 10 Mar 2017 10:47:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Fri, 10 Mar 2017 10:47:43 -0800 (PST)
In-Reply-To: <1489145258.10535.0@smtp.yandex.ru>
References: <1489145258.10535.0@smtp.yandex.ru>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 10 Mar 2017 10:47:43 -0800
Message-ID: <CAGZ79kZHjpptQAF4NM5y47PF+YXHRADAhzFUYG_+CSwRozo+qQ@mail.gmail.com>
Subject: Re: [GSoC] Discussion of "Submodule related work" project
To:     Valery Tolstov <me@vtolstov.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 3:27 AM, Valery Tolstov <me@vtolstov.org> wrote:
> Have some questions about "Submodule related work" project
>
> First of all, I would like to add this task to the project, if I'll take it:
> https://public-inbox.org/git/1488913150.8812.0@smtp.yandex.ru/T/
> What do you think about this task?

That is a nice project, though my gut feeling is that it is too small
for a GSoC project on itself.

>> Cleanup our test suite. Do not use a repo itself as a submodule for itself
>
> Not quite familiar with submodules yet, why this is considered to be
> ineligible (i.e. using repo as a submodule for itself)?

(a bit of background on submodules)

man gitglossary (then searching for submodule):
       submodule
           A repository that holds the history of a separate project inside
           another repository (the latter of which is called superproject).

       superproject
           A repository that references repositories of other projects in its
           working tree as submodules. The superproject knows about the names
           of (but does not hold copies of) commit objects of the contained
           submodules.

An example that I just found on Github[1]. It is a game
(so it includes graphics, game code etc). But it makes use of a library[2],
which could be used by different projects.

[1] https://github.com/stephank/orona
[2] https://github.com/stephank/villain

Now why would a repo be ineligible to use itself as a submodule?
There is nothing wrong with it *technically* (which is why we do such things
in the test suite.)

But what are the use cases for it? Why would a project bind itself
as a submodule (you can get the same effect of having the source code
by just checking out that other version.) ? Well now that I think about it,
it may be useful if you want to test old versions of yourself for e.g.
networking compatibility. But for that you'd probably still not use submodules.

So the use case of using submodules for another copy of itself is
*very rare* if it exists at all out there. And the Git test suite
should rather test
use cases that are not these weird corner cases, but rather pay attention to
the common case first.

I thought this project would have been solved parially already, but I was wrong.
($ git grep "submodule add \./\."). This also doesn't seem large enough for
a summer project, after thinking about it further.

>> (Advanced datastructure knowledge required?) Protect submodule from gc-ing
>> interesting HEADS.
>
> Can you provide a small example that shows the problem, please?

Let's use this example from above:

$ git clone --recursive https://github.com/stephank/orona
    # now we have 2 repositories, the orona repo as well as its submodule
    # at node_modules/villain
    #
    # "Let's inspect the Readmes/license files, if they are ok to use
    # Oh! the submodule is MIT licensed but doesn't have the full
    # license text, I can contribute and make a patch for it."
$ cd node_modules/villain
$ $EDIT LICENSE
$ git add LICENSE
$ git commit -a -m "add license full text"
$
$ cd ../.. # go back to the superproject
$ git add  node_modules/villain
$ git commit -a -m "update game to include latest lib"
$ git checkout -b "fix_license"
    # note how I forget to actually push it / pull request it!
    # All we need for the demonstration is a local commit
    # in the submodule that is referenced by the superproject...
    #
    # ... "Let's test the pristine copy of the game!" ...
$ git checkout origin/master
$ git submodule update
    # ... which gets lost here. The submodule commit
    # is only referenced by a superproject commit.

.. time passes ..

    # "My disk is so full, maybe I can clean up all these random
    # accumulated projects, to have more disk space again."
    # my cleanup script may do this:

$ cd node_modules/villain
$ git reflog expire --all --expire=all
$ git gc --prune=all
$ cd ../..

$ git branch
    # "Oh what about this 'fix_license branch' ?
    #  Did I actually send that upstream?"
$ git checkout fix_license
$ git submodule update
error: no such remote ref 96016818b2ed9eb0ca72552b18f8339fc20850b4
Fetched in submodule path 'villain', but it did not contain
96016818b2ed9eb0ca72552b18f8339fc20850b4. Direct fetching of that
commit failed.

> And why advanced datastructure knowledge is expected?

I am not quite sure how to approach this problem, so I put
a "warning; it may be complicated" sticker on it. ;)

The problem is that a submodule until now was considered
its own repository, in full control what to keep and delete,
how to name its branches and so on.

git-gc only pays attention to commits (and its history) of all
branches and commits mentioned in the reflog.
(which is why we had to delete the reflog, and as we
were making the license commit on a "detached HEAD",
there was no need to delete its branch).

However it should also consider all commits referenced
by the superproject valuable.

In this case the superproject has a branch "fix_license",
so that commit is considered too valuable for gc in the
superproject, but it breaks with the submodule pointer
as the pointer changes in the superproject, but the
gc operation in the submodule doesn't care.

One way to fix it is to figure out if there is a superproject
at gc time and then collect all valuable hashes (submodule
pointers) before actually performing the gc.

But that may be expensive, so we would rather record
it on the fly, e.g. when making the commit in the superproject
we'd record in the submodule that the given hash by the
submodule pointer is valuable.

This could be done by having a ref (=branch) in the submodule
that points at all the interesting submodule commits.

So despite being prominent on the ideas page (because of a lot
of text), this may be controversial how to actually solve it.

>
> Maybe you have something else about this project to say.

If I remember correctly, shell -> C conversion projects are
easy (both for writing the code as well as for mentoring)

> git archive(/bundle) to have a --recurse-submodules flag
> to include the submodule contents.

is an actual interesting project as well despite its short description.

Thanks,
Stefan
