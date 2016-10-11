Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73D2A1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 13:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751593AbcJKN5D (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 09:57:03 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33724 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752097AbcJKN5C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 09:57:02 -0400
Received: by mail-qk0-f182.google.com with SMTP id n189so35441646qke.0
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 06:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZnhgzKB5IOoXeJ4bNS339D2MJnbZug7JKj1wKxLg9YU=;
        b=rbn6iE0lBZFYmQN1Lxw9YTsADYdjX5SzJ07IGtUVhrkFXOMnvcJQIIATvR95xC3S/R
         tI6xhGAvyS0ft5WfCGgI0EforQ9oOefOvK5CUsu8iiOkTKQRK8XTMO2yV89IBRa7D5FM
         ocxoo08+bLeVBtGwmT4dYz4UOtzpc1LJLRflo8QyjuoW5lOLnDkGEKoZdAGNSBwfyhS0
         xkYlhG9jWaUJK+Xf1b+05YoHkPBN7WLmp+8C5iQGeDweCwySq9wE0s0iAgnkpT8lpwfi
         jXQN+UrNM3G3qHILkgGdZsdNrJDnyiw2n4wOOrRlCULk6TacMKfW6C9X7ttjcRYfsIfX
         LKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZnhgzKB5IOoXeJ4bNS339D2MJnbZug7JKj1wKxLg9YU=;
        b=JUmAaj9ydZscHTvspvYhpS6gGeNmS9Dgij5cVL1Rh6VM2TICcug/IkSzhCxrsrgIOe
         VqrFp183jJ5pNHJsmZg/mN4rP4syt8VH34JyXpbLf67UyJV3IVML9OxpLtSlV6eRCgQQ
         QauedtPQKPbRwoD1ZR0nJHLyzhyFo9ffQ66Gd/6xRoOc7IloL8nMWTdWNLIcew/i7lP+
         7Fdb1OdGh5tPHnDzvji8HaL782s1V3S5Y/KKglrEVB2o63kue22oqbd/3qPktqZDHwJc
         /aTML0q701eDDNBsRZqiogzJdqEOb7P0mWuqYWYIXLaK++cicPAvy8ZEcn0x3C0WHHs9
         Crhw==
X-Gm-Message-State: AA6/9RmGuWG0zR2uzHY9ce6q0ZUEy+1iUCnE2iacKHlB09gQrT9oqYXYZmxS64f/3hFFysNXd6YOiesyVLy9uw==
X-Received: by 10.194.0.205 with SMTP id 13mr5052079wjg.87.1476194199902; Tue,
 11 Oct 2016 06:56:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.236.135 with HTTP; Tue, 11 Oct 2016 06:56:39 -0700 (PDT)
In-Reply-To: <20161010181907.bqekupn6npuimbir@sigill.intra.peff.net>
References: <CAN40BKqPdPP2+K4FBzgDDfYiGkzk1gYcOeP==_t+pr5w0rj0EQ@mail.gmail.com>
 <20161010153032.v2x773cbs4ifvzec@sigill.intra.peff.net> <CAN40BKoWroM4ZJHHdMvO8YvvCho0FnWzV9BG9E5xnCZbYOO2pg@mail.gmail.com>
 <20161010181907.bqekupn6npuimbir@sigill.intra.peff.net>
From:   Seaders Oloinsigh <seaders69@gmail.com>
Date:   Tue, 11 Oct 2016 14:56:39 +0100
Message-ID: <CAN40BKoHGHWrNyTg3h=VJdBtzpQbWXbc1F+2j+mrPgPC7uUmMQ@mail.gmail.com>
Subject: Re: git filter-branch --subdirectory-filter not working as expected,
 history of other folders is preserved
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 7:19 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 10, 2016 at 05:12:25PM +0100, Seaders Oloinsigh wrote:
>
>> Due to the structure of this repo, it looks like there are some
>> branches that never had anything to do with the android/ subdirectory,
>> so they're not getting wiped out.  My branch is in a better state to
>> how I want it, but still, if I run your suggestion,
>> [...]
>
> Hmm. Yeah, I think this is an artifact of the way that filter-branch
> works with pathspec limiting. It keeps a mapping of commits that it has
> rewritten (including ones that were rewritten only because their
> ancestors were), and realizes that a branch ref needs updated when the
> commit it points to was rewritten.
>
> But if we don't touch _any_ commits in the history reachable from a
> branch (because they didn't even show up in our pathspec-limited
> rev-list), then it doesn't realize we touched the branch's history at
> all.
>
> I agree that the right outcome is for it to delete those branches
> entirely. I suspect the fix would be pretty tricky, though.
>
> In the meantime, I think you can work around it by either:
>
>   1. Make a pass beforehand for refs that do not touch your desired
>      paths at all, like:
>
>        path=android ;# or whatever
>        git for-each-ref --format='%(refname)' |
>        while read ref; do
>          if test "$(git rev-list --count "$ref" -- "$path")" = 0; then
>            echo "delete $ref"
>          fi
>        done |
>        git update-ref --stdin
>
>      and then filter what's left:
>
>        git filter-branch --subdirectory-filter $path -- --all

This is the perfect solution for me.  Going through the delete
branches runthrough also quickened the filter-branch command, and I'm
left with a much more complete version of where I want to be.

I would still contend that the filter-branch either doesn't work as
expected, or the docs need updating to provide extra steps like you've
done, because when dealing with a large repo like we have, running
multiple filter-branch commands, trying different combinations is
quite a time sync, when you're left with the same incorrect solution
again and again.

>
> or
>
>   2. Do the filter-branch, and because you know you specified --all and
>      that your filters would touch all histories, any ref which _wasn't_
>      touched can be deleted. That list is anything which didn't get a
>      backup entry in refs/original. So something like:
>
>        git for-each-ref --format='%(refname)' |
>        perl -lne 'print $1 if m{^refs/original/(.*)}' >backups
>
>        git for-each-ref --format='%(refname)' |
>        grep -v ^refs/original >refs
>
>        comm -23 refs backups |
>        sed "s/^/delete /" |
>        git update-ref --stdin
>
> -Peff
