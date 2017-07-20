Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4702320288
	for <e@80x24.org>; Thu, 20 Jul 2017 05:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933957AbdGTFBn (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 01:01:43 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34926 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933916AbdGTFBl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 01:01:41 -0400
Received: by mail-pf0-f171.google.com with SMTP id e199so7872012pfh.2
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 22:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=r9G52olFj6LWim6MGDmIFHAQ0PnTn66irLsrgmXw8hM=;
        b=f7pYCLZv9ri5sknytEKT0TH9Vgf1x79yuX6Di0Ji87vo6WLj0/wcFkO5i/vj0LPYIH
         04UAY2VlC66fLyJTdplvG2eD5FLCdZK69QbeCcNzmyMundBIGu0wNDt4PwVXLK408KP5
         LXCEh1Eg4nq61FPhZZDZqwp+HaVB//RXhYKVd/HuNRiwrl86nJrLWpQmO7C5fdC5JxOc
         F1vlFiXgo4zCpmsvpxaGVFAD2LgPzQlnIxhMctWX361P367kz54YWWKKVZdgyo4eRZPH
         pdNfDe6fGoHurkVLdhdZ6Q3EwHqSf8G7BBwNcTZFWltbtIPveXfYtCnEGXD/luSGBA+d
         ea3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=r9G52olFj6LWim6MGDmIFHAQ0PnTn66irLsrgmXw8hM=;
        b=MpY5e712sA2WVbPw8ZfbkGx2CqzPj2wb3uU1FnmeHVbPnoWClnvsEyAB/WF4haXjiz
         0Atn9YacNAbleBpgaEumrYJXnOKwWEb61t2wVaZquA+EgjYzKnnWiHVF8LkEmKkBS9By
         +pfd4DzyuCy9bOdcgbHLzQaVyHDI+0MKUmzT0hUGahJAGKuIHv+uBRNmP/8B1eZtTYD+
         eE4i0bnbe+27eB7TN5xXmzv2bpypfnD41Rk+zzZBBet1wozRdK04nxzrnR+vUFg8MLBl
         8XfHhRjNTZJ5rgtBSrZf+PAlcTaO7UwNI4elR2Qjucnm1/Qss+uLkIswCdrr/dnom7in
         s/jw==
X-Gm-Message-State: AIVw110yQvXkat7ImyNlUowNf41blWxNmxLf8Hx6uS6sthFqsGIeA7mj
        wCBVWzOyzREAEhIMdbZooD/H4uM2HA==
X-Received: by 10.84.129.12 with SMTP id 12mr2807274plb.242.1500526900509;
 Wed, 19 Jul 2017 22:01:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.102 with HTTP; Wed, 19 Jul 2017 22:01:39 -0700 (PDT)
In-Reply-To: <CAO1QjAFGnK+riGT_ZffM_-=ymJm08U8adOfHV4wrhR9LJLhSAA@mail.gmail.com>
References: <CAO1QjAFGnK+riGT_ZffM_-=ymJm08U8adOfHV4wrhR9LJLhSAA@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 20 Jul 2017 07:01:39 +0200
Message-ID: <CAN0heSrzdfpH=ocQrC3SYLNF2K=agdKuRdscSPnnCgBMWhPRxg@mail.gmail.com>
Subject: Re: Bug Report - Segmentation Fault on "git add --all"
To:     Tillson Galloway <tillson.galloway@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20 July 2017 at 02:54, Tillson Galloway <tillson.galloway@gmail.com> wrote:
> Context:
> We currently have a git project with a root directory ("~/project")
> for pipelines and deployment of a Node app, and then a subdirectory
> ("~/project/project-app").
> After realizing that we didn't need the node app in a subdirectory, we
> moved the full app into the root directory (using the mv command).
>
[...]
>
> Running "git status" shows that git successfully tracked that the
> original files within ~/project/project-app were deleted, but it did
> not pick up the "newly created" files from moving.

So you did "mv project-app/* ." and see something like

  Changes not staged for commit:
    (use "git add/rm <file>..." to update what will be committed)
    (use "git checkout -- <file>..." to discard changes in working directory)

      deleted:    ... lots of files ...

? That means Git has *realized* that the files are gone, but it's not
*tracking* that fact (yet).

What if you restore the files and instead try "git mv project-app/*
."? It will move the files like "mv", but it will also do basically
what you wanted to achieve with "git add --all". After that, you'll
just have to "git commit".

You'll probably want to "rmdir project-app/" once it's empty. If you
have some structure like project-app/project-app/ the move might fail
(should be possible to work around).

This obviously doesn't address the problem you saw and on which I
cannot comment, but I hope it helps you do what you actually wanted to
do. :)

Martin
