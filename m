Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FBC21F453
	for <e@80x24.org>; Thu,  4 Oct 2018 16:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeJDW7N (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 18:59:13 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:37558 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbeJDW7N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 18:59:13 -0400
Received: by mail-wm1-f45.google.com with SMTP id 185-v6so9631160wmt.2
        for <git@vger.kernel.org>; Thu, 04 Oct 2018 09:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=2ldPFLC+cWERMhzKFUrSjmVm6l+OJDcv/YVAUbnOao8=;
        b=g/Mf63jlTGNYfag4tg4Noytef8EsLbaU4yfGMcRhxKeI6bBm3USAnv11a06dv0hYpa
         iG6MRtyHOC1/skjoFwOMOiTopQJ000EhPrSMQPdb6SKBxqcF6OJuyl9FZayoUu9Jh5N1
         X/R3ZSijZLAmwC5LbiR46g91s7wWW3nchT5+iZy6ZngQiJlfp4MVUoQdY3JlkF/IH5ZX
         PxHMcY5aTEyMnNG462cyHvndZrll2EAtzdRzV4fFW8LfExszt0VjAXihA5U2LCYqCYtU
         ueUAAO+X150gjG2w95jWP6E7Q4qExIEkDzJvoGfe0JmMo9ue8C/hk9zkDVp86CZxd8UD
         ppKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=2ldPFLC+cWERMhzKFUrSjmVm6l+OJDcv/YVAUbnOao8=;
        b=PP6KzdNC5cze50nBroEK46PGdROROdObe8jUBWJgHsaJDY0r+nU+hoYY6Pr8OEmUKo
         kiLbj3b9IQlhJwGxpZMhmmAevn1cYRAyBxDsQ31/qobhZYNlUGSPeU4kHCBAkR69X31t
         Ab11Coww/wkc2tDeqCStaOfX/vwIVSfojoRh/4S2TWpVrGoP2re+F/ciFH2t4mrPcQEh
         MbBc1kUW/S21wUUHrJ9p6tTC0kp63AOhP9YyksP5jnsiokgbdRuSo8plqJtZMeXCZx6Z
         /yTj30Ho6/EJwFjNqvxoze2tV0YkFYy3sGw+VLcDOd7DuUAcBsNTKzf8NCzVa4jl6ATS
         bm1w==
X-Gm-Message-State: ABuFfoilDL4MzXnADfo8zWUHc5AqZR4iVsHpv6Q9wYaxasd78qft7FMU
        UOJg/ViMxeAfr2Oi31PWF+WJDTBo
X-Google-Smtp-Source: ACcGV60ZF4kuyb+kPcm5I9j4Q74cnPzDyF2WIXkKQbxNhOLxRTuOXwdQgZB3YvCkOpks3effOMK/Hw==
X-Received: by 2002:a1c:a851:: with SMTP id r78-v6mr5075090wme.97.1538669116252;
        Thu, 04 Oct 2018 09:05:16 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egk144.neoplus.adsl.tpnet.pl. [83.21.74.144])
        by smtp.gmail.com with ESMTPSA id u76-v6sm9136965wmd.10.2018.10.04.09.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 09:05:14 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Xenos <sxenos@google.com>, git@vger.kernel.org
Subject: Re: Git Evolve
References: <CAPL8ZivFmHqS2y+WmNR6faRMnuahiqwPVYsV99NiJ1QLHOs9fQ@mail.gmail.com>
        <xmqqbm8f952b.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 04 Oct 2018 18:05:10 +0200
In-Reply-To: <xmqqbm8f952b.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 29 Sep 2018 17:55:56 -0700")
Message-ID: <86d0spzoi1.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Stefan Xenos <sxenos@google.com> writes:
>
>> What is the evolve command?
>> ...
>> - Systems like gerrit would no longer need to rely on "change-id" tags
>> in commit comments to associate commits with the change that they
>> edit, since git itself would have that information.
>> ...
>> Is anyone else interested in this? Please email me directly or on this
>> list. Let's chat: I want to make sure that whatever we come up with is
>> at least as good as any similar technology that has come before.
>
> As you listed in the related technologies section, I think the
> underlying machinery that supports "rebase -i", especially with the
> recent addition of redoing the existing merges (i.e. "rebase -i
> -r"), may be enough to rewrite the histories that were built on top
> of a commit that has been obsoleted by amending.
>
> I would imagine that the main design effort you would need to make
> is to figure out a good way to
>
>  (1) keep track of which commits are obsoleted by which other ones
>      [*1*], and
>
>  (2) to figure out what histories are still to be rebuilt in what
>      order on top of what commit efficiently.
>
> Once these are done, you should be able to write out the sequence of
> instructions to feed the same sequencer machinery used by the
> "rebase -i" command.

Well, that assumes that "rebase -i" can correctly recreate merges, if
needed.

> [Side note]
>
> *1* It is very desirable to keep track of the evolution of a change
>     without polluting the commit object with things like Change-Id:
>     and other cruft, either in the body or in the header.  If we
>     lose the Change-Id: footer without adding any new cruft in the
>     commit object header, that would be a great success.  It would
>     be a failure if we end up touching the object header.

Doesn't Gerrit use git-notes instead of 'Change-Id:' trailer nowadays?
Notes transport is quite easily controlled; the problem with notes merge
does not matter for this use.

Best,
--
Jakub Nar=C4=99bski
