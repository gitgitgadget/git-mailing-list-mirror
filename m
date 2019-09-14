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
	by dcvr.yhbt.net (Postfix) with ESMTP id 417C21F463
	for <e@80x24.org>; Sat, 14 Sep 2019 16:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfINQHQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 12:07:16 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:45398 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfINQHP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Sep 2019 12:07:15 -0400
Received: by mail-io1-f52.google.com with SMTP id f12so69296764iog.12
        for <git@vger.kernel.org>; Sat, 14 Sep 2019 09:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=RcqmBBQsseRGNuKjXM2Fc4HHZr6rv4AIM5n4DUUbgfY=;
        b=f56oORNrDc1SNo9RmBOpx/Gcf3YYNIr0JiM42Kusbrk5V1s9AmOpganRXeNavleYoX
         O/KAG224NU0U8HwkbLfXWjEHCNwHK9ZgLUpUFnGiJ7B44LJIc5AtR0Madsdzl93gn6oe
         3rt/rsGcP3xe/NvMbtj0zq9Ds59YBWlvRe0wD6hZOxb8Dn/gnwOE6PRCjcWj7O1tnbum
         QVjAfzvwMlfEvyMTppOdZd2PqWLpPxol+lsUC/flPSLgsv+VzKvzid2aOoXCmb8zjtph
         ZOQwtG8pjdSHVkhjlqr9kprqWJ3IvNb7+iRp5DmKrLcz4kYzRWA7pbMvRaAMVwewRRq/
         EVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=RcqmBBQsseRGNuKjXM2Fc4HHZr6rv4AIM5n4DUUbgfY=;
        b=tTXS2tD1DkaubuC6UNQUdlJ5MwvLSaVSp+BptrJcn+Cj0CDpEFKuZHj6LVMcQSzdCy
         Ks9+9o6pJFF17OIekdIoiHxfLa2XBokWyKjJOtwY+mrb5XQ2wY6Ol794bINsHsIajNie
         0il9/JPCvMqdKgZF+KPDmXNXCXBeqM8FivTNRzkn7k0wIZZoraWOuCGmQ8IbJMNDH20v
         KGJRqWcpWoall0c6XG+qsVaQHQKUpNjt/7vMyJcEgyrms3obxRlEk/xuqkdIYx6jAyGf
         /HvY7Y894RS/GnImhJLEYFVAihGOdjBSzam+z2+8ySUw21uTWlgdvNk8/GUk2UM5dAto
         C1aA==
X-Gm-Message-State: APjAAAVXbT9AOsvPDb2Dcu2SVu2pxJ6bZht5/9pfKj76hZK8hU6xaZSq
        +OQ/yAcNbFLy9v7QmPgFAfH08+pZUFdi4nuVOVZOtQ==
X-Google-Smtp-Source: APXvYqyWiCBQwuREbj+SVpNf5rtHLI7b9rg6Z1bCPMcMJ4IYZvCeXzdY+FMFx1L0ur5sAm3A84+e+reaxoldxbIpftk=
X-Received: by 2002:a6b:3bc5:: with SMTP id i188mr7244761ioa.113.1568477233673;
 Sat, 14 Sep 2019 09:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAL-6oQorDOzAr4sDoddoAQv3hzAgUMx7K+V=bMcvScv8G=7oqg@mail.gmail.com>
 <20190913143229.5yop5oaascgavynl@yadavpratyush.com> <CAKPyHN0=AHzr1V35PDzsq02aeGK1e54CxTeunED_u6GRUygkuA@mail.gmail.com>
In-Reply-To: <CAKPyHN0=AHzr1V35PDzsq02aeGK1e54CxTeunED_u6GRUygkuA@mail.gmail.com>
From:   David <bouncingcats@gmail.com>
Date:   Sun, 15 Sep 2019 02:07:02 +1000
Message-ID: <CAMPXz=qWmHGpDrGVpg1gwEBQsg5pujY-Ghg8icyaPoiMNCXssg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Git_Gui_=2D_enhancement_suggestion_=2D_Can_a_double_?=
        =?UTF-8?Q?click_on_the_file_name_in_the_=E2=80=9Cunstaged=E2=80=9D_area_move_the_i?=
        =?UTF-8?Q?tem_to_=E2=80=9Cstaged_changes=E2=80=9D?=
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 14 Sep 2019 at 06:51, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> On Fri, Sep 13, 2019 at 4:32 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > On 13/09/19 12:24PM, Allan Ford wrote:
>
> I miss a general problem description: Whats wrong with the
> single-click on the icon to begin with?

No problem here, but see my other message for further thoughts.

> I consider adding a second way as not not acceptable. I also consider
> double-click on a file in a GUI an "open" action.

Yes!

In fact, I've often fantasized how useful it would be that if I double
clicked on that file name in the unstaged pane or the staged pane,
then that would open the file for editing in my preferred/configured editor.

Now for me *that* would be a very frequently used improvement!

I wonder what other readers think about this idea?
