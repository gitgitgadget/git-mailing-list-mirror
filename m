Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30B1B1F453
	for <e@80x24.org>; Mon,  4 Feb 2019 09:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfBDJQ7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 04:16:59 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40101 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfBDJQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 04:16:59 -0500
Received: by mail-ed1-f68.google.com with SMTP id g22so10588884edr.7
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 01:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=uQ77Ldi46WI1pyDAON4lMGXtNhICOOKD8xQriggZJqk=;
        b=Guhd1gP3Rw+tmfuUnzmLLZT305BR8WQBxZGIjwnccQI2pvHFwRSJGUMkZulDKNr0I5
         NQQEs90JAjFnr9nFf1LGJDu27U4rg0EhIvW67Y0lJbxdeFrucD1s0/oAikkDg24Q4avY
         Ro2wSgMRcSLQl9qxK9olktr8X5CbtEJv9iO4/jcR2yuL9N+KKGf2uBjR8cYhvAKDCj2x
         lsrb1moGW0G5Mer8WHt5/VQglmd+7SdXjLpC4c5mjTWsi2Nw+2/1cHstfFtT77IBOLwS
         F5HfjQorr5yzc4oWlkEzXKI6vF0ju8Qo9Cdzvtw3eJ1eIXe1GsMZplvVMFEvl/1bLn6Z
         XWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uQ77Ldi46WI1pyDAON4lMGXtNhICOOKD8xQriggZJqk=;
        b=Kym/hhVC1kiOGbDJiG067TONDqNFlP/qJBuDQWOub6xfdX3cFHMGMhBvJuSgTDThS7
         PTzF3xNA5tI65koyrWmQD1yjTa5FjUXvJPAyxjJLSZ+ZW5Lwij8WxJJaNoeahOI/sw+X
         3XIqRkgmpQcrlxba5/RVu09v6f73lZyZhjrhO7c8J4GdvoSF/vF8jENyRZY1GzSJjFAY
         1Hpl2B5fuBwQK/Udh7VplpI7fQilUxqcmSayA5oHfk9WBj1lVo8CSbQhr1g5SarO57qr
         atktVSqrDheNwq3Zu9DNJzrsR098U7LvRLSx+zfikKRDwH6Iscu5SAAtMbCWSU8WvpmE
         n3bw==
X-Gm-Message-State: AJcUukfi70p8dC5wY4rJJ2QyEx04mwSsjkK4zjlPqjAz+QtK5t6l17SY
        AaXyjwSG1r0nWuJOWnz4Q0grljp4S18S1qL+y0CLez56fpM=
X-Google-Smtp-Source: ALg8bN5UKLrgWJq9rbiTNUlIUiBPym7soKAq9lb6N3GPNYecEmaVgqBDMsk6uBzaaMvO1N6iz6nEFYxx+LIHG1aCOd0=
X-Received: by 2002:a50:b0e5:: with SMTP id j92mr47391897edd.188.1549271816989;
 Mon, 04 Feb 2019 01:16:56 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 4 Feb 2019 10:16:41 +0100
Message-ID: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
Subject: GSoC 2019: Git's application submitted
To:     git <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Matthieu Moy <Matthieu.Moy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

There are now ideas, micro-projects and organization application pages
for GSoC 2019 on https://git.github.io/

It would be nice to have a few more project ideas.
https://git.github.io/SoC-2019-Ideas/ currently lists only 2 possible
projects:

- Unify ref-filter formats with other --pretty formats (which is new)
- git log --oneline improvements

as I didn't feel that the others were still relevant, though I might be wrong.

As Olga and Thomas told me at the Git Merge that they could be ok to
co-mentor with me, they are listed as possible mentors for both of
these projects.

Anyway feel free to comment and suggest improvements on those pages,
especially the micro-projects and ideas one. Pull requests on
https://github.com/git/git.github.io/ are very much appreciated.

The application has been submitted on
https://summerofcode.withgoogle.com, but it will not be complete until
someone else volunteers as an org admin. I volunteered, but they
require "at least 2 and at most 5 Organization Administrators".

So another org admin is needed before Wednesday February 6th, as this
is the deadline. Invitations have been sent to Peff, Thomas, Olga and
Matthieu, but anyone can do it and it requires a very low amount of
work.

Thanks,
Christian.
