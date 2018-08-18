Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F2971F954
	for <e@80x24.org>; Sat, 18 Aug 2018 15:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbeHRSrR (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 14:47:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39998 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeHRSrR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 14:47:17 -0400
Received: by mail-ed1-f68.google.com with SMTP id e19-v6so6099600edq.7
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 08:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yt5b5mf/LAltOCRg/5M2fNejTYn0CY7urGRyr+rdon4=;
        b=eeAuRaLAsjDBuOdg1ltzMytAuzRRy8VvaKIM5Vzlf8ugsUYBUZx0sGvPE90cqyHWOB
         sq9SLTbtrfFbxo3vlhbg64w2Fqx8aO2MnqLHs6UD/EDt6X2aOM0kOutbDP4EiHRTlico
         68CpEEr1NVOVBsitEcuMQpRhP658tY0EzYdVtFoBjvh+yb4gH8ScZhi2pKIk/uyma6GR
         C0Uu3CsX1m6Gh8HCLg+eEKQuPjsUEk6qi5qDeHrblpaISdXjFYSUPngfKobq4tjIsTmI
         5gY+D3ty/5c0MAN6dk7dM4PNMQjiRS8bPpcOR+ktnlUneCQhOImfyBTOg92aznj/a8x6
         s0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yt5b5mf/LAltOCRg/5M2fNejTYn0CY7urGRyr+rdon4=;
        b=tIZ/iryyRd0apjUW4S+FuL0Y3YUC9Eb+6YGu9tKxN/aZ2WnTKbZVAqpOpkVHNoFxSq
         C1/mFIxO3iCSDSy0xCs01TBJ+gzDVs3+k/LujNuGYXcz/dM7aCW1rNjHiTY93fLUPCy4
         STgTzivIcnvoNcl/WA7QW7/GPQPTC5tjuI2n2I7TATzlArdn6ZqKI3Jilm71tgSB0XdI
         VXWoA58Z8c1Mo3PxOJ37N1esHf+XslwIk34VwZn4GuBwGVJFjkP3/d03hUa4iHZmjaRL
         xTNvQEatYLs+YcV8L6T9qOGpwmQ1vlCiMqa3LAd7lM2+r3CwcEnw0O2G8sy+xOq38OAK
         BNaQ==
X-Gm-Message-State: AOUpUlFBiBVT01vyQnnlKp+S/4N7LpF1Z8Al+Ra+vqG6Ub/Lzo3gPyp7
        FB9b+6mrpfkZrMDWr+BAr3/lEFdikzFwSLPS+qg=
X-Google-Smtp-Source: AA+uWPx/h7FlPYKnCtxJjRhqLlQD4soranWxViliwrmPnVcsrDYl7QBOR6XIndw03Ze2/axZZ0K23J7t3NuyqCJP5Wc=
X-Received: by 2002:a50:a0c5:: with SMTP id 63-v6mr42845152edo.47.1534606748562;
 Sat, 18 Aug 2018 08:39:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:2642:0:0:0:0 with HTTP; Sat, 18 Aug 2018 08:39:08
 -0700 (PDT)
In-Reply-To: <20180815221305.GQ2734@hank.intra.tgummerer.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <0393bbd09daeb7ab67da4a343ba58d824c35532b.1533753605.git.ungureanupaulsebastian@gmail.com>
 <20180815221305.GQ2734@hank.intra.tgummerer.com>
From:   Paul Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Date:   Sat, 18 Aug 2018 18:39:08 +0300
Message-ID: <CADzBBBaO3em0kcebL5kiE1JxSEsea2OFrzyRUgfEDjrwV6fxsw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v7 15/26] stash: convert create to builtin
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 1:13 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> On 08/08, Paul-Sebastian Ungureanu wrote:
>> Add stash create to the helper.
>>
>> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
>> ---
>>  builtin/stash--helper.c | 406 ++++++++++++++++++++++++++++++++++++++++
>>  git-stash.sh            |   2 +-
>>  2 files changed, 407 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
>> index 5ff810f8c..a4e57899b 100644
>> --- a/builtin/stash--helper.c
>> +++ b/builtin/stash--helper.c
>> @@ -21,6 +21,7 @@ static const char * const git_stash_helper_usage[] = {
>>       N_("git stash--helper branch <branchname> [<stash>]"),
>>       N_("git stash--helper clear"),
>>       N_("git stash--helper store [-m|--message <message>] [-q|--quiet] <commit>"),
>> +     N_("git stash--helper create [<message>]"),
>>       NULL
>>  };
>>
>> @@ -64,6 +65,11 @@ static const char * const git_stash_helper_store_usage[] = {
>>       NULL
>>  };
>>
>> +static const char * const git_stash_helper_create_usage[] = {
>> +     N_("git stash--helper create [<message>]"),
>> +     NULL
>> +};
>> +
>>  static const char *ref_stash = "refs/stash";
>>  static int quiet;
>>  static struct strbuf stash_index_path = STRBUF_INIT;
>> @@ -781,6 +787,404 @@ static int store_stash(int argc, const char **argv, const char *prefix)
>>       return do_store_stash(argv[0], stash_msg, quiet);
>>  }
>>
>> [...]
>>
>> +
>> +static int do_create_stash(int argc, const char **argv, const char *prefix,
>> +                        const char **stash_msg, int include_untracked,
>> +                        int patch_mode, struct stash_info *info)
>> +{
>> +     int untracked_commit_option = 0;
>> +     int ret = 0;
>> +     int subject_len;
>> +     int flags;
>> +     const char *head_short_sha1 = NULL;
>> +     const char *branch_ref = NULL;
>> +     const char *head_subject = NULL;
>> +     const char *branch_name = "(no branch)";
>> +     struct commit *head_commit = NULL;
>> +     struct commit_list *parents = NULL;
>> +     struct strbuf msg = STRBUF_INIT;
>> +     struct strbuf commit_tree_label = STRBUF_INIT;
>> +     struct strbuf out = STRBUF_INIT;
>> +     struct strbuf final_stash_msg = STRBUF_INIT;
>> +
>> +     read_cache_preload(NULL);
>> +     refresh_cache(REFRESH_QUIET);
>> +
>> +     if (!check_changes(argv, include_untracked, prefix)) {
>> +             ret = 1;
>> +             goto done;
>
> I wonder if we can just 'exit(0)' here, instead of returning.  This
> whole command is a builtin, and I *think* outside of 'libgit.a' exiting
> early is fine.  It does mean that we're not free'ing the memory
> though, which means a leak checker would probably complain.  So
> dunno.  It would simplify the code a little, but not sure it's worth it.

Indeed, there shouldn't be any problem by calling exit(0).

>> +     }
>> +
>> +     if (get_oid("HEAD", &info->b_commit)) {
>> +             fprintf_ln(stderr, "You do not have the initial commit yet");
>> +             ret = -1;
>> +             goto done;
>> +     } else {
>> +             head_commit = lookup_commit(the_repository, &info->b_commit);
>> +     }
>> +
>> +     branch_ref = resolve_ref_unsafe("HEAD", 0, NULL, &flags);
>> +     if (flags & REF_ISSYMREF)
>> +             branch_name = strrchr(branch_ref, '/') + 1;
>> +     head_short_sha1 = find_unique_abbrev(&head_commit->object.oid,
>> +                                          DEFAULT_ABBREV);
>> +     subject_len = find_commit_subject(get_commit_buffer(head_commit, NULL),
>> +                                       &head_subject);
>> +     strbuf_addf(&msg, "%s: %s %.*s\n", branch_name, head_short_sha1,
>> +                 subject_len, head_subject);
>
> I think this can be written in a slightly simpler way:
>
>         head_short_sha1 = find_unique_abbrev(&head_commit->object.oid,
>                                              DEFAULT_ABBREV);
>         strbuf_addf(&msg, "%s: %s", branch_name, head_short_sha1);
>         pp_commit_easy(CMIT_FMT_ONELINE, head_commit, &msg);
>         strbuf_addch(&msg, '\n');
>
> The other advantage this brings is that it is consistent with other
> places where we print/use the subject of a commit (e.g. in 'git reset
> --hard').

Thanks for this suggestion.

>> +
>> +     strbuf_addf(&commit_tree_label, "index on %s\n", msg.buf);
>> +     commit_list_insert(head_commit, &parents);
>> +     if (write_cache_as_tree(&info->i_tree, 0, NULL) ||
>> +         commit_tree(commit_tree_label.buf, commit_tree_label.len,
>> +                     &info->i_tree, parents, &info->i_commit, NULL, NULL)) {
>> +             fprintf_ln(stderr, "Cannot save the current index state");
>
> Looks like this message is translated in the current 'git stash'
> implementation, so it should be here as well.  Same for the messages
> below.
>
>> +             ret = -1;
>> +             goto done;
>> +     }
>> +
>> +     if (include_untracked && get_untracked_files(argv, 1,
>> +                                                  include_untracked, &out)) {
>> +             if (save_untracked_files(info, &msg, &out)) {
>> +                     printf_ln("Cannot save the untracked files");
>
> Why does this go to stdout, whereas "Cannot save the current index
> state" above goes to stderr?  In the shell version of git stash these
> all go to stderr fwiw.  There are a few similar cases, it would
> probably be worth going through all the print statements here and see
> if they need to be translated, and to which output stream they should
> go.

This is what I am going to do.

>> +                     ret = -1;
>> +                     goto done;
>> +             }
>> +             untracked_commit_option = 1;
>> +     }
>> +     if (patch_mode) {
>> +             ret = stash_patch(info, argv);
>> +             if (ret < 0) {
>> +                     printf_ln("Cannot save the current worktree state");
>> +                     goto done;
>> +             } else if (ret > 0) {
>> +                     goto done;
>> +             }
>> +     } else {
>> +             if (stash_working_tree(info, argv)) {
>> +                     printf_ln("Cannot save the current worktree state");
>> +                     ret = -1;
>> +                     goto done;
>> +             }
>> +     }
>> +
>> +     if (!*stash_msg || !strlen(*stash_msg))
>> +             strbuf_addf(&final_stash_msg, "WIP on %s", msg.buf);
>> +     else
>> +             strbuf_addf(&final_stash_msg, "On %s: %s\n", branch_name,
>> +                         *stash_msg);
>> +     *stash_msg = strbuf_detach(&final_stash_msg, NULL);
>
> strbuf_detach means we're taking ownership of the memory, so we'll
> have to free it afterwards. Looking at this we may not even want to
> re-use the 'stash_msg' variable here, but instead introduce another
> variable for it, so it doesn't have a dual meaning in this function.
>
>> +
>> +     /*
>> +      * `parents` will be empty after calling `commit_tree()`, so there is
>> +      * no need to call `free_commit_list()`
>> +      */
>> +     parents = NULL;
>> +     if (untracked_commit_option)
>> +             commit_list_insert(lookup_commit(the_repository, &info->u_commit), &parents);
>> +     commit_list_insert(lookup_commit(the_repository, &info->i_commit), &parents);
>> +     commit_list_insert(head_commit, &parents);
>> +
>> +     if (commit_tree(*stash_msg, strlen(*stash_msg), &info->w_tree,
>> +                     parents, &info->w_commit, NULL, NULL)) {
>> +             printf_ln("Cannot record working tree state");
>> +             ret = -1;
>> +             goto done;
>> +     }
>> +
>> +done:
>> +     strbuf_release(&commit_tree_label);
>> +     strbuf_release(&msg);
>> +     strbuf_release(&out);
>> +     strbuf_release(&final_stash_msg);
>> +     return ret;
>> +}
>> +
>> +static int create_stash(int argc, const char **argv, const char *prefix)
>> +{
>> +     int include_untracked = 0;
>> +     int ret = 0;
>> +     const char *stash_msg = NULL;
>> +     struct stash_info info;
>> +     struct option options[] = {
>> +             OPT_BOOL('u', "include-untracked", &include_untracked,
>> +                      N_("include untracked files in stash")),
>> +             OPT_STRING('m', "message", &stash_msg, N_("message"),
>> +                      N_("stash message")),
>> +             OPT_END()
>> +     };
>> +
>> +     argc = parse_options(argc, argv, prefix, options,
>> +                          git_stash_helper_create_usage,
>> +                          0);
>> +
>> +     ret = do_create_stash(argc, argv, prefix, &stash_msg,
>> +                           include_untracked, 0, &info);
>
> stash_msg doesn't have to be passed as a pointer to a pointer here, as
> we never need the modified value after this function returns.  I think
> just passing 'stash_msg' here instead of '&stash_msg' will make
> 'do_create_stash' slightly easier to read.

That's right, but `do_create_stash()` is also called by
`do_push_stash()`, which will need the modified value.

>> +
>> +     if (!ret)
>> +             printf_ln("%s", oid_to_hex(&info.w_commit));
>> +
>> +     /*
>> +      * ret can be 1 if there were no changes. In this case, we should
>> +      * not error out.
>> +      */
>> +     return ret < 0;
>> +}
>> +
>>  int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>>  {
>>       pid_t pid = getpid();
>> @@ -817,6 +1221,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>>               return !!show_stash(argc, argv, prefix);
>>       else if (!strcmp(argv[0], "store"))
>>               return !!store_stash(argc, argv, prefix);
>> +     else if (!strcmp(argv[0], "create"))
>> +             return !!create_stash(argc, argv, prefix);
>>
>>       usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
>>                     git_stash_helper_usage, options);
>> diff --git a/git-stash.sh b/git-stash.sh
>> index 5739c5152..ab06e4ffb 100755
>> --- a/git-stash.sh
>> +++ b/git-stash.sh
>> @@ -425,7 +425,7 @@ clear)
>>       ;;
>>  create)
>>       shift
>> -     create_stash -m "$*" && echo "$w_commit"
>> +     git stash--helper create --message "$*"
>>       ;;
>>  store)
>>       shift
>> --
>> 2.18.0.573.g56500d98f
>>
Thanks!
