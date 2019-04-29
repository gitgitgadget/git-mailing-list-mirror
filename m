Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EAC41F453
	for <e@80x24.org>; Mon, 29 Apr 2019 11:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfD2LCy (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 07:02:54 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:40030 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfD2LCy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 07:02:54 -0400
Received: by mail-lf1-f52.google.com with SMTP id o16so7626041lfl.7
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 04:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=QXiUItsccupvtFE5syZPjeGtQEYBkvPYaMq0ZzNG4gQ=;
        b=pkh2RphnA6QNc1uFDiZ6NrLLCMYLBdZm2VfCSs8wyDJwEw7MR8cBYZWIElRLfg8dnc
         BH4ZjNWE1wqYosYsM7MMFzHuZ6AqSn15T3MMUlkKpEiCV+pOOOiP6qwqcwJrfPcUyLYg
         qaDQluwALBXfBQRvG3TuoXiaA+AJVWeKExGF422ZM5JOUzQgoYBj1u2ERSuuGo4YGJTK
         6K+Pp3tOvFpem3kMi6uciQsGL9mtQgp5EYXm1r18PQE4yK8EdpY8ePyKhh5ISNRpBMm5
         scGnqzWN+2NPdIYfaDOjW4gsUmdc4ZuR922SBf0bfOoBunsSTg4fwDZCxEfMd/pWdt9W
         Y+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=QXiUItsccupvtFE5syZPjeGtQEYBkvPYaMq0ZzNG4gQ=;
        b=iEidPrCxvsyQzqDZ6bjXOiPha2XMgTHUOGRaGo//26OMgTX2zxd+TfSVcU+4536ws/
         PrIXPVGVkJafIGq3cJqLhPSG+gZt6pn/Q1gtFJ75+FqtvShanTuOW4Kz1BETbpXfX6PF
         G1K9KHPMG9CDpJ9Y7Jl0L1JoCKlYdQ8IVpRZ8VTU9nmgdR2GROUJ+ChvlM0k2m5rwTOM
         OBODuOnwa61wy8KuCqPfilSzx3m13p44j8fBw+1DEo5X53QZtItYGJc2C4mJGnfPDOyr
         pPHjvSDMABb0YY+11XpXh5+Fvqek2lNcubjAz183yvscYA3wfxgBu8YzQqE0k/nQDA4C
         D0yA==
X-Gm-Message-State: APjAAAUMQ3o7dU2Bb6crWvbmyxmRNIsBh5TPwzjqqOl0LZQZV9+se9gd
        dtxB9gKNWJYcctjII8iZ1+gdYY2rHBKKA21+KGIMUAP5
X-Google-Smtp-Source: APXvYqzweUIq2PnK4g5ZMz9CeTUXxwxEJ2lFSNze9QrPtllf/1EJDmHjnVBkLUC74L0EwrCgw6ePdL6gHMRFjiN9Kz4=
X-Received: by 2002:ac2:5203:: with SMTP id a3mr12353116lfl.111.1556535771789;
 Mon, 29 Apr 2019 04:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAF8BazDu_GqoCPBQ-gEJ+q8n1aWSjf_TOV7bDE5VCQkDgBjyfQ@mail.gmail.com>
In-Reply-To: <CAF8BazDu_GqoCPBQ-gEJ+q8n1aWSjf_TOV7bDE5VCQkDgBjyfQ@mail.gmail.com>
From:   Aleksey Midenkov <midenok@gmail.com>
Date:   Mon, 29 Apr 2019 14:02:39 +0300
Message-ID: <CAF8BazA-VYFns7o9F7gXfFZCspbM0yQKi+LQ+BnkpGH+EjPC9A@mail.gmail.com>
Subject: Bug: fatal: Unable to create '.../.git/index.lock': File exists.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reproduce:
```
cat << EOF >> /tmp/check.sh
#!/bin/sh
git log HEAD~..HEAD | cat
# sleep 1
EOF
chmod +x /tmp/check.sh
git rebase -p -x /tmp/check.sh base
```
If the `base` is far away enough it fails with "fatal: Unable to
create '.../.git/index.lock': File exists." at an arbitrary commit.

Abort current rebase, uncomment 'sleep 1' and repeat rebase. Now it
doesn't fail.

Version:
git version 2.20.1

uname --all
Linux lian 4.18.0-15-generic #16-Ubuntu SMP Thu Feb 7 10:56:39 UTC
2019 x86_64 x86_64 x86_64 GNU/Linux


-- 
All the best,

Aleksey Midenkov
@midenok
