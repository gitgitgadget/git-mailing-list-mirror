Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E47821F453
	for <e@80x24.org>; Tue, 23 Oct 2018 02:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeJWLCE (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 07:02:04 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34427 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeJWLCE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 07:02:04 -0400
Received: by mail-ot1-f66.google.com with SMTP id c3so2423324otm.1
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 19:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pN0BxhLjLxj6b4DgZf374qE3712VPLswHyOzteptRZg=;
        b=jVGXW571C5k9xZLyjjkLsd+F21gSkRf8P4gOY7ujrSjxv0iUxlaVZuzR4d2NfB/BGB
         5NT+qMOIx6Z6a/HDp13ewunlmWCB/KcdGwGdoVxWee95qE5HmuyEZmnXqTTFYyeHSsr6
         NZa1RYwKIvjA4c1UYBddwdWfS+TAK8hhtKWo3v/CrLa+sLuC6oKdjsvO6FJIPhYC1rmm
         sQTQ2cXkNev27h8Ic9st3nHxWw/pcIhTt51EpRPz0KtaWGxZ3CQkyU8OCofp7pox2+45
         OkqEL61hpii2bulncjx+hljgUBmqZ/0sknXPrBllLk7VQd+MqfDW7qRRWfl1Msg4r9em
         Posw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pN0BxhLjLxj6b4DgZf374qE3712VPLswHyOzteptRZg=;
        b=j++dk32/fMV+x9/I60StQvrVl7eEPTZa+SyY40GH8HfaZV/MIfXs9UYBkDACGIdgNX
         SyLO53sIHi7netlItPfsJWdNTJ2r5pnGH2cNF2kqFc/z42n2xzWJjpgXhAJW+NAm3FKo
         O8nqgbqh8Garr9ULfHCgHbRsBSG4fjIqDZuJqP4x3YwfOHyLHF4mpx1bUrBkj6VuGynR
         /bGW5U1KajZR9Ous8IRQ6wKb0ymc3m1WRXRuONCA6B9vdsuyaSHDiRWJAr5K0E89mbLI
         RnkEYe+U8hcBS+Ehg0YapMNkSHRr8P1ZlwLcLCxTTgqJZZ8hPtJqdJMangdaqgCg3B0x
         q6LQ==
X-Gm-Message-State: ABuFfohaG93z+mqDpyEBJcQaPnbjoxUBPV+FSpUM3spbnmJyM5YVC7k7
        iQUvMh8oABijUQ3tq1XZRlETz2CryYWNEyFdFUYM6IDO
X-Google-Smtp-Source: ACcGV62YZwFzSFnUAsEv+h2w4JCgqEEdFJy/kp0YLFMFbeML3PMmh9HDWED0MFmmh6HAk7hxnn41ai1sta3lJUF5xKg=
X-Received: by 2002:a9d:62cb:: with SMTP id z11mr32807553otk.342.1540262447723;
 Mon, 22 Oct 2018 19:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181018211527.25597-1-JPEWhacker@gmail.com> <20181022175248.3940-1-JPEWhacker@gmail.com>
 <xmqqd0s1tsdd.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0s1tsdd.fsf@gitster-ct.c.googlers.com>
From:   Joshua Watt <jpewhacker@gmail.com>
Date:   Mon, 22 Oct 2018 21:40:36 -0500
Message-ID: <CAJdd5GaQtHVX_wCF8D3y4qJ-a6RdMHpv=BGQVM=xfBEe8xEyOw@mail.gmail.com>
Subject: Re: [PATCH v2] send-email: explicitly disable authentication
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 7:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Joshua Watt <jpewhacker@gmail.com> writes:
>
> > It can be necessary to disable SMTP authentication by a mechanism other
> > than sendemail.smtpuser being undefined. For example, if the user has
> > sendemail.smtpuser set globally but wants to disable authentication
> > locally in one repository.
>
> I wonder if it would be more productive to introduce a mechanism
> that can be used to address that use case more directly.  For
> example, would it help to teach "git send-email" that
> sendemail.smtpuser set to a particular value (say '!', or empty
> string if you prefer) is equivalent to the variable unset at all?
>

I'm a little worried that is more likely to break someone's workflow
(although, I'm not sure why someone would have such simple username).
Using sendemail.smtpauth = "none" is pretty much guaranteed to not
break an existing setup because git send-email would previously reject
any value that wasn't upper case. I suppose the one disadvantage is
that it isn't backward compatible, since setting sendemail.smtpauth to
"none" wouldn't work with older versions of git (due to it not being
upper case), but I'm not sure how much of a concern that is.

IMHO, setting ""  or "!" for sendemail.smtpuser probably isn't any
more clear or direct for the end user than my solution.
