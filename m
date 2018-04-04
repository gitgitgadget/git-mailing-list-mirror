Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EC0A1F404
	for <e@80x24.org>; Wed,  4 Apr 2018 17:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbeDDRrv (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 13:47:51 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:38530 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbeDDRru (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 13:47:50 -0400
Received: by mail-ot0-f178.google.com with SMTP id o9-v6so24292349otj.5
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 10:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FY7NRHUg0rZE51nymKM5Rt+CqvcsqWnwEHujkPJe2Zg=;
        b=oxY4m2bf0yzMcGyfhEp9cFBUpl8rnksvkKxxjUaRFXTOujYWbxC/wUjOIdCkSB5gLH
         ON9U82ojkTlr40gDSnzLfNRNMGfDH3CH3/RluHin6U7F/eVNNPPMyWD5iUpiE2fyMGsr
         8/jPN0fLbYVQnACV7ps5OtgW0Yy6yO4izJiSBoh+wG4m4aWkpX9SJswBoRs/c+06+2oG
         Cn80PXq9ZRfaqTLu2g50e6XlCP7BWVMMTHxGbmrBkYaNIBwHVapLucmmpoypoGlagm3Z
         QJqemXqD7eyAbSdLTQgc6eAyUpVCy4kiGegwRURfo7vGt2ZD86cDAwgHTWvZC+0DglQE
         HB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FY7NRHUg0rZE51nymKM5Rt+CqvcsqWnwEHujkPJe2Zg=;
        b=BABc+jX/YHng/3koGzth9yQJB7+De/Sxb/NsMEdbdaRg/nwnnS5Yw3I8NRnmP4Ni87
         N+ngRm2lSpnohoBYEUEhghdAs31CRD4LpzqTaRqtCJGCA74N/gP1NmU7jLvc1gPBUPMx
         7u85nm5jvehiVmn7I+TY7U1cZtV7XT0cXt3hsAcFL6QTYrH+qcV0UFxeCWfg2BuANnQ7
         u+3MlZ+VvJDElE0i2S921KUx4bIzvvvkrS/tUoXr7xw8ALHcwmKSGWOagMm/vOj+PGIW
         HBtLGqwwNKVoYri/ZE0fEosJLk1VSAxz+axHB/bDBCfItOAte05xoFuX52SsA+ONOUXt
         +kug==
X-Gm-Message-State: ALQs6tCUxqHADw7BaKSmS/nYHveuE/eA3aAn61ve5o70QmVBEdg75jBX
        g6ny7xJjqkIZbdu8t60NvwEXxvyGEcUp9XheKYwpYta0
X-Google-Smtp-Source: AIpwx48sb3UkbQ1kRUM6TEOPwE5T4R117lfrF9tQdVa1yuAidsmOmT+M/OrqzAk+Ev3FBva3iwutxlPqUvXABGrJ46A=
X-Received: by 2002:a9d:481a:: with SMTP id c26-v6mr12062877otf.393.1522864069796;
 Wed, 04 Apr 2018 10:47:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.68.194 with HTTP; Wed, 4 Apr 2018 10:47:09 -0700 (PDT)
In-Reply-To: <CAHwyqnXtc-WgynCmE+EEVYtg6RRVweK8vwfBQS5VL4ygaFumKQ@mail.gmail.com>
References: <20180402005248.52418-1-haraldnordgren@gmail.com>
 <20180404171153.4126-1-haraldnordgren@gmail.com> <CAHwyqnXtc-WgynCmE+EEVYtg6RRVweK8vwfBQS5VL4ygaFumKQ@mail.gmail.com>
From:   Harald Nordgren <haraldnordgren@gmail.com>
Date:   Wed, 4 Apr 2018 19:47:09 +0200
Message-ID: <CAHwyqnX614p+xbmUBLJwY2yK1gOddRuzEM806z1Fu1VPU8rzJw@mail.gmail.com>
Subject: Re: [PATCH v7] ls-remote: create '--sort' option
To:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Links to previous revisions:

[1] https://public-inbox.org/git/20180402174614.GA28566@sigill.intra.peff.net/T/#m108fe8c83f3558afaea8e317e680f7eaa136e9a9
[2] https://public-inbox.org/git/20180402211920.GA32099@sigill.intra.peff.net/T/#ma9ec4e0ce664160086e535c012e20d76822c60e5
...
[4] https://public-inbox.org/git/20180402174614.GA28566@sigill.intra.peff.net/T/#maa02c40c87b192e56c370c312098d469c9fce757
[5] https://public-inbox.org/git/20180402174614.GA28566@sigill.intra.peff.net/T/#m52cdbbbba3f359e1257e7bdfe19cd9a26f55fa20
[6] https://public-inbox.org/git/20180402174614.GA28566@sigill.intra.peff.net/T/#m6d3ce17f0f6dabeddaf03336c92512b7c413422b

On Wed, Apr 4, 2018 at 7:18 PM, Harald Nordgren
<haraldnordgren@gmail.com> wrote:
> I updated the code to use 'ALLOC_GROW'. I makes sense, I now I realize
> why array.alloc is there ;)
>
> Jeff, you are right that 'git ls-remote --sort=committerdate' will not
> work. Do you think we need to do something about this, or it's fine
> that it fails the way you showed?
>
> On Wed, Apr 4, 2018 at 7:11 PM, Harald Nordgren
> <haraldnordgren@gmail.com> wrote:
>> Create a '--sort' option for ls-remote, based on the one from
>> for-each-ref. This e.g. allows ref names to be sorted by version
>> semantics, so that v1.2 is sorted before v1.10.
>>
>> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>> ---
>>
>> Notes:
>>     Started using 'ALLOC_GROW'
>>
>>  Documentation/git-ls-remote.txt | 12 +++++++++++-
>>  builtin/ls-remote.c             | 27 +++++++++++++++++++++++++--
>>  t/t5512-ls-remote.sh            | 41 ++++++++++++++++++++++++++++++++++++++++-
>>  3 files changed, 76 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
>> index 5f2628c8f..17fae7218 100644
>> --- a/Documentation/git-ls-remote.txt
>> +++ b/Documentation/git-ls-remote.txt
>> @@ -10,7 +10,7 @@ SYNOPSIS
>>  --------
>>  [verse]
>>  'git ls-remote' [--heads] [--tags] [--refs] [--upload-pack=<exec>]
>> -             [-q | --quiet] [--exit-code] [--get-url]
>> +             [-q | --quiet] [--exit-code] [--get-url] [--sort=<key>]
>>               [--symref] [<repository> [<refs>...]]
>>
>>  DESCRIPTION
>> @@ -60,6 +60,16 @@ OPTIONS
>>         upload-pack only shows the symref HEAD, so it will be the only
>>         one shown by ls-remote.
>>
>> +--sort=<key>::
>> +       Sort based on the key given.  Prefix `-` to sort in
>> +       descending order of the value. You may use the --sort=<key> option
>> +       multiple times, in which case the last key becomes the primary
>> +       key. Also supports "version:refname" or "v:refname" (tag
>> +       names are treated as versions). The "version:refname" sort
>> +       order can also be affected by the "versionsort.suffix"
>> +       configuration variable.
>> +       The keys supported are the same as those in `git for-each-ref`.
>> +
>>  <repository>::
>>         The "remote" repository to query.  This parameter can be
>>         either a URL or the name of a remote (see the GIT URLS and
>> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
>> index 540d56429..5bb8ee68a 100644
>> --- a/builtin/ls-remote.c
>> +++ b/builtin/ls-remote.c
>> @@ -1,6 +1,7 @@
>>  #include "builtin.h"
>>  #include "cache.h"
>>  #include "transport.h"
>> +#include "ref-filter.h"
>>  #include "remote.h"
>>
>>  static const char * const ls_remote_usage[] = {
>> @@ -43,10 +44,13 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>>         int show_symref_target = 0;
>>         const char *uploadpack = NULL;
>>         const char **pattern = NULL;
>> +       int i;
>>
>>         struct remote *remote;
>>         struct transport *transport;
>>         const struct ref *ref;
>> +       struct ref_array array;
>> +       static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
>>
>>         struct option options[] = {
>>                 OPT__QUIET(&quiet, N_("do not print remote URL")),
>> @@ -60,6 +64,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>>                 OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
>>                 OPT_BOOL(0, "get-url", &get_url,
>>                          N_("take url.<base>.insteadOf into account")),
>> +               OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
>> +                            N_("field name to sort on"), &parse_opt_ref_sorting),
>>                 OPT_SET_INT_F(0, "exit-code", &status,
>>                               N_("exit with exit code 2 if no matching refs are found"),
>>                               2, PARSE_OPT_NOCOMPLETE),
>> @@ -68,6 +74,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>>                 OPT_END()
>>         };
>>
>> +       memset(&array, 0, sizeof(array));
>> +
>>         argc = parse_options(argc, argv, prefix, options, ls_remote_usage,
>>                              PARSE_OPT_STOP_AT_NON_OPTION);
>>         dest = argv[0];
>> @@ -104,13 +112,28 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>>         if (!dest && !quiet)
>>                 fprintf(stderr, "From %s\n", *remote->url);
>>         for ( ; ref; ref = ref->next) {
>> +               struct ref_array_item *item;
>>                 if (!check_ref_type(ref, flags))
>>                         continue;
>>                 if (!tail_match(pattern, ref->name))
>>                         continue;
>> +
>> +               FLEX_ALLOC_MEM(item, refname, ref->name, strlen(ref->name));
>> +               item->symref = ref->symref;
>> +               item->objectname = ref->old_oid;
>> +
>> +               ALLOC_GROW(array.items, array.nr + 1, array.alloc);
>> +               array.items[array.nr++] = item;
>> +       }
>> +
>> +       if (sorting)
>> +               ref_array_sort(sorting, &array);
>> +
>> +       for (i = 0; i < array.nr; i++) {
>> +               const struct ref_array_item *ref = array.items[i];
>>                 if (show_symref_target && ref->symref)
>> -                       printf("ref: %s\t%s\n", ref->symref, ref->name);
>> -               printf("%s\t%s\n", oid_to_hex(&ref->old_oid), ref->name);
>> +                       printf("ref: %s\t%s\n", ref->symref, ref->refname);
>> +               printf("%s\t%s\n", oid_to_hex(&ref->objectname), ref->refname);
>>                 status = 0; /* we found something */
>>         }
>>         return status;
>> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
>> index 02106c922..66370cd88 100755
>> --- a/t/t5512-ls-remote.sh
>> +++ b/t/t5512-ls-remote.sh
>> @@ -10,6 +10,9 @@ test_expect_success setup '
>>         test_tick &&
>>         git commit -m initial &&
>>         git tag mark &&
>> +       git tag mark1.1 &&
>> +       git tag mark1.2 &&
>> +       git tag mark1.10 &&
>>         git show-ref --tags -d | sed -e "s/ /   /" >expected.tag &&
>>         (
>>                 echo "$(git rev-parse HEAD)     HEAD"
>> @@ -39,6 +42,39 @@ test_expect_success 'ls-remote self' '
>>         test_cmp expected.all actual
>>  '
>>
>> +test_expect_success 'ls-remote --sort="version:refname" --tags self' '
>> +       cat >expect <<-\EOF &&
>> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark
>> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark1.1
>> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark1.2
>> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark1.10
>> +       EOF
>> +       git ls-remote --sort="version:refname" --tags self >actual &&
>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'ls-remote --sort="-version:refname" --tags self' '
>> +       cat >expect <<-\EOF &&
>> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark1.10
>> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark1.2
>> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark1.1
>> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark
>> +       EOF
>> +       git ls-remote --sort="-version:refname" --tags self >actual &&
>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'ls-remote --sort="-refname" --tags self' '
>> +       cat >expect <<-\EOF &&
>> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark1.2
>> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark1.10
>> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark1.1
>> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark
>> +       EOF
>> +       git ls-remote --sort="-refname" --tags self >actual &&
>> +       test_cmp expect actual
>> +'
>> +
>>  test_expect_success 'dies when no remote specified and no default remotes found' '
>>         test_must_fail git ls-remote
>>  '
>> @@ -131,7 +167,7 @@ test_expect_success 'Report no-match with --exit-code' '
>>
>>  test_expect_success 'Report match with --exit-code' '
>>         git ls-remote --exit-code other.git "refs/tags/*" >actual &&
>> -       git ls-remote . tags/mark >expect &&
>> +       git ls-remote . tags/mark* >expect &&
>>         test_cmp expect actual
>>  '
>>
>> @@ -178,6 +214,9 @@ test_expect_success 'ls-remote --symref' '
>>         1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/remotes/origin/HEAD
>>         1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/remotes/origin/master
>>         1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark
>> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark1.1
>> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark1.10
>> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark1.2
>>         EOF
>>         git ls-remote --symref >actual &&
>>         test_cmp expect actual
>> --
>> 2.14.3 (Apple Git-98)
>>
