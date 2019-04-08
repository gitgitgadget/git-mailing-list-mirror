Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79C0620248
	for <e@80x24.org>; Mon,  8 Apr 2019 09:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbfDHJ7E (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 05:59:04 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:33041 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfDHJ7D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 05:59:03 -0400
Received: by mail-it1-f196.google.com with SMTP id v8so16755442itf.0
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 02:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upJobZnjTvNEY0FAzfT/VFpv3GBXcN9SqbeP6p6zORI=;
        b=Sr84pvGyH6kfbHNXQWp1ziUCjhESFT7ufH1hfRkNnCTO+uxY1GrakAChb9goJPB0Aq
         hXgAqibC1hkr6B4B7Gz7dB6gVQV+QclHkH09YoLUV6O5CHytaHFk/QS6CnKfApsCWNOk
         fVz8dW87VHoGVRW2dxUn3M9UiGMK0dF2DvfoS/r2HoIVjHMynqSSWfoWtYq5BuatBKHf
         ZKUyMcRK7kmFIVv4I+m3g1lfc2zoy2a5aSmVFM6VCj/4p8nN6wRfX6SLm3/TdyE5hGsn
         1cCC+CagDKWNPPwaao7yceuvl4DguiAkbZ0G5kuUkhVWZySSlUWMbUf9kxcxvjxKsIz3
         mb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upJobZnjTvNEY0FAzfT/VFpv3GBXcN9SqbeP6p6zORI=;
        b=gBnAFhpVrxGAJWvbAErvQ+zbqBQ/tgGVdS2VUU+GP6//E+qKb+zK4mmTz5GrX63uvi
         v2pJH/52Y6kHJoyRnKsqNe7lbQHpc5xxmXpMlj7sBUZH69DJT9VplJhHFK95jr3bBgFL
         SMnM0FhyORcmXrIJ8QmTn0cHc9bPgz22PRFrAmp/+zah32qZDAobExHMGM2iIQ1Ibgb0
         lCa1ysof2riw6pt1cCVX8mNF3JeXCoNSYNquDcRjZ4IH3RM72wE6w9LTfvEOmyYxKdG0
         LgFD3CMXRNPEH9UpdlwcMhi++GpvIW/b3BA22QTcAx4s2uQMHmbP+nZfzSxOhlaKVXJE
         PmIw==
X-Gm-Message-State: APjAAAUFE73ZQ6KWYUppg9dX0eBvEx1urotVUxcXD+D7prPXFJAb+VCs
        NEPG8xr1eUOiA8WuNtNjlT735rhriIj8Q3MHxDY=
X-Google-Smtp-Source: APXvYqy1sbYBAqJKr+RlcsKxJFVlPrPmvx7kQemYcspAnmJP+orxcs3WXxHrJ6dUoSmUg0llZmhxUszbNgkWryBQXlc=
X-Received: by 2002:a24:f8c7:: with SMTP id a190mr11813937ith.72.1554717542700;
 Mon, 08 Apr 2019 02:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <CACsJy8CgXLZxqab4vcP1jh3OMCGh1i=easb5BpCs1J8Uf_jsxw@mail.gmail.com>
 <20190405170934.20441-1-jonathantanmy@google.com> <CACsJy8AjyY1Azbf4VfnJMA3O8NNBV1P16dZRrHOUJdsYQHUu4g@mail.gmail.com>
 <xmqqmul1b0pg.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmul1b0pg.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 8 Apr 2019 16:58:35 +0700
Message-ID: <CACsJy8BHqaqOHVbwtONU5=RiG7Q8WNNAN5EGV_nm7NyNWeyuiQ@mail.gmail.com>
Subject: Re: [PATCH] fixup! diff: batch fetching of missing blobs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 8, 2019 at 11:06 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> >> Avoid a usage of the_repository by propagating the configured repository
> >> to add_if_missing(). Also, prefetch only if the repository being diffed
> >> is the_repository (because we do not support lazy fetching for any other
> >> repository anyway).
>
> If we are willing to stay limited to the default repository anyway,
> allowing add_if_missing() to take an arbitrary repository does not
> really matter, but before the caller of add_if_missing() befcomes
> ready to work on an arbitrary repository, this change has to happen.
>
> To update the caller, it seems to me that fetch_objects() must learn
> to take an arbitrary repository, but is that the only thing needed?
> After that, the function that the caller resides in and callchain
> upwards can learn to take a repository instance if we want to be
> able to diff inside an arbitrary repository.
>
> But.  Such a change still would not allow us to compare a tree in
> one repository against a tree in another repository.

I feel lost (and the answer "go read partial clone code!" is perfectly
acceptable) but why would we need to diff trees of two different
repositories?

> It is likely
> that a caller with such a need would simply make sure that objects
> in both repositories are available by using the in-core alternate
> object store mechanism, making it a more-or-less moot point to be
> able to pass a repository instance through the callchain X-<.  We
> probably should make it, and spell it out somewhere in a long term
> vision shared among the developers, an explicit goal to get rid of
> the internal (ab)use of the alternate object store mechanism.

I think submodule code so far is doing this way. Though I don't see
any reason we need it for submodule code. Objects are not supposed to
be shared between the super- and the sub-repo.

>
> With squashing the fix-up commit in, the 2/2 patch has become like
> so.
>
> Thanks, both.
>
> -- >8 --
> From: Jonathan Tan <jonathantanmy@google.com>
> Date: Fri, 5 Apr 2019 10:09:34 -0700
> Subject: [PATCH] diff: batch fetching of missing blobs
>
> When running a command like "git show" or "git diff" in a partial clone,
> batch all missing blobs to be fetched as one request.
>
> This is similar to c0c578b33c ("unpack-trees: batch fetching of missing
> blobs", 2017-12-08), but for another command.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  diff.c                        |  33 +++++++++++
>  t/t4067-diff-partial-clone.sh | 103 ++++++++++++++++++++++++++++++++++
>  2 files changed, 136 insertions(+)
>  create mode 100755 t/t4067-diff-partial-clone.sh
>
> diff --git a/diff.c b/diff.c
> index ec5c095199..811afbdfb1 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -25,6 +25,7 @@
>  #include "packfile.h"
>  #include "parse-options.h"
>  #include "help.h"
> +#include "fetch-object.h"
>
>  #ifdef NO_FAST_WORKING_DIRECTORY
>  #define FAST_WORKING_DIRECTORY 0
> @@ -6366,8 +6367,40 @@ void diffcore_fix_diff_index(void)
>         QSORT(q->queue, q->nr, diffnamecmp);
>  }
>
> +static void add_if_missing(struct oid_array *to_fetch, struct repository *r,
> +                          const struct diff_filespec *filespec)
> +{
> +       if (filespec && filespec->oid_valid &&
> +           oid_object_info_extended(r, &filespec->oid, NULL,
> +                                    OBJECT_INFO_FOR_PREFETCH))
> +               oid_array_append(to_fetch, &filespec->oid);
> +}
> +
>  void diffcore_std(struct diff_options *options)
>  {
> +       if (options->repo == the_repository &&
> +           repository_format_partial_clone) {
> +               /*
> +                * Prefetch the diff pairs that are about to be flushed.
> +                */
> +               int i;
> +               struct diff_queue_struct *q = &diff_queued_diff;
> +               struct oid_array to_fetch = OID_ARRAY_INIT;
> +
> +               for (i = 0; i < q->nr; i++) {
> +                       struct diff_filepair *p = q->queue[i];
> +                       add_if_missing(&to_fetch, options->repo, p->one);
> +                       add_if_missing(&to_fetch, options->repo, p->two);
> +               }
> +               if (to_fetch.nr)
> +                       /*
> +                        * NEEDSWORK: Consider deduplicating the OIDs sent.
> +                        */
> +                       fetch_objects(repository_format_partial_clone,
> +                                     to_fetch.oid, to_fetch.nr);
> +               oid_array_clear(&to_fetch);
> +       }
> +
>         /* NOTE please keep the following in sync with diff_tree_combined() */
>         if (options->skip_stat_unmatch)
>                 diffcore_skip_stat_unmatch(options);
> diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
> new file mode 100755
> index 0000000000..90c8fb2901
> --- /dev/null
> +++ b/t/t4067-diff-partial-clone.sh
> @@ -0,0 +1,103 @@
> +#!/bin/sh
> +
> +test_description='behavior of diff when reading objects in a partial clone'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'git show batches blobs' '
> +       test_when_finished "rm -rf server client trace" &&
> +
> +       test_create_repo server &&
> +       echo a >server/a &&
> +       echo b >server/b &&
> +       git -C server add a b &&
> +       git -C server commit -m x &&
> +
> +       test_config -C server uploadpack.allowfilter 1 &&
> +       test_config -C server uploadpack.allowanysha1inwant 1 &&
> +       git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
> +
> +       # Ensure that there is exactly 1 negotiation by checking that there is
> +       # only 1 "done" line sent. ("done" marks the end of negotiation.)
> +       GIT_TRACE_PACKET="$(pwd)/trace" git -C client show HEAD &&
> +       grep "git> done" trace >done_lines &&
> +       test_line_count = 1 done_lines
> +'
> +
> +test_expect_success 'diff batches blobs' '
> +       test_when_finished "rm -rf server client trace" &&
> +
> +       test_create_repo server &&
> +       echo a >server/a &&
> +       echo b >server/b &&
> +       git -C server add a b &&
> +       git -C server commit -m x &&
> +       echo c >server/c &&
> +       echo d >server/d &&
> +       git -C server add c d &&
> +       git -C server commit -m x &&
> +
> +       test_config -C server uploadpack.allowfilter 1 &&
> +       test_config -C server uploadpack.allowanysha1inwant 1 &&
> +       git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
> +
> +       # Ensure that there is exactly 1 negotiation by checking that there is
> +       # only 1 "done" line sent. ("done" marks the end of negotiation.)
> +       GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff HEAD^ HEAD &&
> +       grep "git> done" trace >done_lines &&
> +       test_line_count = 1 done_lines
> +'
> +
> +test_expect_success 'diff skips same-OID blobs' '
> +       test_when_finished "rm -rf server client trace" &&
> +
> +       test_create_repo server &&
> +       echo a >server/a &&
> +       echo b >server/b &&
> +       git -C server add a b &&
> +       git -C server commit -m x &&
> +       echo another-a >server/a &&
> +       git -C server add a &&
> +       git -C server commit -m x &&
> +
> +       test_config -C server uploadpack.allowfilter 1 &&
> +       test_config -C server uploadpack.allowanysha1inwant 1 &&
> +       git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
> +
> +       echo a | git hash-object --stdin >hash-old-a &&
> +       echo another-a | git hash-object --stdin >hash-new-a &&
> +       echo b | git hash-object --stdin >hash-b &&
> +
> +       # Ensure that only a and another-a are fetched.
> +       GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff HEAD^ HEAD &&
> +       grep "want $(cat hash-old-a)" trace &&
> +       grep "want $(cat hash-new-a)" trace &&
> +       ! grep "want $(cat hash-b)" trace
> +'
> +
> +test_expect_success 'diff with rename detection batches blobs' '
> +       test_when_finished "rm -rf server client trace" &&
> +
> +       test_create_repo server &&
> +       echo a >server/a &&
> +       printf "b\nb\nb\nb\nb\n" >server/b &&
> +       git -C server add a b &&
> +       git -C server commit -m x &&
> +       rm server/b &&
> +       printf "b\nb\nb\nb\nbX\n" >server/c &&
> +       git -C server add c &&
> +       git -C server commit -a -m x &&
> +
> +       test_config -C server uploadpack.allowfilter 1 &&
> +       test_config -C server uploadpack.allowanysha1inwant 1 &&
> +       git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
> +
> +       # Ensure that there is exactly 1 negotiation by checking that there is
> +       # only 1 "done" line sent. ("done" marks the end of negotiation.)
> +       GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff -M HEAD^ HEAD >out &&
> +       grep "similarity index" out &&
> +       grep "git> done" trace >done_lines &&
> +       test_line_count = 1 done_lines
> +'
> +
> +test_done
> --
> 2.21.0-196-g041f5ea1cf
>


-- 
Duy
