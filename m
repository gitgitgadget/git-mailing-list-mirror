Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD50A1F7D2
	for <e@80x24.org>; Sun,  4 Jun 2017 11:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751157AbdFDLJj (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Jun 2017 07:09:39 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35487 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbdFDLJh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2017 07:09:37 -0400
Received: by mail-oi0-f52.google.com with SMTP id l18so132849076oig.2
        for <git@vger.kernel.org>; Sun, 04 Jun 2017 04:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=egcRsfMRsfEfg2zsg1FK/nyGekvkOC2VEIzKvBhCsLg=;
        b=anvtYddygbVzLukpmEbMQELMgWindVjoFzZ+zED4wM3u1GMUKcM0jvjK6bQqVGqIsp
         Q00XRu9b3Pj3qy6aVGBcItGKgGgLmWKRrsOaLg+1xuNfiUctrC20310z0vGt7jabJh1b
         DZQqR6xjhC3k6AfKoz8txj3TeycWalWPB9GkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=egcRsfMRsfEfg2zsg1FK/nyGekvkOC2VEIzKvBhCsLg=;
        b=aRytyaj6rd4h1OkZ9Eq1SaqmKUWQeUjki13BVCPNwxZ5KqTTAz5JpY8uCImk4iM/gI
         X42jMtPaxkiOd+W3M0tb536vgq3ORbsRxuzS4kpjV0Kb+vqv5/0t8BjTDMtdWHhBFlNG
         OlfAMKG/ndUdDNtUXzQkv5OZiXpHsYgxHCma+GvuQwA8IUHNsHE0iT4KRivy8ul0VXn4
         9FA1cihaCwBUHf/drE7djvqpl1ejUx4IQ7h4Mo5o/adw8awOqyJvqnkT0WUeHYXXyHWP
         EN7TF5/6ZmgtBRK41OGRjfweqUZ7ODWkN3mkXHmD7UJNfMQrR9IJ+3zhDL1E0AVTDNw1
         2dDA==
X-Gm-Message-State: AKS2vOy76ks+ROypT/eSHl5m0iNpDdTZdJtzUC2qavNDVc8QZz0CPFSe
        isNZyJDPqcF3KDd6KJXensl4umTGIYq5
X-Received: by 10.157.53.88 with SMTP id l24mr8329826ote.155.1496574577064;
 Sun, 04 Jun 2017 04:09:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.62.71 with HTTP; Sun, 4 Jun 2017 04:09:36 -0700 (PDT)
In-Reply-To: <CAPRL90JeQ3i1m7ydYzTCFgtZ4cC+gYEXFeAKvCuAVwPLXpsgXg@mail.gmail.com>
References: <CAPRL90JeQ3i1m7ydYzTCFgtZ4cC+gYEXFeAKvCuAVwPLXpsgXg@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Sun, 4 Jun 2017 12:09:36 +0100
Message-ID: <CAE5ih7-Nmy2J6zO9mx7g=L7Ey9PnVUcD3wnXBN4_0znwOHaUeQ@mail.gmail.com>
Subject: Re: Git p4 sync changelist interval
To:     =?UTF-8?B?0JDQvdC00YDQtdC5INCV0YTQsNC90L7Qsg==?= 
        <1134togo@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4 June 2017 at 10:56, =D0=90=D0=BD=D0=B4=D1=80=D0=B5=D0=B9 =D0=95=D1=84=
=D0=B0=D0=BD=D0=BE=D0=B2 <1134togo@gmail.com> wrote:
> Hello,
>
> My goal is to sync the repository from p4 using an interval of
> changelists so that the first changelist version of the repository
> would be considered as an initial commit.
> So I used the following command:
>
>  git p4 clone //depot@cl1,cl2
>
> And when it finished, the files, that were created before the cl1 were
> not in the HEAD.

Do you mean that if foo.c was created at cl1+1, that after doing the
clone, it wasn't there?

If so, that doesn't sound right to me.

I have just tried doing what I think you mean:

1. Create p4 depot
2. Add foo.c (at CL 2)
3. Add bar.c (at CL 3)
4. git-p4 clone //depot@2,3

I end up with both files.

>
> The problem, as I see it, is that before syncing changes in the given
> range, p4 task does not sync to cl1 version of the repo, and applies
> commits to the empty repository.
> Is it a bug or my misunderstanding of how git p4 should work?

Possibly I'm misunderstanding what you're doing! Can you give a
sequence of steps to show the problem?

Thanks!
Luke
