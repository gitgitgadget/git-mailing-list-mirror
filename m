Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C451F404
	for <e@80x24.org>; Mon,  9 Apr 2018 16:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753097AbeDIQMB (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 12:12:01 -0400
Received: from mail-ot0-f169.google.com ([74.125.82.169]:41483 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753074AbeDIQMA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 12:12:00 -0400
Received: by mail-ot0-f169.google.com with SMTP id m22-v6so6186773otf.8
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 09:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hhsbwKA4vV5L890tycRFCVq8YyHK9Bobi1rCUFqBmQo=;
        b=n/doWXSbLqjRVpqpMBIhi4sJ2UTrq1rRFlyNxBZ9Ekr/7uoSdBB2bzXdPC+ApaZote
         EoTZsCpAN1XR+ksS+RJfjNba356mMBZGVbMIVVazwAwoVbRVaTm7BmyAZhdtF7vH0PO7
         JN+giQ2YobEkM1Y679eetyV3ewtYj1Oe7/F6uoa/JZi8tfWqDlu+jNZ506+1ukJiPK4F
         fodBavmV4izNSxzpKz+iF2oncptw6tOo56V+Qc7GtCmOuhTZqm7wMLdSHbSFIt9lYwwy
         Nmbd7zDQTi6SjZGLV3BPzvL05Q6R7Fj7Zdy8iwmNrD4+me4UyKK4h1PlKV/VcuCV+5OI
         eo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hhsbwKA4vV5L890tycRFCVq8YyHK9Bobi1rCUFqBmQo=;
        b=Do9crSGYd2+h+8C+613iSX7jpz6nO0XkU3H135EUyi/kzT64eC5fbhhIV8EwJop1oM
         T2zgGtC2r1yxkoYe8bZ21CrNvSsqfM0D0ta/whimH6sn1xcCUwr6EzMjbpm6O2DTapXM
         9NEarrRJywB8f/KWa541RoipjZwxOXmnfrcLsA0n2iJnJgFJEW9KZHNukHxEUf94y9FW
         aBPQivLo+n6lwp80+3KUxf7y6Pr9i4YT1ODI7xq2Z70jfb2GtvldjXhDINTgsamYa2cC
         6k9eioEQOoBESR+pEch6srMDTOz4k61s2hcZiXOkg+kg6CfdNFhRZuksZGULDDVUi1ty
         dyJA==
X-Gm-Message-State: ALQs6tAOvI14xKkVP5vUpeBXFtKI5paymzWbzw4/+xhSbkIM7WZrKOF1
        Qj6wJ0J55BC1QS2geENSfFecGIgqRYQ3YBfHSSM=
X-Google-Smtp-Source: AIpwx4/PTPAjAlOU3fzOGoHYu8eGs9Pb7EleXXnjrCNJyi2PuvQ5+cT3q71uUCRtTw4qsLU3wO7DnjfxWI5awQrsNqc=
X-Received: by 2002:a9d:154c:: with SMTP id z12-v6mr24451538otz.65.1523290319581;
 Mon, 09 Apr 2018 09:11:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Mon, 9 Apr 2018 09:11:28 -0700 (PDT)
In-Reply-To: <20180409073400.19415-1-sunshine@sunshineco.com>
References: <20180409073400.19415-1-sunshine@sunshineco.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 9 Apr 2018 18:11:28 +0200
Message-ID: <CACsJy8C+x__iEXU3LPTBRnoUBbcOXom6qO_42yk=eNS8_UddvQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] git-worktree.txt: recommend 'git worktree remove'
 over manual deletion
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 9, 2018 at 9:33 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> When cc73385cf6 (worktree remove: new command, 2018-02-12) implemented
> and documented 'git worktree remove', it forgot to update existing
> instructions suggesting manual deletion. Fix this oversight by
> recommending 'git worktree remove' instead.

Too bad we can't show off "git worktree move" :) The patches look fine.
-- 
Duy
