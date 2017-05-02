Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D10C61F790
	for <e@80x24.org>; Tue,  2 May 2017 23:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750853AbdEBX4b (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 19:56:31 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35059 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbdEBX4a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 19:56:30 -0400
Received: by mail-io0-f193.google.com with SMTP id v34so409503iov.2
        for <git@vger.kernel.org>; Tue, 02 May 2017 16:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZSnr3tn2mCJ+n4FExbQ4vLmYzJ7fpDTWsBwoVdX0GII=;
        b=LGVs3zyyb+3MpJe33bp9UWU3L2O+rA2JAdSmZo+LPPgyuhD7om+xp+Q/2eLzqP7dBS
         jgx4XWARJ09GOfE6yNicFvE0GPn+SblOn5U0pi2yGZgSUdno25BuT50mWdF5QnmMOPzb
         UjdaHQDG3L1CTdOOvs0ByvdlZ0I8JeufvuxTHmNJ3xrkw61g/UvcMzRMpkWDn53hsutU
         Kcrqd3IC+d074IVZE0CEt6Yp/f5gKDgAspUtyaBxa0TKlWFDq75dL1OCZ9uAUdyUgSe+
         GY0mgu2jE4LSZV1LGQNElsBVJtL2E2LHMQlm+b2PQtjOTkUatan0XIgFgKyVXzuhLsci
         /D4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZSnr3tn2mCJ+n4FExbQ4vLmYzJ7fpDTWsBwoVdX0GII=;
        b=t5owUkK8JaRE58+QCaRMLbzoE71kHrlbIQNPWr7ARUTDXyzcSvkufGaHBhKhEpWAld
         MP5nQnAtQ4vncGCc5AuOYyW00tGHc7XNv9aCOpGlwUWGGvUCvPMmqu7J7GnLjActSWT+
         6QhvbWzESh9RdpL0Ub5WSwoWIaLA0JyGy0ArjWALQ2FmHG+D17wzd1qyYVPIThz07IKz
         vDhun1kDyVWmYLirmyi9e/hBX9el55R5A9vDbsb28O+ktYY6TkDN18RBe3txrESLrYui
         uJb0/TY6UCnOIOHFkHhzL9EdRnegT3fnfav91rmu2ImoXCwPw274Pd8te9rr7eVZDQmF
         wZ0A==
X-Gm-Message-State: AN3rC/43fxPQBJPbHj0OedFq/J6dsnfaVdjRcXf6wOP37AZKGv0ohhtI
        fpulGNp2CmePow==
X-Received: by 10.107.48.144 with SMTP id w138mr34783408iow.30.1493769389396;
        Tue, 02 May 2017 16:56:29 -0700 (PDT)
Received: from atris (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.googlemail.com with ESMTPSA id u187sm955906ita.27.2017.05.02.16.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 May 2017 16:56:28 -0700 (PDT)
Message-ID: <1493769381.29673.39.camel@gmail.com>
Subject: Re: [PATCH v3 0/6] rebase -i: add config to abbreviate command-names
From:   Liam Beguin <liambeguin@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, peff@peff.net
Date:   Tue, 02 May 2017 19:56:21 -0400
In-Reply-To: <alpine.DEB.2.20.1705021741580.3480@virtualbox>
References: <20170502040048.9065-1-liambeguin@gmail.com>
         <alpine.DEB.2.20.1705021741580.3480@virtualbox>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.5 (3.22.5-1.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes, 

On Tue, 2017-05-02 at 17:48 +0200, Johannes Schindelin wrote:
> Hi Liam,
> 
> On Tue, 2 May 2017, Liam Beguin wrote:
> 
> > Add the 'rebase.abbreviateCommands' configuration option to allow `git
> > rebase -i` to default to the single-letter command-names in the todo
> > list.
> > 
> > Using single-letter command-names can present two benefits.  First, it
> > makes it easier to change the action since you only need to replace a
> > single character (i.e.: in vim "r<character>" instead of
> > "ciw<character>").  Second, using this with a large enough value of
> > 'core.abbrev' enables the lines of the todo list to remain aligned
> > making the files easier to read.
> > 
> > Changes from v1 to v2:
> >  - Improve Documentation and commit message
> > 
> > Changes from v2 to v3:
> >  - Transform a single patch into a series
> >  - change option name from 'rebase.abbrevCmd' to 'rebase.abbreviateCommands'
> >  - abbreviate all commands (not just pick)
> >  - teach `git rebase -i --autosquash` to recognise single-letter command-names
> >  - move rebase configuration documentation to Documentation/rebase-config.txt
> >  - update Documentation to use the preferred naming for the todo list
> >  - update Documentation and commit messages according to feedback
> 
> Thank you for this pleasant read. It is an excellent contribution, and the
> way you communicate what you changed and why is very welcome.
> 

Thanks! and thank you for the support and help.

> I offered a couple of comments, my biggest one probably being that this
> patch series is crossing paths with my patch series that tries to move
> more functionality out of the git-rebase--interactive.sh script into the
> git-rebase--helper that is written in C, closely followed by my suggestion
> to fold at least part of the functionality into the SHA-1
> collapsing/expanding.
> 

I've seen a few messages about this migration, but I'm not yet sure I understand
the difference between the shell and the C implementations. Is the C version going
to replace 'git-rebase--interactive.sh'?

> If your patch series "wins", I can easily forward-port your changes to the
> rebase-i-extra branch, but it may actually make sense to build on top of
> the rebase-i-extra branch to begin with. If you agree: I pushed the
> proposed change to the `rebase-i-extra+abbrev` branch at
> https://github.com/dscho/git.
> 

If 'git-rebase--interactive.sh' is bound to be replaced, I could
just shrink this to the Documentation cleanup (patches 4 and 5)
and rework the rest on top of your new implementation.

> I look forward to see this story unfold!
> 
> Ciao,
> Johannes

Thanks, 
Liam
