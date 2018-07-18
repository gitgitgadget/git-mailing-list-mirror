Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06E991F597
	for <e@80x24.org>; Wed, 18 Jul 2018 15:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbeGRPkk (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 11:40:40 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54148 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbeGRPkj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 11:40:39 -0400
Received: by mail-it0-f66.google.com with SMTP id 72-v6so4575351itw.3
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 08:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aQkYwgSm8M7sC0/Sv8TJE1fBvMfVXR8speXwm6dWKck=;
        b=or5j5RRP+eXjES+4rRcrpVH1XnkdFzLJY0H8qxcvBpFujfVxd05LN7yOr8tuvOBUmm
         lQIghDLVJRB2bvXLrqnF/NcX9MwQTZlegvvo1z7nbM52g8mw7JXrpyAuYVDcdpq+KRj+
         FEy50m6S/8576NlyhpmYcbgigFMuDYgrVCBJxhMYydBvXpUKQ4ATNfTugDT1YXwOkthc
         LxZ15lOFCDsrdxp0ElfLJ1uYf9QsSi9ZueAtjLqf7+3959qlmjBI59kwIt2JuCu/N8z+
         f5h1ObT7dBGQD+p/UV1wBdRVmZsWp+dr1JLPCpXwI4+s0P2BQMIZuoJuibTD7OP6+uMs
         Yt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQkYwgSm8M7sC0/Sv8TJE1fBvMfVXR8speXwm6dWKck=;
        b=dYwulpfIAa2w+FNP2witpYvXHatXfZtqfYTQCbx2DXVVa/AvJdz+ko14Q4P10KRSn9
         jPMUmbx7WyO5Kagz9lE/Na8knWOExcnjopqpfK95LjlD0aCL+NxKrvmZksrFpS16ku6B
         YbCbAWP6YXRW+j53GnSLbQ/CQEQdxjrFZSuFzg5Cz8uJcb2A0C/3eSLZH3k6HKbKpdwp
         GYj+LCkGw6GstqNzccBD9wNSdStKjUziifWHMMeyPxiUeA1ax093xvnWAhAfVD9qNQHv
         bHctUbghboqncYJIvDloDAkg56FxnZ1Ivx70GkERwtcbAKW73Gm4+vZuwkQUoLw6XU79
         O7bg==
X-Gm-Message-State: AOUpUlENP/Fdc3O+7GOhDGfTQFL4ppUzhJA91VtfkKOJTPeMr8RyY3i8
        4FO83KNSv9R5S0BRhC6gnxS1LYwmoUKw0YCtYO0=
X-Google-Smtp-Source: AAOMgpeek/FiYy1KFA2ieA+iT+OcqM+2yGvsIS2XSTe7BZP6KhHns/iljwHjRqrQMIis7oJqOa0xDrnC3PqWdTbNaeo=
X-Received: by 2002:a02:59c9:: with SMTP id v70-v6mr5478246jad.94.1531926139992;
 Wed, 18 Jul 2018 08:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.10.git.gitgitgadget@gmail.com> <6b7a50dc-6b71-0e31-030a-42dd1b26bde4@ramsayjones.plus.com>
 <CAGZ79kYem+uMrhv+CUSDNXtE3C8Pv1cx=aZOyBLG=uo-aQWXeA@mail.gmail.com>
 <CAPig+cQj5_bEiLyAAS4xnsUQEPzqT_2yerdAQxd8FidVpJ5CxA@mail.gmail.com>
 <65d51c26-e248-f16d-bac2-e6ba0a3be8e5@gmail.com> <nycvar.QRO.7.76.6.1807181427120.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1807181427120.71@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 18 Jul 2018 17:01:52 +0200
Message-ID: <CACsJy8AbT3=wzKecGqvj8ibHmquU=NfP872f1cAM-VFOLSLSGQ@mail.gmail.com>
Subject: Re: [PATCH 00/16] Consolidate reachability logic
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        gitgitgadget@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 2:30 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi,
>
> On Mon, 16 Jul 2018, Derrick Stolee wrote:
>
> > On 7/16/2018 2:44 PM, Eric Sunshine wrote:
> > > On Mon, Jul 16, 2018 at 1:27 PM Stefan Beller <sbeller@google.com> wrote:
> > > > Another pain point of the Gadget is that CC's in the cover letter
> > > > do not work as I would imagine. The line
> > > >
> > > > CC: sbeller@google.com
> > > >
> > > > did not put that email into the cc field.
> > > gitgitgadget recognizes case-sensitive "Cc:" only[1].
> > >
> > > [1]:
> > > https://github.com/gitgitgadget/gitgitgadget/blob/c4805370f59532aa438283431b8ea7d4484c530f/lib/patch-series.ts#L188
> >
> > Thanks for everyone's patience while we improve gitgitgadget (and - in this
> > case - I learn how to use it).
>
> And let's please stop pretending that this GitGitGadget project is
> somebody else's problem.
>
> It is our best shot at addressing the *constant* pain point that is the code
> contribution process of Git.
>
> In other words: if you see something that you don't like about
> GitGitGadget, get your butts off the ground and contribute a fix.

Thank you for the frank words. I will choose to not review any mails
coming from GitGitGadget.
-- 
Duy
