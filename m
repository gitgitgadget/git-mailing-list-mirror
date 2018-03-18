Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D890C1F404
	for <e@80x24.org>; Sun, 18 Mar 2018 19:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754121AbeCRTGM convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 18 Mar 2018 15:06:12 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:43266 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751062AbeCRTGK (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Mar 2018 15:06:10 -0400
X-AuditID: 1207440e-1c1ff70000000b4f-59-5aaeb89fb0f6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 99.52.02895.0A8BEAA5; Sun, 18 Mar 2018 15:06:08 -0400 (EDT)
Received: from mail-lf0-f41.google.com (mail-lf0-f41.google.com [209.85.215.41])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w2IJ65W9023112
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 15:06:07 -0400
Received: by mail-lf0-f41.google.com with SMTP id f75-v6so22259894lfg.6
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 12:06:06 -0700 (PDT)
X-Gm-Message-State: AElRT7EtWgr8h3h4I6LRvN2XIefI9Gqg8huKXPcgfZuQ/EYP4qP8tlYo
        rr9Wue0b+7Fh4Uqa6E/k6Md4ShkyQCChjzQjWEo=
X-Google-Smtp-Source: AG47ELvlM09GqPZ0h11U0looXqggUq6m75ENEyMNhV4GCU/lFZYssXTWgPA1e99tFuG8ox0DDR+NJ6FsiHdTWghIvcs=
X-Received: by 2002:a19:a355:: with SMTP id m82-v6mr6007285lfe.54.1521399965521;
 Sun, 18 Mar 2018 12:06:05 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.46.135.152 with HTTP; Sun, 18 Mar 2018 12:06:04 -0700 (PDT)
In-Reply-To: <20180316212920.GD12333@sigill.intra.peff.net>
References: <CAMy9T_FaOdLP482YZcMX16mpy_EgM0ok1GKg45rE=X+HTGxSiQ@mail.gmail.com>
 <87370zeqmx.fsf@evledraar.gmail.com> <20180316212920.GD12333@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Sun, 18 Mar 2018 20:06:04 +0100
X-Gmail-Original-Message-ID: <CAMy9T_FNW5ksx-zLJRb48A-Dt4KNikQ9zXmxDshbby40OSLuyw@mail.gmail.com>
Message-ID: <CAMy9T_FNW5ksx-zLJRb48A-Dt4KNikQ9zXmxDshbby40OSLuyw@mail.gmail.com>
Subject: Re: [ANNOUNCE] git-sizer: compute various size-related metrics for
 your Git repository
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsUixO6iqLtgx7oog4lHLC26rnQzOTB6fN4k
        F8AYxWWTkpqTWZZapG+XwJXxZccGxoJF3BXTT5xkaWDs5Oxi5OSQEDCReHGila2LkYtDSGAH
        k8Sixa+ZIJxHTBLvV39kgXAmMkosPDELqIwDqKVc4ttBYYjuIomG9TvYIewKiY/3lzKB2LwC
        ghInZz5hAbGFBOQkXm24wQhhe0u0NZ4Di3MKWEvc394KNX8Zo8Sy10+YQRJsAroSi3qawQax
        CKhKtPyezgKxIFHi2/qLUAsCJO5/7wIbKgwUf7PqMliviICsxPfDGxlBhjILrGGU+HrxNytI
        gllAU6J1+292CFtbYtnC18wTGEVnITl2FpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszL
        Sy3SNdbLzSzRS00p3cQIiQi+HYzt62UOMQpwMCrx8EqUrY0SYk0sK67MPcQoycGkJMp7d/Oa
        KCG+pPyUyozE4oz4otKc1OJDjBIczEoivAtb1kUJ8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQn
        lqRmp6YWpBbBZGU4OJQkeOdvB2oULEpNT61Iy8wpQUgzcXCCDOcBGr4FpIa3uCAxtzgzHSJ/
        itGe49usB23MHH/2gshv054DyRsvXrcxC7Hk5eelSonzLgRpEwBpyyjNg5sMS3avGMWBHhXm
        nQVSxQNMlHCzXwGtZQJa67N0DcjakkSElFQDY/AN4+AJ/6adZe/yeDlN0a/Vi1934r99p923
        ScSuXSjW0M3ffyd+x8/NoUHGy7I7e/93LFjy4ECobRnL/63cjBWntxtuWxpVdVbB82RzmM3F
        mdEOM3mXOc87MkO2V/pD5aMl1492fX+lUN+2dDtPikWwSz27j7WE4IW3XjkKNz/dP5l1YEnu
        biWW4oxEQy3mouJEAI5uEvdRAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 16, 2018 at 10:29 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Mar 16, 2018 at 09:01:42PM +0100, Ævar Arnfjörð Bjarmason wrote:
>> One thing that can make repositories very pathological is if the ratio
>> of trees to commits is too low.
>>
>> I was dealing with a repo the other day that had several thousand files
>> all in the same root directory, and no subdirectories.
>
> We've definitely run into this problem before (CocoaPods/Specs, for
> example). The metric that would hopefully show this off is "what is the
> tree object with the most entries". Or possibly "what is the average
> number of entries in a tree object".

I find that the best metric for determining this sort of problem is
"Overall repository size -> Trees -> Total tree entries". If you have
a big directory that is being changed frequently, the *real* problem
is that every commit has to rewrite the whole tree, with all of its
many entries. So "Total tree entries" (or equivalently, the total tree
size) skyrockets. And this means that a history traversal has to
*expand* all of those trees again. So a repository that is problematic
for this reason will have a very large number of tree entries.

If you want to detect a bad repository layout like this *before* it
becomes a problem, then probably something like "average tree entries
per commit" might be a good leading indicator of a problem.

Michael
