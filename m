Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BA5720229
	for <e@80x24.org>; Tue,  1 Nov 2016 22:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbcKAW4M (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 18:56:12 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35035 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752446AbcKAW4M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 18:56:12 -0400
Received: by mail-qk0-f174.google.com with SMTP id z190so216705671qkc.2
        for <git@vger.kernel.org>; Tue, 01 Nov 2016 15:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/a7m4qeL7WRsu6zuC3FO6JWLNh/8NGyop26jIfSVXEc=;
        b=kKesAeDE7ShMe/loEEJIVJZReA9pdcTp5oujjy0muCvXYUjzeLOSxpkuJEt2N7UBY2
         +ZINQxEWDoiG6w579gBasjdkpXUFzdMLIXUXVaa9YHVC+LzCQRD9N+OgZ3QDrTUb3OO3
         4ka1cbn7n5s9Kobh2C+jtndMAD+UXCBmPJGvnOlfjVic5+4sGEKtQJZDBZMzMz2f+7dM
         xn/iiM+DVn+cq0wPLOUoob7DhUgAWHB+7Q9jo2jar8tRFpqpQPzNsW4DrFk8YP+PsU3L
         l4cxq/VB0jb1fqjwOsQVc6Vb0Ke5HjDYPqt8g6p9CqfYqIWJ6D4Igwxw0kc2Cl2rHMiA
         O7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/a7m4qeL7WRsu6zuC3FO6JWLNh/8NGyop26jIfSVXEc=;
        b=ihPhw0RR10Iixg55q4pNO6jYdGN9BUnkMvRrgFndhhF4mGk1MDe1E/Qkg3ZJ8AEMvh
         rooxdyXrXy44egn5RhJpWr/8WG2I/urHyH2vcuwyboExpg8w5Bo+LRyQjWHXzkxs63Rc
         1YrieXxfBF/aX8NuYf5TxUo63p4NyvG/K8nsi3XpxcZn8TB2uOLqUZrmgGr/3zBXDPFy
         1qjXU9KpcuF/kgcNqiHEREcwbbj+948NsYEqYeqf6Wb4TJylqNzQ60NFmX0lIc0pu9U5
         mqwqlRq91UzlJiWrryH0XSG36cMXU7i2f1dtn4pvWrRNLSQNWqee9okubAKBeXz4+cEu
         mgkQ==
X-Gm-Message-State: ABUngvdqg7OFSx6rO4tVum7qRMzchontNRwoXDcwXAIB18Az4DSDOzPo1qPnQeJGU5OZGZq7dfKvHXBlgQ+MOSIA
X-Received: by 10.55.64.80 with SMTP id n77mr467101qka.173.1478040970921; Tue,
 01 Nov 2016 15:56:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Tue, 1 Nov 2016 15:56:10 -0700 (PDT)
In-Reply-To: <6533af94ebd74952b75e51c5609d8c20@exmbdft7.ad.twosigma.com>
References: <6533af94ebd74952b75e51c5609d8c20@exmbdft7.ad.twosigma.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 1 Nov 2016 15:56:10 -0700
Message-ID: <CAGZ79kbqVphQpDSEKFs=_6E1XNsn6rz=1ifRx9iEHFhRd9ZPOA@mail.gmail.com>
Subject: Re: Submodules: two confusing situations
To:     David Turner <David.Turner@twosigma.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 1, 2016 at 3:13 PM, David Turner <David.Turner@twosigma.com> wr=
ote:
> Consider the following two cases:
>
> We have commit X and commit Y.  X is an ancestor of Y.
>
> We're at X and doing get checkout Y -- or we're at Y and we're doing
> git checkout X.
>
> Case 1: Between X and Y, we have deleted a submodule.
> In order to move from X to Y, git removes the submodule
> from the working tree.
>
> Case 2: Between X and Y, we have instead added a submodule.  In order
> to move from Y to X (that is, the opposite direction), git *does not*
> remove the submodule from the tree; instead, it gives a warning and
> leaves the submodule behind.
>
> I don't understand why these two cases are not symmetric.

Because you are using git-submodule.sh that is only an approximation of
what is supposed to happen. ("git checkout [X | Y] && git submodule update"
I'd guess).

"git submodule update" only *updates* the submodules and doesn't *delete*
them at all. I think this originated from the historic behavior of
having the submodules
.git directory inside the submodule and not in the superprojects .git/modul=
e.
When having the .git dir inside the submodule, you cannot delete the submod=
ule
as you'd potentially loose information (local commits) from the submodule.

I am currently working on implementing a flag --recurse-submodules for
git-checkout
that would be symmetrical from X -> Y and back, but that feature hasn't see=
n
the mailing list yet as I discovered yet another bug locally.
I think I found a reviewer though. ;)

The problem with doing a propoer checkout, i.e. update and deletion of
a submodule,
you need to be sure the submodule in its state can go away:
* no untracked files that are lost (except for gitignored files)
* clean index in the submodule and
* the submodule points at the recorded sha1 (i.e. there are no
  commits that would be dangling)

>
> Perhaps relatedly, consider the attached shell-script, which I have not y=
et made into a full git test because I'm not sure I understand the issues f=
ully.
>
> It creates three commits:
>
> Commit 1 adds a submodule
> Commit 2 removes that submodule and re-adds it into a subdirectory (sub1 =
to sub1/sub1).
> Commit 3 adds an unrelated file.
>
> Then it checks out commit 1 (first deinitializing the submodule to avoid =
case 2 above), and attempts to cherry-pick commit 3.  This seems like it ou=
ght to work, based on my understanding of cherry-pick.  But in fact it give=
s a conflict on the stuff from commit 2 (which is unrelated to commit 3).

That sounds like a bug indeed.

>
> This is confusing to me, and looks like a bug.  What am I missing?
>
