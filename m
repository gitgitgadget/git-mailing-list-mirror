Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9448D1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 09:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbeKFScJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 13:32:09 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:37639 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbeKFScJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 13:32:09 -0500
Received: by mail-oi1-f173.google.com with SMTP id w66-v6so10085248oiw.4
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 01:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Txdyd2FwjcZYv+NfaewXN4uSND++sec5txmkz1p2VBw=;
        b=EkUPVcPxGYvf0iEQfqgxxJxMogpsY/I+/PBjU6A0ZTz7L0L0V6uAswVAOnesZE0U5J
         YIg6EwRKudXvVUJd0c2IYxkcDaA4K/TeILSzgLIvosuhRYj+6xrQ2oTX2fCOS//hg6MZ
         r2bK07m3YBIyV0Y+JMbh+WGM82YKNjDU5k1qO5hFxCxRr9s64GY0rx2Z9Z0CQTm7E8+g
         VVBsYFv84nYJMN6TPH7myqO6ROf+IF1AlI+nyEjc8GfLmrvIl46DX750Oo6cVny7zVd3
         fQEyM7RM2hnTxcpvu/hXSb7RXYU+LQ9R47ing62stxIkOCfpDiJ75t9aA3Ih5o4jp3i8
         93Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Txdyd2FwjcZYv+NfaewXN4uSND++sec5txmkz1p2VBw=;
        b=EmADqMbfKN1V+M3ZN/B7+EB+AASffkIcdZWIEcXEFHtI7iLFF/AxZnMXQrUAGzZhlb
         EEYfJtbPOirxwPBA9Hl+LiWZ5JjRPc6M7ePGZHqZg+ifZbvQpCRf+mG5P3F0TUarlXfg
         ktWsBeAMps/IBzk6cQK9Yld0J0u6bHi08yBGPI85PxL+ZXLBN6EZQtFqiQk222okdIJo
         SHsuRVzeY9vWbUWt6quUEcvdCv1tNSaeUzDctlpNZXem05HFRwkjb++GPYh/SJJEhW70
         2pDPWvznuXzTnrK7jSuFuvvjNnB7PUOclaWSpdeTIy29RSu5geLq0XXG6HuVxmeQiLPR
         bfaA==
X-Gm-Message-State: AGRZ1gJ6DLuYdWqEnctnKYQcvviTCwNzHcVmyY7ELsNuIDEom/qJ4gbU
        gkJCZ91PnGl1Ukv69nL0SBmbqTVXlzSPIf6F2WQ6ALyC
X-Google-Smtp-Source: AJdET5eru1OVjeBdUROnc5221qZqwdYQ3NExjALXZRnSur/koUzG2IHOJQVkgugWrk+FJbgPhtKCQVARkrcaRyCqnPM=
X-Received: by 2002:aca:c5c6:: with SMTP id v189-v6mr37305oif.113.1541495275122;
 Tue, 06 Nov 2018 01:07:55 -0800 (PST)
MIME-Version: 1.0
From:   yan ke <yanke131415@gmail.com>
Date:   Tue, 6 Nov 2018 17:07:42 +0800
Message-ID: <CAJosSJ4eKJfa4s+3LcP3Q5qatcg3aFjh9H=Q9bETnkROu06+KQ@mail.gmail.com>
Subject: build error on mac os 10.14.1
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello

    when build on mac os 10.14.1 with the master branch, I got the
error as blew, so what is wrong?

ld: archive has no table of contents file 'xdiff/lib.a' for architecture x86_64
ld: archive has no table of contents file 'xdiff/lib.a' for architecture x86_64
ld: archive has no table of contents file 'xdiff/lib.a' for architecture x86_64
ld: archive has no table of contents file 'xdiff/lib.a' for architecture x86_64
ld: archive has no table of contents file 'xdiff/lib.a' for architecture x86_64
ld: archive has no table of contents file 'xdiff/lib.a' for architecture x86_64
clangclang: error: linker command failed with exit code 1 (use -v to
see invocation)
: error: linker command failed with exit code 1 (use -v to see invocation)
clang: error: linker command failed with exit code 1 (use -v to see invocation)
clangmake: *** [Makefile:2369: git-shell] Error 1
make: *** Waiting for unfinished jobs....
make: *** [Makefile:2369: git-sh-i18n--envsubst] Error 1
: error: linker command failed with exit code 1 (use -v to see invocation)
clang: make: *** [Makefile:2369: git-credential-cache--daemon] Error 1
error: linker command failed with exit code 1 (use -v to see invocation)
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [Makefile:2369: git-credential-cache] Error 1
make: *** [Makefile:2369: git-credential-store] Error 1
make: *** [Makefile:2383: git-remote-testsvn] Error 1
ld: archive has no table of contents file 'xdiff/lib.a' for architecture x86_64
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [Makefile:2393: git-remote-http] Error 1
ld: archive has no table of contents file 'xdiff/lib.a' for architecture x86_64
ld: archive has no table of contents file 'xdiff/lib.a' for architecture x86_64
ld: archive has no table of contents file 'xdiff/lib.a' for architecture x86_64
ld: archive has no table of contents file 'xdiff/lib.a' for architecture x86_64
clang: error: linker command failed with exit code 1 (use -v to see invocation)
ld: archive has no table of contents file 'xdiff/lib.a' for architecture x86_64
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [Makefile:2369: git-http-backend] Error 1
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [Makefile:2372: git-imap-send] Error 1
make: *** [Makefile:2379: git-http-push] Error 1
clang: error: linker command failed with exit code 1 (use -v to see invocation)
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [Makefile:2376: git-http-fetch] Error 1
make: *** [Makefile:2369: git-daemon] Error 1
ld: archive has no table of contents file 'xdiff/lib.a' for architecture x86_64
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [Makefile:2369: git-fast-import] Error 1
ld: archive has no table of contents file 'xdiff/lib.a' for architecture x86_64
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [Makefile:2046: git] Error 1
