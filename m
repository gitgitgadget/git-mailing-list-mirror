Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DBB720A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 06:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbeLGGze (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 01:55:34 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:33116 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeLGGzd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 01:55:33 -0500
Received: by mail-io1-f49.google.com with SMTP id t24so2510257ioi.0
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 22:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Fi0rrfneoUDkQtkMv1ro3uAo1FAmxHpfarKCAIlR3Y=;
        b=mCd3S/Xg72ZbJVpTj3ZKyAkwEMeEoRR6syq3Xoh2kaQoB+LMmyp/AO+l8h00mz57Sv
         2kaoRVQ520OZWayo2+sjEibNsgy6lI8EXtoc5RxwuuphuwsaVI5iiOQ65WgHE0gs0Hfa
         LyybHVaEmDYTYg3s0vB24fMFs+2JolRtCBT5cUhiSHULLNhlCdEaBhf+Uqrt0pYFZBoi
         rD7EBPDC8i+LomjD5aV7O5qRr7B78WFuWArduJdnmyA7J3kJ1hYsG1Bf99b61K9lOYYQ
         hLYHj9zMEUBONAxsVZSVaM1SlKCIrQCqnLl2ARbGIAfrmo910GLYMT2HBb1LIRrnmvKv
         HpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Fi0rrfneoUDkQtkMv1ro3uAo1FAmxHpfarKCAIlR3Y=;
        b=B1RjvY0d0hDBbz81B7vqvTsBS8l7ciqTL9wRR0PEE1a9UmjKpm61lBMv18cWBMPt8S
         dh+k8s2IraCSEsf73cIJF/zgZoLPx1dJaHR0is2mnjNwPU21tZYDc12P6XwfuvvUGurT
         opGAQhzn3Wbw4XRrHAmilGKqA62X6GI8B0DlxQKqKukZknbtV+Z5OsPqXpFcwfGsK6cc
         Dg6zV+QK5LhiCx+xuYwbliW0xrfIVIqn+ijIC73lgzJr9+LSYF8qM0dBSY2NulOyRkAB
         LsW04ePptRnwCxPAY0zUr8qa4HKVyOY0my7Tf595jqjcKKOKibg7nya8i2OZ6gv68F5N
         isUQ==
X-Gm-Message-State: AA+aEWZ67REySDP5YregUzfSCJM7DpJxlo9yFMnZXzgJuQoRV0Ml+eFy
        V0u5R9yEYJDQx1syFt6BUXifkL8OalhYj4ktE3b1JQ==
X-Google-Smtp-Source: AFSGD/Wpd8DeFUToSDXCjL8UHLGwE+VgcuBY/kFBwdjUiRZGMkVkVvm0akI/51I0XXV1bhiDeCZelvJvRQ+jJ+FM+/E=
X-Received: by 2002:a6b:3c17:: with SMTP id k23mr686535iob.182.1544165732774;
 Thu, 06 Dec 2018 22:55:32 -0800 (PST)
MIME-Version: 1.0
References: <CADHAf1Y_d=-9By4jC2xd+BmWJgfGmBNUr=uSuQtfuHDrarN4kw@mail.gmail.com>
In-Reply-To: <CADHAf1Y_d=-9By4jC2xd+BmWJgfGmBNUr=uSuQtfuHDrarN4kw@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 6 Dec 2018 22:55:21 -0800
Message-ID: <CAGyf7-FUHMEq_FfPNrH6uT2b-nCd_wi=Aww+OUuoDem11DROGA@mail.gmail.com>
Subject: Re: Retrieving a file in git that was deleted and committed
To:     biswaranjan.nitrkl@gmail.com
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 6, 2018 at 10:49 PM biswaranjan panda
<biswaranjan.nitrkl@gmail.com> wrote:
>
> I have the following scenario:
>
> On a branch A, I deleted a file foo.txt and committed the change. Then
> I did a bunch of other changes.
> Now I want to undelete foo.txt.
>
> One way is to checkout a separate branch B where the file is present.
> Then checkout A. Then do
> git checkout B -- path_to_file

It doesn't change anything, but note that you don't need to checkout B
first, to restore the file. If you know a commit SHA where the file is
present, "git checkout SHA -- path_to_file" will pull back the file as
it existed at that commit.

>
> While this does gets the file back, the file shows up as a new file to
> be committed. Once I commit it, git blame doesn't show the old history
> for the file.
>
> I would appreciate if anyone knows how to preserve git blame history

It's not possible, as far as I'm aware. While the new file has the
same name as the old file, to Git they are two unrelated entries that
happen to reside at the same path. Even things like "git log --follow"
won't consider the file to be related to its previous history.

Bryan
