Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22E601F453
	for <e@80x24.org>; Mon, 22 Oct 2018 03:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeJVLin (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 07:38:43 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:33170 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbeJVLin (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 07:38:43 -0400
Received: by mail-wm1-f43.google.com with SMTP id y140-v6so8152438wmd.0
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 20:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QeEPjZYEiGC+Vf2x6pvHnRXGL3OxDAlXNUJmQlRS6bw=;
        b=CHXgJ9VpZ9m0LFFP7/sSqHU3BM3BPf16iKHssueCqU/kulEytDGoM3vlHCVdtOZ3Dr
         0ImJcdVwBXj0SjF3caKSrE6uSeBL9Gt2muB3lAWVYcag1gXrTgrJ/LyTAuQIdyku8kHQ
         2qpgY3/SQckuRS94/qFR2s9PpSPfpQqZHQHm7RkgXN+SGSiBsNtYDvGh3G3K8+QS0Lz9
         r20GakRfEknamyLLbQmITLtuguj2dtkEUOZ2MjiOdE8xuZKLZMOL8+z0QTlx9mstZ8Cd
         MblbWc9Z1PkZ8oVHcR5wd3I7U54L4l3bnLUK1J9VL4GiFipTuZNl7mNmV9SjSf+4/F+p
         jppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QeEPjZYEiGC+Vf2x6pvHnRXGL3OxDAlXNUJmQlRS6bw=;
        b=nEL0QnH6P/A0qGO51TJahKC1VDckQnuxBDbpAQ8sbVJ6r+BZ8AzWt4ktYOIiJJaZ3u
         vVGy4IcDwoLik7mqU/47OOIX8CtRIiQgnYbUEYIC/0Gyj/v67RRXqscPxCMqYS8KiZQW
         3t3Zrs6bRRHzHgdTngyoMM/aMsvbxh80T/cEzVbwNr30FRv57macQaEsiEjR/KHTlbx8
         vvTXg5LeC3t7V1+8XGZwZcxPGuCJPbNGNb38HKYZPVCHyp6t2TGR0sL8OrEauszmLLu4
         KOoBIBcmGZ3NM7VBv8CpKRjH+qhp6CyhcZ7R40EVGoCq2Bmq5/GXUWiHIKJX0Fv3B+f5
         JfrQ==
X-Gm-Message-State: ABuFfoijXJvYy4rrxoeeI2sLTQu/hBw1o8+VSbf+Ftqf2bUbaRqlZkXL
        TmSHx7TxfAEzpGQ3oA34/as=
X-Google-Smtp-Source: ACcGV63cQMK+8UEcigjpgZycGrdzZFxUxw0mloTM6k8VXCMkQSJsSBdQzw6S1K7AnVOXYxdfEdfJ0A==
X-Received: by 2002:a1c:c012:: with SMTP id q18-v6mr13404721wmf.150.1540178522450;
        Sun, 21 Oct 2018 20:22:02 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l11-v6sm45283865wrn.61.2018.10.21.20.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 20:22:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joey Hess <id@joeyh.name>
Cc:     git@vger.kernel.org
Subject: Re: git ls-files --with-tree documentation
References: <20181019183335.GA12353@kitenet.net>
Date:   Mon, 22 Oct 2018 12:22:00 +0900
In-Reply-To: <20181019183335.GA12353@kitenet.net> (Joey Hess's message of
        "Fri, 19 Oct 2018 14:33:35 -0400")
Message-ID: <xmqq8t2qy8br.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joey Hess <id@joeyh.name> writes:

> How about changing the documentation to something like this to make
> more explicit what it does.
>
>        --with-tree=<tree-ish>
>            Treat all files in the <tree-ish> as if they were present in the index.
>            When using --error-unmatch to expand the user supplied <file> (i.e.
>            path pattern) arguments to paths, this has the effect that paths which were
>            removed in the index since the named <tree-ish> are still present.
>            Using this option with -s or -u options does not make any sense.

If <tree-ish> has a file F and the index has a file F/1, I do not
think the command can pretend that F is present in the index (which
requires it to also pretend that F/1 does not exist), so the above
description is not quite right---the description needs to be
tightened a bit, I am afraid [*1*].

But more importantly, given the fact that we needed piecemeal
fix-ups like 4b4e26d2 ("Teach ls-files --with-tree=<tree> to work
with options other than -c", 2008-11-16), and the fact that your
description above still mentions "incompatible with -s", I strongly
suspect that the implementation as-is would still *not* perform the
way you describe above.  In some modes, it won't pretend as if all
of <tree-ish> are present in the index.

And I do not think I care that much to respond to a bug report that
claims the above paragraph describes the way the command ought to
work, either, but apparently you do care much more than I do, so
perhaps you can respond to such bug reports whey they come and I do
not have to worry about them too much ;-)


[Footnote]

*1* It actually pretends that entries in <tree-ish> are at stage #1,
    all the originally unmerged entries are at stage #3, and shows
    entries at stage #0 (i.e. merged entries in the original index)
    and stage #1 (i.e. from <tree-ish>), but only those that do not
    have corresponding stage #0 entries.  That is why "-s" won't
    make sense (i.e. from an entry being at stage #3, you cannot
    tell if it were originally at stage #1, #2 or #3), and "-u"
    won't make sense (i.e. ditto---and there is no good explanation
    as to why <tree-ish> entries appear at stage #1, other than the
    real reason: this is only to be able to enumerate all paths that
    are in <tree-ish> and the index, so that error-unmatch can say
    "Ah, that path is in the HEAD so it is not a typo" even for a
    path that has been removed from the index when running "git
    commit <paths>").



