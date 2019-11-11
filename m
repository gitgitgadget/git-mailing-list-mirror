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
	by dcvr.yhbt.net (Postfix) with ESMTP id 13CF01F454
	for <e@80x24.org>; Mon, 11 Nov 2019 21:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfKKVlU (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 16:41:20 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42932 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKKVix (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 16:38:53 -0500
Received: by mail-ed1-f67.google.com with SMTP id m13so13127245edv.9
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 13:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IEDTB58Y5pheJ3TGNeKZDPZgDvFYwTAi010qp9R8tiQ=;
        b=TP4wINRWF9LwH2HgG/xuG6Ct/WCV1GmI9Vr3vptluJhaj2pN5zHxAS8FPmwvkdnJte
         UqgfEzDJMa23OENxSQLxv2WGrT85Sf1uljt8IAWJZPnmw9lh09IDffTEqlxSaTm+fqnx
         akEbJ1Ri53RGUP8E8hGamx+VSBXUEkWDPA2VT2sqZkhd8baLjjFrDrB5n/CF36xOw7WO
         olzTYp1f70dGPaqNAZUC8WkVJ7zWHvJ40/zg26eMvNnDmc3jbHS04Att8IZDGWQQKAU3
         EYFhPnTgz51uSOw4tqZ6ITvXzUBmQy0N+LRRNygEDTsCy3+wUIUbzIaQJCkGXQ9KRAFY
         4zqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IEDTB58Y5pheJ3TGNeKZDPZgDvFYwTAi010qp9R8tiQ=;
        b=Er5Z3iZ+6JvuVkU+/ieGTham98gPDI3SkfUL5FnSgjqdMLrptNMM8Gz6VbSUGYsPZy
         KkA0VSrlpWhohM5Kox3DFN2a+/UtH5R1cQzuy+m40rG/Hf1xnft5V35Sn8u1qPjgsW+4
         DzghQ2h3+9Bi7TDaUn7wgccdxhjQ9GybSFRKCFM+jzxaxsvF9SZi3S2RTPX9y4zCuMFi
         qHjJ58Dk0EHviyn8+AOj8Ozvoz2R2yznYNxzqCqxiRCkEfgnO5iIVyMBr4t4M641tKST
         iSxAiAJvU9+kKf97bwO+7K0GfexbgD32tVHEHNAUssY9i1W2fzAh0gVHk6csLLMLAdiY
         Sc8Q==
X-Gm-Message-State: APjAAAXvhiPAQ+VvqgD3BIuNG6L+CUULcBPyb5VVfDVfUQ86oaG3uiKz
        HjopvChZsWIAt5XXhWfsPqePRQEQqK85WhYxEvI+PJNZWX4=
X-Google-Smtp-Source: APXvYqzISvaPFbq635wera+4OGBr6dYo/nzRyCQOPUU1njsWcORRdzWVwKPrOkGjD9zUIFRYVgOaj+sCYA7agrPM660=
X-Received: by 2002:a17:906:245b:: with SMTP id a27mr25428300ejb.192.1573508331635;
 Mon, 11 Nov 2019 13:38:51 -0800 (PST)
MIME-Version: 1.0
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
 <pull.434.v2.git.1573034387.gitgitgadget@gmail.com> <3d1e7e72efca06d18606b6f9dd8c3b6771dfde06.1573034387.git.gitgitgadget@gmail.com>
 <xmqqh83bi10h.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh83bi10h.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Tue, 12 Nov 2019 10:38:40 +1300
Message-ID: <CACg5j27=t_tC4AqNz6tSdsgbDKECq1p+OwS=ydak7d94q2PHZg@mail.gmail.com>
Subject: Re: [PATCH v2 15/20] parse-options: move doc to parse-options.h
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 11, 2019 at 3:45 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > + * Steps to parse options
> > + * ----------------------
> > + *
> > + * - `#include "parse-options.h"`
> > + *
> > + * - define a NULL-terminated
> > + *   `static const char * const builtin_foo_usage[]` array
> > + *   containing alternative usage strings
> > + *
> > + * - define `builtin_foo_options` array as described below
> > + *   in section 'Data Structure'.
> > + *
> > + * - in `cmd_foo(int argc, const char **argv, const char *prefix)`
> > + *   call
> > + *
> > + *   argc = parse_options(argc, argv, prefix, builtin_foo_options, builtin_foo_usage, flags);
> > + *
> > + * `parse_options()` will filter out the processed options of `argv[]` and leave the
> > + * non-option arguments in `argv[]`.
> > + * `argc` is updated appropriately because of the assignment.
> > + *
> > + * You can also pass NULL instead of a usage array as the fifth parameter of
> > + * parse_options(), to avoid displaying a help screen with usage info and
> > + * option list. This should only be done if necessary, e.g. to implement
> > + * a limited parser for only a subset of the options that needs to be run
> > + * before the full parser, which in turn shows the full help message.
>
> After just looking at Documentation/technical/api-parse-options.txt
> for real reasons (i.e. not for the purpose of reviewing this patch,
> but to review a patch that uses parse-options API), I must say that
> applying this change would have made the documentation quite less
> useful, at least for my purpose.
>
> My reading began by "git grep PARSE_OPT_STOP_AT_NON_OPTION" to find
> the page that this patch proposes to remove, and in that document,
> the list of flags the PARSE_OPT_STOP_AT_NON_OPTION belongs to comes
> immediately after the above message, so it was much easier to see
> where in the overall API usage the option comes into picture.
>
> With the description moved close to enum{}, I know there would be
> less risk of adding a new member without documenting it, but that is
> for convenience by the developers of the parse-options API, and not
> necessarily makes it convenient to learn and use the API.  I would
> have been forced to jump around to hunt for the necessary pieces of
> info sprinkled in the header file to form the overall picture, that
> a simple flat-file text document would have much easily given me.
>
> So, I dunno.

Hi Junio,

I can see your point, let me share my perspective as I've thought
about that several times while moving the docs. As a new contributor
to the code base, when I come across a function or a data structure
that I want to understand what it does, I'd first try to find it in
the .h or .c files, looking for its documentation, unless I find a
link there to a file named
Documentation/technical/api-parse-options.txt I won't know about its
existence and I'll feel frustrated to find no documentation in the
code.

On the other hand some doc files had too many details for a header
file (or that's what I thought) like for example
Documentation/technical/api-trace2.txt. So the approach I took there
which is pending on review/discussions was to remove the functions
documentation from the text file to the .h file and leave the rest of
the details as is in the text file. (you can refer to this patch here
(https://public-inbox.org/git/a337f88a55ddaafd5754492ae0399137966738a8.1573507684.git.gitgitgadget@gmail.com/)).

So my proposal for this matter is to investigate the possibility of
using a doc generators that'd extract the documentations from the code
to a single doc file per library.

Thanks,
Heba
