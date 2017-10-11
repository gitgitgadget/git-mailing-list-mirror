Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B0441FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 18:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757473AbdJKSOI (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 14:14:08 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:51487 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752498AbdJKSOH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 14:14:07 -0400
Received: by mail-it0-f46.google.com with SMTP id o135so3921536itb.0
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 11:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6bZRymssBplwUiuKXXvfb4EvH+ysGhzLAgMruo6eAf4=;
        b=dvey9Y/v9dE12AUPS6hL7LSB/k5DypfBqyvtt5uo0FnBp4E4c3eCjtoZyCojs7E7j8
         w1cueXTl2qj5JxQTk0PMrnohw26d1pMzJQBzKBHsw4acGIh7kaPPeeZ++0HOeptNHoKW
         YX4UVSOIEU1UzEO9JhsT3jEwXFie+eL30j/or0+ej8hJ3+krLNen5EmYFnyB+F0G94+T
         7AMZLtMkLHKmrLbvtluyOutrYo+G9nPeufYJKJbxEw70YyHtxIhzv5VZsqIZ7/Wzr0yk
         bHavbvx8QlI3uMovOuIxW4eaojzIxJiUQ2uyJrQjibRVJPJmC5ogJ7+mgnL8IOX6slaX
         FlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6bZRymssBplwUiuKXXvfb4EvH+ysGhzLAgMruo6eAf4=;
        b=e1ZRtRaLjsB2WpWwzK46rlhA7cQUGA6wK8OrWhjEETkgIWagF9BYwI9NTSn0M5+oIp
         KFw4Bcoh/J27Wh3YzP/NFba7ad+vn1NjxKgAB+H4uzC3CURw6tv6fegvMVJXUfITvIc3
         /qk/OVS5vWkbIyzCsbZlS3SD9Z0ZZKTkYQldVPYOOEYnAWD+RchlLRsxnjMm+HT6Tb5a
         jKkKOG3rC45BKw3rZPFbnUU78I8SU57BJG3UkYPxSaYxZfBBlKcZbyz7NU4sV18hE0HR
         vaxQDB0Qzmo+gk/WEY3xRDdT09CyRrppoHMTBdwCLFzIet7od9dCcHEzX4BzacsSoZmD
         E7tw==
X-Gm-Message-State: AMCzsaVvR68C0VqXZQQgib8GHuv+4LFckiWo/5l7koMM2TY5hfM8UHaF
        qUYbTVvWBiVmEFs4hnHwDTp4EkcAGmxfRVHGu5/UEw==
X-Google-Smtp-Source: AOwi7QAEl4ShI0ecNIv9w2TFAp65WP7nHQjHj/QDv1F7t31LSz/4J9/8L/R2ZKpOOd+y5D4zS0Jv1JaBfkUzMSUZts0=
X-Received: by 10.36.5.74 with SMTP id 71mr613155itl.72.1507745646961; Wed, 11
 Oct 2017 11:14:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.145.215 with HTTP; Wed, 11 Oct 2017 11:13:46 -0700 (PDT)
In-Reply-To: <20171011180015.mqn5xkj5z4yjdrhm@sigill.intra.peff.net>
References: <CAEBs8jLnU44n2fhE8tGommqfEpFPdd0FLUtmeZXZ+qhB1RV6XQ@mail.gmail.com>
 <20171011174952.almye3qa2tmyrmol@LykOS.localdomain> <CAEBs8jKAsb3B-6WJ=ptL2AsGvDRFVPYLCsztpdTN6KCBLOo1XA@mail.gmail.com>
 <20171011180015.mqn5xkj5z4yjdrhm@sigill.intra.peff.net>
From:   Ayush Goel <ayushgoel111@gmail.com>
Date:   Wed, 11 Oct 2017 23:43:46 +0530
Message-ID: <CAEBs8jLyvyE+t=9mDHkD0nUY2SBYymg44BeQbUF0Li4CSZhMWg@mail.gmail.com>
Subject: Re: Unable to use --patch with git add
To:     Jeff King <peff@peff.net>
Cc:     Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Jeff,

Thank you for your mail. It works :)

For future reference, is there a page for known issues of git?

On Wed, Oct 11, 2017 at 11:30 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Oct 11, 2017 at 11:25:52PM +0530, Ayush Goel wrote:
>
>> On Wed, Oct 11, 2017 at 11:19 PM, Santiago Torres <santiago@nyu.edu> wrote:
>> > It'd be helpful to know:
>> >
>> > - What did you do?
>>
>> I have recently updated to git version 2.14.2. The problem started
>> happening after that.
>> Made changes to a file. Tried `git add -p`.
>
> This is a known issue in v2.14.2 with having "color.ui" set to "always"
> in your config.
>
> There's a fix in v2.15.0-rc1. You can either upgrade to that, or as a
> workaround set "color.ui" to "auto" (or remove it completely from your
> config, as "auto" is the default).
>
> -Peff



-- 
Regards,
Ayush Goel
