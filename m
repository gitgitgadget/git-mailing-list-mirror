Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E83491F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 22:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfHLWZs (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 18:25:48 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:33473 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfHLWZr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 18:25:47 -0400
Received: by mail-lj1-f169.google.com with SMTP id z17so11295698ljz.0
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 15:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u15yebLj9vpkK7F6IC+xGNwi8iHX00r4y1oUtgZXPtg=;
        b=GbTsJjdbnBHqrJeEciAZz3SV3N6TiXmDgS8/40Kwv/yhxyPhtQE3CyTGrmGTyhZP42
         rRoJ0pkAqYtrjUnAiYtUzTV9vf94HUJkZ+RiS2flIPCdhTvRhJNxeN76NrIeN8ooataS
         HUGaumR7OIL3E7ZpzuiPfzKTG8f+ZIYoP8yMuhiVwvX4tyFkTERGMBOAfx31PHhNs6QA
         3u5HMzoUkwJwrcJhHkJKudSDduwEt6b9714eB/vHp2j59jhnYE9kxKjKCkmmi6WDpcKx
         zScbDivHxuHakHwFTqjSEm58eAEcNVaKkjY22LbSgC5pltPSFphPZAAfmxKCmPFJHY2e
         yt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u15yebLj9vpkK7F6IC+xGNwi8iHX00r4y1oUtgZXPtg=;
        b=lFETv2KCC6fKKQWFV3eB27FTFo44q3jhShb7a6tLz/MflnfAz4HqlvEJJGzpa7/aFH
         cLWT/4fs1wfXebQ4iM2rlJYWR0TZ3rsz3NHir1ITvbCbWKMCXdM+PHgmnd0HT+IklOxS
         SgIXCXJNNI5RRdw/X75mfZwhZxvpKD0c6H+7uaY2iXzwVLBBhOPdHUGdFEBvVbp3lM8V
         9zYGlVtV26Hpx7E41Vz9OuM7c+GwRZ+OExcgMbdG/IxQvhvQhix24feVrwXckTIAYOcs
         OkQbjzKOzySCUtZl19np2NaXaARs5G+fbC08mZKBlO/bfwRXo9YcDMoSa5L8b0qZEvmO
         yFlg==
X-Gm-Message-State: APjAAAXYbHiDS9VJX9KngExH9aHRvuHhd0mOPG6yLogm+FjtDZkaisd1
        JCwqSgNBIqQQkLX6h+ufjZf6ErQoj2UOCE9ErH0=
X-Google-Smtp-Source: APXvYqzNeCEeDO+1yuJCeoEB5rNy0jMIgLCHEfSAE7rIFBPQ2yQOj0/WVeB7e+iA30+ZP8PqdDcXBZYrQS8bWapJhrI=
X-Received: by 2002:a2e:92c6:: with SMTP id k6mr13737564ljh.148.1565648745193;
 Mon, 12 Aug 2019 15:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <CALnO6CDFQA_QmR_2tczPNJiymfUxt8LUiF0HOvKJKreB_HmNuQ@mail.gmail.com>
 <20190812221828.GA16666@sigill.intra.peff.net>
In-Reply-To: <20190812221828.GA16666@sigill.intra.peff.net>
From:   "D. Ben Knoble" <ben.knoble@gmail.com>
Date:   Mon, 12 Aug 2019 18:25:32 -0400
Message-ID: <CALnO6CDYBv+742=4Z0KbC0rgNA0KTdVR=deU7pPj6twHHpkgJg@mail.gmail.com>
Subject: Re: send-email and credential
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peff is completely right: the log showed host=smpt.gmail.com:587 as
expected. Keychain confirms.

Thanks!

D. Ben Knoble

P.S. Be sure to delete /tmp/credential.log afterwards to clean up your
passwords.

On Mon, Aug 12, 2019 at 6:18 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, Aug 12, 2019 at 06:00:14PM -0400, D. Ben Knoble wrote:
>
> > I spent a frustrating hour today hoping to setup git-send-email with
> > my gmail account. I've been able to confirm the following:
> >
> > 1. git credential works
> >
> >     # git config credential.helper
> >     osxkeychain
> >     # git credential fill <<EOF
> >     protocol=smtp
> >     host=smtp.gmail.com
> >     EOF
> >
> > outputs the correct username and password for my gmail account.
> >
> > 2. I (believe) I setup gitconfig properly:
> >
> >     # git config --get-regexp sendemail
> >     sendemail.smtpserver smtp.gmail.com
> >     sendemail.smtpuser ben.knoble@gmail.com
> >     sendemail.smtpencryption tls
> >     sendemail.smtpserverport 587
> >     sendemail.multiedit true
> >     sendemail.annotate true
> >
> > The strange behavior I'm seeing is that git-send-email
> >
> > - prompted me via macOS for keychain access (expected). This happened
> > twice in a row, during one command invocation.
> > - prompted me at the terminal for my gmail password (shudders)
> > - stopped prompting me for messages send after that (all within the 15
> > minutes of the first two)
> >
> > Can anyone confirm/explain what's going on? I've never tried to use
> > git-credential or git-send-email before, so I'm new to those (but
> > experienced in git).
>
> I don't think the saved password you're showing in step 1 is being
> triggered, because Git will send "smtp.gmail.com:587" as the host field.
> Try this:
>
>   git \
>     -c credential.helper='!exec >/tmp/credential.log 2>&1; cat; echo' \
>     send-email ...
>
> which will log the helper request. It probably has:
>
>   host=smtp.gmail.com:587
>
> I don't remember the specifics of how osxkeychain works, but it probably
> pulls the port out of that and passes it to the OS keychain code, which
> then treats it as a separate service.
>
> So the rest of the behavior makes sense, then, I think:
>
>   1. macOS had to unlock your keychain to check for the entry
>
>   2. finding nothing, Git prompted you for the password
>
>   3. Git then wrote the password to keychain after it was used
>      successfully (maybe prompting another keychain password request? I
>      don't know how it works), after which it should work without a
>      password.
>
> -Peff
