Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EF5E20A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 07:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbeLGHHO (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 02:07:14 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:35185 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeLGHHN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 02:07:13 -0500
Received: by mail-qt1-f176.google.com with SMTP id v11so3459766qtc.2
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 23:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IzLwQ34lDrjxm6p4y4w/rc8ksoZL6n2lJJT6GKqTpdg=;
        b=S9OCxRczkoykotQkJ47X0uwtjc9GuTct4FSa503cCJaU8E860HCml9/bV09ExFp1ZW
         gmsstYTRpP3BimjrtORj6WN8Pknk1jfTCO9BvJaaqgv1Yj2uWhNvjHP68u7xXkGMEzog
         p5vSBBiXm1wW11F7U1AFbT5eGMqmUuJb1jMwLKHywyxG3C+u06cugkuAYzgBGzI2/9wy
         gl6UFwPCEMC1FVbZEG9aO3zbspt4AByimdiu0QLlTZ/fYVUIlGx6rtNBN8q7Mf7mg2Zi
         lPSVhcU4nzHzNfQRT2/WuSK+sYgIXAS1goqm2QoiNjkurJzMTzjF8ThKCQt1hBYDtsj5
         TyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IzLwQ34lDrjxm6p4y4w/rc8ksoZL6n2lJJT6GKqTpdg=;
        b=YRs8uAMczrjcZcvwo7sIDqBCLr5DWT6iByka1rfSRlcK59DagwN7VJKNG8QwN8Za5B
         RYs8ArRLiOHk077a+xE0Ij+XxRapSXHMEpJW0Rs2FPSzy8jqDWleOxIw5JJPPfaYX/MV
         AmT7RIN8iZhEg+ddI8bVXwPby6pGw/q4iTuI6t7V/oATKA52VHB91KXn9cK3/XWLLvGO
         TRLK1vvzDfNQuEui+CNojvXsXfQKXGb8GORGTR5m9ZkD4FsGW/fZJf2QjaqgCP698mAI
         eieqo17Ea+aLRNn1plVqvVm7ZOXvs9xpEoEMCxgUb1o10MXx/ZR2LZgGekqncFKIi/vd
         R05Q==
X-Gm-Message-State: AA+aEWZrS0WWX6Q6YaSIJAvnhjJNLwA78KrwfWi2Lx9Y8dhYpYzUfU4T
        JsUtedvYjmAowOzW3MGauQvZhEZrZHbje8IIIQ==
X-Google-Smtp-Source: AFSGD/UHDGXvqa7uOzPgd7dBBeEqjMyFPFFdEmHKW9TT3AKdXCHqrQefRN+gXhguW35Qbo/j7RFYtm399o1dzb7ZIHA=
X-Received: by 2002:a0c:b02c:: with SMTP id k41mr904536qvc.154.1544166431848;
 Thu, 06 Dec 2018 23:07:11 -0800 (PST)
MIME-Version: 1.0
References: <CADHAf1Y_d=-9By4jC2xd+BmWJgfGmBNUr=uSuQtfuHDrarN4kw@mail.gmail.com>
 <CAGyf7-FUHMEq_FfPNrH6uT2b-nCd_wi=Aww+OUuoDem11DROGA@mail.gmail.com>
In-Reply-To: <CAGyf7-FUHMEq_FfPNrH6uT2b-nCd_wi=Aww+OUuoDem11DROGA@mail.gmail.com>
From:   biswaranjan panda <biswaranjan.nitrkl@gmail.com>
Date:   Thu, 6 Dec 2018 23:07:00 -0800
Message-ID: <CADHAf1Y8or_frf=Ecu-82z-jo06NKe7oqo1cxtsZsOxhKKxjAw@mail.gmail.com>
Subject: Re: Retrieving a file in git that was deleted and committed
To:     bturner@atlassian.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks! Strangely git log --follow does work.
On Thu, Dec 6, 2018 at 10:55 PM Bryan Turner <bturner@atlassian.com> wrote:
>
> On Thu, Dec 6, 2018 at 10:49 PM biswaranjan panda
> <biswaranjan.nitrkl@gmail.com> wrote:
> >
> > I have the following scenario:
> >
> > On a branch A, I deleted a file foo.txt and committed the change. Then
> > I did a bunch of other changes.
> > Now I want to undelete foo.txt.
> >
> > One way is to checkout a separate branch B where the file is present.
> > Then checkout A. Then do
> > git checkout B -- path_to_file
>
> It doesn't change anything, but note that you don't need to checkout B
> first, to restore the file. If you know a commit SHA where the file is
> present, "git checkout SHA -- path_to_file" will pull back the file as
> it existed at that commit.
>
> >
> > While this does gets the file back, the file shows up as a new file to
> > be committed. Once I commit it, git blame doesn't show the old history
> > for the file.
> >
> > I would appreciate if anyone knows how to preserve git blame history
>
> It's not possible, as far as I'm aware. While the new file has the
> same name as the old file, to Git they are two unrelated entries that
> happen to reside at the same path. Even things like "git log --follow"
> won't consider the file to be related to its previous history.
>
> Bryan



-- 
Thanks,
-Biswa
