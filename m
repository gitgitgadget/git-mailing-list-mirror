Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 042461F51C
	for <e@80x24.org>; Mon, 21 May 2018 17:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753440AbeEUREC (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 13:04:02 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35845 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753382AbeEUREA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 13:04:00 -0400
Received: by mail-pg0-f42.google.com with SMTP id 63-v6so4469368pgg.3
        for <git@vger.kernel.org>; Mon, 21 May 2018 10:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wpJ+I0VhjBw6ZafE/ua9DtrUcaY0ryjLgYY7u0vpFP4=;
        b=q1cesrtvdVMUQobgm7EsZecqW2QgFDMomBhcvlAIVfiLlJVkTOfGNFjxIXodTayDWa
         DvQNrBNGtG9bIUgXu4F1tpfcvem6kLbByul1WItcUTRFSE6pphB1B1s3+J6XNryibz5R
         CTEPeskn5yV0SyVbue5AkCokMN5gtiKEQc+i9KG2nQVGokt31VYjvXlSWZfKTwMgZCHt
         Oe7IR5SqlZzborv36f1j3UgB5uFy8mbhe/KJQaKP7KTD3926epI2D6WyXnMRRLg02SbJ
         hn0wfu+Ws94tniRSiUKcduwLwZt8HSxFo9icLfzNVYbTfS5zugtt6XNxgJGyxbxYP3Q8
         EZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wpJ+I0VhjBw6ZafE/ua9DtrUcaY0ryjLgYY7u0vpFP4=;
        b=ENNf3UqVZ0AuM4u2RvZTETIP7gKkE6nsSeqv9YJdPtVhdW1+GTAqWv/0oTnDqrjTNN
         JWsDe0Bbz6PTXxkVgyFfxtLzQdRTu81ivzU+CYuesGbsrfYJzcamUXwhEQfxOy8Yq7/A
         WDYf29NtzAHDhDjR5LKluXV46iU5XBr4SlhoeoQL7GId4PCjVr5OSHgc/T6v2iFhh2F/
         SFLPDGrf4ba8oIbMbA7JxvbzQnXYe9joyW0xP8fVx59sSC6EUishHyL2hNB+++2LYZL0
         QFlqupZF8GXJVL3HSE4zFKjYa/BE5qDYjpdAHg/yZbR4sDA1C0Fm5tyNJeb5zdUTBAAz
         ruUg==
X-Gm-Message-State: ALKqPwckFN7CG1Q6dBhC5xkFl1Jz9bMhmuzidpoAOAWvsj0i3wGSlEt0
        a2qHpTDyhj3C99tIJT8abjOHVcY0
X-Google-Smtp-Source: AB8JxZrKA6Ob6FgwxO6fjijB6925MGHbJZANcUGla6+ItXcm+JjGCEc+H2StJq4CbIvcDOIC1PpUmA==
X-Received: by 2002:a63:384d:: with SMTP id h13-v6mr16291532pgn.209.1526922239218;
        Mon, 21 May 2018 10:03:59 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 16-v6sm31429429pfq.115.2018.05.21.10.03.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 May 2018 10:03:58 -0700 (PDT)
Date:   Mon, 21 May 2018 10:03:53 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: issues(?) installing git-lfs via fedora "dnf" command
Message-ID: <20180521170353.GA10623@aiede.svl.corp.google.com>
References: <alpine.LFD.2.21.1805210625410.6679@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1805210625410.6679@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert P. J. Day wrote:

>   $ sudo dnf install git-lfs
[...]
>   Running transaction
>     Preparing        :
>     Installing       : git-lfs-2.4.0-1.fc28.x86_64
>     Running scriptlet: git-lfs-2.4.0-1.fc28.x86_64
>   Error: Failed to call git rev-parse --git-dir --show-toplevel: "fatal:
>   not a git repository (or any of the parent directories): .git\n"
[...]
> is one supposed to be *in* a git repository when installing, because i
> was in fact at the top level of my linux kernel source repo, so i'm
> unclear on what that "Error" is trying to tell me. am i just being
> clueless? is this something that i should submit as a fedora packaging
> issue?

Yes, this looks like something that should be reported as a Fedora
packaging issue.

The packager should be able to find out whether it's an issue in
git-lfs upstream and report it to that project if it is.  Git-lfs is
not part of git.git; it's a separate project:
https://github.com/git-lfs/git-lfs/blob/master/CONTRIBUTING.md
I believe they use github's issue tracker to track bugs.

Thanks,
Jonathan
