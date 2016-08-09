Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9511B1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 18:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbcHISwH (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 14:52:07 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:35022 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932207AbcHISwG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 14:52:06 -0400
Received: by mail-io0-f180.google.com with SMTP id m101so20256883ioi.2
        for <git@vger.kernel.org>; Tue, 09 Aug 2016 11:52:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aZMvIUBUTycziRHhnBImZ/zlokvHGeL/+X0FwQZ93aQ=;
        b=0xW5s69cT3wI+ptJwz9X+lq+jRbf9ei5CtJc+w4VTPKMuOIyoGR6b9qNIvdzeOPtHB
         I5IpqfsAUkEIU/yQ75g3UtnkEKMJiu7ANUIdcLt/arFmplesinMkElmaGNiB9a/U24kf
         mVAI/iN/xwNM14PNq/ccMSmE6GV+QOQoR86QdR9oaMy4FjELXDgUKajqRXVZA2LCw5Q2
         5M5Z8io4zaD6zDYt1WmrlP+toEOFA13wYVvmroRo4bHjuLyGTsC9AtlwEd8Zvp6fbGvG
         yFFned5AmYtnSpdBlDRvPkMVjFKV2rx1SEJwgWYXFI91yvkRwcaW6b9RSdRqC30axGY+
         HIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aZMvIUBUTycziRHhnBImZ/zlokvHGeL/+X0FwQZ93aQ=;
        b=dtxyY8c2FBtUUh2NIByuhKH95tQtR4a8XDx+ASc86+xaU7fIV4/rXdLWGcGlbQNjpb
         aPZUot7iKPbxbCBSWTRvqqrgH6m2Yvg5yqOq5kznO6SXdF4udClOQIBxpowErw6YkBBa
         QOR2jNIcUAmT6xFK/A4DPaAtMHmuXcBT1HDGX7sUK8CLvbgZY34SIdTMGdqOPyqxStWO
         4q3lirzipdVsIECXFYyiWoYwQfsIDhhBFvqLfIE9k0m/aTRViN1/TqksIQZ5ogZ4g516
         0KwXu+fvYxAOrXtefNwAOYov04AYZqkbwzI0YbBg4kchA0V9QDcCCaXmxxbrdfWQAjQL
         ONNQ==
X-Gm-Message-State: AEkoouuxC/R80xK2u1r35WZv6jymY6k7aPkUV5a+f2nhDnd0vt9J+pHiWhtoP8gFV/w0hTzehgeI5G8KkFA+nQ==
X-Received: by 10.107.131.170 with SMTP id n42mr676170ioi.126.1470768725730;
 Tue, 09 Aug 2016 11:52:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.128.97 with HTTP; Tue, 9 Aug 2016 11:52:05 -0700 (PDT)
In-Reply-To: <xmqqwpjqdh7w.fsf@gitster.mtv.corp.google.com>
References: <xmqqwpjqdh7w.fsf@gitster.mtv.corp.google.com>
From:	Elijah Newren <newren@gmail.com>
Date:	Tue, 9 Aug 2016 11:52:05 -0700
Message-ID: <CABPp-BEqRFid1_2_B+Q_FyVN3KeApV3pknG7FrfaMUoyY6WJGg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2016, #03; Mon, 8)
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

On Mon, Aug 8, 2016 at 3:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> * js/am-3-merge-recursive-direct (2016-08-01) 16 commits
>   (merged to 'next' on 2016-08-05 at dc1c9bb)
>  + merge-recursive: flush output buffer even when erroring out
>  + merge_trees(): ensure that the callers release output buffer
>  + merge-recursive: offer an option to retain the output in 'obuf'
>  + merge-recursive: write the commit title in one go
>  + merge-recursive: flush output buffer before printing error messages
>  + am -3: use merge_recursive() directly again
>  + merge-recursive: switch to returning errors instead of dying
>  + merge-recursive: handle return values indicating errors
>  + merge-recursive: allow write_tree_from_memory() to error out
>  + merge-recursive: avoid returning a wholesale struct
>  + merge_recursive: abort properly upon errors
>  + prepare the builtins for a libified merge_recursive()
>  + merge-recursive: clarify code in was_tracked()
>  + die(_("BUG")): avoid translating bug messages
>  + die("bug"): report bugs consistently
>  + t5520: verify that `pull --rebase` shows the helpful advice when failing
>
>  "git am -3" calls "git merge-recursive" when it needs to fall back
>  to a three-way merge; this call has been turned into an internal
>  subroutine call instead of spawning a separate subprocess.
>
>  Will merge to 'master'.
>
>  Eyes from other people are highly appreciated, as my eyes (and the
>  original author's, too) have rotten by staring many rerolls of the
>  same topic and are not effective in spotting errors.

I gave it a whirl and read over all these patches.  I read them first
trying to see if there was any difference in behavior for cases where
the old code wouldn't hit a die().  As far as I can tell, the only
place that could change the non-die() paths was the early return added
when a filed couldn't be removed in remove_file_from_cache (inside the
handle_change_delete() function):

-               remove_file_from_cache(path);
-               update_file(o, 0, o_oid, o_mode, renamed ? renamed : path);
+               ret = remove_file_from_cache(path);
+               if (!ret)
+                       ret = update_file(o, 0, o_oid, o_mode,
+                                         renamed ? renamed : path);

However, remove_file_from_cache() unconditionally returns 0 and
appears to have done so since it was introduced in 2005.  That seems a
bit odd (Is the function just buggy?  Should it be transformed into a
void function to make it clear that there's no point checking return
values?)  Anyway, even if remove_file_from_cache() was modified to
return a nonzero result when its argument wasn't already in the index,
I believe that wouldn't matter here because path must be in the index
in order to reach this point of the code (if it somehow wasn't in the
index, that probably would have been a die()-worthy condition in the
old code that we just didn't bother checking for).

After my reading, I'm fairly confident that things that worked before
without hitting a die() should have the same behavior after this set
of patches (modulo the intentional changes like output buffering).

I then re-read in another pass for when the code would have hit a
die() previously, and in all those cases Johannes is returning as
early as possible and avoiding falling through to subsequent code,
which is probably the most reasonable thing to do.  There might be a
few cases where a few extra steps could be taken, but it's safer to
just return early.

So, I think the series looks good.  Sorry that I didn't spot any errors.

Elijah
