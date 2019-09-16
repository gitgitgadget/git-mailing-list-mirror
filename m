Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 294251F463
	for <e@80x24.org>; Mon, 16 Sep 2019 18:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390307AbfIPSTW (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 14:19:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36519 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390280AbfIPSTW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 14:19:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so418431pfr.3
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 11:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c8zM1FmpMc/C66CtzhNaS/GkJqxg7JiSAiutaO0KKBw=;
        b=M5kkHiitmsM0sKJUP9ZtbjfbasvpxImHjnDpnhXJpw65qRCMVef37fRjREW7T841vt
         T74bt83dsUQLofSg7GL6rCJ/YxMbEXX4d0Fhey7zxvfjIFNFVl6hzRaSNpwRf92ERWra
         feNMfLusTatr7nASk7V1+aW5hTdjsY0zUJscOrr/8C4G5jQW6x0JhCl4SS2izIVXrk43
         WuHXxAO0mu12+8M1XMzjD7LZWDTzsJOd+FbYUF3bRynmv0CvsWAAHdZ01XhcJ0nRoKJE
         Pj+PwX7ZXJACbKjiplkCFyO2KdhH642Bj/KXJDAS14IMfmI66BWuEdUPjjBNEFZNf69i
         /sOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c8zM1FmpMc/C66CtzhNaS/GkJqxg7JiSAiutaO0KKBw=;
        b=oCLyJoOK7RrThIEkqPI8Xb1CL5xOUd7TcKrRvSNW+j+weUGbHOPUb448Y6cHlgH1zg
         qKPTH5lNB500kXYMLwQT/eSrRrne1ZdHZtoPKLChjc7vYtsgu5+Xv3+MAxiX4PEaaV+5
         xJesQ1UF32GZm3AFIMbji5ZGGMpIAOKk42FF9NKlWsbFnFvp0Qd4B/dnFd2hYpE9Xl3J
         zukzW3QAl+4n19V01YZwOkvET+nJBmer4rLa7DZuMv5Tj+rgSXOau44huoUScSj4ELQT
         h40N7GIdR0QMA2UdgJdkYsQuAz3OZtu/xg6eyOML2g0KlKuidqaJA3m3o771XubUPjGz
         l5bQ==
X-Gm-Message-State: APjAAAVRiy2qPbzyQyOJmkIvHVbsu1gJ0yUvXFaMt44WvqTuHRUs9Zpv
        cZRmuE/QVpkrEgCrGrednU1cBKxHwP4=
X-Google-Smtp-Source: APXvYqzbfZ0X6K9Kh/owC3ymgdxJyzOlgd/9hHHmaBT1pUZfg3jfh38xbXZP56qbpcOPqPrVNbFL1w==
X-Received: by 2002:aa7:8a17:: with SMTP id m23mr638856pfa.255.1568657960909;
        Mon, 16 Sep 2019 11:19:20 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id e189sm35876080pgc.15.2019.09.16.11.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 11:19:19 -0700 (PDT)
Date:   Mon, 16 Sep 2019 11:19:17 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] git-submodule.txt: fix AsciiDoc formatting error
Message-ID: <2ae16375ba185bcaceb2ba3e8843db495f0044a6.1568657575.git.liu.denton@gmail.com>
References: <796a25ee1e9a9c0421d42ab6644e81d23a9bd99b.1568142486.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <796a25ee1e9a9c0421d42ab6644e81d23a9bd99b.1568142486.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In b57e8119e6 (submodule: teach set-branch subcommand, 2019-02-08), the
`set-branch` subcommand was added for submodules. When the documentation
was written, the syntax for a "index term" in AsciiDoc was
accidentally used. This caused the documentation to be rendered as

	set-branch -d|--default)|(-b|--branch <branch> [--] <path>

instead of

	set-branch ((-d|--default)|(-b|--branch <branch>)) [--] <path>

In addition to this, the original documentation was possibly confusing
as it made it seem as if the `-b` option didn't accept a `<branch>`
argument.

Break `--default` and `--branch` into their own separate invocations to
make it obvious that these options are mutually exclusive. Also, this
removes the surrounding parentheses so that the "index term" syntax is
not triggered.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Thanks for reviewing, Junio.

I thought about it over the weekend and I hope that this is a good
compromise.

I looked through other options in the documentation and I couldn't find
any other places where a short-form was documented in the body instead
of in the summary line so I didn't want to introduce that with this
commit. I feel like it would be unfamiliar to someone who's used to
reading other Git documentation.

Also, I opted to separate the the options onto their own lines because
this makes it obvious that these two arguments are incompatible.
Hopefully, this assuages your concerns.

Range-diff against v1:
1:  796a25ee1e ! 1:  2ae16375ba git-submodule.txt: fix AsciiDoc formatting error
    @@ Commit message
     
         instead of
     
    -            set-branch (-d|--default)|(-b|--branch <branch>) [--] <path>
    +            set-branch ((-d|--default)|(-b|--branch <branch>)) [--] <path>
     
    -    Remove surrounding parentheses so that the "index term" syntax is not
    -    triggered (and because it looks nicer without them anyway ;) ).
    +    In addition to this, the original documentation was possibly confusing
    +    as it made it seem as if the `-b` option didn't accept a `<branch>`
    +    argument.
    +
    +    Break `--default` and `--branch` into their own separate invocations to
    +    make it obvious that these options are mutually exclusive. Also, this
    +    removes the surrounding parentheses so that the "index term" syntax is
    +    not triggered.
     
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
     
    @@ Documentation/git-submodule.txt: submodule with the `--init` option.
      registered submodules, and update any nested submodules within.
      --
     -set-branch ((-d|--default)|(-b|--branch <branch>)) [--] <path>::
    -+set-branch (-d|--default)|(-b|--branch <branch>) [--] <path>::
    ++set-branch (-b|--branch) <branch> [--] <path>::
    ++set-branch (-d|--default) [--] <path>::
      	Sets the default remote tracking branch for the submodule. The
      	`--branch` option allows the remote branch to be specified. The
      	`--default` option removes the submodule.<name>.branch configuration

 Documentation/git-submodule.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 0ed5c24dc1..1f46380af2 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -173,7 +173,8 @@ submodule with the `--init` option.
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
 --
-set-branch ((-d|--default)|(-b|--branch <branch>)) [--] <path>::
+set-branch (-b|--branch) <branch> [--] <path>::
+set-branch (-d|--default) [--] <path>::
 	Sets the default remote tracking branch for the submodule. The
 	`--branch` option allows the remote branch to be specified. The
 	`--default` option removes the submodule.<name>.branch configuration
-- 
2.23.0

