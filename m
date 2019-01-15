Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C87B1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 20:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbfAOUhC (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 15:37:02 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:38795 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbfAOUhC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 15:37:02 -0500
Received: by mail-qt1-f175.google.com with SMTP id p17so4586333qtl.5
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 12:37:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HBdnN2YVu9ctHxDlZeKm4VNTC+CA87TZgVgE57Pq1Xw=;
        b=lj4w7W725gRk/0gKmbzCPUHclNgN+4tTVDrx0pDb8ZRMuuI4AdrlPDNSiQ89PJrsi7
         EQgar/0S8UO+VSRKbFhUlYK0H+dHCKxqRd3rCEYzRfkBItF/miqfdUF5ec3FGs59jfKK
         Abhc88tDXHZKguHSAZ4Lw2FmNPUgP8ChKn3R7LqI7ZEa71uNmfrqv0FJ+Rt/tWlO5eE+
         ydEuHIC4cdd6hZmn2VaBy5t6s9urTuuCfMwCp7uPmA6AASwufSnvKIk9PuK/w2Zy/fXG
         amXEKsUxuPzLUi6bPPQEZV5AKztCfbmWiGTb+kYgEUZ3WOQDhm9RPhsmh4UvNNC77f7y
         NHZA==
X-Gm-Message-State: AJcUukcCqu7BoXNZX7jDsfXoWk1rhbR//NzvR8103ZPtAzOYOF/yiMEU
        GQKWpA6M6z9pU/yll+7EFI8reFtElcu1Yxy86KA=
X-Google-Smtp-Source: ALg8bN42p4YXdODJQmmm7SG3fGQFA8mvvqK/hN55DdoOVQxvpviq6uIvAQIHJk5p3UxToZlyGm41ooszrehJsJIHUjQ=
X-Received: by 2002:a0c:86c1:: with SMTP id 1mr4342820qvg.6.1547584621071;
 Tue, 15 Jan 2019 12:37:01 -0800 (PST)
MIME-Version: 1.0
References: <CAKd-JgStGb4Ka9Rs6G2e4ADQKZVrsJMsNGz1sRP_4Ej4=FtxtA@mail.gmail.com>
 <CAKd-JgS3omKbN+OzQL2dUun6Seg9CjDNk8KEj9m83xdTZE=7FA@mail.gmail.com>
 <CAPig+cQWW9kibWYKu5oRDgo_Pt4wVmzkqzbTG=YGvwqRCXcNXw@mail.gmail.com>
 <BF7AD597-5C05-4A7A-8DB6-0FEA2F95AF72@derailer.org> <89DD4C7B-7F8B-42C5-81F2-F14D5B2D4CFD@derailer.org>
 <355CD611-C58E-43E1-838C-017CAEF5AD38@derailer.org>
In-Reply-To: <355CD611-C58E-43E1-838C-017CAEF5AD38@derailer.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 15 Jan 2019 15:36:50 -0500
Message-ID: <CAPig+cTdP631KLQNM8XfFzcZbMTfMRcvm7wJ67BUUUeGSmoMDw@mail.gmail.com>
Subject: Re: [Bug report] Git incorrectly selects language in macos
To:     Nate Weaver <wevah@derailer.org>
Cc:     Niko Dzhus <primenico@gmail.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 15, 2019 at 2:06 PM Nate Weaver <wevah@derailer.org> wrote:
> Nevermind: I've been informed that this has already been fixed on the git trunk
> for gettext, and will be in the next release.
>
> (See: https://savannah.gnu.org/bugs/?49560)

Thanks for the follow-up report. It's good to know that this is fixed
at the correct location upstream.

I tried updating the Homebrew bug report[1] regarding this problem
with respect to Git in order to add the new information you provided,
but the ticket has been "locked" so no additional comments can be made
there, which is unfortunate.

[1]: https://github.com/Homebrew/homebrew-core/issues/31980
