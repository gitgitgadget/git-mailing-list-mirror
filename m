Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B74D31FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 19:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbdBFTKz (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 14:10:55 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35460 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbdBFTKy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 14:10:54 -0500
Received: by mail-pf0-f196.google.com with SMTP id f144so7473684pfa.2
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 11:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PPZ0cv2erENtKGTCvYzAfKS2y6SvNlmffB/4gy7YXf8=;
        b=oFDPWmpISk+GHXm801ip5MuUkkDi0vCN93NKtIK+FFuVHboG/PmgnZsth28Gpv6eUa
         Gppynkn+jSefq8mlPlfoNV2FHkG4cG5RcDgcEE15MkqwGQSZRdWiEfbRZiIJ5+XTCTuJ
         YN1WNzqKBI1bJ21VtD+UNtbevZGK35ME83v7iXW6BxhNmpkfILDyCYZqU4v9hlokDGqi
         aPC5c+2Tjl6cM1OD6j0DAYX2CmxVvfV4YBnHtE5/cxo1CtcA869aYKIvm7nmwpGoBxts
         JoZcGAasnYLSJoO1uOmE1gTyLKonCQk6wzKkIZtV441rBBLdXUm67kfOl2QwR1/dLrl2
         IghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PPZ0cv2erENtKGTCvYzAfKS2y6SvNlmffB/4gy7YXf8=;
        b=iOzrXbOK52NGYjJCs1WW82mc2gtO2cu8NpA9tqh/z6wEAYVwXt1CtPYTtipdI0Q9f5
         TKP4SB3+Wtpjn5cPUY6pRCttLDmgEdMyMe0fUJtvCDWljOmoWo9+/mKxUAzJncevMyEM
         YZEOHrpvTxIirwwFPXGjknGh6drazQtTl5R90cModh+L9ecqjmdi+iaFuyF1J9IMAKfT
         nseWNE3r/CKyIXcy2wrb1lABqeJKeKUnIdJB8ZzRJwjln+Wai5zkQihd4zPN0tRE33Ab
         x49SF+B/mB0+IvcUMrqRQ0CIHbNt6Cxzj1O/z2iQTsuIqBIlzUTusfF2WcM8UWkSVFNN
         to6g==
X-Gm-Message-State: AIkVDXJ7gB2LORSzPOwqFpkXp4kCyYVOu7zjx9ORakoCeA/2chTfRHE2dlk1UHJ2LR835A==
X-Received: by 10.84.210.8 with SMTP id z8mr19464425plh.94.1486408253798;
        Mon, 06 Feb 2017 11:10:53 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:310c:cda4:fdbc:2aa2])
        by smtp.gmail.com with ESMTPSA id 66sm4611863pfx.29.2017.02.06.11.10.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Feb 2017 11:10:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
Subject: Re: Cross-referencing the Git mailing list archive with their corresponding commits in `pu`
References: <alpine.DEB.2.20.1702041206130.3496@virtualbox>
Date:   Mon, 06 Feb 2017 11:10:52 -0800
In-Reply-To: <alpine.DEB.2.20.1702041206130.3496@virtualbox> (Johannes
        Schindelin's message of "Mon, 6 Feb 2017 16:34:28 +0100 (CET)")
Message-ID: <xmqqwpd316f7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So I thought maybe the From: line (from the body, if available, otherwise
> from the header) in conjunction with the "Date:" header would work.

FYI, I use a post-applypatch hook to populate refs/notes/amlog notes
tree when I queue a new patch; I am not sure how well the notes in
it are preserved across rebases, but it could be a good starting
point.  The notes tree is mirrored at git://github.com/git/gitster
repository.

E.g.

$ git show --notes=amlog --stat
commit 2488dcab22cee343fe35d9951160f0966a45fdb3
Author: Patrick Steinhardt <patrick.steinhardt@elego.de>
Date:   Mon Feb 6 14:13:59 2017 +0100

    worktree: fix option descriptions for `prune`
    
    The `verbose` and `expire` options of the `git worktree prune`
    subcommand have wrong descriptions in that they pretend to relate to
    objects. But as the git-worktree(1) correctly states, these options have
    nothing to do with objects but only with worktrees. Fix the description
    accordingly.
    
    Signed-off-by: Patrick Steinhardt <patrick.steinhardt@elego.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Notes (amlog):
    Message-Id: <c2af75361b7b357fa905ab072bfdc45ad055ca49.1486386803.git.patrick.steinhardt@elego.de>

 builtin/worktree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
