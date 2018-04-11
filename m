Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4321C1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 20:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756077AbeDKUml (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 16:42:41 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39874 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbeDKUmh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 16:42:37 -0400
Received: by mail-qt0-f193.google.com with SMTP id v11so3585007qtj.6
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 13:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=IgABzRbBWpxB+NeuU2afmRh31sjJXPopFXKoi4K/sJg=;
        b=Kw7vSQXzivrRGqLd31EimaUBR1759chFqwNfSD8GS04JP4/rTYlkoGp3B41WSjxl+2
         4JszLoioajEl8kVXF9I7sb8GKhs75ymajidjJRHuCecTp30BB2ZGAbbZMNdKoYd86ctT
         PlFxwhNvubWNMOLTzoziPpDIfuWDcW93wpZTetHSm8rl6iars4NrQmVKZB+lcDybbHMR
         MZuW4OJeFv5FC3L5Btw4zvNeSl/R2gQwmRj0Cfp4ag/uTeKpi67vc73HZe2EuwJKedZ2
         fMdyFX7q9Pbv4hZyD1Wr9g7qcPV9P4Fbe0iCgy1CJMr4TKIPuJsTtWSiFz1Mfj0jxqYE
         RB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=IgABzRbBWpxB+NeuU2afmRh31sjJXPopFXKoi4K/sJg=;
        b=BmmRwiJ6dVKc2KSUwEQL+n2z2QD0pPvYe4klECHpPxs0buGoCLnE69Bk6XnAt8u04K
         SFQRd0P1RS8vdjEPwie7Yu66EqGwQycBYkK+UP47+WAp8tGrVBHDk+G2vvZgZz5GQzau
         pI47NF3187GcdH3h+l5MNPhn8aEQvzKRdcS78N4cDcQjnpN5fZO4LGW4R9cP66cawOld
         zpK3F4YUOU6CRjnK0w45Gs+qUGjAGkVhdkxqx4Lui5LbgiV8JKkU7qKZUvVOPLRCzPO0
         eDEKTik2abUV91jS5cOcsf9w4H6O1tNyP5cqun9B5I7c8/Qn+Th0HypT9yLHS+J43oJO
         r01w==
X-Gm-Message-State: ALQs6tAZ++q8w6PbVI32cIWNmA7z0ITCbEet4Uw/5va4P7OcqpblSyEk
        yqC43Lhxq2eNEcDDxbd8iFLJbcEN4NRk7w5tEfY=
X-Google-Smtp-Source: AIpwx4+3hCN6So9S5qXl+TdfKhjBqQEmGMcXpkEgEXveXhBfFBG3Q8BQDTxWN3QIZIMbyzpPfnoUwBFlvtvkg1g6qc4=
X-Received: by 10.200.50.174 with SMTP id z43mr9449312qta.250.1523479356523;
 Wed, 11 Apr 2018 13:42:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Wed, 11 Apr 2018 13:42:35 -0700 (PDT)
In-Reply-To: <20180411202000.31086-1-t.gummerer@gmail.com>
References: <20180411202000.31086-1-t.gummerer@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 11 Apr 2018 16:42:35 -0400
X-Google-Sender-Auth: dDwy559lBigrNSS3NRtO6x7Wjyk
Message-ID: <CAPig+cTQxHPufoB2rCnmLQoLDkCHNeOO477+qwBJ5qseVro4vg@mail.gmail.com>
Subject: Re: [PATCH resend] SubmittingPatches: mention the git contacts command
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 11, 2018 at 4:20 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Instead of just mentioning 'git blame' and 'git shortlog', which make it
> quite hard for new contributors to pick out the appropriate list of
> people to cc on their patch series, mention the 'git contacts' utility,
> which makes it much easier to get a reasonable list of contacts for a
> change.
>
> This should help new contributors pick out a reasonable cc list by
> simply using a single command.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>
> I've originally sent this at <20180316213323.GC2224@hank>, during an
> the rc period.  Eric had some comments, which I interpreted as being
> okay with the change (hope I'm not mistaken there :)).  As I still
> think this would be an improvement for new contributors, I'm resending
> it here.

I don't think you misinterpreted my response. Your answers to my
review questions seemed satisfactory, so I wasn't expecting any
changes.
