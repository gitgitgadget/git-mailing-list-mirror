Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C55301F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 10:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405304AbeKVV2C (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 16:28:02 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41737 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732079AbeKVV2B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 16:28:01 -0500
Received: by mail-qk1-f195.google.com with SMTP id 189so6563906qkj.8
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 02:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rFo412V3IS7V4/HOKG+kZNWj9c/ZOO0bpAIRL/U0MRs=;
        b=o1zHeGufUU6wSKF4bxDxE1/agDEuKSGVqNonTOmQsMrt6CIeNCjMRJwuzRRJhKj8MN
         lSRC+Q1mFD5ets39Y+JRf4Vj7H/slnHc6tBolCkPDom253PWS5NvfwlOH9dZsz9Eg4cZ
         eGdI+UcLaotdQsMqYVNlZg3NJraNL5T8GXyX6NBgKWTczO6kE+bGcebUREAKj46A0mh+
         YGEGw1VsKPnuK0kChIyCskt0SPOd+RFSuB5rjZTe8SlgUhB9fxK6aOGlQTuvn5qLX3WN
         XbutQZ4kzqgXRlaNF+uB5Y7UO6LCSB282zOL3BTHwfw/T/ow+odE4Objnucez4eZFlHg
         i0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rFo412V3IS7V4/HOKG+kZNWj9c/ZOO0bpAIRL/U0MRs=;
        b=OBk6h9YEGPtYqhpckqfRRlAEDAEgO+iQW7pypS1U3Lzruu6tHcaMXSHeQZgh7a7rS5
         Fl205Lo5+BoRZXFWGSBiZi6oitymFWQkhj9TtBvLvtWpPKF6H38ORQ5XZM3u0TQzH2G9
         nwX4bXBY6K8EILhH3MIywryFAReW9D3Q+YfnqwnLWJFHWDXlWjldjmMVoraYGAJiwUeC
         fEtzEAeSW2ZuNRDdOwv3a12clQ/5vr309l8t6zzzK1uaKWx4xybD68/0nT+gvC7TUlW5
         PvQwsAq8IB9ZQKzGOktgHNo575I4LYFrGMGagryfOeJDEYnKJRWnEAxhZxpigsb3Gov6
         mNlw==
X-Gm-Message-State: AA+aEWZSzf5tqwDYB45/qvE+MwVDqJiQMi1dCWtrULwdCtihbGe1UhaK
        9gATcrvT1o4rqyxwa9PjTQHP6fq/QFzc+qiAAxM=
X-Google-Smtp-Source: AFSGD/VQsfIfcZXRhA+yxyzpkPJQLkpu/INmzP0QRBT5enl6FVIYvyN2u3ULQiWUGX3uePQ1+R3ydZMoki8DxzQ7rG4=
X-Received: by 2002:ae9:e895:: with SMTP id a143mr8749332qkg.242.1542883749437;
 Thu, 22 Nov 2018 02:49:09 -0800 (PST)
MIME-Version: 1.0
References: <xmqqlg5m7qlb.fsf@gitster-ct.c.googlers.com> <1965413.u7ZHvrJggb@thunderbird>
In-Reply-To: <1965413.u7ZHvrJggb@thunderbird>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 22 Nov 2018 11:48:58 +0100
Message-ID: <CACBZZX5t8GARu0TPxWjhwY8ZtRop+EPQO3KbVHAyNpShm0ghRA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2018, #06; Wed, 21)
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 22, 2018 at 11:31 AM Stephen P. Smith <ischis2@cox.net> wrote:
>
> On Wednesday, November 21, 2018 2:00:16 AM MST Junio C Hamano wrote:
> > [Stalled]
> >
> > * lt/date-human (2018-07-09) 1 commit
> >  - Add 'human' date format
> >
> >  A new date format "--date=human" that morphs its output depending
> >  on how far the time is from the current time has been introduced.
> >  "--date=auto" can be used to use this new format when the output is
> >  goint to the pager or to the terminal and otherwise the default
> >  format.
>
> What needs to be done with this patch to move it along?

In e.g. "Git Test Coverage Report (Wednesday Nov 21)" by Stolee you
can see that the new code in date.c is largely uncovered. Adding tests
for the behavior would be a good start.

> I see that both Linus and Junio have signed the patch.

That just means Linus wrote it and Junio ran "git am -s" on it.
