Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C04D81FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 22:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbdDCWbj (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 18:31:39 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36641 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbdDCWbj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 18:31:39 -0400
Received: by mail-pg0-f46.google.com with SMTP id g2so131791899pge.3
        for <git@vger.kernel.org>; Mon, 03 Apr 2017 15:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZsFPqp9iUxbL0VXTl2Yi0zQF3ELQ/3L+rybYI1UaGts=;
        b=TbH9JXdRvEAskc/mI38RvATJ4N0Tzo5R4B8PFoUmLHP0lkbzpPe2t/59+3jEDCoC02
         EcnAAs64dJsQvC2vd+jiYLYJugI/4Kh+ypo8VCZ77JBAdYNZRgDSJVo051/SXAeNMT2c
         pFfYi0asuuEaF5/bziQEByJlnvNIRzmMJBWZId/dffsOhTCoHniDBw3h/ZRHa2WXeNo6
         wVHGoh0GJmj7UCvsaohKzcLODp7k4PRD7jAISXPmhw3+IKMXl6dMkIWiEdmuMMZ9a4ow
         Nc8HOBrUwIMxItQGz80iDHfIkNloTzvvfDdIYg+d7AHHcYZMaOjFsmz/VnleZVVFl/uo
         XCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZsFPqp9iUxbL0VXTl2Yi0zQF3ELQ/3L+rybYI1UaGts=;
        b=uSn61Z9X/HPTbLFCtUQDzCrF3djWWvJQYn6jVC2i7/Pk909g6AjHXMr1L155PLyqno
         eVYMmf4EnPyednJWDGTJExnjBXSqbZWLqV+ynbdIhQDmjMaEbJRKBuI3PjW0rUhZ/zaf
         akQ4+IyASfBFq12xwxnJdtOX0lo9GyAg5KMBUddwBVO+B17SMsJeFFYUm+J6yS7SN0w2
         EoXs45nhQevHxBKRzmTDuiQQh4s2rreFk0LZBg0VJE0b75a8kDNvuhcaUcjyXEAl/pQA
         zYqGaXoo3dKr3JsWRfRf5N2cSNP8d8fPfox4660JmfsDFRLJXT1ABW3SQ2xkrZNbYl1x
         ogCg==
X-Gm-Message-State: AFeK/H1uHXvVVjocCPxcXb0TBXjUBuy4Z71QuAjTH0+uNsvb3UQyR0JsA3SQMA2qy8idAFp/PPB2ZXQRsG19aZxv
X-Received: by 10.98.204.25 with SMTP id a25mr19561337pfg.6.1491258698129;
 Mon, 03 Apr 2017 15:31:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Mon, 3 Apr 2017 15:31:37 -0700 (PDT)
In-Reply-To: <1491163388-41255-2-git-send-email-bnmvco@gmail.com>
References: <1491163388-41255-1-git-send-email-bnmvco@gmail.com> <1491163388-41255-2-git-send-email-bnmvco@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 3 Apr 2017 15:31:37 -0700
Message-ID: <CAGZ79ka032GPTp1Y5GH5joKm1_arf4GAywPXipt869MobRwrVA@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] dir_iterator: add tests for dir_iterator API
To:     Daniel Ferreira <bnmvco@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 2, 2017 at 1:03 PM, Daniel Ferreira <bnmvco@gmail.com> wrote:
> Create t/helper/test-dir-iterator.c, which prints relevant information
> about a directory tree iterated over with dir_iterator.
>
> Create t/t0065-dir-iterator.sh, which tests that dir_iterator does
> iterate through a whole directory tree.
>
> Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
> ---
>  Makefile                     |  1 +
>  t/helper/.gitignore          |  1 +
>  t/helper/test-dir-iterator.c | 28 +++++++++++++++++++++++
>  t/t0065-dir-iterator.sh      | 54 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 84 insertions(+)
>  create mode 100644 t/helper/test-dir-iterator.c
>  create mode 100755 t/t0065-dir-iterator.sh
>
> diff --git a/Makefile b/Makefile
> index 9b36068..41ce9ab 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -614,6 +614,7 @@ TEST_PROGRAMS_NEED_X += test-ctype
>  TEST_PROGRAMS_NEED_X += test-config
>  TEST_PROGRAMS_NEED_X += test-date
>  TEST_PROGRAMS_NEED_X += test-delta
> +TEST_PROGRAMS_NEED_X += test-dir-iterator
>  TEST_PROGRAMS_NEED_X += test-dump-cache-tree
>  TEST_PROGRAMS_NEED_X += test-dump-split-index
>  TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
> diff --git a/t/helper/.gitignore b/t/helper/.gitignore
> index 758ed2e..a7d74d3 100644
> --- a/t/helper/.gitignore
> +++ b/t/helper/.gitignore
> @@ -3,6 +3,7 @@
>  /test-config
>  /test-date
>  /test-delta
> +/test-dir-iterator
>  /test-dump-cache-tree
>  /test-dump-split-index
>  /test-dump-untracked-cache
> diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
> new file mode 100644
> index 0000000..06f03fc
> --- /dev/null
> +++ b/t/helper/test-dir-iterator.c
> @@ -0,0 +1,28 @@
> +#include "git-compat-util.h"
> +#include "strbuf.h"
> +#include "iterator.h"
> +#include "dir-iterator.h"
> +
> +int cmd_main(int argc, const char **argv) {
> +       struct strbuf path = STRBUF_INIT;
> +       struct dir_iterator *diter;
> +
> +       if (argc < 2) {

Coding style: please use no braces for single statements after
control structures (if, for, while).

Instead of just returning 1 (which is harder to diagnose in an
interactive shell for users who do not know the details of this
program), we could

    die("BUG: test-dir-iterator takes exactly one argument");

> +               return 1;
> +       }
> +
> +       strbuf_add(&path, argv[1], strlen(argv[1]));
> +
> +       diter = dir_iterator_begin(path.buf);
> +
> +       while (dir_iterator_advance(diter) == ITER_OK) {
> +               if (S_ISDIR(diter->st.st_mode))
> +                       printf("[d] ");
> +               else
> +                       printf("[f] ");

In the operating system there are more 'st_mode's than
just directory or file, e.g. symbolic link.

Maybe

    else if (S_ISREG(diter->st.st_mode))
        printf("[f] ");
    else
        printf("[?]");

to catch the unknown things better instead of
defaulting them to regular files?

> +#!/bin/sh
> +
> +test_description='Test directory iteration.'
> +
> +. ./test-lib.sh
> +
> +cat >expect-sorted-output <<-\EOF &&
> +[d] (a) ./dir/a
> +[d] (a/b) ./dir/a/b
> +[d] (a/b/c) ./dir/a/b/c
> +[d] (d) ./dir/d
> +[d] (d/e) ./dir/d/e
> +[d] (d/e/d) ./dir/d/e/d
> +[f] (a/b/c/d) ./dir/a/b/c/d
> +[f] (a/e) ./dir/a/e
> +[f] (b) ./dir/b
> +[f] (c) ./dir/c
> +[f] (d/e/d/a) ./dir/d/e/d/a
> +EOF
> +
> +test_expect_success 'dir-iterator should iterate through all files' '
> +       mkdir -p dir &&
> +       mkdir -p dir/a/b/c/ &&
> +       >dir/b &&
> +       >dir/c &&
> +       mkdir -p dir/d/e/d/ &&
> +       >dir/a/b/c/d &&
> +       >dir/a/e &&
> +       >dir/d/e/d/a &&
> +
> +       test-dir-iterator ./dir | sort >./actual-pre-order-sorted-output &&

We just had some micro projects that were trying to get rid of git
commands on the upstream of a pipe, to better observe
the exit codes of the programs that we write here. I think it is
not as critical for test helpers, but the it would be better to diagnose
an error when we had

    test-dir-iterator ./dir >out &&
    sort <out >actual &&
    test_cmp expect actual

as in case of an error we'd stop early in the && chain at test-dir-iterator
(and if that would use the die() function we'd even get some error message
on stderr).

> +       rm -rf dir &&

I'd put that cleanup first via
test_expect_success 'title' '
    test_when_finished "rm -rf dir" &&
    mkdir ... &&
    ...
'

By doing so, an inspection is easier afterwards.
When this test breaks, you'd want to debug it via e.g.

  cd t
  ./t0065-dir-iterator.sh -d -i -v -x # see README for all the nice flags)

which in case of error would stop at e.g. test_cmp failing. But at that
point of the test we already removed the files so it is impossible to inspect
what was on the file system, without adding a test_pause before the rm.

> +
> +       test_cmp expect-sorted-output actual-pre-order-sorted-output

Usually the file names are shorter (expect, actual), but I do not
mind encoding some expectation in them.

Thanks,
Stefan
