Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99FDEB64D9
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 11:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjGLLeN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 07:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGLLeM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 07:34:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772C68F
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 04:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689161647; x=1689766447; i=johannes.schindelin@gmx.de;
 bh=jxWz8BLn5xKFp4/2AphuaIcBwJRNHmllvUxVHQ4imAY=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=OBkvG8wAMcp1vAxllCqzQ2i6p077F46gJjcku1Hz2VJr/+8Sos1nw9d2gEmPlM/uVQdh4j2
 ioKa9DYl3kr6WFL7sbRt//Wxxed6vxnKeZmtbjhVgVnt+maq3bHz1cpGvkg7RCFX37oQOJ5U6
 7a9mllg36gAc/FCmPDb0X9scu6BFPRU3xCyk8YvKIi97qX8xWMTdA5bGIVyiO6RbUiBy5Vb2k
 eZphAjyMP9u4pB50sVkg3x8Mu+CurWjrs5CFwipe7gO6cBZOVvALPnJa3jdiSLKFZ1AhElJtT
 XDGoqMszJh0qFGbhTzsw5rhcHkNzsZIazs8JRw13FDON60gknphA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.64]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMGNC-1qZYoz0Piw-00JH4Y; Wed, 12
 Jul 2023 13:34:07 +0200
Date:   Wed, 12 Jul 2023 13:34:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?Aleksander_Korzy=C5=84ski?= <ak@akorzy.net>
cc:     git@vger.kernel.org
Subject: Re: Beyond Merge and Rebase: The Upstream Import Approach in Git
In-Reply-To: <CADWu+UnThMq2M+kCMADP9rZ5c6nL+Hz+z0-OqRnuG2oYVzbvWw@mail.gmail.com>
Message-ID: <71f7d816-b139-03ab-88fc-7552d65e4498@gmx.de>
References: <CADWu+UnThMq2M+kCMADP9rZ5c6nL+Hz+z0-OqRnuG2oYVzbvWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-119226400-1689161647=:25096"
X-Provags-ID: V03:K1:KV/bZkGnmr44rgGFyBeGFUkjfXpqKXlGSidzR6/Sy5VTP89tCwH
 +vc0AfICChhED2l3vGHz6rnEP+63d6A5vKdtW64DARiB+MiPbu5p6hQ5nmAigN/D8zCNbaW
 KHYZkMKQEY5nhTAy0FYLB1NaplPIJWAdNbT3PpCLy7NJTjyZr8ko0m2UgPwvDOr8IssGmoQ
 F5CPXmQEcbt3ZzNJQi0hg==
UI-OutboundReport: notjunk:1;M01:P0:lwTet6ncpTg=;VvItpxoGNW/qIS4uoTcoGyDj45+
 GwcQ+23W/PFj9o9JdH55a3JDKwx9+L4uMIezSaYAw92Ox6M5LayaEZiWtwXFOr/6hZmJgvceq
 VBZHuQXFuv38pCwXJ6xH14cbjEJXQDsE1+MpzsgphpBi3wcMk3sjCzyCLZOPJBvVNG+GCTFWP
 poqOHU/fJLUx/dnAOJ04NKy16wADKfOhNjzlcE/EzvyJv5Ixlb01aKRJjabq/rOEXaWTwk5Bv
 m5I3oAtpu0cFQvKlSFwZe8Bne7p49OoBtLXrEZ38/BBUYSdtAxxg5rv3LQlk3/jD30xh+WXMA
 ZuAVrMRz4W+0FuEKhITsT99+/ghQpz0TvAbsiWwWGEc7sbmuXcYqx9iwYzMrIUcYWt8/s2Hnq
 kkTbhSBDhw8y94SGLBfijJIM7p8E/V159imiiyVavy0+VZKN+JnAe1iAxccUbE1AwZtSzf8Sc
 piekfRpWCj0Q7gtQlh+2yft/h1tH2y5UhHLvUMwcSnyIDpyicdRKYwFeT/CX66pKnovumb4ke
 5+atlAJNOx1g+DM1W+9DVNj7OP2qB161R1sdGBRh7KdFrhrUQ1NGuB8vQKl77lLQWRiyH7vuF
 buYrKfFv4aT7ptyv/ZGTKE13HY9DqpHJcUZq5UwCMYQmaQ7TmT+GC4p0nr0sflDtt/nefGmX+
 KV0WACitZlMuFR+NZulfCqnae6bzDhuQjpvICpzheZ+h0GE52TypqQRQlYffsxDtxVaC9NaYt
 C6LPMTPym6Lc9c5pRv0ZX0YNfi2+iNLca5FJx/+JkQvDA7fGksrB7P6sgls4FPd9Q1AY1Qp1r
 2L8WsElVGWlPCWGM0kPDs9oNrQPzR1JH2IcRHI8TKYrgmo6Nf8gpZyfdYt3jX94WjzsvP+LMU
 qgr5dKhz/x8cg5JxjnqWOSsFOAXyORdOFMG+l0qp07OjyTSyEW4x052VQLuzUDPGTH7yr+yNP
 A5AzGA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-119226400-1689161647=:25096
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Aleksander,

On Tue, 11 Jul 2023, Aleksander Korzy=C5=84ski wrote:

> THE THIRD WAY - UPSTREAM IMPORT
>
> The proposed third way is a special operation that (in the described
> use case) has the advantages of both a merge and a rebase, without the
> disadvantages. The approach is illustrated below:
>
>   o---o---o---o---o  upstream/main
>        \           \
>         \           o'---o'---o'
>          \                     \
>           o---o---o-------------S  main
>
> First, the divergent commits from "main" are rebased on top of
> "upstream/main", but then they are combined back with "main" using a
> special merge commit, which has a custom strategy: it replaces the old
> content of "main" with the new rebased content. This last commit is
> the secret sauce of this solution: the commit has two parents, like an
> ordinary merge, but has the semantics of a rebase.
>
> The structure above has the advantages of both a merge and a rebase.
> On the one hand, just like with an ordinary merge, a user who runs
> "git pull" on their local copy of "main" is not going to see the error
> about divergent branches. On the other hand, just like with an
> ordinary rebase, there is visibility into the last imported commit
> from "upstream/main" and the differences between that commit and the
> tip of "main".

I know this strategy well, having used it initially to maintain Git for
Windows' patches on top of Git releases. I refer to it as `rebasing merge`
strategy.

The main benefit for me was that the patches were always kept in an
"upstreamable state", which incidentally also helped resolving the
merge conflicts that occurred by continually rebasing them onto upstream
releases.

However, I soon realized that the delineation between upstream and
downstream patches was unsatisfactory, in particular when new downstream
patches are added. In the context of the example above, try to find a `git
rebase` invocation that rebases the current set of downstream patches:

   o---o---o---o---o---o---o---o  upstream/main
        \           \
         \           o'---o'---o'
          \                     \
           o---o---o-------------S---o---o---o  main

A candidate to describe this in a commit range would be
`upstream/main..main ^S^`, but you cannot pass that to `git rebase -i`,
which expects a single upstream.

Side note: You could _simulate_ this by calling `git replace --graft
upstream/main upstream/main^ S^` before calling `git rebase -i
upstream/main`, but I found it really easy to forget to remove the replace
object afterwards, and I managed to confuse myself many times before
deciding to use replace objects only very rarely.

So I switched to a different scheme instead that I dub "merging rebase".
Instead of finishing the rebase with a merge, I start it with that merge.
In your example, it would look like this:

   o---o---o---o---o  upstream/main
        \           \
         o---o---o---M---o'---o'---o' main

Naturally, `M` needs to be a merge that _must_ be made with `-s ours` in
order to be "tree-same with upstream/main".

This strategy was implemented initially in
https://github.com/msysgit/msysgit/commit/95ae63b8c6c0b275f460897c15a44a7d=
f5246dfb
and is in use to this day:
https://github.com/git-for-windows/build-extra/blob/main/shears.sh

This strategy is not without problems, though, which becomes quite clear
when you accept PRs that are based on commits prior to the most recent
merging rebase (or rebasing merge, both strategies suffer from the same
problem): the _next_ merging rebase will not necessarily find the most
appropriate base commit, in particular when rebasing with
`--rebase-merges`, causing unnecessary merge conflicts.

The underlying problem is, of course, the lack of mapping between
pre-rebase and post-rebase versions of the commits: Git has no idea
that two commits should be considered identical for the purposes of the
rebase, even if their SHA-1 differs. And in my hands, the patch ID has
been a poor tool to address this lack of mapping, almost always failing
for me. Not even hacked-up `git range-diff` was able to reconstruct the
mapping reliably enough.

And that problem, as far as I can tell, is still unsolved.

There have been efforts to this end, including
https://lore.kernel.org/git/pull.1356.v2.git.1664981957.gitgitgadget@gmail=
.com/,
but I do not think that any satisfying consensus was reached.

Ciao,
Johannes

--8323328-119226400-1689161647=:25096--
