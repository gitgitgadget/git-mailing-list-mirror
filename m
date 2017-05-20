Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 718A42023D
	for <e@80x24.org>; Sat, 20 May 2017 01:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755335AbdETB3z (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 21:29:55 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33710 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755281AbdETB3z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 21:29:55 -0400
Received: by mail-qk0-f176.google.com with SMTP id y201so73938026qka.0
        for <git@vger.kernel.org>; Fri, 19 May 2017 18:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3De1rIiXizv/B9QuqTLOi1IRIDGHHY6oRzF38mUqk6U=;
        b=iYE4srb/VCRYqeimBKz/0thRZ7nQwvUX5I7T7LiST57ywJMTbpTJmieVlc9Lv3bAdT
         qZmsr5YPqqJLrb7GYIot7Sz0Q9y6GosZghSN/rradX8NWkpoWPqfDpXLwe1bEzfB4Gk4
         dKqWtRZCo54hsO3QdbG79CuLzWui3hbrdkCjH7cAEm7rxfcYI5vR8t0g9B93qUj4DOk2
         dRQr1rV3WCW7GgME3AZ4dH1qHiLIJ04lzkHohCe1bGBCLJ2HmRph0H3D5tEA+bzWmLgO
         yruqqUw0bWgUH76Ut5CpBk4XdR4e9UGZizwVbREfzuoiMCFmC33+owYJu1plsYW7JDBM
         BREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3De1rIiXizv/B9QuqTLOi1IRIDGHHY6oRzF38mUqk6U=;
        b=DxFvyqMSixD0JN1kTcHNd2EZfVlPxZwKPKUlnJHQksuVNjsNaLqzQjNiR79s1T/nGQ
         PB+sG5AMnpkEXPID3bRXPQr8bR1QC/8wd0K7RQBV60CNCMfONBwvFajGO7XtO/GIN8PK
         6ca83qZmrA6rEMhXbqaza+oIEbv9gDgmeNNYeJI34d0DqwlSl+zoUeF1UizYXrGvuq5n
         E8chePDdU0wgOKfDS5NL6qXLGnEU9kAfpmuosJdjyySvvvWrxlU7fMJ5kbhxiGFHN5rO
         zhFMG7D1BpuTmTCyeFui9yUVAMaXA6/V0ItHcrBpytiBpRGYfjXgijqMzzRdwF8q7prI
         idoQ==
X-Gm-Message-State: AODbwcC3Meuav//U2dYsD+5fI5tKGsBHt4pw52veS2ZII7TLySY/ctxq
        cJvFcQyTfIV+PQ==
X-Received: by 10.55.204.16 with SMTP id r16mr12237372qki.169.1495243794043;
        Fri, 19 May 2017 18:29:54 -0700 (PDT)
Received: from zaya.teonanacatl.net (pool-71-113-173-254.hrbgpa.fios.verizon.net. [71.113.173.254])
        by smtp.gmail.com with ESMTPSA id s32sm6994527qtg.2.2017.05.19.18.29.52
        (version=TLS1_1 cipher=AES128-SHA bits=128/128);
        Fri, 19 May 2017 18:29:52 -0700 (PDT)
Date:   Fri, 19 May 2017 21:29:50 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Caleb Evans <caleb@calebevans.me>
Cc:     git <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Git log.decorate can't be overridden in global config (v2.13.0)
Message-ID: <20170520012950.GC25542@zaya.teonanacatl.net>
References: <15c2318a2c4.1100a44f3621653.6175207833450352995@calebevans.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <15c2318a2c4.1100a44f3621653.6175207833450352995@calebevans.me>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Caleb,

Caleb Evans wrote:
> I recently updated to Git v2.13.0 (macOS Sierra via Homebrew), and I 
> noticed that the default --decorate option for `git log` has changed 
> from --decorate=no to --decorate=auto. I'd prefer to keep decoration 
> disabled to minimize clutter in the logs, so I try disabling it in 
> my global .gitconfig (~/.gitconfig) like so:
>
> git config --global log.decorate none
>
> However, this does not seem to disable the log decorations. Running 
> `git log` again still shows the decorations. Strangely, running `git 
> config log.decorate none` does seem to disable decoration, but I 
> would prefer not to do this on a per-repository basis. I can only 
> suspect that this is a Git bug, as my log.decorate global config 
> setting is not being honored. I have already confirmed that my 
> repository's .git/config is not overriding my global preference.
>
> I hope this should be a simple issue, but please let me know if you 
> have questions.

I believe a patch for this is on the ah/log-decorate-default-to-auto 
branch, courtesy of Brian Carlson (Cc:d):

    https://github.com/gitster/git/commit/c74271aae7

The relevant list thread is here:

    https://public-inbox.org/git/20170512213407.46251-1-sandals@crustytoothpaste.net/

Cheers,

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Ambition is a poor excuse for not having enough sense to be lazy.

