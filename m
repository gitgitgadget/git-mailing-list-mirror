Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8845208DB
	for <e@80x24.org>; Wed, 30 Aug 2017 18:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752217AbdH3SHl (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 14:07:41 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34288 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbdH3SHk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 14:07:40 -0400
Received: by mail-pf0-f173.google.com with SMTP id l87so11549641pfj.1
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 11:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3sPu3AJ6U5rXD+nEiSbDKj8KxPoG65Ulltshw5gihQg=;
        b=X62Zh1ZDyo5h4koTIeGHhSanNnxIy8e793DFvNQc7mxI7xJFfkL8E5XBz99GpdTXTl
         xvt/gutRkbYCEVGtklJMd6s1hljpYIW7EbOXTSyZIx80cmpBrMY1FWtFxjddBTAGIlyA
         hi/k5TVOhd7ltE/wC/svjqAABYC+iVjHPHnQeFHZb07mvT3yQIhqkjmZ5qWfikdOG1gg
         mRWbXxDPHcb6OKqo+mcihgOGPUMT25+EWt5+Wecw02OW8cYLibEatkFlXPGdf3JeqEXn
         f7dvwzosTs0VyEvqkB5pOwwZQi9OhEdwYPYMCZV+YaGoimZgTlV4Aw9S1O8oXx3ODRYK
         R9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3sPu3AJ6U5rXD+nEiSbDKj8KxPoG65Ulltshw5gihQg=;
        b=mXYbog2xSp5h4+1MNlCZ0AXlbaI1h9YV6eHwZvcCUnHyc07IxAPL0Ck0yl549VoAGJ
         umBZb3S8Lb8+sWJrhMbVji2sBjtLUp7BVLzRJcz0Hypx1jkTTQzmc2P59P0CyrMj5yAk
         +JJk15jhCiwfUS4S2nqF2cOd+JzDwfID/bGLa0TrqoG9DeKP32nR7tQr1r9Bj0AhJhX4
         89wQzvOxyf2AvzeZhlbpcnZL8WYGU9EpuDYBGpM5afMVrdnmL3oXYF8mae5derzMGYpg
         abpU9+P5MWk3LjxZXPG868kfeMdcCiVqDPlF2ZIk34a+y5SMQSWW/mLgmsKQYpPH73Yi
         LDKg==
X-Gm-Message-State: AHYfb5gMvurJzIvIWFvlmA/b9ebU4lRKxKpFEY1ig5bi3oqUatH0ds6Z
        Y2lC1gaMEETdeDu3Oo0O7nL/gT/8IA==
X-Received: by 10.98.111.136 with SMTP id k130mr2438352pfc.122.1504116459788;
 Wed, 30 Aug 2017 11:07:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.182.197 with HTTP; Wed, 30 Aug 2017 11:07:39 -0700 (PDT)
In-Reply-To: <oo62vr$pvq$1@blaine.gmane.org>
References: <oo62vr$pvq$1@blaine.gmane.org>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 30 Aug 2017 20:07:39 +0200
Message-ID: <CAN0heSqGfxrFTwuaxgppZTx+3U=g_Qs4PyaCBF6ddV_PbvdpTQ@mail.gmail.com>
Subject: Re: Commit dropped when swapping commits with rebase -i -p
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30 August 2017 at 12:11, Sebastian Schuberth <sschuberth@gmail.com> wrot=
e:
> Hi,
>
> I believe stumbled upon a nasty bug in Git: It looks like a commits gets =
dropped during interactive rebase when asking to preserve merges. Steps:
>
> $ git clone -b git-bug --single-branch https://github.com/heremaps/scanco=
de-toolkit.git
> $ git rebase -i -p HEAD~2
> # In the editor, swap the order of the two (non-merge) commits.
> $ git diff origin/git-bug
>
> The last command will show a non-empty diff which looks as if the "Do not=
 shadow the os package with a variable name" commit has been dropped, and i=
ndeed "git log" confirms this. The commit should not get dropped, and it do=
es not if just using "git rebase -i -p HEAD~2" (without "-p").
>
> I'm observing this with Git 2.14.1 on Linux.

The man-page for git rebase says that combining -p with -i is "generally
not a good idea unless you know what you are doing (see BUGS below)".

Under BUGS, it says

"The todo list presented by --preserve-merges --interactive does not
represent the topology of the revision graph. Editing commits and
rewording their commit messages should work fine, but attempts to
reorder commits tend to produce counterintuitive results."

So if you agree that a "dropped commit" is a "counterintuitive result",
this is known and documented. Maybe the warning could be harsher, but it
does say "unless you know what you are doing".

Martin
