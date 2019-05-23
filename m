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
	by dcvr.yhbt.net (Postfix) with ESMTP id C4F3F1F462
	for <e@80x24.org>; Thu, 23 May 2019 20:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387973AbfEWUav (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 16:30:51 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40613 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387544AbfEWUav (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 16:30:51 -0400
Received: by mail-it1-f196.google.com with SMTP id h11so10477928itf.5
        for <git@vger.kernel.org>; Thu, 23 May 2019 13:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vIg9zmyh3Gkxd7uQyMWvy4iub2o9fgT1CHgKma7xenQ=;
        b=oS6fes24sQj3GFbJ3BTIrhhmZ3AMeOMrYij8g3LJ5Wh5AwIVfbU5XZr6AeTNv/KXK6
         Sf/EtpCFpcEJSGOHUxTFMcKK8EfTArKu/yQQD+Z1BhoIlN2BNM84GrnWVh4iIiLAbqa0
         HEAbCgKtH717nuJVk4JZy6Pj5Wm01t6kISUYlU9tR45fwr208fiBpScWcOBnT9SxTRKd
         sSJpdMGGYzopkh6FZA4nKf3PqrmNVzSeaSLP7UsX4LfjvW+CFVp68WnTJ0efvpTv/tJE
         a7kE2R1nLDoHlY51J4zWul/QdwUUKwbAN8ESK7STpxveEAUH+3vsrih3bszSGDjkTWTr
         o4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vIg9zmyh3Gkxd7uQyMWvy4iub2o9fgT1CHgKma7xenQ=;
        b=J5irtbapwwmauknxmEU721JLQwl+qEabAYIcLySFZ451eAH9rpgp8SLcREKgPhNpTD
         b1Y8uLUpsnYfiEWNz9RIRvsVDXAsHqfFdzH6lpTdVkCPlWAPfUYCj2JDeIjyytAWFmq/
         f/yVESNSyjMc70CBpuHW60ZpyUY2xMp+Rj48r1/oUAbkpBbIYEVJJPZWuxEAMiNHKwDf
         mMec7jqGCXEi7eHfyW80lR6Lmxzo5idKNNXrgJi+/VGpLy+4NXxjH1FWOmnir957Pf7f
         zfcW/ZY7g7b50OaQn8hCHsLJQgBPiybDJJ4e7yReVO4XgWl4LkQCUo4wabgx6mnbeFXq
         ya3w==
X-Gm-Message-State: APjAAAW2M6Jm0xSHVhRhYzWp66454Dcd3Z8o97xZEY1XF+YONETEx13J
        m8SfguTtB1ubFPhjLSnPBKI4rOSTo9WADanUWRpTyA==
X-Google-Smtp-Source: APXvYqxhfM6C57G64yoYVmbKqApeofOm6yvkwhxcUEVpS5EigUmksYkOcG47ERC2lzjzS4bCBJyx5tWHS9RFLu4Hnk8=
X-Received: by 2002:a24:e046:: with SMTP id c67mr13964050ith.16.1558643450542;
 Thu, 23 May 2019 13:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq36la24t1.fsf@gitster-ct.c.googlers.com> <20190523150416.GL3654@pobox.com>
 <20190523191429.GO3654@pobox.com>
In-Reply-To: <20190523191429.GO3654@pobox.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 24 May 2019 03:30:24 +0700
Message-ID: <CACsJy8CY8CVVv1+s9sLtVEAhrC5Ki8NSY2qje8+se7VVudFo_g@mail.gmail.com>
Subject: Re: New diff test failures on s390x architecture (was: [ANNOUNCE] Git v2.22.0-rc1)
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 24, 2019 at 2:14 AM Todd Zullinger <tmz@pobox.com> wrote:
>
> I wrote:
> > While running the 2.22.0-rc1 tests on Fedora, I hit a few
> > new test failures since 2.21.0 -- but only on the s390x
> > architecture.
> >
> > I haven't had time to dig into these the past few days, so I
> > thought I would send what I do have in case the problem is
> > obvious to someone else.  I think all of the failing tests
> > are due to `git diff` commands.
> [...]
> > I don't have direct access to these s390x builders.  I may
> > be able to arrange shell access (or even reproduce this with
> > qemu's s390x emulation).
>
> I poked around a little with a qemu s390x instance and see
> the same failures.
>
> One simple failure in t4015 is with:
>
>     git diff -w >out &&
>     test_must_be_empty out
>
> Using git-2.21.0 this succeeds, while git-2.22.0-rc1 fails
> and produces:
>
>     diff --git a/x b/x
>     index d99af23..22d9f73 100644
>     --- a/x
>     +++ b/x
>     @@ -1,6 +1,6 @@
>     -whitespace at beginning
>     -whitespace change
>     -whitespace in the middle
>     -whitespace at end
>     +   whitespace at beginning
>     +whitespace          change
>     +white space in the middle
>     +whitespace at end
>      unchanged line
>     -CR at end
>     +CR at end
>
> I am guessing it's no coincidence that this only fails on
> s390x and it is the only big endian architecture in the
> fedora build system.

I see a problem with -w and wrong type casting. sizeof(int) and
sizeof(long) on s390x are not the same, are they?
-- 
Duy
