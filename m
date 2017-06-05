Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_STARTS_WITH_NUMS,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A9EA1F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 18:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751200AbdFESu5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 14:50:57 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:36993 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbdFESu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 14:50:56 -0400
Received: by mail-it0-f42.google.com with SMTP id m47so85642061iti.0
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 11:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=y2DsooTy7hLaTziDu4Ur2oe/Z35OequlMzmcepZc7Q0=;
        b=Nq1Z+X7uCy3dJyEoRNdAOGBfU83Cu/av4tqyDif99uQk6C2VOTsQlXbzeP6UULomTn
         pjm8MLR37qwRKcoyoAzMiNUdPuS6VzRxHVD7/sCzVHsUw0SUdJyGzfvZ86CVOKnINNPQ
         sQ74MJXeYsOQJ5b0jNC+bG6+npykNrYAt7x2Iu5RPGSKi2xI4xry1o60r5TxkVmJRnvR
         6dRrSJH9MnkSvjWybU53VpM/Qn88ubD+jlCttsuI3d4KCwYU7FPHOEkJ4qUVUyS0xeVL
         tWBd0ELWbX5fwe2MBr2ZF2q8TjV1fXCzT1Wf0GwwcIL4YFhG/jpuk9ncUtpgGse0yOWy
         EHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=y2DsooTy7hLaTziDu4Ur2oe/Z35OequlMzmcepZc7Q0=;
        b=h+bHk4gnApgosOUX1yzBqYRE0wCSAxDaTr+IjTyTLHEaTs3W+GKRGP1G6j11E89h4b
         KaGrJdQSXiPn/qtYtYfsQugAE2ypR6dgAISqln4EPPhPeVNRS6MxrqKbV2urWJ6bVZGE
         4t3T35MGOX0+/Gd66n3HfqYaq3k8FO+rvA6/TlnEgXIRm8GH+9rsz/qfMA/rOh9ZFvpU
         +n7p9lo7AE55Ln+zLQ2Q384f+eIszadNm0BXPVVD0qwjvVdNsQOhQSN511E8lDn2ve1W
         rO1DFKn9JMe9ZJyS4T4WMQkMlqkjVfi0VrUVk3ul2gN+XNAa4I5CCacgvZ6zwIXjC0Il
         4SnA==
X-Gm-Message-State: AODbwcBRfhQmXTnFJQSlXK4b+1yAbfzDu7SsQK5o+GnzzhZ6yhQNnxHi
        d+rYL6VPYB9BkC0enGyCrMzbB6FoPIMFgzg=
X-Received: by 10.36.6.18 with SMTP id 18mr14491993itv.61.1496688655782; Mon,
 05 Jun 2017 11:50:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.135.12 with HTTP; Mon, 5 Jun 2017 11:50:55 -0700 (PDT)
In-Reply-To: <CAKOu8-2iBV=sAP0WeRMQFT+0y5cJ1g6A3bQ5x=D=8q9ocxnBVg@mail.gmail.com>
References: <CAPRL90JeQ3i1m7ydYzTCFgtZ4cC+gYEXFeAKvCuAVwPLXpsgXg@mail.gmail.com>
 <CAE5ih7-Nmy2J6zO9mx7g=L7Ey9PnVUcD3wnXBN4_0znwOHaUeQ@mail.gmail.com> <CAKOu8-2iBV=sAP0WeRMQFT+0y5cJ1g6A3bQ5x=D=8q9ocxnBVg@mail.gmail.com>
From:   =?UTF-8?B?0JDQvdC00YDQtdC5INCV0YTQsNC90L7Qsg==?= 
        <1134togo@gmail.com>
Date:   Mon, 5 Jun 2017 21:50:55 +0300
Message-ID: <CAKOu8-0DG_wQf4ch_MH=rjAncg1iP=uA1U7XHgXe7JNrEJSkGg@mail.gmail.com>
Subject: Fwd: Git p4 sync changelist interval
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-06-04 14:09 GMT+03:00 Luke Diamand <luke@diamand.org>:
>
> On 4 June 2017 at 10:56, =D0=90=D0=BD=D0=B4=D1=80=D0=B5=D0=B9 =D0=95=D1=
=84=D0=B0=D0=BD=D0=BE=D0=B2 <1134togo@gmail.com> wrote:
> > Hello,
> >
> > My goal is to sync the repository from p4 using an interval of
> > changelists so that the first changelist version of the repository
> > would be considered as an initial commit.
> > So I used the following command:
> >
> >  git p4 clone //depot@cl1,cl2
> >
> > And when it finished, the files, that were created before the cl1 were
> > not in the HEAD.
>
> Do you mean that if foo.c was created at cl1+1, that after doing the
> clone, it wasn't there?
>
> If so, that doesn't sound right to me.
>
> I have just tried doing what I think you mean:
>
> 1. Create p4 depot
> 2. Add foo.c (at CL 2)
> 3. Add bar.c (at CL 3)
> 4. git-p4 clone //depot@2,3
>
> I end up with both files.
>
> >
> > The problem, as I see it, is that before syncing changes in the given
> > range, p4 task does not sync to cl1 version of the repo, and applies
> > commits to the empty repository.
> > Is it a bug or my misunderstanding of how git p4 should work?
>
> Possibly I'm misunderstanding what you're doing! Can you give a
> sequence of steps to show the problem?

What I meant is:

1. Create p4 depot
2. Add first.file (CL 2)
3. Add second.file (at CL 3)
4. Add third.file (at CL 4)
5. Modify first.file (at CL 5)
4. git-p4 clone //depot@3,5

In this case first.file, will not be represented in the repository.

Regards,
Andrew
