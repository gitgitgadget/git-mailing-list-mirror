Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F33AD1FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 18:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753263AbdC1S5J (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 14:57:09 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33698 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752653AbdC1S5I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 14:57:08 -0400
Received: by mail-pg0-f48.google.com with SMTP id n5so73254735pgh.0
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 11:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qM+OqzvB+AiqgyPDJtcZlM5tAh/xHRzD5qhY8WvY2eY=;
        b=pqItrIdmZWg+kQihdQPJKP7Jq3COM2bX3fSZEIaE2/LfElADtxN0uHu7xmPdPa7V3h
         xR/icU19jUZ6qAyka0ui/RCEmPbgHpRVLR0O0RbtYtBam72SPuBotqyEyHc+hO7Ry4zp
         bm21CQIiQ9CSrOnREaieI1vykEzoEeiYNZRprXt7RtCp5srQZcahYxdH0M4sFTsFKje1
         v1T2rkIuCNnXKf3kn9bfvgpR+xeF2w9fG1jP9mXVRhasue7ODrC2ymTjo+3L3XTyGl86
         swXnWDZlpO5nlNRiffM4kZ5GpfMyS4vs2BwlHWA02FWJUP7fiy3tgl5aBmTA+xD7TBoF
         k5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qM+OqzvB+AiqgyPDJtcZlM5tAh/xHRzD5qhY8WvY2eY=;
        b=qKZCX7N16mP0XBE5sit1XIuiXH7kD2/jnwbBaJc1uqg0xyb+LMSiuLAfM07cRwZFBk
         AqWsQEiNpdv0+AF6KcNo0ewWgIdvF3dXGSfOjLSK2hhgZ2XupD3nnTIZkuICEovQPXJI
         ONQye/2mQl+dW0F7G96Jm8Wmij4Dx6p4mq7H4zWwHi4WkMs/GVW/IDqn1P6bL4k5Erm4
         cZKTzWgA6Uke9NJxCfTkxi5yh4R+YOgMekNaqPhsL1qvUS95anJqSA+QIfGAxhFhsG8N
         vUNG0O4IkouDB5KWsn8kgWFZxOV4/QrgfaXvq1H7GhGv+BQsOFBtdCrM2zO88b8IOhDK
         6yRw==
X-Gm-Message-State: AFeK/H3CdG9NkPqhIuLAC3WQEGADByEzeqdiA9jZsDC5Hn8Kq3YM3sYUODWdtWwjIRPT5d53ZulagS8lqKVhzi7V
X-Received: by 10.98.97.7 with SMTP id v7mr25529144pfb.161.1490727426867; Tue,
 28 Mar 2017 11:57:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Tue, 28 Mar 2017 11:57:06 -0700 (PDT)
In-Reply-To: <xmqqshlxckr2.fsf@gitster.mtv.corp.google.com>
References: <xmqqshlxckr2.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 28 Mar 2017 11:57:06 -0700
Message-ID: <CAGZ79kaxyQUsZvkEGLseLFoWJtdWQ9V8nY9kjUW_4BAmx68eoA@mail.gmail.com>
Subject: Re: [RFC] should these two topics graduate to 'master' soon?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2017 at 11:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> There are two topics that are marked as "Will cook in 'next'" for
> practically forever in the "What's cooking" reports.  The world may
> have become ready for one or both of them, in which case we should
> do the merge not too late in the cycle.
>
> * jc/merge-drop-old-syntax (2015-04-29) 1 commit
>
>   This topic stops "git merge <message> HEAD <commit>" syntax that
>   has been deprecated since October 2007 (and we have issued a
>   warning message since around v2.5.0 when the ancient syntax was
>   used).

git-gui has:
82fbd8a (git-gui: maintain backwards compatibility for merge syntax, 2016-10-04)
which was the only blocker IIUC.
So this looks good to me.

>
> * jk/no-looking-at-dotgit-outside-repo-final (2016-10-26) 1 commit
>
>   This is the endgame of the topic to avoid blindly falling back to
>   ".git" when the setup sequence said we are _not_ in Git repository.
>   A corner case that happens to work right now may be broken by a call
>   to die("BUG").
>
> I am leaning toward including the former in the upcoming release,
> whose -rc0 is tentatively scheduled to happen on Apr 20th.  I think
> the rest of the system is also ready for the latter (back when we
> merged it to 'next' and started cooking, there were still a few
> codepaths that triggered its die(), which have been fixed).

Just read through the commit messages of that branch and they
look reasonable, but I refrain from having an opinion here.

Thanks,
Stefan
