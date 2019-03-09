Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE45320248
	for <e@80x24.org>; Sat,  9 Mar 2019 12:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfCIMel (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 07:34:41 -0500
Received: from mail-it1-f175.google.com ([209.85.166.175]:54089 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfCIMek (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 07:34:40 -0500
Received: by mail-it1-f175.google.com with SMTP id v2so431612ith.3
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 04:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=THhAl7gPMVsVv0O3RC2YniYu1Nw6Q6+dr3lk9W4FCso=;
        b=uTcRSEOVVHDN8oAkaKVbtQNtaAaFxaR/9Mobll4c3K1DoIbOxYwxdkPFWvHE+YJr3q
         1wkuxogB1wiWQz+kMZE7wIw6J2RXp1CjG/s3tS89ak/UerISEilFpZDuR1ggjRBxdlZ8
         nWgNpzoHLEXvzXpLgR9y8iQ9EMmGgPSxOAOAqqRFsoidYn4+68eNWnbBITQhW93pGyNX
         Pl2zylfhLXIQ4kO0CJMiVWBkjkeToZCXoW3ulelRmDnLG+FXxPoJbcEECpjrahkCimeL
         r9qDCqEucw5Kw8E5ojWoDleple6pyUUGFqF0VlMKupEh3xKY34gXny6ieOPMivcWY1Wr
         awTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=THhAl7gPMVsVv0O3RC2YniYu1Nw6Q6+dr3lk9W4FCso=;
        b=L+IwCRtgca55PXbmMJlVF8+RhGsOeZlg9wfNqEIE7d9d662dMcrMDuA1wVW3hCjKe8
         rgo4iq2ZQIsmwC6zHogfEWWVh6IrFU/xsqKRAX1zlz6iKFLVtOhjUVhZG+SZdU+ZctdL
         42papFfeIEh2ysGZQ5Iwur04bsuHP9AbmSRu159S6VG32vEQk106C/16qyVVB+tDJF2M
         PHMm3If8C33q9Zp8XZIJ0N95sNwlbEBHFGgkWTetUBCj+05ID+Z/4Y6Y0c8/2ZzSUfSq
         bqynRcp1mPDO35TWG/QmdhCEZRCF2ihhK4FV0T67SFuLE/ssM4faHmFw9w8f9vCcnU8G
         a5KA==
X-Gm-Message-State: APjAAAUr9Chkc31TifLpQWPmJBAtYSQCn0DQBa3wFursmkgj4HiEiGUh
        Ch56Ly4sshiKW/e8NHsBa2x6041jH/n9xVNlpdw=
X-Google-Smtp-Source: APXvYqwo+3IvJervZrgml4vlrKO07FWrIp3O3+dBx6ILls9c8lS2eYFIX95DRnacxyqRk5zB5VrYtTUotUn+HDVbEm4=
X-Received: by 2002:a24:7cc4:: with SMTP id a187mr11526511itd.171.1552134879417;
 Sat, 09 Mar 2019 04:34:39 -0800 (PST)
MIME-Version: 1.0
References: <CAH8yC8k_Zyi89uxTWTrjN65UAAc1L+jLho+P7O7UyvE-LvZuzA@mail.gmail.com>
 <20190308174343.GX31362@zaya.teonanacatl.net>
In-Reply-To: <20190308174343.GX31362@zaya.teonanacatl.net>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sat, 9 Mar 2019 07:34:15 -0500
Message-ID: <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com>
Subject: Re: One failed self test on Fedora 29
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 8, 2019 at 12:43 PM Todd Zullinger <tmz@pobox.com> wrote:
>
> Jeffrey Walton wrote:
> > Fedora 29, x86_64. One failed self test:
> >
> > *** t0021-conversion.sh ***
> [...]
> > not ok 13 - disable filter with empty override
> > #
> > #               test_config_global filter.disable.smudge false &&
> > #               test_config_global filter.disable.clean false &&
> > #               test_config filter.disable.smudge false &&
> > #               test_config filter.disable.clean false &&
> > #
> > #               echo "*.disable filter=disable" >.gitattributes &&
> > #
> > #               echo test >test.disable &&
> > #               git -c filter.disable.clean= add test.disable 2>err &&
> > #               test_must_be_empty err &&
> > #               rm -f test.disable &&
> > #               git -c filter.disable.smudge= checkout -- test.disable 2>err &&
> > #               test_must_be_empty err
> > #
> [...]
> > # failed 1 among 26 test(s)
> > 1..26
> > gmake[2]: *** [Makefile:56: t0021-conversion.sh] Error 1
> >
> > Does anyone need a config.log or other test data?
>
> It would probably help to know what commit you're building.
> The verbose test output would also be useful, e.g.:

I built with CFLAGS += -fsanitize=undefined. It looks like the
misaligned accesses generate UBsan findings, which is causing
t0021-conversion to fail.

git-2.21.0$ grep -IR 'runtime error'
t/trash directory.t0021-conversion/err:sha1dc/sha1.c:392:2: runtime
error: load of misaligned address 0x0000024fc245 for type 'const
uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/err:sha1dc/sha1.c:397:2: runtime
error: load of misaligned address 0x0000024fc245 for type 'const
uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/err:sha1dc/sha1.c:402:2: runtime
error: load of misaligned address 0x0000024fc245 for type 'const
uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/err:sha1dc/sha1.c:407:2: runtime
error: load of misaligned address 0x0000024fc245 for type 'const
uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/err:sha1dc/sha1.c:412:2: runtime
error: load of misaligned address 0x0000024fc245 for type 'const
uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/err:sha1dc/sha1.c:417:2: runtime
error: load of misaligned address 0x0000024fc245 for type 'const
uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/err:sha1dc/sha1.c:422:2: runtime
error: load of misaligned address 0x0000024fc245 for type 'const
uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/err:sha1dc/sha1.c:427:2: runtime
error: load of misaligned address 0x0000024fc245 for type 'const
uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/err:sha1dc/sha1.c:432:2: runtime
error: load of misaligned address 0x0000024fc245 for type 'const
uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/err:sha1dc/sha1.c:437:2: runtime
error: load of misaligned address 0x0000024fc245 for type 'const
uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/err:sha1dc/sha1.c:442:2: runtime
error: load of misaligned address 0x0000024fc245 for type 'const
uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/err:sha1dc/sha1.c:447:2: runtime
error: load of misaligned address 0x0000024fc245 for type 'const
uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/err:sha1dc/sha1.c:452:2: runtime
error: load of misaligned address 0x0000024fc245 for type 'const
uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/err:sha1dc/sha1.c:457:2: runtime
error: load of misaligned address 0x0000024fc245 for type 'const
uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/err:sha1dc/sha1.c:462:2: runtime
error: load of misaligned address 0x0000024fc245 for type 'const
uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/err:sha1dc/sha1.c:467:2: runtime
error: load of misaligned address 0x0000024fc245 for type 'const
uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/git-stderr.log:sha1dc/sha1.c:392:2:
runtime error: load of misaligned address 0x000001a39cf5 for type
'const uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/git-stderr.log:sha1dc/sha1.c:397:2:
runtime error: load of misaligned address 0x000001a39cf5 for type
'const uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/git-stderr.log:sha1dc/sha1.c:402:2:
runtime error: load of misaligned address 0x000001a39cf5 for type
'const uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/git-stderr.log:sha1dc/sha1.c:407:2:
runtime error: load of misaligned address 0x000001a39cf5 for type
'const uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/git-stderr.log:sha1dc/sha1.c:412:2:
runtime error: load of misaligned address 0x000001a39cf5 for type
'const uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/git-stderr.log:sha1dc/sha1.c:417:2:
runtime error: load of misaligned address 0x000001a39cf5 for type
'const uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/git-stderr.log:sha1dc/sha1.c:422:2:
runtime error: load of misaligned address 0x000001a39cf5 for type
'const uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/git-stderr.log:sha1dc/sha1.c:427:2:
runtime error: load of misaligned address 0x000001a39cf5 for type
'const uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/git-stderr.log:sha1dc/sha1.c:432:2:
runtime error: load of misaligned address 0x000001a39cf5 for type
'const uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/git-stderr.log:sha1dc/sha1.c:437:2:
runtime error: load of misaligned address 0x000001a39cf5 for type
'const uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/git-stderr.log:sha1dc/sha1.c:442:2:
runtime error: load of misaligned address 0x000001a39cf5 for type
'const uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/git-stderr.log:sha1dc/sha1.c:447:2:
runtime error: load of misaligned address 0x000001a39cf5 for type
'const uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/git-stderr.log:sha1dc/sha1.c:452:2:
runtime error: load of misaligned address 0x000001a39cf5 for type
'const uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/git-stderr.log:sha1dc/sha1.c:457:2:
runtime error: load of misaligned address 0x000001a39cf5 for type
'const uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/git-stderr.log:sha1dc/sha1.c:462:2:
runtime error: load of misaligned address 0x000001a39cf5 for type
'const uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/git-stderr.log:sha1dc/sha1.c:467:2:
runtime error: load of misaligned address 0x000001a39cf5 for type
'const uint32_t', which requires 4 byte alignment
