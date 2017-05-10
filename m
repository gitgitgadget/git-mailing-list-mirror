Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DD5C20188
	for <e@80x24.org>; Wed, 10 May 2017 19:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754541AbdEJTQG (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 15:16:06 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:34546 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754066AbdEJTQE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 15:16:04 -0400
Received: by mail-io0-f177.google.com with SMTP id k91so8024310ioi.1
        for <git@vger.kernel.org>; Wed, 10 May 2017 12:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2+rjgZ6n/LFflNQ2iPa+jTbmr/OJxu+rN8QX/vnQQWk=;
        b=ZSPhkmMBDosLwdTNtOSXVyhsgOrqKB2HZLvkPaqW6i5kdUSNy4+jbsO2Y66AcWjEQb
         LTNE5sggS6JI/y9ytYQxiVL7KKqlBet11HkSeTjqdRQroa0BWwwdyGTwdUDHIuiu8V6x
         8o8hy9PP3S/z0+eqRv8Z64581MSsgPSNonu0dfCvQOWdYL/WORvbkqSjxjugSz9kPoMi
         xdy6JG/IMfEwfL7kwBOBUQtilI9E5jKQaR80HQfpPJJhjcd9CKql5tQtAobmeyrPTRjx
         mo1Z8JMPjWhdIhH18SmeiWyOGnTVRQfRFwMXzo9S25lgD5fTB49zwE5Z6XHmfwgR/oad
         /RyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2+rjgZ6n/LFflNQ2iPa+jTbmr/OJxu+rN8QX/vnQQWk=;
        b=JijfKu74nZhFZGLAloXBBlhgmO9fldkubr5b1C2W+Bey1g851R7XZKD5pNqk8b7ZjI
         2xhwi/prLGLSSUICozsq4hSJTZJETLZnC8rYqzY+JxdEU8A01II3zd9b+akGryp8+jpz
         3AifoOfpIhbP3tupFjo9kKHw1QLTbZxkmUV13mfCV2/9RjmaB4LvxD6b0KUpHgXOhAKh
         bAgEyNpP9UTmW9lqwC6JVJKHpwaOXEuzN4KlmsTbpZOwclTN8JtTYmO8VvTR5+kGvDLQ
         X6hf51Aw/yFBp1p5sPFaOolWPBYRBhPOzQmjsgLM38nRLfxQ9+J2jpAVqyWC4cnoffwF
         GeKA==
X-Gm-Message-State: AODbwcDM/QucnijttFft/l0bzn1MEHc6qIC0n6T+KtxmboGJk0Sr6A9h
        mJVmESm+UpN3GkMrbXXOd8BG7f1nRU1o
X-Received: by 10.107.195.68 with SMTP id t65mr5767943iof.17.1494443763644;
 Wed, 10 May 2017 12:16:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Wed, 10 May 2017 12:15:23 -0700 (PDT)
In-Reply-To: <CA+qhfwO4=1X9fNCW2PeKSgqUHV-z26qhvr_yXfz1QGApJ_roRQ@mail.gmail.com>
References: <CA+qhfwO4=1X9fNCW2PeKSgqUHV-z26qhvr_yXfz1QGApJ_roRQ@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Wed, 10 May 2017 14:15:23 -0500
Message-ID: <CAJZjrdX-oAP7GFcPJ_FVNCMuErF7DNkq97KhjwgBX_G5tGXoFg@mail.gmail.com>
Subject: Re: git log --follow after subtree merge
To:     Jonny Gilchrist <jonnygilchrist@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2017 at 9:46 AM, Jonny Gilchrist
<jonnygilchrist@gmail.com> wrote:
> Hi,
>
> After doing a subtree merge, using 'git log' and 'git log --follow' on
> files in the subtree show only the merge commit in which they were
> added.
>
> After reading around I understand that the issue is that git log
> --follow doesn't track renames that occur during a merge.

Try git log --follow -M. (You may also want to combine this with -l and/or -C).

> Has there been any work (or are there any plans) to allow git log
> --follow to work in this case? I couldn't find anything in the mailing
> list archives aside from a couple of threads from 2011 explaining the
> issue.
>
> Thanks,
> J.
