Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 086D81F453
	for <e@80x24.org>; Sat,  9 Feb 2019 09:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfBIJ6F (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 04:58:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35714 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfBIJ6E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 04:58:04 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so7586207wmt.0
        for <git@vger.kernel.org>; Sat, 09 Feb 2019 01:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kg6esbHitW0ykS6e9BJIzdVaOAJjJJcpYMYTKR4n5gE=;
        b=VwInS+AOCLoIwormQAz5ZmnOE0HF+LOLRDfPrZRF875VWZZgvlO7WsaNFm1H3gMp+1
         aQ4hgQP2zrF1qHJRPCNI7NmorhpPlt1animbcHGkvpKxrV+G4+6vMCHFygqdav+1lZLE
         P0ddQWZUKjUsLbkcXnGMH+bN5I0TtztEpoHpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kg6esbHitW0ykS6e9BJIzdVaOAJjJJcpYMYTKR4n5gE=;
        b=nbz11QRLTJOu2M1acLlPgrXxFAuKVO4xSS9BrDAYUvEN8DcqKKKHYBSYFDcNrOSwwt
         RR2tUB9kgt4jFohH1YZ0BeGwbmyzrOyjlEfbnSG/bx2bvN4rEitKkifnMvsEXrKxcOlE
         92K2PaHVnmpQC7wzFUu7IR/E7dHnnyos1jK3prTAQxb41FucWtbM6uXghX5lLPttEXL8
         aUvLEpMHG1RcVs0KLe3igaZoqA5yNN7Ray8EolWAdL6IvnQn2LY7VvNEr+U2YxHre84F
         ukSoxc7a6MuaaPTc7Tz3DZpYSc39kqkXjMjOIxzjZkJn5K8nfbcmZFadaxOCUSirdkdO
         3lfw==
X-Gm-Message-State: AHQUAuaOMhIr0EaiJboIioUFs/g2F/RBgbSiUihPb3GtZo//lCJdRNss
        Imd98GIFpplsEJFjRWXrblz+cbBLPRuIFxWnWXUzOw==
X-Google-Smtp-Source: AHgI3IY1ni+GYeQ1LlkbNgqC0ET4eojzm9JNoSHmro2kq0KmjCMtkjtAC75HGbt8ES5/CqFvIQPL2vR68SVXm1idZ4Q=
X-Received: by 2002:a05:600c:211a:: with SMTP id u26mr2234611wml.142.1549706282385;
 Sat, 09 Feb 2019 01:58:02 -0800 (PST)
MIME-Version: 1.0
References: <CAE5ih79DuU5Wrk4p+wpQX3j6bgyA2_ZgXYJX-tGvZpYhWazWqA@mail.gmail.com>
 <20190208100221.GA22283@ash> <CAE5ih7_b_LXfPp5eMcrr4iSuyzaiKxvQqN73Osw+ck9CPrfdqw@mail.gmail.com>
 <CACsJy8CeRFyhkdohwU_KtXtgmkOzNsQPb4oKFcn+R210MpS1KA@mail.gmail.com>
In-Reply-To: <CACsJy8CeRFyhkdohwU_KtXtgmkOzNsQPb4oKFcn+R210MpS1KA@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Sat, 9 Feb 2019 09:57:51 +0000
Message-ID: <CAE5ih79JYrcV9cxMBU88Hq=HHQOOyzpkq+kT2zAgDzs=ao+PMg@mail.gmail.com>
Subject: Re: could not freshen shared index ..../sharedindex.0000000000000000000000000000000000000000'
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Users <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 9 Feb 2019 at 05:01, Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Fri, Feb 8, 2019 at 11:39 PM Luke Diamand <luke@diamand.org> wrote:
> >
> > On Fri, 8 Feb 2019 at 10:02, Duy Nguyen <pclouds@gmail.com> wrote:
> > >
> > > On Wed, Feb 06, 2019 at 10:25:25AM +0000, Luke Diamand wrote:
> > > > I've recently started seeing a lot of this message when doing a rebase:
> > > >
> > > >    warning: could not freshen shared index
> > > > '/home/ldiamand/git/dev_full/.git/worktrees/gcc8-take-2/sharedindex.0000000000000000000000000000000000000000'
> > >
> > > There are only two places in the code that could print this. The one
> > > in read_index_from() can't happen unless is_null_oid() is broken (very
> > > very unlikely).
> > >
> > > The other one is in write_locked_index() which could happen in theory
> > > but I don't understand how it got there. If you could build git, could
> > > you try this patch and see if it helps?
> >
> > They've gone away!
>
> Great! Since you seem able to reproduce this (and can build git!)
> could you try bisect to pin point the commit that causes this problem?
> That would help a lot. I think you could start maybe from v2.19.0

The first bad commit was d658196f3c4b2478ebdff638e2c3e4fb2f9cbba2.

$ git show d658196f3c4b2478ebdff638e2c3e4fb2f9cbba2
commit d658196f3c4b2478ebdff638e2c3e4fb2f9cbba2 (refs/bisect/bad)
Merge: 6b0f1d9c47 7db118303a
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed May 23 14:38:22 2018 +0900

    Merge branch 'en/unpack-trees-split-index-fix'

    The split-index feature had a long-standing and dormant bug in
    certain use of the in-core merge machinery, which has been fixed.

    * en/unpack-trees-split-index-fix:
      unpack_trees: fix breakage when o->src_index != o->dst_index

The test I'm doing is just:

1. git checkout some_tag
2. git rebase -i HEAD~5
3. Swap the top and bottom commit
4. repeat

I just chose "5" as my first wild guess, other numbers are also available.

With "5" I get 3 lots of:
   warning: could not freshen shared index
'.git/sharedindex.0000000000000000000000000000000000000000'

As far as I can tell the actual rebasing is fine.
