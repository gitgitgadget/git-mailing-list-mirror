From: Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (Aug 2015, #03; Mon, 17)
Date: Mon, 17 Aug 2015 16:28:39 -0700
Message-ID: <CAGZ79ka6mz=f=g0mkgtP2955z+sRf1Sh+ArB=-ZA2ZhX27LuWw@mail.gmail.com>
References: <xmqqk2stbl3o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 01:28:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRTpd-0005S9-Lc
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 01:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbbHQX2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 19:28:41 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:36701 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbbHQX2k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 19:28:40 -0400
Received: by ykfw73 with SMTP id w73so88630299ykf.3
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 16:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tjsgDR6yssE6m11BkFyEVp8SEoJSZdX/9GKHT+xsv0w=;
        b=dZWJh+uOBnSwoGD4b9jZNgXbv3d3sRo4IAYP8Yf2A1JSjv9BQYArKGqFe1egeEYXQh
         nG0PK9iupVDHh7xysBJ+ZSC4P0SEhafbJ9WK9ON3O2DCs9wc/TbXH/iZWwzGdyhxhQqc
         sQlRlE/6XqxfuTIesyQnZQPFho9AH7lCbWB70AErSe4OY+d964q6WJE+crgwqjqpDUiZ
         ymAnv/YGmqocyOKBBpyGyeDBJRvUbZJ+3UVnPfrdPmMtxkcg06Hzt1mF77Xb13MsWokm
         zJtfJbs3NGwiKpLmPFb/EAcUpFFVvf1cM34CkhkerFH4SLlvcZ32/l0JltWQuxylIdWP
         TBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=tjsgDR6yssE6m11BkFyEVp8SEoJSZdX/9GKHT+xsv0w=;
        b=fLRtG6mLL3iMsUX8wl29KSRC6S/tHFy0iIKFxtEyIsbauWYxvaH3zR38lgJ0qy99Jq
         E8NJecR4ERvyj7cI+/I3KISg+esxmQ6sA9zSlGu40K4J+sUu3las9lVYZX/0EgBZk/m3
         Eh+hdDJrtAa/dRdNxv6p5/3/i3Z9NXac3l0jGfohqkLTfmHq4I9RUiliszH9cHUyLRlZ
         kllYXUvHlEtNpu+vfC6Inms57REZTNOArgyYBoxkG2j6mnapZJshP7uWNtLfd7fZu7V7
         bg0CMOWWmcNoIze7kzzVrH6IwadNnOEtv8vYsQ7c7lqKPSm5EVFhGNZOapDeeb8mb8s9
         vCZQ==
X-Gm-Message-State: ALoCoQlJsmJYhB0/FVcNzdqNNDLMjKT1TBA68mGK91Zpyq6PxF+sIeYlv7jcr6svs0UFh0g/3tt1
X-Received: by 10.170.200.212 with SMTP id r203mr4007649yke.10.1439854119549;
 Mon, 17 Aug 2015 16:28:39 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Mon, 17 Aug 2015 16:28:39 -0700 (PDT)
In-Reply-To: <xmqqk2stbl3o.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276104>

On Mon, Aug 17, 2015 at 3:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> * hv/submodule-config (2015-06-15) 4 commits
>  - do not die on error of parsing fetchrecursesubmodules option
>  - use new config API for worktree configurations of submodules
>  - extract functions for submodule config set and lookup
>  - implement submodule config API for lookup of .gitmodules values
>
>  The gitmodules API accessed from the C code learned to cache stuff
>  lazily.

Will reroll today as part of a larger series.

> * mk/submodule-gitdir-path (2015-08-05) 2 commits
>  - path: implement common_dir handling in git_path_submodule()
>  - submodule refactor: use git_path_submodule() in add_submodule_odb()
>
>  The submodule code has been taught to work better with separate
>  work trees created via "git worktree add".
>
>  Waiting for a review.
>  ($gmane/275340).

I'll look into it.

>
> * sb/remove-get-pathspec (2015-08-03) 1 commit
>  - builtin/mv: remove get_pathspec()
>
>  Expecting a reroll.
>  ($gmane/275224)

IIRC the discussion turned out to expect a
full conversion of internal_copy_pathspec in builtin/mv
and not just moving all the cruft there, such that we can
make the deprecated function non public and update the
documentation.

So I am not going to spend more time on that series,
anyone is free to pick it up. So I guess dropping it for
now is ok.

>
>
> * sb/submodule-helper (2015-08-07) 1 commit
>  - submodule: implement `module_list` as a builtin helper
>
>  The beginning of "git submodule" rewritten in C.

This combined will be combined with hv/submodule-config

>
>
> * tb/complete-rebase-i-edit-todo (2015-08-05) 1 commit
>   (merged to 'next' on 2015-08-12 at 9606c21)
>  + completion: offer '--edit-todo' during interactive rebase
>
>  The command-line completion script (in contrib/) has been updated.
>
>  Will merge to 'master'.
>
>
> * dt/untracked-subdir (2015-08-07) 2 commits
>  - DONTMERGE: wait for Duy to Ack or comment
>  - untracked-cache: fix subdirectory handling
>
>  Waiting for a review cycle to conclude.
>  ($gmane/276019).
>
>
> * jk/test-with-x (2015-08-07) 2 commits
>   (merged to 'next' on 2015-08-12 at 06576a1)
>  + test-lib: disable trace when test is not verbose
>  + test-lib: turn off "-x" tracing during chain-lint check
>
>  Running tests with the "-x" option to make them verbose had some
>  unpleasant interactions with other features of the test suite.
>
>  Will merge to 'master'.
>
>
> * ad/cygwin-wants-rename (2015-08-07) 1 commit
>  - config.mak.uname: Cygwin needs OBJECT_CREATION_USES_RENAMES
>
>  Will hold.
>  ($gmane/275680).
>
>
> * ee/clean-remove-dirs (2015-08-11) 1 commit
>   (merged to 'next' on 2015-08-12 at fc41b09)
>  + t7300-clean: require POSIXPERM for chmod 0 test
>
>  Test updates for Windows.
>
>  Will merge to 'master'.
>
>
> * jc/finalize-temp-file (2015-08-10) 1 commit
>   (merged to 'next' on 2015-08-12 at 6fe62fe)
>  + sha1_file.c: rename move_temp_to_file() to finalize_object_file()
>
>  Long overdue micro clean-up.
>
>  Will merge to 'master'.
>
>
> * jk/git-path (2015-08-10) 16 commits
>   (merged to 'next' on 2015-08-12 at 7ebe864)
>  + memoize common git-path "constant" files
>  + get_repo_path: refactor path-allocation
>  + find_hook: keep our own static buffer
>  + refs.c: remove_empty_directories can take a strbuf
>  + refs.c: avoid git_path assignment in lock_ref_sha1_basic
>  + refs.c: avoid repeated git_path calls in rename_tmp_log
>  + refs.c: simplify strbufs in reflog setup and writing
>  + path.c: drop git_path_submodule

Oops, I just wanted to add a caller to git_path_submodule. I'll also look into
this series to see the alternatives. :)

>  + refs.c: remove extra git_path calls from read_loose_refs
>  + remote.c: drop extraneous local variable from migrate_file
>  + prefer mkpathdup to mkpath in assignments
>  + prefer git_pathdup to git_path in some possibly-dangerous cases
>  + add_to_alternates_file: don't add duplicate entries
>  + t5700: modernize style
>  + cache.h: complete set of git_path_submodule helpers
>  + cache.h: clarify documentation for git_path, et al
>
>  git_path() and mkpath() are handy helper functions but it is easy
>  to misuse, as the callers need to be careful to keep the number of
>  active results below 4.  Their uses have been reduced.
>
>  Will merge to 'master'.
>
