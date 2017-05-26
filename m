Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B09C209FD
	for <e@80x24.org>; Fri, 26 May 2017 02:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965131AbdEZC4t (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 22:56:49 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36352 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932649AbdEZC4s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 22:56:48 -0400
Received: by mail-pf0-f169.google.com with SMTP id m17so184240151pfg.3
        for <git@vger.kernel.org>; Thu, 25 May 2017 19:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wDbfqAZvWHUb3qes+O3RqGgbOeNY4efiZi3d8L/sy84=;
        b=fau7/1CyU6fArPtJzVJjIVHwMWt+RULuyj2i0NbWUgAsgA7J491kAHEsVsH1ttBuz1
         qQrOP69mmtWvPnwa2bVbHxjyr1HnYQOXwU/rFHrkgtAuFId0qtlA5Kn6n86IgPciUW1A
         ER4FTsIP+2K5pHDAnB6bWBMDzGJXkm+muUx8FSdZeOehmm5dgieVDQPGBdDw+iVw6y9w
         eOaDwBb+UjEi2Tif+hqPr/LAz+DpkOTBXJOHdL0juAzy8N+XyN6O62S0VIOQUiuOKDiQ
         9Nf38bbqBJTi79kZjtzJIdA2KxnW1frKIdt3k91qSN2xKcy2TLRRr+9XNCNGLkZ+Kr5k
         L/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wDbfqAZvWHUb3qes+O3RqGgbOeNY4efiZi3d8L/sy84=;
        b=s5vClGr0IEFowkz3DCvNcAjjFlUEpiShfyqV9I3Xw7EwjwV8iPQ3R5E1ULkCes7JO6
         8P/QobJ7GQcmgAp+Cej9a8iKMGN1hUU0CgJ6o5rCjY8sg1v3/XKbqjfkTODRBjY+0fMQ
         w0ynKyTGFs9X2uc1gRxojqJdcmRjjWnQ5JG+hQOwa+5K5PhD+iBKM5QTBhhQf1yG+yPJ
         kIIhJyPorhDiwrWJl+tbUKEoyT0J3BJSxR4EK2t6T/CtiFc4Amdp1BpZSRsIpRHK9aZD
         Rg1HySm6EgsvJhHebCe6HUqQ5ngNBoHEaG9LthyXdK+Ot7p/4IJ4CvuOsMif75lpYT20
         gJpg==
X-Gm-Message-State: AODbwcDyIjg2Tz38X1dGfVAudl6AkrTsLzy120iyJ3Aryvqn8F69tz2Q
        7QEFjYNsNkCPhg==
X-Received: by 10.99.167.75 with SMTP id w11mr49902986pgo.148.1495767407833;
        Thu, 25 May 2017 19:56:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id e20sm16185854pfd.34.2017.05.25.19.56.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 19:56:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (May 2017, #06; Mon, 22)
References: <xmqqo9ulo1yn.fsf@gitster.mtv.corp.google.com>
        <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
Date:   Fri, 26 May 2017 11:56:44 +0900
In-Reply-To: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 25 May 2017 19:58:23 +0700")
Message-ID: <xmqqzie0ba1f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, May 22, 2017 at 1:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> * nd/fopen-errors (2017-05-09) 23 commits
>>  - t1308: add a test case on open a config directory
>>  - config.c: handle error on failing to fopen()
>>  - xdiff-interface.c: report errno on failure to stat() or fopen()
>>  - wt-status.c: report error on failure to fopen()
>>  - server-info: report error on failure to fopen()
>>  - sequencer.c: report error on failure to fopen()
>>  - rerere.c: report correct errno
>>  - rerere.c: report error on failure to fopen()
>>  - remote.c: report error on failure to fopen()
>>  - commit.c: report error on failure to fopen() the graft file
>>  - log: fix memory leak in open_next_file()
>>  - log: report errno on failure to fopen() a file
>>  - blame: report error on open if graft_file is a directory
>>  - bisect: report on fopen() error
>>  - ident.c: use fopen_or_warn()
>>  - attr.c: use fopen_or_warn()
>>  - wrapper.c: add fopen_or_warn()
>>  - wrapper.c: add warn_on_fopen_errors()
>>  - config.mak.uname: set FREAD_READS_DIRECTORIES for Darwin, too
>>  - config.mak.uname: set FREAD_READS_DIRECTORIES for Linux and FreeBSD
>>  - clone: use xfopen() instead of fopen()
>>  - Use xfopen() in more places
>>  - git_fopen: fix a sparse 'not declared' warning
>>
>>  We often try to open a file for reading whose existence is
>>  optional, and silently ignore errors from open/fopen; report such
>>  errors if they are not due to missing files.
>
> If anyone wants to continue this, I've cleaned up the series based on
> Johannes comments here [1]. It does not have the Darwin change though.

Also it seems to be missing the SUPPRESS_FOPEN_REDEF thing by
Ramsay.  I'll mix these two in, post to the list for review and
requeue.

Thanks.


> There was the last question about the '*' test change in ref path and
> what exact code change causes that, which I can't answer because I
> don't have Windows, or the time to simulate and pinpoint the fault on
> Linux.
>
> [1] https://github.com/pclouds/git/commits/fopen-or-warn
