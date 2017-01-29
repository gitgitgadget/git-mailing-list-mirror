Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F166E1F6DC
	for <e@80x24.org>; Sun, 29 Jan 2017 18:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbdA2S7q (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jan 2017 13:59:46 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:43942 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751215AbdA2S7o (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jan 2017 13:59:44 -0500
Received: from homiemail-a61.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
        by hapkido.dreamhost.com (Postfix) with ESMTP id 33D09ED5D4
        for <git@vger.kernel.org>; Sat, 28 Jan 2017 22:46:08 -0800 (PST)
Received: from homiemail-a61.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a61.g.dreamhost.com (Postfix) with ESMTP id 454B6578077
        for <git@vger.kernel.org>; Sat, 28 Jan 2017 22:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bit-booster.com; h=
        mime-version:in-reply-to:references:from:date:message-id:subject
        :to:cc:content-type; s=bit-booster.com; bh=VrHj5iyGgqNFXaqVRon2S
        N9xuFM=; b=i76TOtqz+StORFWoXUQZSiEQDGJrGhyqszdLAeJGH4MLSv+VNdnJ/
        ypXgS1QJRPmTjK97kTb8xdyAkB3K/jQV5rmRzIwGU5IPivkBx/XP9voviOKMZ+gg
        3imFjo7ZnatFaCMXW1zUueuAJGJlRhmJCsMyqBYbs8nKMbgDCShulk=
Received: from mail-yw0-f169.google.com (mail-yw0-f169.google.com [209.85.161.169])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sylvie@bit-booster.com)
        by homiemail-a61.g.dreamhost.com (Postfix) with ESMTPSA id D8E5857807B
        for <git@vger.kernel.org>; Sat, 28 Jan 2017 22:45:05 -0800 (PST)
Received: by mail-yw0-f169.google.com with SMTP id u68so39639560ywg.0
        for <git@vger.kernel.org>; Sat, 28 Jan 2017 22:45:05 -0800 (PST)
X-Gm-Message-State: AIkVDXKo6gzIf2Phf6reAc1PMAYUxfOtIFFNLNmiyWMODSLylQVIuDVbm4D1LHTNLGY8OkgT+yC3GFFZ5u65wQ==
X-Received: by 10.13.197.71 with SMTP id h68mr12207698ywd.127.1485672305041;
 Sat, 28 Jan 2017 22:45:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.56.201 with HTTP; Sat, 28 Jan 2017 22:45:04 -0800 (PST)
In-Reply-To: <20170128142808.hefnv7r3h6zidobw@sigill.intra.peff.net>
References: <CANwu5-o=3p8QfWo9wQvok=UZESRVtF3Uxb3nEMZVv8AvkKYYGw@mail.gmail.com>
 <20170127175151.srhhczliqgvbzcre@sigill.intra.peff.net> <CAAj3zPzO4+9t9_L2OXFmkihw-HwFvzybb7GXs4tTeFRyZHOaNQ@mail.gmail.com>
 <20170128142808.hefnv7r3h6zidobw@sigill.intra.peff.net>
From:   "G. Sylvie Davies" <sylvie@bit-booster.com>
Date:   Sat, 28 Jan 2017 22:45:04 -0800
X-Gmail-Original-Message-ID: <CAAj3zPx5fKHUTLLEuuZjmq+H5somp980j0hqWjmLyvLuk709GQ@mail.gmail.com>
Message-ID: <CAAj3zPx5fKHUTLLEuuZjmq+H5somp980j0hqWjmLyvLuk709GQ@mail.gmail.com>
Subject: Re: show all merge conflicts
To:     Jeff King <peff@peff.net>
Cc:     "G. Sylvie Davies" <sylvie@bit-booster.com>,
        Michael Spiegel <michael.m.spiegel@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 28, 2017 at 6:28 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 27, 2017 at 09:42:41PM -0800, G. Sylvie Davies wrote:
>
>> Aside from the usual "git log -cc", I think this should work (replace
>> HEAD with whichever commit you are analyzing):
>>
>> git diff --name-only HEAD^2...HEAD^1 > m1
>> git diff --name-only HEAD^1...HEAD^2 > b1
>> git diff --name-only HEAD^1..HEAD    > m2
>> git diff --name-only HEAD^2..HEAD    > b2
>>
>> If files listed between m1 and b2 differ, then the merge is dirty.
>> Similarly for m2 and b1.
>>
>> More information here:
>>
>> http://stackoverflow.com/questions/27683077/how-do-you-detect-an-evil-merge-in-git/41356308#41356308
>
> I don't think that can reliably find evil merges, since it looks at the
> file level. If you had one hunk resolved for "theirs" and one hunk for
> "ours" in a given file, then the file will be listed in each diff,
> whether it has evil hunks or not.
>

Well, you have to do both.  Do "git show -c" to catch that one
("theirs" for one hunk, "ours" for the other, same file).

And then do that sequence of the 4 "git diff" commands to identify
dirty merges where "theirs" or "ours" was applied to entire files, and
thus not showing up in the "git show -c".

> I don't think this is just about evil merges, though. For instance,
> try:
>
>   seq 1 10 >file
>   git add file
>   git commit -m base
>
>   sed s/4/master/ <file >tmp && mv tmp file
>   git commit -am master
>
>   git checkout -b other HEAD^
>   sed s/4/other/ <file >tmp && mv tmp file
>   git commit -am other
>
>   git merge master
>   git checkout --ours file
>   git commit -am merged
>
>   merge=$(git rev-parse HEAD)
>
> The question is: were there conflicts in $merge, and how were they
> resolved?
>
> That isn't an evil merge, but there's still something interesting to
> show that "git log --cc" won't display.
>
> Replaying the merge like:
>
>   git checkout $merge^1
>   git merge $merge^2
>   git diff -R $merge
>
> shows you the patch to go from the conflict state to the final one.
>

I know the stackoverflow question asks "how to detect evil merges",
and I go along with that in my answer.  But honestly I prefer to call
them dirty rather than evil, and by "dirty" I just mean merges that
did not resolve cleanly via "git merge", and had some form of user
intervention, be it conflict resolution, or other strange things.

The trick I propose with the sequence of 4 "git diff" commands
identifies that merge from your example as dirty:

$ cat b1 m2
file

$ cat b2 m1
file
file

The trick doesn't really tell you much except that the merge is dirty.
If you notice that the "m2" file is empty, I think that's one way to
realize that master's edit was dropped, and therefore "other" won.

Maybe it even merged cleanly but someone did a "git commit --amend" to
make it the merge dirty after the fact.

I do like your approach, it's very simple and reliable.  But in my
situation I'm writing pre-receive hooks for bare repos, so I don't
think I can actually do "git merge"!

I think my suggestion would work for OP, as long as they also run "git
show -c" alongside it.   (And your suggestion would work, too, of
course).



- Sylvie
