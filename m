Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4AAA20281
	for <e@80x24.org>; Mon, 22 May 2017 11:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758929AbdEVLLx (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 07:11:53 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35679 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758926AbdEVLLw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 07:11:52 -0400
Received: by mail-oi0-f44.google.com with SMTP id l18so156508977oig.2
        for <git@vger.kernel.org>; Mon, 22 May 2017 04:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RHce0+E9HV9IPlTtMAwoXo2cXz9ZROZPfGCunlYPKYs=;
        b=g23Kg/NNXCWCSrgnW4i/Wr/wLfMggPYf1HCDcE0WwMrBj0h3e4VJ8we4gibv72MkTR
         Gh3Ij96//qZor1JVAwX8bnbuCdvO0dv7xBqfli9c6O0OPz1zANjpdz8plxEyxz0hsPnz
         cDb4nDqF/aCiFKf7Viq2t6ehjm5zj5wASvqfHgnXLOpUkCnt008Cb86Z1vHbZ2AewzHz
         uxbUsorSG64a6iC3XjJ6RDmCBAj5SXPv+d0eEahKkYE5/8SlATivcstTifKbPAJcPuR0
         PQMBvUPtd7jVt9eJ9O7P6GVuMEHbiIXdjYPjBpR23wprC8FTafhlvoeqtLlD6dpgdJVq
         udYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RHce0+E9HV9IPlTtMAwoXo2cXz9ZROZPfGCunlYPKYs=;
        b=EaN2GNK+Mi0Pz49uqCianH0YYyPT3HJ/64Q/usJSSn8/ngm3KKJBFSwNNS7YZu+oDz
         4pe6lULwYQZKpVMWTmFUXHCGaeDG72UpRwWmLehI+8nEXMzJnDjy/W0RpBAxAY6N9F4U
         RdDA6vI2uhVy3bVBpHsDFAnPp0bW/YMtsJcZmJUVlyIHS0abwMe8Jxds6eAP0eujaq+F
         2Y9KRJV2vWI+1i0Jqhk/Tp/cPy2HO5kx16+SJ9uDGmyups6kHpLLV9BfHO9FlJN7bG3Y
         9kO+XC+xweNfWqADEgWu0JSCOgAeLBraSKL8/9KCkvge7sDp8vO0QcMBKim1H8bbqRzs
         bm2A==
X-Gm-Message-State: AODbwcDnb1M+NXy/3VW/yUBQxMKfEIr4sbtO95XuXlXvzT69D+9wf/ZB
        EUs1wxtAVsS7Lx3PjInqCzIxd9eKDA==
X-Received: by 10.157.24.123 with SMTP id t56mr12137633ott.101.1495451511691;
 Mon, 22 May 2017 04:11:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.145.17 with HTTP; Mon, 22 May 2017 04:11:21 -0700 (PDT)
In-Reply-To: <20170519143727.edi4ni7v5pywm7dk@kitenet.net>
References: <20170516171028.5eagqr2sw5a2i77d@kitenet.net> <20170519143727.edi4ni7v5pywm7dk@kitenet.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 22 May 2017 18:11:21 +0700
Message-ID: <CACsJy8C4EZnB2PkJw5t7c007vRmb8DDKk41p2azvjOnJNO0n7Q@mail.gmail.com>
Subject: Re: reversion in GIT_COMMON_DIR refs path
To:     Joey Hess <id@joeyh.name>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Peter Simons <simons@cryp.to>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 19, 2017 at 9:37 PM, Joey Hess <id@joeyh.name> wrote:
> Joey Hess wrote:
>> Bisecting this test suite failure
>> https://git-annex.branchable.com/git-annex_in_nixpkgs_fails_with_git-2.13.0/
>> I landed on commit f57f37e2e1bf11ab4cdfd221ad47e961ba9353a0 to git.
>>
>> It seems that changed resolving refs paths when GIT_DIR and GIT_COMMON_DIR
>> are both set. While before refs were looked for in GIT_COMMON_DIR,
>> now they're not.
>
> In case there's any doubt about whether this is a reversion or an
> intentional change, see gitrepository-layout(5):
>
>        refs
>            References are stored in subdirectories of this directory. The git
>            prune command knows to preserve objects reachable from refs found
>            in this directory and its subdirectories. This directory is ignored
>            if $GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/refs" will be used
>            instead.
>
> So the documented behavior is broken.

It's a gray area. When I wrote that I think I forgot about
per-worktree refs (refs/bisect/*) so "This directory is ignored" is
not completely true. The final line (probably won't help you much) is
"per-repo refs must be read from $GIT_COMMON_DIR/refs, per-worktree
from $GIT_DIR". The fact that we looked per-repo (like master) in
$GIT_DIR is probably an unwanted side effect.
-- 
Duy
