Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BDE4202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 16:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754708AbdKAQg0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 12:36:26 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:45193 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754089AbdKAQgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 12:36:25 -0400
Received: by mail-wm0-f47.google.com with SMTP id y80so5886624wmd.0
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 09:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zX7wGSk/JvZdXbIU2l36hOYXnVuE9u0buJANXUEJkZk=;
        b=LSWBOHnluQW9DGG86dxwW5jDJYf3Elg6QzSUUmecY+KWZdh9kzAd2Zr7SdDlpPAQLe
         dSrqVJRWlfnY/yIy7pGl54HXMZwKUPb9+Td+6deADoye2mqM6+rbdarnkhxClt/Yx0dj
         isONJzZqqV/bnZ/NsGtHxlnnJmmN+B0MSNZ2cmAzklMNnHZKSbixBG6Bdb26TM4hklz9
         r+WIbkzDbExV8kHiIBI1qobtM4N+vlUeuuhfbeK1q/XBeQ+TIfx/IssEmxm2EVslGhkm
         fi9nkSV4txRNiAVxqpmPMrsCt//+MjxdAh+pjxoLSiZ7p972OCFm4l2VCCVx7L+Rrycm
         7n1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zX7wGSk/JvZdXbIU2l36hOYXnVuE9u0buJANXUEJkZk=;
        b=V8ZdqJpxH4DqfSDYOnEJ+lk89ARh70OjcJ8kWPGQ8mC+d1aIUH552bm3oDikdUv75s
         reTpE+//CHhtsjkLeBIe6tov4fCy9oer40ZTh5zJcVsQATqP3XZJ9gCMTUwzk7ExvsvU
         i0PeDJywpNTL0apezHxfH79wmNQNd8Ew6/QYo3DkEHjjnwl1ZVHPKAZbmdnR7t0PeFTB
         IbRKP0fiYFnsOxrNFMe8CcJETbl0+scJbsf2y/l6MICV/pZlL3JvXTHiM5J245mMVDc5
         ek9j6HCR6ErR++30G9fRKKmycPj8QYfrQTTXtf5yOJvdrOqHasVIjE/UUQHNxPJBGSov
         ymoQ==
X-Gm-Message-State: AMCzsaVArWYGTH1KTOStCgwRpGOBTaYSDi8OpVID3rPWzBeeQStXMtgU
        ziruHv3K27FAuEePnowaO64+y90W4646cJDxZ1T4lLfj
X-Google-Smtp-Source: ABhQp+RRFPtxjlRwWiOCkr/bGPD2O0CzlETibtvGGfEUKQ26paPYEgOk4wx2edPcEckDKZUINLChG0DTkps0fLuVggM=
X-Received: by 10.80.182.118 with SMTP id c51mr1062632ede.204.1509554184440;
 Wed, 01 Nov 2017 09:36:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.132.232 with HTTP; Wed, 1 Nov 2017 09:36:24 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
Date:   Wed, 1 Nov 2017 16:36:24 +0000
Message-ID: <CALgYhfO=6WfdzfGYwgw+cp2Tb58Yzx6YYvBtMCPNcJto5rMUCg@mail.gmail.com>
Subject: Git Open Source Weekend London 11th/12th November
To:     Git Mailing List <git@vger.kernel.org>
Cc:     hkleynhans@bloomberg.net, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Bloomberg is hosting an Open Source Weekend in London on the 11th
& 12th November 2017 to contribute to the Git project.  We have
also confirmed that Peff will be amongst the mentors on hand to
guide attendees through their efforts!

Some of you may notice that we tried to organize this earlier in the
year, but unfortunately had to postpone it.  For this time around we
are further along in planning, and it's definitely happening :)

For those unfamiliar with Bloomberg Open Source weekends: These
events provide a great way for those who love working on code to
give back to the community. Come and help make difference to a
great project!

There will be tasks provided by the mentors, or bring your own if
you already have a great idea.  Also if you can't attend the weekend
and can think of a project which you would like tackled at this
event please let me know.  Obviously the projects should be
completable inside a weekend.

Normally attendees work in small groups on a specific task to
prevent anyone from getting stuck. Per usual, Bloomberg will
provide the venue, mentors, snacks and drinks.  Bring your
enthusiasm (and your laptop!) and come share in the fun!  The
event is also open to everyone, so feel free to pass on the
invite!

The event is free of charge, but please ensure that you are able
to attend the event before registering.  That will greatly help
us with accurate numbers for catering so that we don't create
unwanted waste!

You can register for the event here:

https://go.bloomberg.com/attend/invite/git-sprint-hosted-bloomberg/

Whether you already are a contributor (as probably most people on
this list are) or interested in starting to contribute to git or
have some friends that you'd like to get to contribute to git, it
would be great to see you at the event.

If you have any further questions feel free to get in touch.

- Thomas
