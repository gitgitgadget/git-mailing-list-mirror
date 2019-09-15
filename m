Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88C4A1F463
	for <e@80x24.org>; Sun, 15 Sep 2019 07:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfIOHzm (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Sep 2019 03:55:42 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:35131 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfIOHzm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Sep 2019 03:55:42 -0400
Received: by mail-lf1-f50.google.com with SMTP id w6so25093370lfl.2
        for <git@vger.kernel.org>; Sun, 15 Sep 2019 00:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LxwsF+Bfx13NPF00cGoHvemRfDr0j6VV0yMvJclaIe8=;
        b=HW+VHHk3EgaiRMZWOAjMY3rd2Nl7uUj61wDtdS6GOwNZK8E6FJCGPLRoBjtAOxPTDW
         HYv2zG/4AHt9fxg43V61rgFBkuOy1WwVZZa4PzJsOZL/nh0K5fr3UUTjbyR0JVvAeX86
         /BAbTqNirTG9PGhnUtZwsURn6O5HbBzSLgKwMk/lCcDbjBc966j/Mp9qp42XXyCRC4pu
         qpWxHF2Kz4ZX8O9mMX/hdn8d6wLh/647mO3T3h0iTbVtMPgoqP+FXsaAupigTHYsUaCm
         Y/2TBr6ZSt4FSO1IWZrM16iXC3jtoiFnuQ3s5d+KT8nrtkJ/CureVQujYSA6Nd5+L3Fh
         befw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LxwsF+Bfx13NPF00cGoHvemRfDr0j6VV0yMvJclaIe8=;
        b=T6gdB97lANTF0CkFwaFa9JHp8pumA45hU0W7O3ZP66AARWbhGzHOSJPJoA1YY7ASSW
         YLc7T+jA3YvhlVaikIGjcBjdLyT5MXcSyGMI7HFLll13hNuOij8Rm9y22RKAzGZkkSpU
         ntF4WBElTalhwk9Qeb1KhDfUIs3C6/jCBt1HNqxhC2ZmfnRkksVcBc3/xXy2bIf/Vcgd
         EPlPIYY+RAxBiJ0C2PESh+HLmtCpnBI0GbKZHpnIhj6u3pa4qSJ4TeMK1OqEgklqq/SW
         JJI62MgbntP3Ca1euNE9we1kCOAmDhOBhbJ/mO3eZDxnMzFTIGe7LsUk5Gy1wJYmEl0e
         cBIg==
X-Gm-Message-State: APjAAAW3Cgl9S2+fsWG+nTXQIBoEQFLP1zwbmcgxf3jYQTujXTpDdGYm
        vn9e3pu170EoUUOrjM68Za/nw5f/SUWf4V882NmwJ7s4LdK/jQ==
X-Google-Smtp-Source: APXvYqwV52/+9vFv46P3kLvc5GzQLW8LH0+0pqX5pZk9d5KEcoPioAK9CfS3HC429aeMr5+53Bidq4zJLYh/IAetbg0=
X-Received: by 2002:a19:f801:: with SMTP id a1mr5880847lff.166.1568534140094;
 Sun, 15 Sep 2019 00:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=KMJmYtVaATFkOPcboAdkLvpZFbWAo4QAE0-uC6RL4Lqg@mail.gmail.com>
 <20190914211509.sjy6lh2rlcl32lj5@yadavpratyush.com> <20190914212732.plymb3vnz3dv4rmc@yadavpratyush.com>
In-Reply-To: <20190914212732.plymb3vnz3dv4rmc@yadavpratyush.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Sun, 15 Sep 2019 09:55:28 +0200
Message-ID: <CAGr--=LmhE9m9V4Dq8Zt0aXqdThzrNnWSnxWawVZiLYTKbL2ig@mail.gmail.com>
Subject: Re: git-gui: automatically move focus to staged file before typing
 commit message?
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

On Sat, Sep 14, 2019 at 11:15 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> Why should it only happen when the commit message widget is selected?
> What's wrong with directly switching focus when all the files are
> staged?
>
> What I have in mind is once there are no more files to stage, the focus
> directly goes to the staged files section, and the first staged file
> gets selected. Then if you want you can type in the commit message. And
> conversely, when unstaging things, once all files are unstaged, the
> focus goes directly to the unstaged files section.

Your questions are fair. My reasoning: I imagine it could be a bit
frustrating that the focus automatically goes away from the "Unstaged
Changes" widget, when the user actually isn't done doing changes.

For instance (as a user);
- Do some changes
- Stage the changes (no more unstaged changes in the repo)
- Realize that you forgot something, jump back to the IDE and make
some more changes
- Jump back again to git-gui, hit refresh
In this scenario, I imagine the user would want to have focus kept on
the "Unstaged Changes" widget. Even if it became empty with files
before.

When the user focus the "Commit Message" widget, the user is kinda
stating "I'm done staging stuff for now". And when that happens, it
really doesn't make sense to show a blank diff any more.

I hope that made sense.

Birger
