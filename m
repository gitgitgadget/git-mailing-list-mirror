Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07F8D1F954
	for <e@80x24.org>; Sat, 18 Aug 2018 15:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbeHRSTa (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 14:19:30 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36313 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeHRSTa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 14:19:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id k15-v6so6078038edr.3
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 08:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NnAJPwEhdwqwXHIW5HLH9vfaSyRzKbEpFyQWI17+j9I=;
        b=ZGggflcyRSDnua6Gulu8chtoHYiASf2DStLqL8mKv+86XcMjCj+2Cq8jlrBBpGjvSi
         xS0A3cpfEol+82abQoyXaNcaO/1ZN7jTLauF+XuXlfbQ+GwQELEOV2D48PMgxiFr852z
         IMUE0f+8djDr/qOBgQsVxJRj08+r5YVVidpv08JKuSIKlpcVOFYmgFTrVx8NjumgA+xP
         V3LdVc9VeRq/IB09f2bOY/e7zs5D7GOk2p+/IIxkrCjzwjxbKvHEY7SSRguSyTCwIu8m
         w+QYHyfiP5djMCw0r+/CsuKhlqqVO5S1A99PH45pRnQ04vBOUszKV+T24ccg/e3pO3BY
         xyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NnAJPwEhdwqwXHIW5HLH9vfaSyRzKbEpFyQWI17+j9I=;
        b=ksqM1vCrc2acmGH+L4achHkdaZCTBmgS7CiVxgHQqCF3XNezfLWsP0h0zEBiSMYwkx
         4p1xb349NTcCb7o+8Q04g8iCwejArUZqdirREeoeV76e6vIMML5G45kE3fPM5RCaN5Bt
         GSak8lNZPnwdCeA4/QwgmiK3n7Pe0zkNJXwWDT4nzna71zmwzvIdzYM1u7p4kWq3tlFR
         7Nw0s65Y9y9LIUAzy7YkpDCx6J3A6NvX/QmvDPBcOqKcEcfui3HHEMc/QXYO+ADSnHqb
         QCaBqxxN4Yuc6jYq1U+kCcnsnq+s/fOb401anv7b4RGJEoBnFRHqOaSs0ZrfdSxlQHr0
         tQog==
X-Gm-Message-State: AOUpUlEbYRMHBEzH6LDtkPrVmLUqdOo12rnzKyX4nLdVl9bf0BJEb8Fr
        3/SXBueb9pu+Fn3cal2ynmm/VmporG70Fl0gZr0=
X-Google-Smtp-Source: AA+uWPzPjVzAGsBD56NfzvniK8TRW1yUuCdVAC7i/7O0GiiO8gmi/urxwzUxRvJ4jWRgHIGHYIx5nTxWW8AeClu7u1Y=
X-Received: by 2002:a50:c313:: with SMTP id a19-v6mr47781063edb.177.1534605087089;
 Sat, 18 Aug 2018 08:11:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:2642:0:0:0:0 with HTTP; Sat, 18 Aug 2018 08:11:26
 -0700 (PDT)
In-Reply-To: <20180815210142.GN2734@hank.intra.tgummerer.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <35e6fdfab85c21f0554da061cfab3f643d1aa794.1533753605.git.ungureanupaulsebastian@gmail.com>
 <20180815210142.GN2734@hank.intra.tgummerer.com>
From:   Paul Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Date:   Sat, 18 Aug 2018 18:11:26 +0300
Message-ID: <CADzBBBbrE7DFQ_wN1VEYriagjfWqYZzcFM26LfnNP-3MmYmyzQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v7 12/26] stash: refactor `show_stash()` to use the
 diff API
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 12:01 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> On 08/08, Paul-Sebastian Ungureanu wrote:
>> Currently, `show_stash()` uses `cmd_diff()` to generate
>> the output. After this commit, the output will be generated
>> using the internal API.
>>
>> Before this commit, `git stash show --quiet` would act like
>> `git diff` and error out if the stash is not empty. Now, the
>> `--quiet` option does not error out given an empty stash.
>
> I think this needs a bit more justification.  As I mentioned in my
> comment to a previous patch, I'm not sure '--quiet' makes much sense
> with 'git stash show' (it will show nothing, and will always exit with
> an error code, as the stash will always contain something), but if we
> are supporting the same flags as 'git diff', and essentially just
> forwarding them, shouldn't they keep the same behaviour as well?

If we are going to support them, I guess there wouldn't be a problem
if any change in behaviour is noted in documentation (but as you said,
the next commit should be squashed into this). Indeed, the big question
is if we should support them. I would say no considering there is no
benefit.

>> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
>> ---
>>  builtin/stash--helper.c | 73 +++++++++++++++++++++++++----------------
>>  1 file changed, 45 insertions(+), 28 deletions(-)
>>
>> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
>> index 0c1efca6b..ec8c38c6f 100644
>> --- a/builtin/stash--helper.c
>> +++ b/builtin/stash--helper.c
>> @@ -10,6 +10,8 @@
>>  #include "run-command.h"
>>  #include "dir.h"
>>  #include "rerere.h"
>> +#include "revision.h"
>> +#include "log-tree.h"
>>
>>  static const char * const git_stash_helper_usage[] = {
>>       N_("git stash--helper list [<options>]"),
>> @@ -662,56 +664,71 @@ static int git_stash_config(const char *var, const char *value, void *cb)
>>
>>  static int show_stash(int argc, const char **argv, const char *prefix)
>>  {
>> -     int i, ret = 0;
>> -     struct child_process cp = CHILD_PROCESS_INIT;
>> -     struct argv_array args_refs = ARGV_ARRAY_INIT;
>> +     int i;
>> +     int flags = 0;
>>       struct stash_info info;
>> +     struct rev_info rev;
>> +     struct argv_array stash_args = ARGV_ARRAY_INIT;
>>       struct option options[] = {
>>               OPT_END()
>>       };
>>
>> -     argc = parse_options(argc, argv, prefix, options,
>> -                          git_stash_helper_show_usage,
>> -                          PARSE_OPT_KEEP_UNKNOWN);
>> +     init_diff_ui_defaults();
>> +     git_config(git_diff_ui_config, NULL);
>>
>> -     cp.git_cmd = 1;
>> -     argv_array_push(&cp.args, "diff");
>> +     init_revisions(&rev, prefix);
>>
>> -     /* Push arguments which are not options into args_refs. */
>> -     for (i = 0; i < argc; ++i) {
>> -             if (argv[i][0] == '-')
>> -                     argv_array_push(&cp.args, argv[i]);
>> +     /* Push arguments which are not options into stash_args. */
>> +     for (i = 1; i < argc; ++i) {
>> +             if (argv[i][0] != '-')
>> +                     argv_array_push(&stash_args, argv[i]);
>>               else
>> -                     argv_array_push(&args_refs, argv[i]);
>> -     }
>> -
>> -     if (get_stash_info(&info, args_refs.argc, args_refs.argv)) {
>> -             child_process_clear(&cp);
>> -             argv_array_clear(&args_refs);
>> -             return -1;
>> +                     flags++;
>>       }
>>
>>       /*
>>        * The config settings are applied only if there are not passed
>>        * any flags.
>>        */
>> -     if (cp.args.argc == 1) {
>> +     if (!flags) {
>>               git_config(git_stash_config, NULL);
>>               if (show_stat)
>> -                     argv_array_push(&cp.args, "--stat");
>> +                     rev.diffopt.output_format |= DIFF_FORMAT_DIFFSTAT;
>> +             if (show_patch) {
>> +                     rev.diffopt.output_format = ~DIFF_FORMAT_NO_OUTPUT;
>> +                     rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
>> +             }
>
> I failed to notice this in the previous patch (the problem existed
> there as well), but this changes the behaviour of 'git -c
> stash.showStat=false stash show <stash>'.  Previously doing this would
> not show anything, which is the correct behaviour, while now still
> shows the diffstat.
>
> I think the show_stat variable is interpreted the wrong way around in
> the previous patch.
>
> Something else I noticed now that I was playing around more with the
> config options is that the parsing of the config options is not
> correctly done in the previous patch.  It does a 'strcmp(var,
> "stash.showStat"))', but the config API makes all variables lowercase
> (config options are case insensitive, and making everything lowercase
> is the way to ensure that), so it should be 'strcmp(var, "stash.showstat"))',
> and similar for the 'stash.showpatch' config option.
>
> This all sounds like it would be nice to have some tests for these
> config options, to make sure we get it right, and won't break them in
> the future.

Thanks! Great suggestion! I will add some tests for this.

>> +     }
>>
>> -             if (show_patch)
>> -                     argv_array_push(&cp.args, "-p");
>> +     if (get_stash_info(&info, stash_args.argc, stash_args.argv)) {
>> +             argv_array_clear(&stash_args);
>> +             return -1;
>>       }
>>
>> -     argv_array_pushl(&cp.args, oid_to_hex(&info.b_commit),
>> -                      oid_to_hex(&info.w_commit), NULL);
>> +     argc = setup_revisions(argc, argv, &rev, NULL);
>> +     if (!rev.diffopt.output_format)
>> +             rev.diffopt.output_format = DIFF_FORMAT_PATCH;
>> +     diff_setup_done(&rev.diffopt);
>> +     rev.diffopt.flags.recursive = 1;
>> +     setup_diff_pager(&rev.diffopt);
>>
>> -     ret = run_command(&cp);
>> +     /*
>> +      * We can return early if there was any option not recognised by
>> +      * `diff_opt_parse()`, besides the word `stash`.
>> +      */
>
> I'm not sure I follow what you mean with this comment.  I don't see
> any 'diff_opt_parse' in the code above?

Oh, right. `diff_opt_parse()` is called by `setup_revision()` at some point,
but as you said a little bit below, these two comments (the previous one
and the next one) are redundant.

>> +     if (argc > 1) {
>> +             free_stash_info(&info);
>> +             argv_array_clear(&stash_args);
>> +             usage_with_options(git_stash_helper_show_usage, options);
>> +     }
>> +
>> +     /* Do the diff thing. */
>
> This comment should be dropped.  It's obvious that we are doing the
> diff thing below from the code, so the comment is redundant at best,
> makes people read more lines, and could possibly get outdated.
>
> I'd also drop the other comments above, as they do not provide a lot
> of extra value imho.
>
>> +     diff_tree_oid(&info.b_commit, &info.w_commit, "", &rev.diffopt);
>> +     log_tree_diff_flush(&rev);
>>
>>       free_stash_info(&info);
>> -     argv_array_clear(&args_refs);
>> -     return ret;
>> +     argv_array_clear(&stash_args);
>> +     return 0;
>>  }
>>
>>  int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>> --
>> 2.18.0.573.g56500d98f
>>
