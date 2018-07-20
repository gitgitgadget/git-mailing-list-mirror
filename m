Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD700208E9
	for <e@80x24.org>; Fri, 20 Jul 2018 06:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbeGTHMW (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 03:12:22 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:38874 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbeGTHMW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 03:12:22 -0400
Received: by mail-yw0-f174.google.com with SMTP id r3-v6so3990576ywc.5
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 23:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=sDVwd3MlQ3OAwLlCrVdyw4G/sCXu3lhvsMInJNtJ2tM=;
        b=Szk3ch6X0ojQmAXfYnfnFeHX/cEtscxvLVMi0rUdV7XiWziVxWJYteomtVPKdSd74/
         LYW3E6vF7qrkCw98dg5W/Jm6ZWcJpbq30FJvGrmsXePap37XsfUMHqIdNNjUqGqqVVDT
         cqgO8th0rKjFPt3R9mqfZyGx1BYwPjqJ13ijW40mbZGvx48OXG/01cQFaoKbE0U8CJmv
         94A58LlqMFAhpZnKAdh7d++KqnhzxXnfm9f1CvckmNPt9mOOliaHZDEeafEBAU3ZHivM
         hvGGJzWobiBPKtW7cf8XX/p8NGqcHnpN9SLEkTrVBrw1uJkqNZYNnE0MD0AXWq1PCHjs
         mitw==
X-Gm-Message-State: AOUpUlEpSNJqCa0eZDZjvQzrRAr12wmWvaqpU1o24obTFRf7VeW/j3U2
        3l6Hf67aVP9LccNusdLy4iTqoouztH82d1pSsvxYXoYK
X-Google-Smtp-Source: AAOMgpcKJ3IlaFnGYj+nYWEmYWhqy06E8OKD5LpbpoZK0CwvFPHfAgzZKzKigFi9gzODp77dwyqEng4XgBfv4RSBUtE=
X-Received: by 2002:a81:1001:: with SMTP id 1-v6mr328062ywq.120.1532067943444;
 Thu, 19 Jul 2018 23:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <D295145E-7596-4409-9681-D8ADBB9EBB0C@me.com> <CAPig+cT+Z-hN6WidMOUW2jRVNFovvv03LEFESXpr05NKmpnWAA@mail.gmail.com>
 <1569C0A9-7C44-4F28-9C9B-AF2489E021AB@me.com> <CAPig+cRYVwsMxUQGWHWyfC1gpVgEtt0VH-CmQoGizEAp-B_7WQ@mail.gmail.com>
 <BD1EAEBF-B125-4D3E-A814-F8824E5D2CA8@me.com> <CAPig+cTRdh56VVcOGzeJmUN-L0-v2i+rCdMGxdr1FEUgfUGw4g@mail.gmail.com>
 <5196A9EF-3967-4E4A-A929-58CD8BE72150@me.com> <CAPig+cRDTMW5O1T20CnK03wWb9W8ev9q34U4P4rRk-3hrnNfGg@mail.gmail.com>
 <C9089D48-5516-4EF9-9260-BADD62FA3CBD@me.com>
In-Reply-To: <C9089D48-5516-4EF9-9260-BADD62FA3CBD@me.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 20 Jul 2018 02:25:32 -0400
Message-ID: <CAPig+cTJvJLMe4CFOb-yxqwF4udvs4G-BUiT=Kp-NZcfAWAyiQ@mail.gmail.com>
Subject: Re: Gitk doesn't work on macOS Mojave
To:     cherpake@me.com, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[re-adding cc:git]

On Fri, Jul 20, 2018 at 12:38 AM Evgeny Cherpak <cherpake@me.com> wrote:
> > On 20 Jul 2018, at 7:30, Eric Sunshine <sunshine@sunshineco.com> wrote:
> >
> > On Fri, Jul 20, 2018 at 12:11 AM Evgeny Cherpak <cherpake@me.com> wrote:
> >> Not sure what you referring to?
> >> Is it alternative to gitk? How I install it?
> >
> > This: https://git-scm.com/docs/git-gui
> >
> > It's not an alternative to gitk, but complements it by providing
> > ability to stage and create commits, show blame information
> > graphically, etc.
> >
> > It's a standard part of the Git distribution, although it may not be
> > installed by default, depending upon your platform and the packager.
> > Some Linux distributions, for instance, may place it in a separate
> > package for installation (named "git-gui" or something).
>
> Just tried it - it works, but doesn't get focus.

Looking more closely, the code in "git gui" is catching and silently
ignoring errors:

    ## On Mac, bring the current Wish process window to front
    if {[tk windowingsystem] eq "aqua"} {
        catch {
            exec osascript -e [format {
                tell application "System Events"
                    set frontmost of processes whose unix id is %d to true
                end tell
            } [pid]]
        }
    }

which explains why you don't see the "Not authorized to send Apple
events" error you see with gitk, and also explains why the application
doesn't get focus.

So, updating gitk to mirror git-gui might be one way forward.
