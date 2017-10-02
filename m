Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 277A220281
	for <e@80x24.org>; Mon,  2 Oct 2017 22:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbdJBWvA (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 18:51:00 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:44457 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbdJBWu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 18:50:59 -0400
Received: by mail-pg0-f52.google.com with SMTP id b1so2226450pge.1
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 15:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9BrABk8B/1NiAzDbX60Z+lLohVABP1Ci3ZhmtPT9YWs=;
        b=mUO5hi5o3NbFoXquKNG39BWiWDWLAf6AWtw1eEOEA0BgdOl5I8NRnOQtIie5eReylt
         ZAQe4rbIG744r7P3kXkr8bpOBDHTlFOFqoscH7hhQ4sKOfYJVucGrTGzwjntGNr7d2ke
         JN5XY1DlXdBCsMdBeLfBSnlnShkGLLHczSnsefthoyr3ITP9U0iD796uXQgPS+3i6HpH
         cAror0yrm7fxt15M6b81QpLhsg6nZJdG9M0SjXrVBk7b62ozwp6LuMupMwcyXEwHV07w
         b9wj5IoyJ9D3Ue9ojXre8BaWRF5oekB3xtqU3Ak2k6Y4HwAjHC6t+yrSoXhKOrj8qLmQ
         rcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9BrABk8B/1NiAzDbX60Z+lLohVABP1Ci3ZhmtPT9YWs=;
        b=Wvb5RrlzFN8oWNa3TBwysY9ylpX1Hk9AP7hziLbXT3SsVTMJ+GFoVt6CxeTpNRjBbB
         d8p3E0fZjPwOih8PEQtteRSuOf5gZFVEsKhrlSdKY21qQAHw4AjxejigAEQxPF12FmfV
         5SFNax812BLxBfWpXHeatAIk2UN6AMGYHH6XTmLYkrV2kc9x0CumEdjJhW/PDmQQPSHA
         eW7/9LtXwk08yd19nC8Bfa1cd/Vmu5JoCy16U8bhWAZ/Ut4G0wUBW4o2AAHXKcLJWKwM
         pSnyXeH+zL0EIkgK2umftVqzFehsBKPl03FpLQi7UOf1EcL0aIv7nvV4o9f1x/ymEQcf
         1kSA==
X-Gm-Message-State: AHPjjUgnIymGNjTh1FtAIXx4DrsfJuvkeRT/Pjx85fzLqhXlBSBQBPa+
        ak1wYY2NocTo9lE+VsHIUDGA5j1a
X-Google-Smtp-Source: AOwi7QDnmyEwbEGIBmA2QpJ+Hr3SdpZd0r4d3zGz3d1QH4WM1R+r/ULqPdBoiXQU2WE0c6n4U0SPrA==
X-Received: by 10.84.179.165 with SMTP id b34mr15046874plc.15.1506984659108;
        Mon, 02 Oct 2017 15:50:59 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c1fd:a9ac:f156:8142])
        by smtp.gmail.com with ESMTPSA id c7sm21176650pfg.85.2017.10.02.15.50.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 02 Oct 2017 15:50:58 -0700 (PDT)
Date:   Mon, 2 Oct 2017 15:50:56 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Damien <damien@dam.io>
Cc:     git@vger.kernel.org
Subject: Re: hooks are ignored if there are not marked as executable
Message-ID: <20171002225056.GS19555@aiede.mtv.corp.google.com>
References: <CAAQ5yigO8FxhUjwr68OnW0UEYck2AKF5P0Qt_zedhBL_SEiKTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAQ5yigO8FxhUjwr68OnW0UEYck2AKF5P0Qt_zedhBL_SEiKTw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Damien,

Damien wrote:

> If you do `echo my_script > .git/hooks/pre-commit` and then `git commit`,
> The hook is just gonna be ignored.
> But if you do `chmod +x .git/hooks/pre-commit`, then it's executed.

This is intentional.

> I think ignoring a hook is misleading and not newbie friendly, an error
> message to signal an incorrectly configured hook could be better.

Adding a warning sounds like a nice change.  Care to propose a patch?

In the early days, sample hooks were installed without .sample in
their filename and could be enabled by "chmod +x"-ing them.  Because
of this, long-time users of Git may find themselves experiencing this
warning more often than they'd like.  That could be acceptable if the
warning shows a command to run to prevent the warning from showing up
again, though (see advice.c for some examples of how that can be
done).

The main code path to look at is run-command.c::find_hook.

"git grep -e 'rev-parse --git-path hooks' -- . ':!contrib'" finds a
few other code paths you may also want to look at.

Thanks and hope that helps,
Jonathan
