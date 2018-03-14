Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1F431FAE3
	for <e@80x24.org>; Wed, 14 Mar 2018 08:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeCNIdj (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 04:33:39 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:49814 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751346AbeCNIdi (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Mar 2018 04:33:38 -0400
X-AuditID: 1207440d-98bff70000000c05-10-5aa8de5ff2de
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 22.10.03077.06ED8AA5; Wed, 14 Mar 2018 04:33:36 -0400 (EDT)
Received: from mail-lf0-f42.google.com (mail-lf0-f42.google.com [209.85.215.42])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w2E8XXwv023953
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 04:33:34 -0400
Received: by mail-lf0-f42.google.com with SMTP id l191-v6so3503080lfe.1
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 01:33:34 -0700 (PDT)
X-Gm-Message-State: AElRT7GsWn31BqJ8XX/rARvByiJ8wOH4NZVczfdofrk0bS7NcGdqcH8E
        zTL5cR16Wul8ZIv4fCNiJ/ZCyoLSaXiB9WXfTDI=
X-Google-Smtp-Source: AG47ELs4z9iwWm7UhsL6AixJRsn56v9xitbd2PVTh65z6+RPiWW/baFchicaZ7qv909AI2dlyViMQaArMt+kQMXo+Dc=
X-Received: by 2002:a19:a551:: with SMTP id o78-v6mr2804156lfe.77.1521016413314;
 Wed, 14 Mar 2018 01:33:33 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.46.18.81 with HTTP; Wed, 14 Mar 2018 01:33:32 -0700 (PDT)
In-Reply-To: <953C263C-6ECA-46AC-849C-8D1A38378654@gmail.com>
References: <953C263C-6ECA-46AC-849C-8D1A38378654@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Wed, 14 Mar 2018 09:33:32 +0100
X-Gmail-Original-Message-ID: <CAMy9T_GdYjUm9DqcgrC=NxyTbZk_ep5rvAAK2J=zwhiSMyvaLA@mail.gmail.com>
Message-ID: <CAMy9T_GdYjUm9DqcgrC=NxyTbZk_ep5rvAAK2J=zwhiSMyvaLA@mail.gmail.com>
Subject: Re: [git-sizer] Implications of a large commit object
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsUixO6iqJt4b0WUwZ5+FouuK91MDowenzfJ
        BTBGcdmkpOZklqUW6dslcGUsnbeVraBJoOLWvKoGxkfcXYycHBICJhILD+xgBrGFBHYwSRxf
        bdvFyAVkP2KS2PpuOROEM5FRYuPVJ6wQHeUSnbs/MEPYRRJvelqh7AqJh609TCA2r4CgxMmZ
        T1ggpspJvNpwgxHC9pQ48fAv2BxOAVuJuS/boDbbSHy4/JMdxGYT0JVY1NMMNodFQFVi46wl
        UHsTJfZ1P2WBmB8g8eQsSJyDQ1jATuLjRLCwCFDr9Q1/wEYyCyhJ/H4wlx3C1pRo3f6bfQKj
        yCwk181CklrAyLSKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdILzezRC81pXQTIySweXcw/l8n
        c4hRgINRiYeX4cLyKCHWxLLiytxDjJIcTEqivPunrIgS4kvKT6nMSCzOiC8qzUktPsQowcGs
        JMK7VQYox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4K28C9QoWJSa
        nlqRlplTgpBm4uAEGc4DNNziDsjw4oLE3OLMdIj8KUZ7jm+zHrQxc/zZCyK/TXsOJG+8eN3G
        LMSSl5+XKiXOWw4yWgCkLaM0D24yLGm9YhQHelSYtwGkigeY8OBmvwJaywS0NnMb2NqSRISU
        VAMjg/0F3/7S7PkGX0yuyWifC1952efQ7k1f6vcWqMroS9dL+O/y5XnFdbHX4vmfjf3z60RW
        Nc1Qjbvl63BzwaVbizkitnFpZrkd7d0ltCy8/veBtZYnz+5/qqhsJvB9We/7vMmT/D5ZXdn7
        7k2szMlVCqn7Xl+t3Hjpy+zP6hlL9z7u/fei5UAjsxJLcUaioRZzUXEiAMqNxJA1AwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 14, 2018 at 9:14 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> I am using Michael's fantastic Git repo analyzer tool "git-sizer" [*]
> and it detected a very large commit of 7.33 MiB in my repo (see chart
> below).
>
> This large commit is expected. I've imported that repo from another
> version control system but excluded all binary files (e.g. images) and
> some 3rd party components as their history is not important [**]. I've
> reintroduced these files in the head commit again. This is where the
> large commit came from.
>
> This repo is not used in production yet but I wonder if this kind of
> approach can cause trouble down the line? Are there any relevant
> implication of a single large commit like this in history?
> [...]
>
> #######################################################################
> ## git-sizer output
>
> [...]
> | Name                         | Value     | Level of concern               |
> | ---------------------------- | --------- | ------------------------------ |
> [...]
> | Biggest objects              |           |                                |
> | * Commits                    |           |                                |
> |   * Maximum size         [1] |  7.33 MiB | !!!!!!!!!!!!!!!!!!!!!!!!!!!!!! |
> [...]

The "commit size" that is being referred to here is the size of the
actual commit object; i.e., the author name, parent commits, etc plus
the log message. So a huge commit probably means that you have a huge
log message. This has nothing to do with the number or sizes of the
files added by the commit.

Maybe your migration tool created a huge commit message, for example
listing each of the files that was changed.

AFAIK this won't cause Git itself any problems, but it's likely to be
inconvenient. For example, when you type `git log` and 7 million
characters page by. Or when you use some GUI tool to view your history
and it performs badly because it wasn't built to handle such enormous
commit messages.

Michael
