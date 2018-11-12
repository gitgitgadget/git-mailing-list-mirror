Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B18C1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 01:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbeKLL0a (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 06:26:30 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:36235 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbeKLL0a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 06:26:30 -0500
Received: by mail-oi1-f171.google.com with SMTP id r127-v6so5920243oie.3
        for <git@vger.kernel.org>; Sun, 11 Nov 2018 17:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5WM9iBTsNLrJoEcjk/PkdogvmRvBfopqgjHJH04aviA=;
        b=dvqpKvr1ZfslwwFm9MZKUfaU2b+0o3enb8YIBvq0hQFgBAL4Pz33615MI7jFBlf1aM
         yKm3qeFzcyG7uILahhd0CeMY3To08LSaXPGSggUP85Oul1UoYcbZ7qDB+lefQsCiXpVs
         no1YKVQK/KHFToFANW4x4uUivcmxf5ITKzH2jXU0V+I2I/zSNXin8zZaT10iuNcSmX+w
         4eXXRyvbkq7XBX2mY4PI/dhudTwEC+fKuVXXLS4+p/qjeE6sF9fuXtZm/OdpEbORkNKB
         WYf9UfwBmSucq+Nc0hBQvd3AGa2k/g2UJOtUbBZLrBqg6J8c/j1BD+5visQgyW1xFXfa
         QHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5WM9iBTsNLrJoEcjk/PkdogvmRvBfopqgjHJH04aviA=;
        b=ZyY7kGCMkd6s6/KUuz6RtEgySPqC6BmTWEZXIkvekMvNpai/ptL3okW9tSrlS6CwEM
         olJ6Iy23h4hMr44fKA/12IYPcoaKA26UkKk5yhfaxv8dGrNWzXsUBc3+BuJUltihnggg
         G9IUlxuLwIs50rX6fP+xqgf8B3EebIwMGLljw7VVuAfNuFem7xqkW8k1R5mFomxDtu0f
         /if/PU2Qb1csJLfVmoQMIfZC6b2KdpfJV7WuQP0Wwj726ebCh4BuYvnJifS1RoiKuUJd
         ibhN91CkEb/EgD2THh/7bsSVSH7T/X+2D3lq3Y8kkMw/lFfeS7kGZKumU8dH7bLhmyxO
         hayg==
X-Gm-Message-State: AGRZ1gJBGuyghLbP1clzl/upGw/Ci2RR37DeMVLpplGG56ZTYEz1zJM9
        EIaTdTeGlDov2lC5iPNuiAxtel8ozm7rPIQ+dcyGrzbe
X-Google-Smtp-Source: AJdET5dkJNnHyA7LPcc8ChQY2DIVCQmWV+U7VhU3fNV5D+54tnhWRgg5twFRk9xeIVprSUeMxNf6wOD/XeBTzr5+tmM=
X-Received: by 2002:aca:905:: with SMTP id 5-v6mr10247570oij.163.1541986543059;
 Sun, 11 Nov 2018 17:35:43 -0800 (PST)
MIME-Version: 1.0
References: <881C01A7-82BB-4A4D-9CDC-6ECDA451B12B@gmail.com>
In-Reply-To: <881C01A7-82BB-4A4D-9CDC-6ECDA451B12B@gmail.com>
From:   yan ke <yanke131415@gmail.com>
Date:   Mon, 12 Nov 2018 09:35:31 +0800
Message-ID: <CAJosSJ4_PXrXUxn0WfFcR90SbDL0UWRRGPpxEjVwc=3NwWP+Jg@mail.gmail.com>
Subject: Re: Add issue management within git
To:     martin.delille@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

   Very very agree, now it is very difficult to find a solution when
has some problem such build problem an so on! The mail-list is good to
send patch es, but is it not suitable for problem track or problem
solution search!
   Now the Github or Gitlab is good to track issues, suggest to open
the git issue track!
Martin Delille <martin.delille@gmail.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=88=
12=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=886:52=E5=86=99=E9=81=93=EF=
=BC=9A
>
> Hi,
>
> This would be awesome to handle issue directly with git:
> Having an offline version of the issues synced to the gitlab/github issue=
s.
> A lot of work is done on the issues and it is lost when migrating from on=
e service to the other.
> Beside we don=E2=80=99t always have a good internet connection.
> There is already a kind of integration between commit message fixing issu=
e automatically when merged in the master branch (with =E2=80=9Cfix #143=E2=
=80=99).
>
> Kind regards,
>
> Martin
>
