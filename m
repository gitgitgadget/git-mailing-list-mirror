Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A88F1F461
	for <e@80x24.org>; Fri, 28 Jun 2019 12:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfF1Mju (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 08:39:50 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46173 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfF1Mju (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 08:39:50 -0400
Received: by mail-qk1-f196.google.com with SMTP id x18so4586503qkn.13
        for <git@vger.kernel.org>; Fri, 28 Jun 2019 05:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q7qpgx+aI047HH4TtpijJwvLuJUJ+0F3coCz04TK3Hc=;
        b=kIQU8787KSRL2EweDX59Ok3S9Sak+kt6gfFpIhm7eFJ3hfOoXKN0Dv6JVwu98xC4CC
         gHzxeeD8Ujf9E8AZr66JnrfyF2KO/AOb7uFQ+TIai1cTnNR2yiKnn0CmkAQyN6XaubFX
         uR939yN4JtMkvNw9SMTFdIAkYVEVMf5qCNCm80E+oyVzYE8sRj6KMPJJfH1nDrE1n94d
         Q06SZ6jQcc6lJkS1UX6k1C4vRkz8Pi+z4CM9E0mx0Zl9iZezPa38FxG2GPnq9ZMnMOgt
         F5sOpexPIqOucfPG8XW0PbPbCnrLj0E4C7N3KSM1EbMRUI1Ckd36a/KbFmfqrVwuf78x
         AzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q7qpgx+aI047HH4TtpijJwvLuJUJ+0F3coCz04TK3Hc=;
        b=KWLG8kiETzkSEkeq9fGXCRc9WdVIGUI98AkiCnS72GA7Pn+B5nOFnzKppy8EM7RAE0
         HsCDTfv86OK7YaVhMKBUqojBMjRHNvW78e+09cg3dnUD4JbN12LJH1uKl8+cbJQnwf1b
         LbLbryiw3ec6/hpL98y+IWMqgTBPYy3iCf3WutBUG0S6Q2N9oey+KfLcV02eGcg8mqDG
         ppt8/xfqaKiTWsGv/0ZX3J0b+t3Rwis2n/DyljWdulwpDaPT7sUleCS8kUhIHvARG+E+
         JeQVeLNCXOgVMFCLz0C07/SA8XU4CxdW49ukSY9DhNqEm1sSIObj2VLe9n+XxXkMVUdk
         lcTA==
X-Gm-Message-State: APjAAAXFcqEgYJXsGATIfUqTKQFyeTB+gYs4E0WBQ5qXSrpFgNTyh5VG
        xXoJ3+d3mmX7Vpq8L9uZ5KMRP//E
X-Google-Smtp-Source: APXvYqxN66JPYG8+uDChejWgUEOmOez+I52BqVdWqQjImW/r98Tj18urIM3JgzSEsWMrlydpIRCl3Q==
X-Received: by 2002:a37:b87:: with SMTP id 129mr8154536qkl.132.1561725589131;
        Fri, 28 Jun 2019 05:39:49 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:54b1:2872:57:b107? ([2001:4898:a800:1010:5e7:2872:57:b107])
        by smtp.gmail.com with ESMTPSA id t80sm893118qka.87.2019.06.28.05.39.48
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 05:39:48 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Thurs. June 27)
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
References: <49d98293-9f0b-44e9-cb07-d6b7ac791eb6@gmail.com>
 <14689d27-eecd-2e0a-715d-796b20d573e5@gmail.com>
 <CACsJy8C7Qr3JauRqUkB957ZDzVVZ0+wofzs7N2NzCbu+e00JnQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e9c14b58-2704-4750-9c37-7a7b15e596dc@gmail.com>
Date:   Fri, 28 Jun 2019 08:39:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8C7Qr3JauRqUkB957ZDzVVZ0+wofzs7N2NzCbu+e00JnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/2019 5:47 AM, Duy Nguyen wrote:
> On Fri, Jun 28, 2019 at 12:35 AM Derrick Stolee <stolee@gmail.com> wrote:
>>> dir.c
>>> 3b2385cf 2840) static void jw_object_untracked_cache_dir(struct json_writer *jw,
>>> 3b2385cf 2845) jw_object_bool(jw, "valid", ucd->valid);
>>> 3b2385cf 2846) jw_object_bool(jw, "check-only", ucd->check_only);
>>> 3b2385cf 2847) jw_object_stat_data(jw, "stat", &ucd->stat_data);
>>> 3b2385cf 2848) jw_object_string(jw, "exclude-oid", oid_to_hex(&ucd->exclude_oid));
>>> 3b2385cf 2849) jw_object_inline_begin_array(jw, "untracked");
>>> 3b2385cf 2850) for (i = 0; i < ucd->untracked_nr; i++)
>>> 3b2385cf 2851) jw_array_string(jw, ucd->untracked[i]);
>>> 3b2385cf 2852) jw_end(jw);
>>> 3b2385cf 2854) jw_object_inline_begin_object(jw, "dirs");
>>> 3b2385cf 2855) for (i = 0; i < ucd->dirs_nr; i++) {
>>> 3b2385cf 2856) jw_object_inline_begin_object(jw, ucd->dirs[i]->name);
>>> 3b2385cf 2857) jw_object_untracked_cache_dir(jw, ucd->dirs[i]);
>>> 3b2385cf 2858) jw_end(jw);
>>> 3b2385cf 2860) jw_end(jw);
>>> 3b2385cf 2861) }
>>> 3b2385cf 2958) jw_object_inline_begin_object(jw, "root");
>>> 3b2385cf 2959) jw_object_untracked_cache_dir(jw, uc->root);
>>> 3b2385cf 2960) jw_end(jw);
>>
>> Duy: I know you were working on some tests for these options. This is specifically
>> in the "untracked cache" mode, so enabling the cache with at least one entry and
>> running --debug-json should be sufficient.
> 
> It's a bit more complicated than that, but I see your point.

It usually is. I don't mean to underestimate the effort here.

> I initially looked at the output and saw "something" and moved on. I
> should have examined the json output more carefully.

Thanks for taking a second look!

>>> read-cache.c
>>> 8eeabe15 1752) ret = error(_("index uses %.4s extension, which we do not understand"),
>>> ee70c128 1754) if (advice_unknown_index_extension) {
>>> ee70c128 1755) warning(_("ignoring optional %.4s index extension"), ext);
>>> ee70c128 1756) advise(_("This is likely due to the file having been written by a newer\n"
>>> 272b3f2a 2026) jw_object_true(jw, "assume_unchanged");
>>> 272b3f2a 2030) jw_object_true(jw, "skip_worktree");
>>> 272b3f2a 2032) jw_object_intmax(jw, "stage", ce_stage(ce));
>>> f0f544da 2309) ieot = read_ieot_extension(istate, mmap, mmap_size, extension_offset);
>>> f0f544da 3651) static struct index_entry_offset_table *read_ieot_extension(
>>> f0f544da 3673) return do_read_ieot_extension(istate, index, extsize);
>>
>> Duy: more JSON output cases that could be interesting to cover.
> 
> This is because I changed the function signature, I think. Both IEOT
> and EOIE extensions, if I'm not mistaken, are never tested in the test
> suite. You need to set GIT_TEST_INDEX_THREADS, then the last three
> lines should be covered.

Thanks! Unfortunately, the threading is removed at compile-time in
order to prevent race conditions with the gcov output. This means
the report will never report the threading code as covered. :(

Does that same reasoning apply to the assume_unchanged, skip_worktree,
and "stage" lines?

-Stolee

