Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D62391F829
	for <e@80x24.org>; Tue,  2 May 2017 08:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751104AbdEBItF (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 04:49:05 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36368 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbdEBItD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 04:49:03 -0400
Received: by mail-it0-f67.google.com with SMTP id x188so1171140itb.3
        for <git@vger.kernel.org>; Tue, 02 May 2017 01:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lFiIGI86Jbkt9yIQaes0M1KMlPDH+s/KLEvmaIwNSkY=;
        b=jxlnBKxJFhaZ3xG2mzGggJH8kLLeSDhYrvN/3NXaoDGPtfxKWoS/IMjKaE2/uDjU9x
         0cHHPOIf+um5tvpBICZOnP8eyp54O3/PgIirBnP9VUwxTV1ZspQxsz2YCV/korEC4XD4
         N9O83/X1cWZf8fo33HAFySm7Vz2741iFRipAvQ8g6Ew0Pygyv9bjUuQZdqwbSPDVHSu/
         4Ku+TtPzj1XZH4eCSUXgEqQphOeaGdZ1+mCxDp5/HmGuZbtiM8g/AAl9wqiqYnt2x144
         9Qu9aUlFaMAvUAGLyCtdivqBxUHmH85lbHXo8NoDPOCuDtPyUS0BtS65En0gW8aDAAKi
         t9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lFiIGI86Jbkt9yIQaes0M1KMlPDH+s/KLEvmaIwNSkY=;
        b=WeVz4CkptRlvljH3Wtub+PZozOBLKp2kElYEujEyXqJFeIrLntGhMoPmdZ5I571ayg
         0lgtQSiHwN1xqYjm0ZQBKTp/dRr1Wvy+vxRVuwClQMv6DxfKiWLYiKOl8Ovdndcg1XsZ
         26DjeEDaMutdS64uq2VfjOv7hjQiAKW7q4YOGL49hfOCT5pDoQlNlPlROIgml0A78smH
         kmdMqAKWfxMkVNpAOZv5BmhRcMQulDZTR9VSK8WH/dAtDZygIhOjCRj66gVH/Rk7AV5T
         5U3wtESv9BP4LeD/hwGy2OyuqR5+nFkFq27BrOw4ShNPtUZsur+lJHr4O12A3HlrDH8z
         K0yg==
X-Gm-Message-State: AN3rC/4o4pH1RPY2b6L7HPYYli2/zqoLC0OXPOzEilNyzRcfQA4pCI0I
        VEE5yZ4JE8Gca5QvWlRVL1LORv/rCw==
X-Received: by 10.36.124.129 with SMTP id a123mr1962029itd.66.1493714942646;
 Tue, 02 May 2017 01:49:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 2 May 2017 01:48:41 -0700 (PDT)
In-Reply-To: <20170502040048.9065-1-liambeguin@gmail.com>
References: <20170502040048.9065-1-liambeguin@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 2 May 2017 10:48:41 +0200
Message-ID: <CACBZZX5MacQZHVjSymWm0_RHjc_Q41J9vhqMuDGwz3L_4LjtzQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] rebase -i: add config to abbreviate command-names
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2017 at 6:00 AM, Liam Beguin <liambeguin@gmail.com> wrote:
> Add the 'rebase.abbreviateCommands' configuration option to allow
> `git rebase -i` to default to the single-letter command-names in
> the todo list.
>
> Using single-letter command-names can present two benefits.
> First, it makes it easier to change the action since you only need to
> replace a single character (i.e.: in vim "r<character>" instead of
> "ciw<character>").
> Second, using this with a large enough value of 'core.abbrev' enables the
> lines of the todo list to remain aligned making the files easier to
> read.
>
> Changes from v1 to v2:
>  - Improve Documentation and commit message
>
> Changes from v2 to v3:
>  - Transform a single patch into a series
>  - change option name from 'rebase.abbrevCmd' to 'rebase.abbreviateCommands'
>  - abbreviate all commands (not just pick)
>  - teach `git rebase -i --autosquash` to recognise single-letter command-names
>  - move rebase configuration documentation to Documentation/rebase-config.txt
>  - update Documentation to use the preferred naming for the todo list
>  - update Documentation and commit messages according to feedback
>
> Liam Beguin (6):
>   rebase -i: add abbreviated command-names handling
>   rebase -i: add abbreviate_commands function
>   rebase -i: add short command-name in --autosquash
>   Documentation: move rebase.* config variables to a separate
>     rebase-config.txt
>   Documentation: use prefered name for the 'todo list' script
>   Documentation: document the rebase.abbreviateCommands option

I locally rebased this into just 3 patches, i.e. in this sequence:

- Documentation: move rebase.* config variables to a separate rebase-config.txt
- Documentation: use preferred name for the 'todo list' script
- *all the rest of this squashed*

I think that's much less confusing than having 3x "rebase -i" patches.
If you look at any one of those you have very little context for
what's going on, and there seems to be no point in splitting them
since the end result is tiny (3 files changed, 45 insertions(+), 4
deletions(-)).

I think with that this looks good, but it also needs tests, if you
apply your series and then comment out the new calls to
abbreviate_commands all tests still pass, if you look at git-config(1)
and search for the other rebase.* commands & grep the test suite for
those you can see how they're tested for.

I don't think this needs a lot of testing since it's a rather trivial
feature, but just one test to make sure that the todo list ends up as
"p ..." "e  ..." instead of "pick ..." "exec ..." etc. would be good.

>  Documentation/config.txt        | 31 +-----------------------
>  Documentation/git-rebase.txt    | 21 +++-------------
>  Documentation/rebase-config.txt | 53 +++++++++++++++++++++++++++++++++++++++++
>  git-rebase--interactive.sh      | 24 ++++++++++++++++++++----
>  4 files changed, 78 insertions(+), 52 deletions(-)
>  create mode 100644 Documentation/rebase-config.txt
>
> --
> 2.9.3
>
