Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A099E2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 19:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753182AbcISTuY (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 15:50:24 -0400
Received: from mail-yb0-f176.google.com ([209.85.213.176]:34330 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753080AbcISTuX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 15:50:23 -0400
Received: by mail-yb0-f176.google.com with SMTP id x93so94794629ybh.1
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 12:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qnGCyebajdjjnIaoKvCN/8FDtOllErwbJsCuHyEeCSY=;
        b=U63n0Dyj/Mrd0VYOZmdFqI6uc4CzwZ3xuK08CtcEAi2dT4b2RAT+pSHsy+v5t85m4m
         kqlDUoiQ4VPNQLnssDsp1gbGFaHr/i0FX7c7k4crSjWtIOh1Hzs+6XF1rpb2awqLEDsW
         BT6VxuZpBjlFKgL/1Mv3a05eCcwS6A7Q1bl40UKsv6Zhwo34lchg2Xvc8nL0447JyYur
         3J7v2pnJD4idqCWwomhWTX4TSWMDyqVV1re7zjS9WZrXtd52evgpfUj40pfWLnPP/+QN
         eLjbzTYLfVE5ys1Ba0y2f38VrLsuidKbWrcH1TkhklVE8ZhInXq8xZ6PbAYmzqTTSU5i
         eFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qnGCyebajdjjnIaoKvCN/8FDtOllErwbJsCuHyEeCSY=;
        b=FX56la+0F0YZo2F7/T40DdNFtDsOjzE5fUfVphfzOFAooJOMoVyYHlnSHAqz32Hj3X
         za3RRagehcajUzLhQXC/xXn/JCUIZPTQl/z7eLFJszf9p1si8ueN+YsFbX4cHVc02OeI
         hoCo1ICM1SuEERtmi2Om31SEoeZ2dKDFi7co6TLT7h4Z2i/OvgBOXjUqgr1GFB4u/c76
         pZJgLLeu9StmD3LefTjMhD5L+8GnGeZsZyLp4C35r2+BzMEpIFgOwBUysOYjGVbmCnL8
         nh5uTOBTA9/nfoFIsXUg9lJ8p4QpFt8+WpZFO0WbXv5nBcotfpaBxZ8d4UImadgCREJq
         kdEQ==
X-Gm-Message-State: AE9vXwNOpQY7eksFz1xApzcmCgZH5LSsVSB6UYbAEjAO0w+fWCxzfwHTbka6xTcGpBYanpf2HxdjlOiyQzNyFg==
X-Received: by 10.37.47.211 with SMTP id v202mr19206229ybv.194.1474314622961;
 Mon, 19 Sep 2016 12:50:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 19 Sep 2016 12:50:02 -0700 (PDT)
In-Reply-To: <YQXPR01MB0023CDCFA27BDD4959B4F9B19EF40@YQXPR01MB0023.CANPRD01.PROD.OUTLOOK.COM>
References: <YQXPR01MB0023CDCFA27BDD4959B4F9B19EF40@YQXPR01MB0023.CANPRD01.PROD.OUTLOOK.COM>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 19 Sep 2016 12:50:02 -0700
Message-ID: <CA+P7+xqR6i6eieVrEHXMNuVo6yfmRRZqX8RdVAE7y4=xSLLYyA@mail.gmail.com>
Subject: Re: Switching branches not working in a cloned repo
To:     Paul Williamson <paul.williamson@mediamiser.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2016 at 6:58 AM, Paul Williamson
<paul.williamson@mediamiser.com> wrote:
> Hi,
>
> We use git extensively on a number of repos. Recently, we have had a prob=
lem with one of them. This repo has a 'web_dev' branch. For copies of the r=
epo cloned before a certain (recent but unidentified) time, we could 'git c=
heckout' between master and web_dev and everything would be normal.
>
> However, now if we clone the repo, we can no longer do 'git checkout web_=
dev'. Git doesn't complain, in fact there is no feedback and we are still i=
n the master branch. Running 'git branch -r' still shows the branch as exis=
ting at origin.
>
> If we try 'git branch web_dev' we then see web_dev listed locally and can=
 switch to it BUT on closer inspection we realise that this action has crea=
ted a new branch off master.
>
> The first time we saw this was under Bash on Windows, so we thought maybe=
 it was a beta problem, but a) other repos work as expected under that envi=
ronment, and b) under cygwin, pulling the same repo to a new directory alon=
gside an older copy shows that the problem occurs with the new clone, but n=
ot the one that that was cloned longer ago.
>
> Also in this situation, there are no local outstanding code changes that =
might cause problems switching branches. This occurs right from a cleanly c=
loned repo.
>
> It seems something has gone wrong with this repo, and we don't know what.=
 It's a tough problem to google, and I was not able to search the gmane arc=
hives (DNS errors).
>
> Any idea how to investigate?
>

Try a fresh clone with "git checkout --track origin/web_dev" and then
a "git status -v" and let us know what happens. I suspect that older
clones have the correct branches already setup for tracking, but the
new clone isn't doing it automatically, so when you run git checkout
web_dev you're just creating a new local copy.

You can probably fix this by running

git checkout web_dev
git branch --set-upstream-to=3Dorigin/web_dev
git reset --hard origin/web_dev

The last command will completely reset your local web_dev to match
what's upstream, and the second command tells git that this branch
tracks a given remote branch.

Hope this helps.

Regards,
Jake

> Thanks,
> Paul
>
>
