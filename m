Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B66001FA7B
	for <e@80x24.org>; Sun, 11 Jun 2017 04:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751687AbdFKENp (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Jun 2017 00:13:45 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34639 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbdFKENo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2017 00:13:44 -0400
Received: by mail-qk0-f178.google.com with SMTP id d14so18692873qkb.1
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 21:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AsWniV4qoPcCWqEb9xSqzmS45Ci9IfaTb+i/GTp7Z/A=;
        b=LhE1NdcFSKwIgDG478ehL4ZmcGWtFM8D+uia9ALz7oECOlsx+ZfmT9e2uubwTQwnzq
         qhnawzOWtWcADaxrfHk6KuhGzJX4cjGn9FJ4yF1V3YOH05RUNWgMDmh0xPvW7y5p9KqK
         ghcN3OnnpKA9ux7U2o2o4qAmCeiZmStI3Lr1z7gbwAUmWl7FuTN3erbYqpSHa3ukXxeH
         tsAl+/Odh1brQR//hrZ2uR/6wgU40wGqG7qlt4KdhTjy2wY2nKXxQCLaaygZQgR2DgJt
         E4QZUfSc24v+0ao+rUmOBkpEJvYHI/WzVEW3lgC6tUKDLnmpICUVv5AgMkt06IzryJoz
         jSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AsWniV4qoPcCWqEb9xSqzmS45Ci9IfaTb+i/GTp7Z/A=;
        b=ErG6UeIudoW6yL6yYpyYu3qypIEi3aQT1PbPYCOsndIFUPVlMonoQbveqKc8OPoaSw
         /dVegs76fQqw87XNifpIw+jsPiZE7CtyaSNMnQFArGHVEl03w32W4HVzIl7zaEfQJqpI
         7QvdjrLpKFM+/hiQim3JO7bWEmsXOq/9oTBFnS/HYr1kCa1rIQXs92nMvtNnwZax0TwS
         Ikt5I7ISXpH/v83OjSyznkex7B0EeJmepwZJOfLin+ihkFn6Kw0+GZTjb4I/OxXsO/Qz
         1/M1nI0dyJEVBiNNAfVX7Z1d7qezS7xi8hASQzrGVEizW7XuCfeNnQbPAoS4UhCHajF6
         yNnA==
X-Gm-Message-State: AKS2vOyWPXJVTtJHsadhVyGcBApCsxpboJN2VA38ImVoOGXcNea4x0Ih
        ppRfdYRnwbdqZEjmhnQ+YSM8OFGEKA==
X-Received: by 10.55.197.202 with SMTP id k71mr39739051qkl.54.1497154423598;
 Sat, 10 Jun 2017 21:13:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.162.85 with HTTP; Sat, 10 Jun 2017 21:13:43 -0700 (PDT)
In-Reply-To: <20170610190510.GE27719@alpha.vpn.ikke.info>
References: <xmqq4lvo2x6i.fsf@gitster.mtv.corp.google.com> <20170610124836.GD27719@alpha.vpn.ikke.info>
 <20170610190510.GE27719@alpha.vpn.ikke.info>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 11 Jun 2017 06:13:43 +0200
Message-ID: <CAP8UFD0nDaBCiWiho7zJtUZ3MpgPY97NQ0AXnGq7parQBi=sMw@mail.gmail.com>
Subject: Re: 'pu' broken at t5304 tonight
To:     Kevin Daudt <me@ikke.info>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 10, 2017 at 9:05 PM, Kevin Daudt <me@ikke.info> wrote:
> On Sat, Jun 10, 2017 at 02:48:36PM +0200, Kevin Daudt wrote:

>> For me, this bisects to the latest merge:
>>
>> 2047eebd3 (Merge branch 'bw/repo-object' into pu, 2017-06-10), but
>> neither of the parent of the merge break this test, so it looks like
>> it's because of an interaction between the repo-object topic and another
>> topic.
>
> Merging the repo-object with different other topic branches reveals this
> topic to cause the bad interaction:
>
> b56c91004 (Merge branch 'nd/prune-in-worktree' into pu, 2017-06-10)
>
> Still investigating why it happens.

Yeah, 9570b25a97 (revision.c: --indexed-objects add objects from all
worktrees, 2017-04-19) adds the following test to t5304-prune.sh but
this fails if nd/prune-in-worktree is rebased on top of
bw/repo-object:

test_expect_success 'prune: handle index in multiple worktrees' '
       git worktree add second-worktree &&
       echo "new blob for second-worktree" >second-worktree/blob &&
       git -C second-worktree add blob &&
       git prune --expire=now &&
       git -C second-worktree show :blob >actual &&
       test_cmp second-worktree/blob actual
'
