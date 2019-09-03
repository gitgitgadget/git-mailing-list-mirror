Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6A8C1F461
	for <e@80x24.org>; Tue,  3 Sep 2019 12:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbfICMow (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 08:44:52 -0400
Received: from mail-yb1-f176.google.com ([209.85.219.176]:35927 "EHLO
        mail-yb1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbfICMow (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 08:44:52 -0400
Received: by mail-yb1-f176.google.com with SMTP id m9so5808767ybm.3
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 05:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=LDsNT356H2kiss6Rl5FdoVZQqPqJEEEOmgZdRTFsmxI=;
        b=c4tkVfLjxoftUh2d+VMRvYREYLEBlh2tKDNaov9mIxP5gDd4FY+/m7pzNgxB8SEBB5
         HDafMND8UjSXzql59nPVJjhbz/vP4ZSDi1IntHnzdCzUDk8cjSGIortPIqxjtwq8dMvb
         bqBTNV+qei4KH4vjE+SHxtNJyBXNWDd7z4g0/w7thSgm9OsdsguG1DsMw6Hd55L/bu8B
         OaNTrJbB0CdzFnatcQXrhbljudghmEiXu/77pJBLtyqLB51C+Mpf94uK4AjkR1BK6Vqk
         WADBtz0zbui4nCDJHmw7UBBqodRWluSslsj7HDL2qUYEU791mb+oV69vvDD2UL4O9i/8
         ccyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=LDsNT356H2kiss6Rl5FdoVZQqPqJEEEOmgZdRTFsmxI=;
        b=jeDJj9BDs9s6jQG62Odt4akjtgTekTxEMbPTebzrnALKunC9zzexIxbE5YaXrpoJzJ
         WTxK2mL9nlACBXBgn2Yvg0fqcbmS5ioSUGBrXkyqaQ7WEOBs14uNPi5hxnoPvszLJouP
         7GKrWpPzb2QtfZ5Y7VJQy6uBoouNF6Ctz1JSVSzRwfHByxKy8AN5Ub/gV6Q++OW6pJ4I
         3WKSJeFsovjKcVenPcreNg+H1ScXE7NlNFC7VuM2PyXNj7U9k1k9GaYnGOtoB3SC9bK/
         r3V2UgzCbhLPyY/u/bMLQDtob7tQVsiQfq2gOZr3pZQz29DB9RNBBJf4zZttJU8mnbZ2
         nIQA==
X-Gm-Message-State: APjAAAU1BJRJBZyxs6lFCDqqNOyOyTIHvyjGxOXJvuvReclj6QYlO2FA
        egUnEYfjtxp1O664tVXa9LngWtRvsYdXZr/XwQmz/zkB
X-Google-Smtp-Source: APXvYqzrkmkzKtVEHw2LyihnyEAWTLXpRtmxRUOsvz4qTNbo71vkg3iA7TzotKtpkYIEZV5lyGawbcdxEBNrIQ2vWq8=
X-Received: by 2002:a25:aa23:: with SMTP id s32mr22533361ybi.198.1567514691395;
 Tue, 03 Sep 2019 05:44:51 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Date:   Tue, 3 Sep 2019 15:44:14 +0300
Message-ID: <CAHMHMxW4-6AZEDaJU8KOy2kRSLXjdC_RTH528=nnhVLXh=ADUA@mail.gmail.com>
Subject: Git does not recognise directory named '${sys:DATA_ROOT_DIR}'
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello there,

While the name is obviously a mistake, git refuses to even acknowledge
the directory.

```
u@h:~/$ mkdir init-test
u@h:~/$ cd init-test
u@h:~/init-test$ git init
Initialized empty Git repository in /home/u/init-test/.git/
u@h:~/init-test$ (master #) mkdir \$\{sys\:DATA_ROOT_DIR\}/
u@h:~/init-test$ (master #) git status
On branch master

No commits yet

nothing to commit (create/copy files and use "git add" to track)
u@h:~/init-test$ (master #) git add
.git/                    ${sys:DATA_ROOT_DIR}/
u@h:~/init-test$ (master #) git add \$\{sys\:DATA_ROOT_DIR\}/
u@h:~/init-test$ (master #) git commit --signoff -m'a'
On branch master

Initial commit

nothing to commit
u@h:~/init-test$ (master #)
```

Is that expected?

=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82 =CE=A3=CF=84=CE=B1=CF=8D=CF=81=
=CE=BF=CF=82
