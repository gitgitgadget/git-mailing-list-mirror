Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A10C207D2
	for <e@80x24.org>; Fri, 23 Jun 2017 23:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754109AbdFWXj6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 19:39:58 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35097 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753946AbdFWXj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 19:39:57 -0400
Received: by mail-pg0-f43.google.com with SMTP id 132so26813539pgb.2
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 16:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RbORx0vLnK3wmor4Nkzkh7WDs/SNc2DqVdpW1H3pQxM=;
        b=aK/NDDdO2hONKOCZaNkiyCgfNPHEdEFbPTsJIZZ6YI6AUrvlMzFfbTt1+CaKQsBKHK
         01DSxo9Ptqw7oO5ooZ5scgYsvyEdTb4bpWB+DwDxOQxs/sIxbt7Tp8NJ1Y0/cbJA0Ba5
         PJwGUuE7kukwv8J3ccts/Q1g+AJC4E4k6bwa9fdHM1A5ohr4BGOb6D0hJY5cx8Ajfx3A
         gh084tiuHRA2T34FWKJDexn5K1s8rNddpBcLzkQlUyGgDd9yJ5sL0VHuVgYuRY/xnFf1
         B/+6ouc3kCjqafC9kG+pbjQ0TTY3zAehAGzuG6wE0oQAVPQxInG9sd7TkwPwR11BjILu
         nd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RbORx0vLnK3wmor4Nkzkh7WDs/SNc2DqVdpW1H3pQxM=;
        b=gbcsldqrSTxV/nBDxeENoDPt+Xb8NjGX5U4b3vIfJXi+kwjcUQbSdRzGNIGCU1ji1e
         JDCOO9EnzA7uSWnafHS0TqvDL+ZBhbTBLilYtC8D8HlSPzGB+hiCnCWumu0TH6KrMquV
         GgTBCrMQSOdld40Hk4u9ROFvKohaKyAjIB7F9Ore05xuhRHO0TArtJm9cdiZFb6zj3Sq
         yREP4X5jsxvtMWoRoDh1u7RrM2uiKV6cUeJwMQ8AoNuYZz9Qz0uo1sFSYrix7izKgocP
         xOvtR589wG8cekyV9djtTmmkOeByyHkJJRclSIkuoCBnWUMpUcHQm5Yt8+BvBCMH484h
         E6Ig==
X-Gm-Message-State: AKS2vOwnINhj0Btrojx/Cu21EjrYfWcPSriA/A4p1xs0VQHlhRlfyy6/
        70Plz7DdEWchpRjc548ltUXBlCLM3NSE
X-Received: by 10.84.191.131 with SMTP id a3mr924866pld.279.1498261196097;
 Fri, 23 Jun 2017 16:39:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Fri, 23 Jun 2017 16:39:55 -0700 (PDT)
In-Reply-To: <871sqajrgi.fsf@gmail.com>
References: <xmqqinjnhcr8.fsf@gitster.mtv.corp.google.com> <871sqajrgi.fsf@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 23 Jun 2017 16:39:55 -0700
Message-ID: <CAGZ79kZyMUKPahTXOF7ds6zSvFKLrM2N78JKG-2+GRL5nnmuvA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2017, #06; Thu, 22)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 2:59 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Jun 22 2017, Junio C. Hamano jotted:
>
>> * sb/diff-color-move (2017-06-21) 25 commits
>>  - diff: document the new --color-moved setting
>>  - diff.c: add dimming to moved line detection
>>  - diff.c: color moved lines differently, plain mode
>>  - diff.c: color moved lines differently
>>  - diff.c: buffer all output if asked to
>>  - diff.c: emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY
>>  - diff.c: emit_diff_symbol learns about DIFF_SYMBOL_STAT_SEP
>>  - diff.c: convert word diffing to use emit_diff_symbol
>>  - diff.c: convert show_stats to use emit_diff_symbol
>>  - diff.c: convert emit_binary_diff_body to use emit_diff_symbol
>>  - submodule.c: migrate diff output to use emit_diff_symbol
>>  - diff.c: emit_diff_symbol learns DIFF_SYMBOL_REWRITE_DIFF
>>  - diff.c: emit_diff_symbol learns about DIFF_SYMBOL_BINARY_FILES
>>  - diff.c: emit_diff_symbol learns DIFF_SYMBOL_HEADER
>>  - diff.c: emit_diff_symbol learns DIFF_SYMBOL_FILEPAIR
>>  - diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_INCOMPLETE
>>  - diff.c: emit_diff_symbol learns DIFF_SYMBOL_WORDS{_PORCELAIN}
>>  - diff.c: migrate emit_line_checked to use emit_diff_symbol
>>  - diff.c: emit_diff_symbol learns DIFF_SYMBOL_NO_LF_EOF
>>  - diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_FRAGINFO
>>  - diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_MARKER
>>  - diff.c: introduce emit_diff_symbol
>>  - diff.c: factor out diff_flush_patch_all_file_pairs
>>  - diff.c: move line ending check into emit_hunk_header
>>  - diff.c: readability fix
>>
>>  "git diff" has been taught to optionally paint new lines that are
>>  the same as deleted lines elsewhere differently from genuinely new
>>  lines.
>>
>>  Is any more update coming?
>
> I guess here's as good a place for feedback is any, this feature's
> great, but I discovered some minor warts in it:

Thanks for reporting these. :)

So:
* have the boolean option as below
* fix error modes in config
* rewrite documentation for lazy skimming readers :)

I also consider
* changing the default to zebra (instead of dimmed_zebra)

Junio wrote (when reviewing Michaels series)
> This patch shows OK, but when applied to other changes in the
> series, e.g. "packed_ref_store: make class into a subclass of
> `ref_store`", it was somewhat irritating that all new blank lines
> are shown as a copy-move of a single deleted blank line (also a
> single "return refs" in an entirely new function being a copy/move
> looked confusing).

* add some heuristic to omit small blobs, (empty lines, closing braces)
  Maybe this is can be solved by not considering anything
  that occurs multiple times?
