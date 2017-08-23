Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0487B20899
	for <e@80x24.org>; Wed, 23 Aug 2017 16:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932109AbdHWQkd (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 12:40:33 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:35652 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754150AbdHWQkc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 12:40:32 -0400
Received: by mail-io0-f171.google.com with SMTP id c18so2363682ioj.2
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KSYwS2ci4TXjccAqvD+bSeyxoNGN9fP82+J30unb9CE=;
        b=ElTaxJjR+8/6n6DTdupEKfc16wXDwmvKD2txwTvUF2hWLNbLawXNnUWBLDQFT4ZuVf
         3ipQYTvGKXwAB5d0Yfj1CGUmAUzZA6+gIT1ZgEZo/7UAHS0PMxWEICEsca+eRY7i461e
         J+VQRCHWO+R8+MyWPDd/17MEL3VRnQrCbCtTuxW8BzfQg51iUX8D/ohSnpEJCZGxfLzW
         r+hIiuxXYA9dzI/Wx+NwhKLBMbbP5iMXWV3Rh18GUIg8dmjdkkv+FLG/997E2iAuebiO
         qsjCxqK+b5r+DLoGHj0+CPFX2eQpBdhafYq+8zuqmlKeZXakei5LAkmAru/NRufCE6AA
         FtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KSYwS2ci4TXjccAqvD+bSeyxoNGN9fP82+J30unb9CE=;
        b=FyTJh16fOnzFS2iPIX6O0ixfsrLycCfGrq2hqf0eL6B37odLzo/FJeqoiAOjlilkiG
         68kwXXh8J7lhG7YC8b7vc+AL31z3U7444A+Y4ncLCm+MqBaKoRcDUNHVFxtzWHxNZ4dK
         1sxQd7MMUTZhTH5FSSdzKWlEQkG2kLBcXqNEDbGGuvan/rU7kJ1t1wxsYT5PcIDNOrCP
         HT+5d5TH7XjamnvnioylOnz6v/45dmwNMrf0rbdDBjPIAUBX3KPE4BHkVMQZrW6SH+FE
         hc/45R6vHdYbDgdjYICPX3EhMiqYxFr6NFdK+I+2sakGJBhViCKoBykr2263JpCEB3V8
         nSaA==
X-Gm-Message-State: AHYfb5jLFlcuHRoxn45BOD4ySksUpKkd0zJ+kazwGJscIfzXNZZfYkcK
        +r/jZzTWJsuA19uGwaBxTJdS6tjRQQ==
X-Received: by 10.107.148.129 with SMTP id w123mr3014002iod.97.1503506431961;
 Wed, 23 Aug 2017 09:40:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.127.85 with HTTP; Wed, 23 Aug 2017 09:40:31 -0700 (PDT)
In-Reply-To: <8e25c42f-80f2-e0d4-38e4-b4fe9c8074e0@morey-chaisemartin.com>
References: <8e25c42f-80f2-e0d4-38e4-b4fe9c8074e0@morey-chaisemartin.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 23 Aug 2017 18:40:31 +0200
Message-ID: <CAP8UFD035niTUQTe73RSTE+3u6WX11UpxoqCSrfVP1Qs-fF0gg@mail.gmail.com>
Subject: Re: sequencer status
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Aug 23, 2017 at 10:10 AM, Nicolas Morey-Chaisemartin
<nicolas@morey-chaisemartin.com> wrote:
> Hi,
>
> I've created a small tool to display the current sequencer status.
> It mimics what Magit does to display what was done and what is left to do.
>
> As someone who often rebase large series of patches (also works with am, revert, cherry-pick), I really needed the feature and use this daily.

Yeah, many people use the interactive rebase a lot so I think it could
be very interesting.

> It's available here:
> https://github.com/nmorey/git-sequencer-status
> SUSE and Fedora packages are available here:
> https://build.opensuse.org/package/show/home:NMoreyChaisemartin:git-tools/git-sequencer-status
>
> It's not necessary very robust yet. Most of the time I use simple rebase so there are a lot of untested corner cases.
>
> Here is an example output:
> $ sequencer-status
> # Interactive rebase: master onto rebase_conflict
> exec    true
> pick    e54d993 Fourth commit
> exec    true
> *pick   b064629 Third commit
> exec    true
> pick    174c933 Second commit
> onto    773cb23 Alternate second

It is displaying the steps that have already been performed, right?
I wonder if people might want more about the current step (but maybe
that belongs to `git status`) or perhaps the not yet performed states
(and maybe even a way to edit the todo list?)

> Two questions:
> - Could this be a candidate for contrib/ ?

It seems to me that these days we don't often add new tools to contrib/.

> - Would it be interesting to add the relevant code to sequencer.c so that all sequencer based commands could have a --status option ?

Yeah, it's probably better if it's integrated in git, either as a
--status option in some commands, or perhaps as an option of `git
status`.

Thanks,
Christian.
