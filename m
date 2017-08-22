Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3533B1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 23:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbdHVXos (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 19:44:48 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:33900 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752452AbdHVXor (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 19:44:47 -0400
Received: by mail-yw0-f170.google.com with SMTP id s143so1134010ywg.1
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 16:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hVzewrYLEVBp6lrRDR+P/3+p3AyHSSPBHdR819vo8L4=;
        b=YDpTSH8pm8mlb4CR3raARIip7+1sfCeZyeyIGYsZ6AiyPh/xA31XWKijs8UzmofkJU
         rJVmw94C1Ywr4JdQ2XYpsaepyHUfWd2/7CpAHnoqGg84rriNmfXAvBG/e6FuzQosVf8A
         Oe7rQO0F4odvSNsATV3ERLhBQlSmEQdPhD5VOmvCv01Zjyo9u0tbAK5crcANge0Ebiu0
         xKmZnfEs/o04dBauxvAWSTXl6XBiey1jSIM9WD/T2rBPPC2P0KHOhiPY0nTgiyCGkQ6O
         8JwQzjqQ5/laAgauolTxn88AHlteRMlzjaepHwtmZjdHoQSBC/ggiWqZ2eRqhCtKOWWx
         EZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hVzewrYLEVBp6lrRDR+P/3+p3AyHSSPBHdR819vo8L4=;
        b=RZU/n8JVUJ8MBE/o+LmIhkdWYKc8nnHwmmSjrKI8f6kwDgLQwxrIkNK9am1dc3dyJH
         a+7AEMB0jqrjNm5ReYYFym2rhgdfwh0hHNq4yHvJIU+o33+hONuXteOZJXGHY0g3YAOl
         6MpueIe3q5ZrSTIgC6/4CEQXLqRKB9xCu6HGFlfo1AWBkh5MrWgpJbefhNlzWL+QAd6u
         +wmsmE061R25IxuQ4NnjK8oSacDRwfRJYIsBRn54qBGvl9SRTR/t6yjGBhuYNV0Najkt
         3PLnqabjO8jT+DaiLWB/pWjA6BssWZlibOpTaLxOXiUS8AF+9H05m9ZYB25pVHvZxWGt
         4YRA==
X-Gm-Message-State: AHYfb5iqoGEL97+PiX3Ujq6beyCjyqiORTCd5tEP1cDbGoB/y6eN4oZL
        oWCcFWOlnujnA7kOhcTsbIlWBtGuKy+3
X-Received: by 10.13.229.3 with SMTP id o3mr656429ywe.137.1503445486453; Tue,
 22 Aug 2017 16:44:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.170.41 with HTTP; Tue, 22 Aug 2017 16:44:45 -0700 (PDT)
In-Reply-To: <20170822233732.GX13924@aiede.mtv.corp.google.com>
References: <20170822233732.GX13924@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 22 Aug 2017 16:44:45 -0700
Message-ID: <CAGZ79kbkLyYTrvkUfsfHsUJstq-7Mj=c8vz2aZVojcXsy1fhog@mail.gmail.com>
Subject: Re: [PATCH 0/4] vcs-svn: remove repo_tree library
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2017 at 4:37 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Stefan noticed that repo_init from vcs-svn/repo_tree.h conflicts with
> repository.h[1].  Earlier brian m. carlson noticed the same thing[2].
>
> Originally repo_tree.h was used to manage an in-memory representation
> of the state of the svn tree being imported.  When that in-memory
> representation was retired, we were lazy and left some utility
> functions there.  Here is a patch series to finish cleaning up and
> remove vcs-svn/repo_tree.h completely.
>
> This is an alternative to bc/vcs-svn-cleanup from 'next'.  Those
> patches weren't cc-ed to me and I missed them --- sorry about that.  I
> can rebase on top of them if that is more convenient.

A rebased version would be easier IIUC Junios reply to
the one-off that I sent.

The patches look good.

Thanks,
Stefan

>
> Thoughts of all kinds welcome, as always.
>
> Thanks,
> Jonathan
>
> Jonathan Nieder (4):
>   vcs-svn: remove prototypes for missing functions
>   vcs-svn: remove custom mode constants
>   vcs-svn: remove repo_delete wrapper function
>   vcs-svn: move remaining repo_tree functions to fast_export.h
>
>  Makefile              |  1 -
>  vcs-svn/fast_export.c | 41 +++++++++++++++++++++++++++++++++++++----
>  vcs-svn/fast_export.h |  3 +++
>  vcs-svn/repo_tree.c   | 48 ------------------------------------------------
>  vcs-svn/repo_tree.h   | 23 -----------------------
>  vcs-svn/svndump.c     | 33 ++++++++++++++++-----------------
>  6 files changed, 56 insertions(+), 93 deletions(-)
>  delete mode 100644 vcs-svn/repo_tree.c
>  delete mode 100644 vcs-svn/repo_tree.h
>
> [1] https://public-inbox.org/git/20170822213501.5928-1-sbeller@google.com
> [2] https://public-inbox.org/git/20170821000022.26729-3-sandals@crustytoothpaste.net
