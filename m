Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EC901F406
	for <e@80x24.org>; Wed, 17 Jan 2018 13:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753054AbeAQNe6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 08:34:58 -0500
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33760 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752792AbeAQNeq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 08:34:46 -0500
Received: by mail-oi0-f46.google.com with SMTP id y141so13131644oia.0
        for <git@vger.kernel.org>; Wed, 17 Jan 2018 05:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Dd0TOKGv20J1AHnrHyUsJABKnpjTxvHqslAzs6Uwx+U=;
        b=awtSzIWUZL2cWTlcZL55PTBAHxdXOfxeZK5aAAlB64oiU/vJzUGLhljBJbsALHcD8f
         xD8rQs2B5ZAP+BJqs/ISjHKbAOuw2ErgjqZ/TiYyAwe9dtWZCf76gWXoKWBDc4NeB4Wx
         XSJRFZPWb/13hFHFZXEw8A+MXacdMrjUNNCehcQjyipYwcnPOqjvWDxl9sNtjbxmNlWu
         7fz51dqI+YQ618360cs3z8ur4ixmrTLjHYnpEEuCngwQuM4GaX2+gG4X6puoYZRU1MEi
         AKZrsFqHaByCLbW2yE6wo9qn2/tqZcZSHZcV44nXgTAyGB9+Jq3fkgwWw8phWsquNqvs
         mfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Dd0TOKGv20J1AHnrHyUsJABKnpjTxvHqslAzs6Uwx+U=;
        b=pfCYQwIum/dUwXlJPIJzYSc8kRi+G/vrp5xR1OIKNrOVEdlmzB4GMxhCQ722S0WimI
         7uuASe8d0ugFI3Evpw/AEu5NrY4SxASt3IGnccHyYZpdl8SCI8REVu8gIKpM6oPIsa3N
         zKq9aNSzHkiOEQTyo5ILXTUL8ch5JjqAGwMOm/MNKxBYfUveBNkV42AT6aIBM06rjJIZ
         5UE852cncVKgCPWleP3S2thpkkYnFNpgOGmfXuxr9umJeRsv279DR0/DHL+Mkzt6Dyw+
         V7zPukUsLBCCwgpsNHTatoSpm+l70463Tv4xEuTM5OCC7wJ1PI5wsIGpl5Qw501WTx9J
         H1pg==
X-Gm-Message-State: AKwxytfSJSDqAe/J+eRoJKh+OZ1PffjxUhAbBPt3IoYwaaSCck6hNjU5
        5a/VrBxL6IdBF6W5vZ+47zHqu6kz9P3niBgqjDc=
X-Google-Smtp-Source: ACJfBovhWkZRp9z1QLqFp2jkJCiNDdvbTW7EfbBIk/ksWpLYyfKZ3REDkR+0kxbJNdZuWJjWZo94dDZPmfehmyEuoiA=
X-Received: by 10.202.76.214 with SMTP id z205mr1023101oia.183.1516196085372;
 Wed, 17 Jan 2018 05:34:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Wed, 17 Jan 2018 05:34:14 -0800 (PST)
In-Reply-To: <alpine.LFD.2.21.1801170455380.16166@localhost.localdomain>
References: <alpine.LFD.2.21.1801170455380.16166@localhost.localdomain>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 17 Jan 2018 20:34:14 +0700
Message-ID: <CACsJy8A0BcdqwkDDd0Fx_8DDCgJc6gZaXkcYqysdv8BH1nvibQ@mail.gmail.com>
Subject: Re: misleading "man git-worktree", is last "add" argument necessarily
 a "branch"?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 7:58 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>   perusing "git worktree", and man page reads:
>
>   SYNOPSIS
>        git worktree add [-f] [--detach] [--checkout] [--lock]   \
>                         [-b <new-branch>] <path> [<branch>]
>                                                  ^^^^^^^^^^
>
> however, can't that last optional argument be any arbitrary commit,
> not just a "branch"?

It's been changed to commit-ish about two months ago in c4738aedc0
(worktree: add can be created from any commit-ish - 2017-11-26)
-- 
Duy
