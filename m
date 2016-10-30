Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4816D20193
	for <e@80x24.org>; Sun, 30 Oct 2016 17:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756871AbcJ3RWE (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Oct 2016 13:22:04 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:35880 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753543AbcJ3RWD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2016 13:22:03 -0400
Received: by mail-it0-f51.google.com with SMTP id m138so45173228itm.1
        for <git@vger.kernel.org>; Sun, 30 Oct 2016 10:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cYgIonvyN41/iX1mbrfUXCUH14vff6cYMgCzZ9AxGyc=;
        b=TfyszT1w9a2JkmHA/xeEe/MDogHv/zMb1c0tWFO0ZijHNxUrPhzbqJaGxmsNqzaHdG
         1lFs2LrxMTGjecqbtDXt6522t82ujyfj/57x+oShyeq1KKF6wpq1hXMtSzdzsTFuE3KV
         m3sTJZ88rnt4CWpZ0PklRJxxZczFSU0l4Lyo7c/TmVzaUVQvu0oXhZQMp91jfYkdHxTX
         mEIJFLvRcOB2pussXn9RV6dUqCasH/z+HZuyqsi87qjhrvcCX+Wr+gCATVdEGYn48iV/
         QQqvIEism77QgrgLcA3avm4m2CJ9poq9+mnzDdq3UNTy7n/PDkFh1YAx4rjuDcXchktv
         W8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cYgIonvyN41/iX1mbrfUXCUH14vff6cYMgCzZ9AxGyc=;
        b=EFybP5GDns9ps3qC8ScM+n9LD/ricSq89BFE0xmrcSWhLKQEFrODyaJSZ4WcoKph13
         p6/rYl+uBMg+C45hM9z5KTSdNveFrxmpocHvNyJ4e6DTjhIw1Sz50/4osFDrNpLI6reT
         UYDzH4WH0FO/mm1HZq+tZA35WJ8U4RGlz4/rbd66rFnD/1TbAfk/nDOS19rlI2s3I4qG
         O1bViIP2Dy8gDSNWiAO6VbsVhgnovOS6eCQl1+7jC0f+GdKW0d+zcYoQquYVkbqhpWu5
         Q9UtCsUSiOSVvKZ29PLfQb/Ngkudq/TRSRLgkl+0Q4ktO2imMB1/mKC8pn6MZU7Ko9Nv
         dRhg==
X-Gm-Message-State: ABUngveR4j+J8s/JJkTtHvxXTHubNhBcJ1Dka4vABex3rV4pCcqDcT4Cz3JZERQK570Q6C8cY1mQW7qn3Iy7rw==
X-Received: by 10.36.24.9 with SMTP id 9mr6729134itr.121.1477848122395; Sun,
 30 Oct 2016 10:22:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.5.212 with HTTP; Sun, 30 Oct 2016 10:21:41 -0700 (PDT)
In-Reply-To: <CAKkAvazX1gDzwhQLTbRvxc84sjz72ONy2-P7qWijQUnQqJ+K8g@mail.gmail.com>
References: <CAKkAvazX1gDzwhQLTbRvxc84sjz72ONy2-P7qWijQUnQqJ+K8g@mail.gmail.com>
From:   Alexei Lozovsky <a.lozovsky@gmail.com>
Date:   Sun, 30 Oct 2016 19:21:41 +0200
Message-ID: <CALhvvbYJ8G12Lbe2FgP8PWKZ-LABcw2M-M-zWPkT12UUqq1vaw@mail.gmail.com>
Subject: Re: [git rebase -i] show time and author besides commit hash and message?
To:     ryenus <ryenus@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It would help especially when the commit message was written badly.
>
> Or it might be possible to customize just like "git log --format"?

It is possible to change the format globally via config option
rebase.instructionFormat:

    $ git config rebase.instructionFormat "%an (%ad): %s"

The format is the same as for 'git log'. This one outputs author
name, date, and the first line of commit message.

This option is supported since Git 2.6.

Or are you interested in a command-line option that can change
the format on per-invocation basis? I think there isn't one.
It can be interesting to add it, but I don't think it has much
utility...
