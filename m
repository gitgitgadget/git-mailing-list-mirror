Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78A4A1F600
	for <e@80x24.org>; Sun, 23 Jul 2017 12:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbdGWMmk (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 08:42:40 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:36875 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbdGWMmj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 08:42:39 -0400
Received: by mail-it0-f45.google.com with SMTP id v127so24157416itd.0
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 05:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ez2Qtbh6yg1j3dVg05qVxMi+dE3KPRCmZm+3WjJrRhg=;
        b=KqKLJft3mlhaMHZWc+wQxunEJMGCbZedu63/a+whflp+C4PUph/bkCS01IH8eO4fUw
         MW7I32kOKkTAT+jDnmzHTPIac1aelAwAAvZh6M5n7yXTmYMtY3h1atBtMZxdyHIQNBcu
         WyPQ9S1s22w0ZqyqR3+kozhEycaRHocM8mcmcrHABdOaQnK3XvrH6sW0plQwLVO6TP5t
         9zrdEK3n27pNYrEqWyvlTEVJ5jb0grjjONRn2X+Q5cLNGN9Q0Om0LRXKYT4pv6KCwFZ7
         NWkkxDdNlIFm4pu65CAytP+t6vsuoUnC+USVkfYkLeeaRg64PVFvPNEUUvys/lQguEIh
         yQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ez2Qtbh6yg1j3dVg05qVxMi+dE3KPRCmZm+3WjJrRhg=;
        b=l6kQXsk+6xMgZqroroWoVorVcpABSkOsDCDZWlF63tFo0LzYBUUwH0H2qczn8sLMUn
         prOMmFPIvRcX9b79LJrtDMawMEvuqzT4HmUUxU8feIw6blbdJE9bsg8QeCebUHNc5pK8
         RA7T07uIa0U23CPMfBykDe1yVCDEfRgF3qHphDg1e4qoP1IWFV1o7hR5ZgvmAvrVpnBm
         KZPq43N1msNCxqjMzZvlpYnMjCYUwlx5xUwiKNlqtdB+hgJJXSqJ1KQGzXazirmj1Hxj
         2AwINPRHP494+XQEM7POPZ0o2o6Rt8ErhhH9nRcJZOHei0h+57rg4DaB2E2Mei6liflg
         C+vA==
X-Gm-Message-State: AIVw111Sg6sOhotUtqzHm6Q5IIjwP7IJ+VkG8ACG2huVHxRtNfS62cvk
        AWKa55ZQDECG5aXlyGf8r9X4f6TwnD8Iisw=
X-Received: by 10.36.206.196 with SMTP id v187mr4401974itg.44.1500813758652;
 Sun, 23 Jul 2017 05:42:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.200.71 with HTTP; Sun, 23 Jul 2017 05:42:18 -0700 (PDT)
In-Reply-To: <241D60E0-1687-4DD8-A18C-CF7310DBFAEB@jetbrains.com>
References: <241D60E0-1687-4DD8-A18C-CF7310DBFAEB@jetbrains.com>
From:   Alexei Lozovsky <a.lozovsky@gmail.com>
Date:   Sun, 23 Jul 2017 15:42:18 +0300
Message-ID: <CALhvvbbud3oTTyzErQVumgUcdSPCcfGV4D31c66-J7P-jneqbQ@mail.gmail.com>
Subject: Re: Remove help advice text from git editors for interactive rebase
 and reword
To:     Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23 July 2017 at 13:03, Kirill Likhodedov wrote:
> Hello,
>
> is it possible to remove the helping text which appears at the bottom
> of the Git interactive rebase editor (the one with the list of
> instructions)

I believe currently there is not way to do it. The interactive rebase
is implemented in git-rebase--interactive.sh which always makes a call
to append_todo_help to append the help text to the todo list of commits.

> and the one which appears at the bottom of the commit editor (which
> appears on rewording a commit or squashing commits)?

This one too seems to be hardcoded in builtin/commit.c.

> I can parse and strip out the help pages (but it is not very reliable
> since the text may change in future)

I doubt the syntax of the interactive rebase todo list will ever change,
so you can reliably remove all lines that are empty or start with the
$(git config --get core.commentchar) or '#' if that's empty or 'auto'.

However, it's harder with the commit messages during --amend as the
comment character is not really fixed and can be dynamically selected
to not conflict with the characters used in the commit message if the
core.commentchar is set to 'auto'.

> However I suppose that experienced command line users could also
> benefit from such configuration, since this helping text is intended
> only for newbies and is more like a noise for advanced users.

Well, the text is appended to the todo list of commits, so not that it
gets too much in the way of editing the list by humans.
