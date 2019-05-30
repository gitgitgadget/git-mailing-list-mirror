Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AFFD1F462
	for <e@80x24.org>; Thu, 30 May 2019 18:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfE3SYq (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 14:24:46 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:41252 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3SYp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 14:24:45 -0400
Received: by mail-qt1-f169.google.com with SMTP id s57so8181880qte.8
        for <git@vger.kernel.org>; Thu, 30 May 2019 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OAT+64ixR1GxtCLoPPl7lyh57KHIQzG6GQ8uv666zoA=;
        b=qnEUfg0swfThy0BNAu7TTA1t66n9Jcn7qVbSjOgZRsHoj/416JNWn/YeNSnM6xFphj
         Mhe+QBthSP6/MHpuD33sRFC9edVEVR9YcyyPjFkJ9AGklPanahi1j9DUsBFCbj+ROjDs
         ArqLrqSQ7QLIA9v2W7pvaU1nHzFV7bfvaCYPnqCssK54gcwSoJj0JIb1RxwH0LELlqqE
         qBKA8l++qlL9s0hoMPiZDqzdzxJpeF3jlcK+N2S9pQamjrAy+ydQ5Aw5Rl13bYNtEgcQ
         X6SHyBWeYNLjwVHL+b37NMigEZn9SciLgONsLMLh/RgSicAZfPIev5ZJw68mYGSBgyiK
         C8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OAT+64ixR1GxtCLoPPl7lyh57KHIQzG6GQ8uv666zoA=;
        b=gEG4l1kDYVCfsVKoGccp7L+R47qbDeqPG6gxXx7+lSvwKlllTE2dvEDD/llpujcnLq
         pdGyqrQFTEHBPVbHKxUDeFhepmlXPFq9/0KceJCRpOJsocdZtCooUVH/o5tGkKGRFOso
         sD1r85er/DBKLo2TY0hipBXTjgcMq5kbbI3GXjrsq9m3MJBp352dO/SOzuNHMnj2743c
         DcfsTWxrxJSnoJmGkuZ9iyC0+tLFxOvRw6/TbSL6FP7jcyEXehSxXGyeFw98uvM1k2vB
         vXcix1/9DiUisY5Yg4lAB93GmO06qyYi32lF3fsvXxLOq8eWNmjYixZgTZb2x7FSscU8
         jRYQ==
X-Gm-Message-State: APjAAAVMIM5mfilfsV6N++bJRcWz5UHS0H22XN0kgyzVLxzEazGbucaQ
        rRTYR5HUg7zJDRfu1bB4gvsmplV/7+s=
X-Google-Smtp-Source: APXvYqwcBRaIKkkME3OwP3WddgpsGhYi2cg4+PjzJH+th0BERUnYvisxOfkc8ila0EgwkoxqRYDTGg==
X-Received: by 2002:ac8:7301:: with SMTP id x1mr4932508qto.209.1559240683945;
        Thu, 30 May 2019 11:24:43 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id s64sm1753759qkb.56.2019.05.30.11.24.42
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 11:24:43 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Thursday, May 30th)
From:   Derrick Stolee <stolee@gmail.com>
To:     GIT Mailing-list <git@vger.kernel.org>
References: <2fb43bd3-71a7-fd92-e9b8-43e4eeed34cd@gmail.com>
Cc:     Barret Rhoden <brho@google.com>, michael@platin.gs,
        Jonathan Tan <jonathantanmy@google.com>
Message-ID: <e18e4391-a574-1f4b-88c7-890ada116f51@gmail.com>
Date:   Thu, 30 May 2019 14:24:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <2fb43bd3-71a7-fd92-e9b8-43e4eeed34cd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I decided to take a stab at a full review of the test coverage report in
order to try and understand all of the uncovered code. The snippets I
highlight below include uncovered code that is not immediately obvious as
an acceptable block to leave uncovered. (Some snippets required looking
around at the context to know that is the case.)

In at least one case, I found a block that is actually covered in my
local testing, so something is wrong with the build environment I use
to generate this report. I'm currently investigating.

On 5/30/2019 8:52 AM, Derrick Stolee wrote:
> blame.c
> 170072f9 846)     (result[i] >= most_certain_line_a ||
> 170072f9 847)      second_best_result[i] >= most_certain_line_a)) {
> 170072f9 848) certainties[i] = CERTAINTY_NOT_CALCULATED;

This section appears in the following block:

        /* More invalidating of results that may be affected by the choice of
         * most certain line.
         * Discard the matches for lines in B that are currently matched with a
         * line in A such that their ordering contradicts the ordering imposed
         * by the choice of most certain line.
         */
        for (i = most_certain_local_line_b - 1; i >= invalidate_min; --i) {
                /* In this loop we discard results for lines in B that are
                 * before most-certain-line-B but are matched with a line in A
                 * that is after most-certain-line-A.
                 */
                if (certainties[i] >= 0 &&
                    (result[i] >= most_certain_line_a ||
                     second_best_result[i] >= most_certain_line_a)) {
                        certainties[i] = CERTAINTY_NOT_CALCULATED;
                }
        }
        for (i = most_certain_local_line_b + 1; i < invalidate_max; ++i) {
                /* In this loop we discard results for lines in B that are
                 * after most-certain-line-B but are matched with a line in A
                 * that is before most-certain-line-A.
                 */
                if (certainties[i] >= 0 &&
                    (result[i] <= most_certain_line_a ||
                     second_best_result[i] <= most_certain_line_a)) {
                        certainties[i] = CERTAINTY_NOT_CALCULATED;
                }
        }

Note that the first for loop includes the uncovered lines. The logical operands
are backwards of the conditions in the second for loop, which are covered. This
seems non-trivial enough to merit a test.

> 170072f9 951) max_search_distance_b = 0;
> 1fc73384 998) return;
> 8934ac8c 1190)     ent->ignored == next->ignored &&
> 8934ac8c 1191)     ent->unblamable == next->unblamable) {

These lines are part of this diff:

--- a/blame.c
+++ b/blame.c
@@ -479,7 +479,9 @@ void blame_coalesce(struct blame_scoreboard *sb)

        for (ent = sb->ent; ent && (next = ent->next); ent = next) {
                if (ent->suspect == next->suspect &&
-                   ent->s_lno + ent->num_lines == next->s_lno) {
+                   ent->s_lno + ent->num_lines == next->s_lno &&
+                   ent->ignored == next->ignored &&
+                   ent->unblamable == next->unblamable) {
                        ent->num_lines += next->num_lines;
                        ent->next = next->next;
                        blame_origin_decref(next->suspect);

The fact that they are uncovered means that the && chain is short-circuited at
"ent->s_lno + ent->num_lines == next->s_lno" before the new conditions can be
checked. So, the block inside is never covered. It includes a call to
blame_origin_decref() and free(), so it would be good to try and exercise this region.

> http.c
> ee334603 2302) target ? hash_to_hex(target->hash) : base_url,

This line being uncovered means that 'target' is never NULL. In the code above,
base_url is used in all cases so this is safe enough.

> promisor-remote.c

> 7bdf0926 93) previous->next = r->next;

This isn't being hit because "previous" is always NULL in the call to
promisor_remote_move_to_tail(), which is filled by a call to
promisor_remote_lookup(). All of this code is rather difficult to read
(double pointers, for loops with two iterator variables) so it is hard
to do the mental math and guarantee that it is working.

I tried playing around with adding more promisor remotes to t0410-partial-clone.sh,
but could not get this line to hit.

> dcc8b4e9 202) static int remove_fetched_oids(struct object_id **oids, int oid_nr, int to_free)

This method isn't covered at all, so I responded directly to the patch thread.

> upload-pack.c
> a8d662e3 355) send_client_data(1, output_state.buffer, output_state.used);

This line looks like a copy-paste from a method refactor.

> 820a5361 1386) string_list_clear(&data->uri_protocols, 0);

This string_list_clear() is preceded by

	if (data->uri_protocols.nr && !data->writer.use_sideband)

but earlier is populated by 

                if (skip_prefix(arg, "packfile-uris ", &p)) {
                        string_list_split(&data->uri_protocols, p, ',', -1);
                        continue;
                }

Why don't we simply not use string_list_split() if !data->writer.use_sideband?

I would apply this diff to avoid calling string_list_split at all:

diff --git a/upload-pack.c b/upload-pack.c
index db74ca57bd..267b419521 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1373,7 +1373,7 @@ static void process_args(struct packet_reader *request,
                        continue;
                }

-               if (skip_prefix(arg, "packfile-uris ", &p)) {
+               if (skip_prefix(arg, "packfile-uris ", &p) && data->writer.use_sideband) {
                        string_list_split(&data->uri_protocols, p, ',', -1);
                        continue;
                }
@@ -1381,9 +1381,6 @@ static void process_args(struct packet_reader *request,
                /* ignore unknown lines maybe? */
                die("unexpected line: '%s'", arg);
        }
-
-       if (data->uri_protocols.nr && !data->writer.use_sideband)
-               string_list_clear(&data->uri_protocols, 0);
 }

 static int process_haves(struct oid_array *haves, struct oid_array *common,


> commit-graph.c
> 93ba1867 969) display_progress(ctx->progress, ctx->approx_nr_objects);

This line seemed suspicious, but is preceded by

	if (ctx->progress_done < ctx->approx_nr_objects)

so is pretty harmless to leave uncovered.

> builtin/fast-export.c
> e80001f8 81) static int parse_opt_reencode_mode(const struct option *opt,

I'm always suspicious of a method that is never called by the test suite.
The only caller is given by this portion of the patch:

+               OPT_CALLBACK(0, "reencode", &reencode_mode, N_("mode"),
+                           N_("select handling of commit messages in an alternate encoding"),
+                           parse_opt_reencode_mode),

But we DO have tests that cover this flag, and inserting a die() in the
method triggers it on t9350-fast-export.sh. I'll investigate what went wrong
on the build [1] to cause this. I see a lot of these in the logs:

	sh: echo: I/O error

So maybe some tests did not actually run. Further, these tests failed:

t3400-rebase.sh                           (Wstat: 256 Tests: 28 Failed: 2)
  Failed tests:  20, 28
  Non-zero exit status: 1
t3420-rebase-autostash.sh                 (Wstat: 256 Tests: 38 Failed: 6)
  Failed tests:  6, 13, 16, 23, 26, 33
  Non-zero exit status: 1
t3404-rebase-interactive.sh               (Wstat: 256 Tests: 110 Failed: 5)
  Failed tests:  3, 9-10, 100-101
  Non-zero exit status: 1
t5521-pull-options.sh                     (Wstat: 256 Tests: 19 Failed: 1)
  Failed test:  3
  Non-zero exit status: 1
t5551-http-fetch-smart.sh                 (Wstat: 256 Tests: 37 Failed: 1)
  Failed test:  26
  Non-zero exit status: 1

They don't fail locally, so perhaps we shouldn't blindly trust the coverage data
until I work out why these errors occurred. (Many of the cases I called out
above I couldn't hit locally with a die() statement.)

[1] https://dev.azure.com/git/git/_build/results?buildId=606

> builtin/rebase.c
> 4c785c0e 1201) opts->flags &= ~REBASE_DIFFSTAT;

This is the only changed line in this commit, which the commit message states was
found by static analysis.

> fast-import.c
> 3edfcc65 2612) read_next_command();
> 3edfcc65 2679) strbuf_addf(&new_data,

I expect this is actually covered, but wasn't reported due to the issues listed above.

> progress.c
> 1aed1a5f 131)     cols - progress->title_len - 1 : 0;

This is the only changed line in this commit.
 
> read-cache.c
> 7bd9631b 2201) src_offset += load_cache_entries_threaded(istate, mmap, mmap_size, nr_threads, ieot);

This was previously uncovered and this commit simply changed the method prototype.

> refs.c
> 1de16aec 111) sanitized->buf[sanitized->len-1] = '-';
> 1de16aec 170) if (sanitized)
> 1de16aec 171) strbuf_addch(sanitized, '-');
> 1de16aec 173) return -1;
> 1de16aec 178) strbuf_complete(sanitized, '/');

These are special cases of custom ref types used in "git worktree add" and some
of them are covered by tests, but these seem harmless.

Thanks,
-Stolee
