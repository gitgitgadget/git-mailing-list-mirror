From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Reviews for the first patches of pclouds/narrow-checkout
Date: Tue, 24 May 2016 19:02:48 +0700
Message-ID: <CACsJy8DVr7iL-bGWbQs52ZgnVeC0NhFM2NzZYmNA-FZ=Yu7+oA@mail.gmail.com>
References: <CAGZ79kb-y6gUHEBSdVB6Y+A=EjykZgcNsLynXcwSMyVNHiDU2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 24 14:03:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5B3c-0008Ac-D0
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 14:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbcEXMDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 08:03:20 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:35156 "EHLO
	mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbcEXMDT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 08:03:19 -0400
Received: by mail-it0-f52.google.com with SMTP id z189so43472580itg.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 05:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FOo9XWnfp7d2VmrftUjWrk+szjxidWb6AYMPi4JW+u8=;
        b=BvGexJPYZ1lW4V6YlWxVQ1tGXgoWtf2zxhYYq/Ff42Ggc4uAeQ0lMXNmCPR6e0RyR9
         uOyR9gXXi1jJO6oM016QVsLdkBeN5X1PvQfm224EvQosf0lS2MOmu3H6ORE/aqpbVHRn
         kStLTPXYaHqcA+s6TBzWlMfcYoI1iJHWPXjXnO94FTqspI+Yw9jg/wuFOS4xUQ5KcNE2
         zET8qDXpCzk4vEiH15vTh8qkIiwZcOU3+liw+yP58jhhuxngEgvH/AkzL6NioILVBmSH
         kfdiVz+QahaGxJi4LooGHhrUpcqHNZ9O3OFMrQQJIWueHwC4uurQhG4FBwZEMUlwtVYD
         hS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FOo9XWnfp7d2VmrftUjWrk+szjxidWb6AYMPi4JW+u8=;
        b=TH3+cqq+6Ce0YcAkOuPkH8q+qAg5EODfcsoGX9LRXsH3Couo5C/ZaSW63mQAZzF2YE
         7G3Z4qulNLVprDcCZJThwW+z24goIssUcb5GRJ49MHRqXVAvJ5njytrf1wvBrNBAzn16
         sQ37kUndlyoTgNqhPESH+frWG2gdLS+4AZ9id8HUxbEV05/tukNfCf0NPoLGmw5Sxv0d
         OpJv8VXhWuAqzb7r5mOAAwu4o3vSD4Uo7y5gKO8fjeO2ymZkFclYCZKbswjUPut9tkH2
         RFadOaqQS4MnO8ciVwNzLLzWdHbEJUdzbrvNJEq/ZMPcFo8We6nUUoCpXWlges6P5GAr
         +V1Q==
X-Gm-Message-State: ALyK8tJoNzXeFALbqpuS7gfyITvX9xm0xUZ9Lf10NVykAyxL+LmqJh0GP6GO+5ww7zHyPoXpWIDc+vK4lOToPw==
X-Received: by 10.36.211.4 with SMTP id n4mr708805itg.57.1464091397939; Tue,
 24 May 2016 05:03:17 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Tue, 24 May 2016 05:02:48 -0700 (PDT)
In-Reply-To: <CAGZ79kb-y6gUHEBSdVB6Y+A=EjykZgcNsLynXcwSMyVNHiDU2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295489>

On Tue, May 24, 2016 at 1:26 AM, Stefan Beller <sbeller@google.com> wrote:
> Hi,
>
> so I started looking into your narrow checkout branch and started reviewing
> the patches. Thanks for working on the narrow checkout!
>
> Reviewed-by: Stefan Beller <sbeller@google.com> (just asking for signoff)
>     tree.c: break long lines
>     read-cache: realign some statements
>     read-cache: add sort_index()
>     read-cache: description for base_name_compare()
>     unpack-trees: break down long lines
>
> Regarding:
>     base_name_compare: do not assume name[len] == '\0'
> Could you clarify if this is an existing bug or a preparation for a future
> different use?

It's a hidden bug if I remember correctly. New code activates it.


>     read-cache: new sort compare function that pays attention to ce_mode
>
> Would a new mode (0100 (directory)) require bumping the index version?
> Or the other way round: What If I use these patches and then try to use
> another version of Git without this feature?

Good question. Current git happily takes index with directories (not
good). However, high level like git-diff will detect and reject
entries that are neither regular files or git-links. I might bump
index version up in the end to be on the safe side.

>     read-cache: refactor check_ce_order()
>
> Would it make sense to avoid the yoda condition?
> (i.e. "cmp > 0" instead of "0 < cmp" -> die("unordered stage entries"))
> Or rather: I found it confusing that cmp is on both sides of the < in two
> different conditions, i.e. it looks like you prefer to keep the "<" sign
> constant, whereas I would have written
>
>     if (cmp < 0)
>         continue;
>     if (cmp > 0)
>         die(...);
>
> It's a style thing, so I guess either is fine.

I didn't notice the new "cmp < 0" makes the old "cmp <0" look weird. Will fix.

> I would however put the case for (cmp < 0) first as that is the expected case?

Yep.

>     read-cache: check ce_mode in check_ce_order()
>
>     Can we replace
>         cmp = (c1 < c2) ? -1 : (c1 > c2) ? 1 : 0;
>     by:
>         cmp = c1 - c2;
>     as it is only used in comparisons lesser/greater than 0 afterwards.


Hmm.. c1 and c2 are unsigned. I guess it's ok to do the subtraction,
going to need to run some tests...
>
> Again, I would put the "continue" case first (cmp >0)
>
>
>
>     read-cache: index_name_stage_pos() => index_name_mode_stage_pos()
>
> "After this read-cache.c code is pretty much ready for accepting dir
> entries in the index."
>
> What is missing?

Something like the next patch, replacing file with a dir of same name
or vice versa.

> So that's a review for the first third of the patches. :)

Thanks :)

> I wonder how much is left for actually finishing the narrow checkout,
> as I could not find documentation or code the user interacts with.
> (i.e. I would like to use a narrow checkout. How do I start? Where do I put
> the pathspec of things I would like to use? Or are you envisioning a git wrapper
> for that? "git narrow [make-go-away, revive] <pathspec>" ?)

UI is bare bone at this stage. You can do "git read-tree -mu HEAD --
<pathspec>". Directories that are _completely_ excluded will be folded
and you should have some nice dir entries in the index (can be
examined with ls-files --stage, notice the mode column). Then you can
try out various commands and see whether they still work (they
should). The shape of the index is not defined in a file like sparse
checkout. You can fold and unfold directories at will and they should
remain so (I think git reset --hard just drops the old index and write
a new one, we may need to fix that, because we would lose fold/unfold
state)

The next step is unfold operation, then re-fold. I think I aimed too
high trying to combine those operations as one in unpack-trees.c.
Unfolding a directory should be simple (UI in update-index), you read
the corresponding tree, you check out all files (and need to make sure
the directory is missing, so no overwrite/data loss can happen).
Re-folding is simply running "read-tree" command again, I think.
read-tree (or unpack_trees() in fact) already knows how to fold and
delete files in folded directories (or refuse to do so if files to be
deleted are dirty). I was trying to do both operations in one step to
avoid unnecessary I/O (e.g. you have folded directory "a", now you
want to unfold "a/b", but you want to keep "a/b/c" folded). That sort
of work can be done at a later phase.

Once you support  both fold and unfold, you can teach "git checkout"
about this so we have a friendlier UI. "git checkout --reshape --
<pathspec>" (or whatever option name) will try to unfold first (only
relevant directories, not unfold the entire worktree) then refold.
Narrow checkout is pretty much done at this point. More work may be
required, e.g. audit the code and prevent it from reading dir's SHA-1,
for narrow _clone_ because such an operation will fail in narrow clone
(but not narrow checkout with full repository). If I remember
correctly the major work to make narrow clone work is dealing with
worktree. Once narrow checkout works, it's probably ~10 patches to get
a naive version of narrow clone.

PS. I forgot about merge. If a merge conflict happens at a directory,
I guess we can simply reject the merge and ask the user to unfold
those directories first... It's probably the same behavior we have
with submodules today, and we are probably fine as submodules have
mostly addressed the "directory in index" issue for us. We just need
to follow the path and accept directories where it already accepts
git-links.
-- 
Duy
