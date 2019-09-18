Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A1AC1F463
	for <e@80x24.org>; Wed, 18 Sep 2019 13:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfIRNzd (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 09:55:33 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37150 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfIRNzc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 09:55:32 -0400
Received: by mail-qt1-f196.google.com with SMTP id d2so8985323qtr.4
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 06:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DLfcQ/rhpPOUZStBwFUCAA7Lq/ByLqpR83jKH0mdwMQ=;
        b=K74CxetKEGcrsP5SBnjZ5zMlq9lEsVYjewoha7JZEIRrcG3fBLIkDrr4I0zfdnbX6I
         2KM6PfHEcyYXMsZj8o0K+J+cmc6LhgaU/wYDy9cwrvOZmOo5IrnJ9ma8Hjbyt+i9lLsK
         BtmPQaVclE8Pn+FVpCd9mFJjq7+RZk8HSw0SCOBEYK5s6Qup2tI1s7qo784ADDvVJxJM
         ZzjFpFLydO9nunFieejgeCsBAELA0O+0bCCh1RlosImBG7poa6Hv/LeJKJmW+wK17rY+
         wBZRqwuUoy8kMB/y3T7V3xg6llRRj+WV0rxbHqkQ4GWhXdZ6lAvBNbTUeNo4AUY33v9m
         akjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DLfcQ/rhpPOUZStBwFUCAA7Lq/ByLqpR83jKH0mdwMQ=;
        b=eKBjRcn3iRekKGS1sH+olQg9ks9MMsW10tgb7bI4fi4k813ZtT1gPWl0/7pvhy1pSi
         Svs+c4cxhLoMz7d/w8k93dZKe1S64mE4bYW7wAiJgft+nILDPBF/9V6Bs/eWMDwF92qg
         ACYGL3Rhv8P/XRbCT3PKXUF2oFaxmgyvaeOkQVRtJrEAaIwAMm0sT8bKXy7ngl05TZBc
         m4Tz9Qrm022HhGcp9q5QR8DEuFT0rdVa6bVfhG+2p6Pql2wTcB/DkbNy5A4qvefYYpD3
         Dafxd1a+KSkAoO9UHOzosTLfF2ZQgYYZlBJ06TLVZI2eUj6mAo9Tq2h5LwdBAUGbywwW
         UksA==
X-Gm-Message-State: APjAAAV+ymT+xbyOXj6KBX967CF3ZAzcRjnahIPv3vRfbhojfdMDrCqV
        6s3wMaG6WDPfEN5rRfaCAdI=
X-Google-Smtp-Source: APXvYqyhyZMVm0iW0QPzUy6ALzSz51ernfTM/9b3AeliX4gMP9oJNAzwE2VYZqx6c8VNfiSnNd2RdA==
X-Received: by 2002:ac8:16d9:: with SMTP id y25mr1996514qtk.72.1568814929910;
        Wed, 18 Sep 2019 06:55:29 -0700 (PDT)
Received: from [10.0.1.21] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id d16sm2005373qkl.7.2019.09.18.06.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 06:55:29 -0700 (PDT)
Subject: Re: [PATCH 4/9] sparse-checkout: 'add' subcommand
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.316.git.gitgitgadget@gmail.com>
 <0f095e85d5bf29346bdc5bf1707bb51eaf2202ae.1566313865.git.gitgitgadget@gmail.com>
 <CABPp-BEhc00g3CwKg13wDrtFHM-sw9tSy75UEbTvugKkdwTyeA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <52c5b7cc-eab1-a74d-2abb-be8f125df9bf@gmail.com>
Date:   Wed, 18 Sep 2019 09:55:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEhc00g3CwKg13wDrtFHM-sw9tSy75UEbTvugKkdwTyeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/23/2019 7:30 PM, Elijah Newren wrote:
> On Tue, Aug 20, 2019 at 8:12 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The 'git sparse-checkout add' subcommand takes a list of patterns
>> over stdin and writes them to the sparse-checkout file. Then, it
>> updates the working directory using 'git read-tree -mu HEAD'.
> 
> As mentioned in response to the cover letter, I'd rather see it take
> patterns as positional arguments (though requiring a '--' argument
> before any patterns that start with a hyphen).  It could also take
> --stdin to read from stdin.
> 
>> Note: if a user adds a negative pattern that would lead to the
>> removal of a non-empty directory, then Git may not delete that
>> directory (on Windows).
> 
> This sounds like you're re-iterating a bug mentioned earlier, but if
> someone in the future comes and reads this comment it might sound like
> you're saying git can avoid clearing a directory for optimization or
> other reasons.  (And, of course, it'd be nice to figure out why this
> bug exists.)
> 
> Another question this brings up, though, is that you worked around
> this bug in 'init' so why would you not also do so for 'add'?  Seems
> inconsistent to me.
> 
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  Documentation/git-sparse-checkout.txt |  4 ++++
>>  builtin/sparse-checkout.c             | 32 ++++++++++++++++++++++++++-
>>  t/t1091-sparse-checkout-builtin.sh    | 20 +++++++++++++++++
>>  3 files changed, 55 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
>> index 50c53ee60a..6f540a3443 100644
>> --- a/Documentation/git-sparse-checkout.txt
>> +++ b/Documentation/git-sparse-checkout.txt
>> @@ -34,6 +34,10 @@ COMMANDS
>>         by Git. Add patterns to the sparse-checkout file to
>>         repopulate the working directory.
>>
>> +'add'::
>> +       Add a set of patterns to the sparse-checkout file, as given over
>> +       stdin. Updates the working directory to match the new patterns.
>> +
>>  SPARSE CHECKOUT
>>  ----------------
>>
>> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
>> index 86d24e6295..ec6134fecc 100644
>> --- a/builtin/sparse-checkout.c
>> +++ b/builtin/sparse-checkout.c
>> @@ -8,7 +8,7 @@
>>  #include "strbuf.h"
>>
>>  static char const * const builtin_sparse_checkout_usage[] = {
>> -       N_("git sparse-checkout [init|list]"),
>> +       N_("git sparse-checkout [init|add|list]"),
>>         NULL
>>  };
>>
>> @@ -166,6 +166,34 @@ static int sparse_checkout_init(int argc, const char **argv)
>>         return sc_read_tree();
>>  }
>>
>> +static int sparse_checkout_add(int argc, const char **argv)
>> +{
>> +       struct exclude_list el;
>> +       char *sparse_filename;
>> +       FILE *fp;
>> +       struct strbuf line = STRBUF_INIT;
>> +
>> +       memset(&el, 0, sizeof(el));
>> +
>> +       sparse_filename = get_sparse_checkout_filename();
>> +       add_excludes_from_file_to_list(sparse_filename, "", 0, &el, NULL);
> 
> el is an exclude_list and we call add_excludes_..., but it's actually
> an *include* list.  This is going to cause errors at some point, and
> will cause lots of headaches.
> 
>> +
>> +       fp = fopen(sparse_filename, "w");
>> +       write_excludes_to_file(fp, &el);
>> +
>> +       while (!strbuf_getline(&line, stdin)) {
>> +               strbuf_trim(&line);
>> +               fprintf(fp, "%s\n", line.buf);
>> +       }
> 
> Should we first check whether these excludes are already in the
> sparse-checkout file?
> 
>> +       fclose(fp);
>> +       free(sparse_filename);
>> +
>> +       clear_exclude_list(&el);
>> +
>> +       return sc_read_tree();
> 
> What if someone calls 'git sparse-checkout add' without first calling
> 'git sparse-checkout init'?  As far as I can tell, core.sparseCheckout
> will be unset (i.e. treated as false), meaning that this operation
> will do some work, but result in no changes and a report of success.
> After users try to figure out why it won't work, they eventually run
> 'git sparse-checkout init', which will delete all the entries they
> previously added with the 'add' subcommand.
> 
> What should happen instead?

If someone runs 'git sparse-checkout init' after an 'add', the
sparse-checkout file has contents, so the init does not overwrite
those.

(In the update I'm working on, 'init' doesn't delete folders, so
it will only remove the files that do not match the patterns.)

>> +}
>> +
>>  int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
>>  {
>>         static struct option builtin_sparse_checkout_options[] = {
>> @@ -187,6 +215,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
>>                         return sparse_checkout_list(argc, argv);
>>                 if (!strcmp(argv[0], "init"))
>>                         return sparse_checkout_init(argc, argv);
>> +               if (!strcmp(argv[0], "add"))
>> +                       return sparse_checkout_add(argc, argv);
>>         }
>>
>>         usage_with_options(builtin_sparse_checkout_usage,
>> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
>> index b7d5f15830..499bd8d6d0 100755
>> --- a/t/t1091-sparse-checkout-builtin.sh
>> +++ b/t/t1091-sparse-checkout-builtin.sh
>> @@ -100,4 +100,24 @@ test_expect_success 'clone --sparse' '
>>         test_cmp expect dir
>>  '
>>
>> +test_expect_success 'add to existing sparse-checkout' '
>> +       echo "/folder2/*" | git -C repo sparse-checkout add &&
> 
> I've always been using '/folder2/' in sparse-checkout, without the
> trailing asterisk.  That seems more friendly for cone mode too.  Are
> there benefits to keeping the trailing asterisk?

I think I've been seeing issues with pattern matching on Windows without
the trailing asterisk. I'm currently double-checking to make sure this
is important or not.
 
>> +       cat >expect <<-EOF &&
>> +               /*
>> +               !/*/*
>> +               /folder1/*
>> +               /folder2/*
>> +       EOF
>> +       git -C repo sparse-checkout list >actual &&
>> +       test_cmp expect actual &&
>> +       test_cmp expect repo/.git/info/sparse-checkout &&
>> +       ls repo >dir  &&
>> +       cat >expect <<-EOF &&
>> +               a
>> +               folder1
>> +               folder2
>> +       EOF
>> +       test_cmp expect dir
>> +'
>> +
>>  test_done
>> \ No newline at end of file

I'm trying to fix this newline issue everywhere.

Thanks,
-Stolee
