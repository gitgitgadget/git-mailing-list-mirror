Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E56F203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 17:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756563AbcGZRVM (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 13:21:12 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:38651 "EHLO
	mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857AbcGZRVK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 13:21:10 -0400
Received: by mail-it0-f47.google.com with SMTP id j124so22754181ith.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 10:21:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jiRB25XFFc+tdRq0kFOd07LpE7OV9G0/mLfGbs0DB5A=;
        b=yKx+PpjC+Mt4+XLP3Abytjki5PwZyMZ3m3ujIcFXr02VwFcNmzAJsBMsNGRyIefN2f
         OKjRJxVdrp6+X12R1+J6CMqigyBC61ygqvRSesDGPCeQ3igzpbM5C3b82/lLIqgyDPK4
         SRw1LU7GtrHNeJlmu3rIA8I35XToZIlnG/6yzy3bJ3k5K9FatzhAHK2SM4je0mVRzoRm
         ajAn9a5LniJ0nI9HZyEwMcaTQ/zHseV0rjeEBKi1qx6cArrbZLcR+/HH58I6veL+LsrV
         ozx+Ful3izM5WXGMS8iodtfiY3ZyILai135pJU0RlsBQcsZGUMtSTJFyDRCJISvbFhlY
         RR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jiRB25XFFc+tdRq0kFOd07LpE7OV9G0/mLfGbs0DB5A=;
        b=jgDcPdr8oobUR0sSiEZq0Bx5vZpzxFG+Gj7+kYl0W/mDu1vH/kttmrRMGh6ke3oab2
         fZwJkZMwYq43/xxWsr3IO+GKrmf8+9Lfp3DZIfkMev0R49l9xQSAkD7x3v8qY9uUmj7x
         S49A+63h8Q7l0cdiekMcI6qxz+7WF1ih83an1SflbPo0NZVPl3pZKKP58GE0rcACBLyF
         r/NeemuArVTvIlstX/bYezt4RBQJvoGN+zr3DgSKClbRN8NVLdvtJV4FUoAKgQzUdDE9
         H6JqRygTGeK7Ph6aOspd29Vz8B2IBl5YflM448v8GCx/7sotfICV+uKCQtSWXCF8ioIJ
         5XYg==
X-Gm-Message-State: AEkoouvHkbuJOtBET/lRK9B6uKyFy4AdjI35ZseXHiwxwp1iERQEh4gvHB7SFj5f0IsqXQbdBfcT0T+URmqX/A==
X-Received: by 10.36.91.134 with SMTP id g128mr28377857itb.42.1469553669720;
 Tue, 26 Jul 2016 10:21:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 26 Jul 2016 10:20:40 -0700 (PDT)
In-Reply-To: <CAGZ79kYbmoKPAPMVkTUycSKVtT6HLK-Y_eGXSX+z69G3+udR8Q@mail.gmail.com>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com> <20160720172419.25473-4-pclouds@gmail.com>
 <CAGZ79kZB8U+ERNeYpZ-i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.com>
 <CACsJy8CSnmnzDMGpMvvkhWRfJvp1L+pfOZ=eYp5JF0GWNH6D0Q@mail.gmail.com>
 <CAGZ79ka-isR4DL7ZqOp8cXE1bmUOnd33yu=pZZHaqNmPWH3PYQ@mail.gmail.com>
 <CACsJy8DKEV3FNmb1vWinRvb-FHSO_VftG7RevQ3TOFhP-Dm0cw@mail.gmail.com> <CAGZ79kYbmoKPAPMVkTUycSKVtT6HLK-Y_eGXSX+z69G3+udR8Q@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 26 Jul 2016 19:20:40 +0200
Message-ID: <CACsJy8DgeSOh-RScmcrSwy7PgeQXwA2R6w9mRmHzuWR4djg=4w@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] submodule: support running in multiple worktree setup
To:	Stefan Beller <sbeller@google.com>
Cc:	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 26, 2016 at 1:25 AM, Stefan Beller <sbeller@google.com> wrote:
> So what is the design philosophy in worktrees? How much independence does
> one working tree have?

git-worktree started out as an alternative for git-stash: hmm.. i need
to make some changes in another branch, okay let's leave this worktree
(with all its messy stuff) as-is, create another worktree, make those
changes, then delete the worktree and go back here. There's already
another way of doing that without git-stash: you clone the repo, fix
your stuff, push back and delete the new repo.

I know I have not really answered your questions. But I think it gives
an idea what are the typical use cases for multiple worktrees. How
much independence would need to be decided case-by-case, I think.

> So here is what I did:
>  *  s/git submodule init/git submodule update --init/
>  * added a test_pause to the last test on the last line
>  * Then:
>
> $ find . |grep da5e6058
> ./addtest/.git/modules/submod/objects/08/da5e6058267d6be703ae058d173ce38ed53066
> ./addtest/.git/worktrees/super-elsewhere/modules/submod/objects/08/da5e6058267d6be703ae058d173ce38ed53066
> ./addtest/.git/worktrees/super-elsewhere/modules/submod2/objects/08/da5e6058267d6be703ae058d173ce38ed53066
> ./.git/objects/08/da5e6058267d6be703ae058d173ce38ed53066
>
> The last entry is the "upstream" for the addtest clone, so that is fine.
> However inside the ./addtest/ (and its worktrees, which currently are
> embedded in there?) we only want to have one object store for a given
> submodule?

How to store stuff in .git is the implementation details that the user
does not care about. As long as we keep the behavior the same (they
can still "git submodule init" and stuff in the new worktree), sharing
the same object store makes sense (pros: lower disk consumption, cons:
none).


> After playing with this series a bit more, I actually like the UI as it is an
> easy mental model "submodules behave completely independent".
>
> However in 3/4 you said:
>
> + - `submodule.*` in current state should not be shared because the
> +   information is tied to a particular version of .gitmodules in a
> +   working directory.
>
> This is already a problem with say different branches/versions.
> That has been solved by duplicating that information to .git/config
> as a required step. (I don't like that approach, as it is super confusing
> IMHO)

Hmm.. I didn't realize this. But then I have never given much thought
about submodules, probably because I have an alternative solution for
it (or some of its use cases) anyway :)

OK so it's already a problem. But if we keep sharing submodule stuff
in .git/config, there's a _new_ problem: when you "submodule init" a
worktree, .git/config is now tailored for the current worktree, when
you move back to the previous worktree, you need to "submodule init"
again. So moving to multiple worktrees setup changes how the user uses
submodule, not good in my opinion.

If you have a grand plan to make submodule work at switching branches
(without reinit) and if it happens to work the same way when we have
multiple worktrees, great.

> I am back to the drawing board for the submodule side of things,
> but I guess this series could be used once we figure out how to
> have just one object database for a submodule.

I would leave this out for now. Let's make submodule work with
multiple worktrees first (and see how the users react to this). Then
we can try to share object database. Object database and refs are tied
closely together so you may run into other problems soon.
-- 
Duy
