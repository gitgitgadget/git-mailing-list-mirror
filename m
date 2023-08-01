Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75671C0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 18:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjHASdg convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 1 Aug 2023 14:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjHASdf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 14:33:35 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA591BC1
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 11:33:34 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3a3efee1d44so4656745b6e.3
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 11:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690914814; x=1691519614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJ8un3P7Me1CNUETXYetNXvSnzr0IXYu+U1DBUmleZg=;
        b=DaQ3AtuXpuWVowEwEBhDa5mn1agFi7dJF5YOkEcX5x5+VqubXwV2E0eErNvrIsvQsg
         nCXrxwHsHXi779LCG3vRHFfHyTUSeiZkzv9rFWV3H90196bA9DaquQP92CyyFtRcOZTv
         v9orkS91TUP3gaSCspecl5fvy+UyJWLlTSOr5YgWdLPiEAiQHyu3wFIXOF2dtLblPNdr
         KmpfehAxTdhkAGMm+8Qxep7BTJs4J6vU1VDK6BZ5kIGALL35nwibhCU94Hs4KB+UZkJ/
         Mgq8om6ADvNOur4rlA++MCHhCWA+Bi0+lymtzaqB89qylCajcXRmHafZaPC0rpUtCesg
         v/eQ==
X-Gm-Message-State: ABy/qLYEo/5o4+w8DJhU56UQ9r/ShPUbIFC5r+DwNFhy+RTPDOxsiIVk
        Ky7V2JZ8hJTsH7Ov6jWa3wO9FRcCnGMyioeNpWcFOJV5
X-Google-Smtp-Source: APBJJlHVHt2b3LdI69AFqlqXlwnEVZVl0D31yI/eH22e6SwbccNEkGJes45LukMHWNMC6oPJmgeDctHBIgwf6L2zQAs=
X-Received: by 2002:a05:6358:919d:b0:135:4003:784c with SMTP id
 j29-20020a056358919d00b001354003784cmr3522792rwa.17.1690914813875; Tue, 01
 Aug 2023 11:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh6po95a5.fsf@gitster.g> <ZMfhWkd24y7XjEIw@nand.local>
In-Reply-To: <ZMfhWkd24y7XjEIw@nand.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 1 Aug 2023 14:33:23 -0400
Message-ID: <CAPig+cTRUac+FRg6V1H+3_rusT17imQGZOy8Fd-MWriEv_epRQ@mail.gmail.com>
Subject: Re: tb/commit-graph-tests (was: Re: What's cooking in git.git (Jul
 2023, #06; Thu, 27))
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 31, 2023 at 12:55 PM Taylor Blau <me@ttaylorr.com> wrote:
> On Thu, Jul 27, 2023 at 06:46:42PM -0700, Junio C Hamano wrote:
> > * tb/commit-graph-tests (2023-07-24) 5 commits
> >  Test updates.
> >
> >  Will merge to 'next'?
> >  source: <cover.1690216758.git.me@ttaylorr.com>
>
> I think this one is ready to go. Eric Sunshine gave the earlier round a
> review, and I made sure to address his feedback in the subsequent
> version.
>
> I'm happy to wait for an ACK from him, but I think this is low-risk
> enough that you could merge it as-is. Either way :-).

Yup, as I recall, I gave v1 a reasonably thorough read. When the
reroll arrived, I scanned the range-diff and saw that the few minor
review comments had been addressed, thus I had nothing more to add.
