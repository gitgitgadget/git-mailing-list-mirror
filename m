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
	by dcvr.yhbt.net (Postfix) with ESMTP id 32EC51F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 09:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfKOJzv (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 04:55:51 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40523 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOJzv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 04:55:51 -0500
Received: by mail-ed1-f65.google.com with SMTP id p59so6884348edp.7
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 01:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fCOiYC1Ok5/4Cfa1RMsqpkO6UOU8UH/xXtNtGSgxAFA=;
        b=KoXlKL5rhtg7y9i4QYt/wjppU2uF5apTttivtFTwrQxJ3eBUtrNGkdG4JJTIHIFhsg
         GoY2hIcYOOWFV4kxzYZS9biQlzQuSAefngE9cyoW9jNze9QdAbRxj3aVRQ+xRgzSZ7oz
         V9z9KLELbIgTFZjFVejzjBGrosXW02YrmXoSyJHU+RT8OOuhxsQBOJO8SA5Oh3pLBMiO
         cjhlsqP9lPtl+UVoiA29BuCSLnojdTiRR/oJcZ5Ou/3cx0op6bErxSGOD8pZRvstT/sy
         5n4lR6qyRE7MzLXjQ4Qz/cG37UvwkLjka5szduHSQUjCw9OME7qBezK1Xi0YmaxQNiQq
         yuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fCOiYC1Ok5/4Cfa1RMsqpkO6UOU8UH/xXtNtGSgxAFA=;
        b=o3ASwb7hfbf3fCyoYRSdGk/aFSdcxBG2ZFV/kSHTajAXTD7kplBTp7EInqPkhPXSMn
         VN0xMwOWkG4ci67gv72h14GtxYN+3yuRKzQlsBTRWj0Q8ur3HF9wZZCVzFjJQibT9PMj
         ut5mQuUzv3TmC3UWUH+fpp/p69t6VtDWQMIixGQxGYfbQg8aOGcQeLUmJKfOSgAu03rR
         8v07eEe2I0uvn6ezo/OL5nkuWTxb4rTw4+V5HYpK4s2IjOEJEAYHDaB4rl0yaZoZSMQ+
         ukxEIyIxW0nioEKcMhfrWYZcBzfTrjyqg8FP+SJbc5nQnEv4wg/CeaVaFp+H6X8EIMYN
         rQkw==
X-Gm-Message-State: APjAAAUN5CNQWnjq56nLmO2qKfBnRBP72ORIBX0+wdp/+430mcKBBG2P
        In9i9Q+4qFpwo63jwk9cDeBnUC131zfgqwPfeJA=
X-Google-Smtp-Source: APXvYqxy9spaa2POzxcI5uSnFY9gN8Gr+LtTFp0JnQPWoPDhrdIDZwyZ+DzFQQE/ozasQZErDvkNc170V4FZ8tV6T58=
X-Received: by 2002:a17:906:245b:: with SMTP id a27mr12997506ejb.192.1573811749266;
 Fri, 15 Nov 2019 01:55:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
 <pull.434.v2.git.1573034387.gitgitgadget@gmail.com> <3d1e7e72efca06d18606b6f9dd8c3b6771dfde06.1573034387.git.gitgitgadget@gmail.com>
 <xmqqh83bi10h.fsf@gitster-ct.c.googlers.com> <CACg5j27=t_tC4AqNz6tSdsgbDKECq1p+OwS=ydak7d94q2PHZg@mail.gmail.com>
 <xmqqblthfxho.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqblthfxho.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Fri, 15 Nov 2019 22:55:37 +1300
Message-ID: <CACg5j25ZO3+=EHYm5-Yp_LKEQA00EH=FAhOeP_TqHw8anCUDEg@mail.gmail.com>
Subject: Re: [PATCH v2 15/20] parse-options: move doc to parse-options.h
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 12, 2019 at 6:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Heba Waly <heba.waly@gmail.com> writes:
>
> > So my proposal for this matter is to investigate the possibility of
> > using a doc generators that'd extract the documentations from the code
> > to a single doc file per library.
>
> Something like that may become necessary to bring docs in some of
> the *.h files up to par with D/t/api-*.txt.
>
> Note that the quality of the latter is quite uneven.  The one I
> noticed perhaps is exceptionally well-structured (even if some of
> the details of its contents may have gotten stale) and to match its
> structure, the order of presentation in the generated doc may have
> to be different from the order of definitions in the header.
>
> But for the ones with poor structure with stale contents, getting
> rid of the stale D/t/api-*.txt and describing the API in *.h files
> is a vast improvement.

I agree.

Back to the main issue you raised in the beginning: lets look at two
different scenarios before and after moving the docs, the first
scenario is the one you've been through trying to look for
PARSE_OPT_STOP_AT_NON_OPTION, luckily you found it in
Documentation/technical/api-parse-options.txt and the doc was pretty
useful for you. But if you were looking for PARSE_OPT_ONE_SHOT
instead, which is not documented in the doc file, you'd have ended up
in parse-options.h with no documentation, even searching for the enum
parse_opt_flags itself won't lead to anything useful I assume.

On the other hand, after moving the docs to the header file in the
last version of this patch, if we're trying to look for either
PARSE_OPT_STOP_AT_NON_OPTION or PARSE_OPT_ONE_SHOT, we'll find that
it's a member of parse_opt_flags, searching for the enum will lead us
to the explanation paragraph in the top of the header file (which was
moved from the D/t/api-parse-options.txt) which I think sounds
convenient enough as it's in the same file, and didn't go through much
trouble to find the needed info.

Happy to discuss more suggestions though.

Thanks,

Heba
