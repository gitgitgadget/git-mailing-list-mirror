Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DCFF1FCA9
	for <e@80x24.org>; Mon, 12 Sep 2016 00:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755687AbcILAeK (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 20:34:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34864 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753632AbcILAeK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 20:34:10 -0400
Received: by mail-wm0-f65.google.com with SMTP id a6so11407158wmc.2
        for <git@vger.kernel.org>; Sun, 11 Sep 2016 17:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=PkxnqAL4P3J7HUiZqV1AoDh0OGli/7/MgykCj/h1qBU=;
        b=DdjtCFJc5l1VZbOCKrvYvIosru4EXvnKobJDD95QGqFK/hInSyj0OSe/9KU0XI0g1W
         EaZ3cWHLI5JcnHwe1uCt7SBWd2WKlUt++DcQwnadVZBWE/ccoyktIpqblY3MII4KIFPf
         7tlgEtXhRZPNQTloaq9DV7uwRP0RJ6goZyNe0auAUaPTZYJcBq2qkhu7ga+lcynL/mSN
         NZhP7xKwutT2Ngh5deNz9rkq7szjYYPwVd37KafDvrLyUKNQXkda9NMcaDjaN1qj0SA2
         iU5D/F+UxxqWFjPqNacDBLFX+GUgYBBPTQs2Ev5efiKt39YfYxRz0MzdkVm4Yn55NPz5
         f+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=PkxnqAL4P3J7HUiZqV1AoDh0OGli/7/MgykCj/h1qBU=;
        b=KPv/J5xK71ugu15MkysIo1GfsNALPRlWw6OPNjH1QOuPrlDNct4tmKTNkfdJ5BGEgy
         48hwe0Tj9SZpx5NotijBQQSi6L5OyQNJNUOvqTxOLmvgi/BvsqJMCQUp5K0o6JfSKSHt
         ePTJnI3yHubWME9rvEmvOK6uM7TCkcVgzJGxeV15uqFxWaDD9KRlO619T9lca1xMhjjn
         Rc2rNpz1oX0lDesy4aE+HI2rOcoLJ33WR/Bl7YmzlIVGY1CKjr5+Eau5ablhaZQAhEt4
         NY+DiOo7Wfb2PCBBxthzDIf7lDOubEYk83zTZ+eVi/YntX454eD6/ACNyPDGHO172v1t
         F3dg==
X-Gm-Message-State: AE9vXwMAxZHwLjeRyrcjzPXo8EXzOXIXXx+2XYq71o6qajQtZY1JbO8O4YC/s7KZduktisjSRxSskavO5fiPDg==
X-Received: by 10.28.199.131 with SMTP id x125mr7602946wmf.70.1473640448628;
 Sun, 11 Sep 2016 17:34:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.91.244 with HTTP; Sun, 11 Sep 2016 17:33:48 -0700 (PDT)
In-Reply-To: <xmqqd1kzwegi.fsf@gitster.mtv.corp.google.com>
References: <CAN7QDo+S21T=1zjBEM7rq3epzvVx7GhmTZ5+sgV0BPvNYhvvUg@mail.gmail.com>
 <xmqqd1kzwegi.fsf@gitster.mtv.corp.google.com>
From:   David Glasser <glasser@davidglasser.net>
Date:   Sun, 11 Sep 2016 17:33:48 -0700
X-Google-Sender-Auth: 7Qy3dpMR99cO_WE4q362N2GAyyw
Message-ID: <CAN7QDoJOzVvCzM80v=jP7RTB0od4exFLMZGkvPx9Uz6Lkm16Tg@mail.gmail.com>
Subject: Re: [PATCH] doc: mention `git -c` in git-config(1)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 11:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
> David Glasser <glasser@davidglasser.net> writes:
>
> That might be something we want to fix up further in later patches;
> the change we see in this patch is good regardless.


Perhaps I am looking at the wrong branch, but I'm not sure that this
got merged? Is there something I should do to move this along?

--dave

-- 
glasser@davidglasser.net | langtonlabs.org | flickr.com/photos/glasser/
