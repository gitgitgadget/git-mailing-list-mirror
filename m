Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 543211F4F8
	for <e@80x24.org>; Sat,  8 Oct 2016 19:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751722AbcJHTzk (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Oct 2016 15:55:40 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33673 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750895AbcJHTzi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2016 15:55:38 -0400
Received: by mail-lf0-f50.google.com with SMTP id x79so62965051lff.0
        for <git@vger.kernel.org>; Sat, 08 Oct 2016 12:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=HcuQdp5NxTKsK8WAOzzeczwBWFeSW3LthUxSyQ7JAkw=;
        b=hMnZhY//fX2mUj3ZCEuzYSFc5ATJbCAkU+4qKHZHGEXbO+QcmnCzcY0vz5jVbSPJCO
         YtM/hpu2SOvFolbaRxX2MTZz0djiOKsICZbM18DsPw9jSg04tahyL+jCcchkIYbkxqOe
         Xqck8NkGuJLuAx2OPRq0yET9NZBaEGH1oekHy/OF8d5BzMRG4/6W61wSI7o1VZc4IEok
         7losbN5aIOjB1o5OgLRusVlrtLIKQrg/XysQvnTDE7gkwwNVIlP2bH6iVVD1AZF1r810
         VmJnfBS2KMjeK8ULyyVnnF+skekfAb4NT3rmkQUANuE6b0XCHuiTB7amkEMQ1DijwfWB
         NcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:content-transfer-encoding;
        bh=HcuQdp5NxTKsK8WAOzzeczwBWFeSW3LthUxSyQ7JAkw=;
        b=hoCOMhTxFdSjtVk94OgX2gJf/DnifAuvG56A8xyY3Tg0yAFUoZK1f//h9RGdaT3hB7
         3qztdp0K5nyQVZJpwUaecZMjD9eyZCDd3frfXxJ2L7R3dyaAaVCuQpyUePzd2Xz24QGw
         9u0T17fC46q+qWDa13IeCUHqpmTID0bHQG67u8Gnu1wYoY0c/K52lTOxW8/JG//96qzv
         1UAckeQtXhjwHwMJSq8JJd9cwGzenJpi6zfeRc2epelI9+WPMMIalYCnxzJlvAXfoKC4
         KcY/C4F6YeaQXseYsyuT211H3vgZsG0y0hpDiDFQvzih6cWo5v7CSFIBOx5WQjX4CECf
         5AYg==
X-Gm-Message-State: AA6/9Rnum5faVb2F06QsBZyUFJ5DecCR4BtEfK+CPZ9McNhe2TI85mofh71FtZ0im/m6SDcabN3grS3cemWlkw==
X-Received: by 10.46.5.130 with SMTP id 124mr10539444ljf.45.1475956536107;
 Sat, 08 Oct 2016 12:55:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.165.11 with HTTP; Sat, 8 Oct 2016 12:54:55 -0700 (PDT)
In-Reply-To: <CADKxhpe3S4L9CPV9yxh2yhrtJMa9wyZAPC45u_S=RiuzY1Xrkg@mail.gmail.com>
References: <CADKxhpe3S4L9CPV9yxh2yhrtJMa9wyZAPC45u_S=RiuzY1Xrkg@mail.gmail.com>
From:   =?UTF-8?Q?St=C3=A9phane_Klein?= <contact@stephane-klein.info>
Date:   Sat, 8 Oct 2016 21:54:55 +0200
X-Google-Sender-Auth: MOp59jB6ta14aOr49vrWHZqu8Uk
Message-ID: <CADKxhpcKOX4RkpbkA8t_6MUh3DttPgwA-YquMkuHkS3C2FR6xg@mail.gmail.com>
Subject: Re: Feature request: use relative path in worktree config files
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've write a small tool in Golang to fix this issue:
https://github.com/harobed/fix-git-worktree

2016-10-08 11:35 GMT+02:00 St=C3=A9phane Klein <contact@stephane-klein.info=
>:
> Hi,
>
> "git worktree add" write absolute path in ".git/gitdir"
>
> The code source is here
> https://git.kernel.org/cgit/git/git.git/tree/builtin/worktree.c?h=3Dv2.10=
.1#n256
>
> Is it possible to use relative path in this config files:
>
> * [main_worktree]/.git/worktrees/[worktree_foobar]/gitdir
> * [worktree_foobar]/.git
>
> Why:
>
> 1. I configure worktree on my host
> 2. next I use this git working copy in Docker with volume share
> 3. next I've some git error in Docker because config files use absolute p=
ath
>
> Best regards,
> St=C3=A9phane
> --
> St=C3=A9phane Klein <contact@stephane-klein.info>
> blog: http://stephane-klein.info
> cv : http://cv.stephane-klein.info
> Twitter: http://twitter.com/klein_stephane



--=20
St=C3=A9phane Klein <contact@stephane-klein.info>
blog: http://stephane-klein.info
cv : http://cv.stephane-klein.info
Twitter: http://twitter.com/klein_stephane
