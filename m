Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF6DB1FC96
	for <e@80x24.org>; Sat, 26 Nov 2016 16:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbcKZQ4g (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Nov 2016 11:56:36 -0500
Received: from mail-wj0-f194.google.com ([209.85.210.194]:33050 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751721AbcKZQ4e (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2016 11:56:34 -0500
Received: by mail-wj0-f194.google.com with SMTP id kp2so8979147wjc.0
        for <git@vger.kernel.org>; Sat, 26 Nov 2016 08:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/daLnEqP2lRGs/qjjZ9iFCRV7i2OvUsATyVVc3Jkf6s=;
        b=LYzOITmYxsNJVtHp4Ece7gKqdR9x3cjny50eUBACG8SVUNzvjQyOjp+uT6gkkYmNTm
         X7tevjd9mtM10WbQy3DCBoFE+NE6/mJIqY4W2FyR86yiJD2Up31QviLc0lBr7RsWPnlQ
         cJgwrnr6nc5PUpePAl+EP3gJDz1300Uwk8HvdaG+t8xA0wCMY/WnvXXpzXWR+FqA/8z/
         HjgFMo/9SXaBCYbMSRN9QFGbilsiuVttdf7G8r1eUOmyHdvV9Cb06E+QgtU+mbdnhVqx
         gYaDMD9opaa2x2bHJlwLWxFYgx+LXGOPRE0OX0lpMnVS85ow2/Mvxw69PI8sCBKjh0Zj
         WIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/daLnEqP2lRGs/qjjZ9iFCRV7i2OvUsATyVVc3Jkf6s=;
        b=cKr7reTOQfRF/bEgNFWd7/JUUMu8YXsJgKm/NrJw+f6B17SBWwIaroTZDTBIwR6r1b
         U7S2T3RD/pQZha07mqPcr1nOrAZSeRDUVs32PvJRvhzW/fnoOHWEoWHi0yzcIPEW0Cvr
         xK3b9+0VoK5LU7Ly0N0N3ixYkJMHaVma3m0hDC0pa+q1xH3FXOFVqEZ+NTcszWyQ0F6h
         ok5A2eHrbmpnIB7G5zPd506n1i4GExGxqgubYh2jp2BHVfQSriWz4kBOhq1mP8+llC7P
         SvcvAzyCwYs40pxzMxK/psNza0cPLLZaueK/8eTVf6bJNkAySEGp9N1jw00mXbM/Blja
         1v4Q==
X-Gm-Message-State: AKaTC00nz+DmhpH5OjibvFIfj8dAqc00rf/e++B3uNkHjqgUry0GFl644t0HBE66lO5+dw==
X-Received: by 10.194.101.97 with SMTP id ff1mr13990488wjb.67.1480179393041;
        Sat, 26 Nov 2016 08:56:33 -0800 (PST)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id d65sm19380894wmh.11.2016.11.26.08.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Nov 2016 08:56:32 -0800 (PST)
Message-ID: <1480179391.10220.19.camel@kaarsemaker.net>
Subject: Re: git-daemon regression: 650c449250d7 common-main: call
 git_extract_argv0_path()
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Mike Galbraith <umgwanakikbuti@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Date:   Sat, 26 Nov 2016 17:56:31 +0100
In-Reply-To: <1480169028.3830.24.camel@gmail.com>
References: <1480169028.3830.24.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.0-2ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mike,

On Sat, 2016-11-26 at 15:03 +0100, Mike Galbraith wrote:
> Greetings,
> 
> git-daemon went broke on me post v2.9.3 due to binaries being installed
> in /usr/lib/git, which is not in PATH.  Reverting 650c449250d7 fixes it
> up, as does ln -s /usr/lib/git/git-daemon /usr/bin/git-daemon 'course,
> but thought I should report it, since it used to work without that.

I don't know how you usually install git, but git-daemon is not
supposed to be in $PATH, the correct way to invoke the git daemon is
'git daemon' not 'git-daemon'

Having all subcommands of git as separate binaries in your $PATH is an
ancient git.git practice that stopped being used/supported quite a
while ago.

I don't know why this patch broke that obsolete practice, but hopefully
this can help you forward.

D.
