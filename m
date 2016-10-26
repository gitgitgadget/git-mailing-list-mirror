Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6618D20193
	for <e@80x24.org>; Wed, 26 Oct 2016 09:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757705AbcJZJcv (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 05:32:51 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:35643 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757303AbcJZJcu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 05:32:50 -0400
Received: by mail-it0-f49.google.com with SMTP id e187so15933271itc.0
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 02:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Rl3X8S6b24H/DOc3Ij+nzskfwzsosOs/H3+vAY4oaGs=;
        b=RS0GegDQF7IdZ09KBU2fYgvh3K4GACQ7BNPlxezihET6KGvFQ2ihJss4DmplHZ808c
         baK+ola8INycXBFWrhqUKBswdp0pwlXIiVpQ2M4kr5m48W407l/N81jTSNmgo2ax+8IB
         BRnWg/mCRtctU3g/qf9giYoDLsxRTkzTcYhCyJf3G2u48MyZOAGjPxt5o5oSNUf6yj9E
         AGEGER71e6cOFlWHH3ieVFqjI4bo1rv+rMbVz7/lGbJtVKhLmC9BmerpkK6F4JivyJE0
         Zu8Misz/iJytZylv5y2Nh5wnAopReVlsrk/Oumiel6wYtOKjr6k1FtcREb9Kox05mk3y
         j2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Rl3X8S6b24H/DOc3Ij+nzskfwzsosOs/H3+vAY4oaGs=;
        b=EPFxSwBTKXEE7e74E1+r8qVfT2JWI1G1m5FmlFRtlAVZY7c9yKsNECVeNlbvdsIhSm
         8p1L+885ptaU/qv+xUyMk4ytn8uAif218ZU8DXML4bLL2AYpTn6ySh8nUdkQyKCs2yfr
         ZiE4W+ad2pkcApN6oE3LeUyx6CJTY3OduQIzjiBuGmZRs+JkM7IrsHSjTZGCZiNXSW1H
         H/cGiqK3+QUvO1S3BKcYXa7Eh5V30RFkq1wmtaYPSHlhVzCimy/LujolebDBEZJcnVK3
         kUs553/GGtb2Z+Gp22U2MhuoQSlQyILNzfLABvbXfebvqQ+Oca3brnku5gcLs3vC1z1G
         fEoQ==
X-Gm-Message-State: ABUngve1OktePczO/IKKkapTOYzFTS1Xei2bjyT1VIqPT2InejH0FlwLt53JjIu/rHpydBvuUwAGB7EvLyOorQ==
X-Received: by 10.36.103.201 with SMTP id u192mr1289313itc.3.1477474365344;
 Wed, 26 Oct 2016 02:32:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Wed, 26 Oct 2016 02:32:14 -0700 (PDT)
In-Reply-To: <xmqqmvhsc8kn.fsf@gitster.mtv.corp.google.com>
References: <xmqqa8dttkbw.fsf@gitster.mtv.corp.google.com> <CACsJy8B-GcMNv7pYYLpaUXc2kKnvyYEYm6w=fiaHy7rt4aug1Q@mail.gmail.com>
 <CACsJy8D4cT2EV_t6=+XTHxLmjV+NtAE+KgiN3ZiP7JQzvu29oQ@mail.gmail.com> <xmqqmvhsc8kn.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 26 Oct 2016 16:32:14 +0700
Message-ID: <CACsJy8Dn7m2axEFkkQtnZMs2yzFwivAJyZCWxODg-HQ=qLnVMA@mail.gmail.com>
Subject: Re: [PATCH] reset: --unmerge
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2016 at 6:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Somebody with a bright idea decided that vc-git-resolve-conflicts
> variable should be on by default in Emacs 25.1 X-<,

Oh good, I have an excuse to stick to 24.5.1 for a while longer then.

>  which causes
> "save" after resolving conflicts to automatically run "git add", to
> destroy this valuable tool.  My knee-jerk reaction, of course, to
> such a default is "that's brain dead", but perhaps they did so for
> some good reason that I fail to fathom.

I was curious. The default is t since the variable's introduction [1].
Interestingly the thread/bug that resulted in that commit started with
"report this bug to git" [2]. Something about git-stash. I quote the
original mail here in case anyone wants to look into it (not sure if
it's actually reported here before, I don't pay much attention to
git-stash mails)

-- 8< --
Bad news, everyone!

When a stash contains changes for several files, and "stash pop"
encounters conflicts only in some of them, the rest of the files are
stages automatically.

At least, that happens with Git 2.1.0 on my machine, and some
commenters here: http://stackoverflow.com/a/1237337/615245

So then when we unstage the files which had conflicts after resolving
those, the result is mixed. Which doesn't look right.

What shall we do? Unstage the automatically-staged files? Revert the
changes from this bug? It seems Git really wants the changes staged
after the conflict resolution.
-- 8< --

[1] http://git.savannah.gnu.org/cgit/emacs.git/commit/?id=45651154473c7d2f16230da765d034ecfde7968a
[2] https://lists.gnu.org/archive/html/bug-gnu-emacs/2015-05/msg00433.html
-- 
Duy
