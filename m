Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA62720281
	for <e@80x24.org>; Thu,  2 Nov 2017 18:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933921AbdKBSzf (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 14:55:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:48380 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932571AbdKBSze (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 14:55:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id p75so888770wmg.3
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 11:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HPHon2mUcRmh7Jnp3/Jm6baC4/D6vxJyi1f4xjnxiD8=;
        b=ySxaBgFF+5V6a0CUFpcdDZiG16QUb/H0VP8UVIC2pOnotqArgXlxuHOd05yW5LCT28
         j+xmdgCdLSw5b/pNvst55Bu5PZiV10hxehYNOYSt2caTxsTLrWJ++trIfbm99k8NUpPU
         m0e+EZWI8jFfmVIX9GKT0ruvjj+VPhJmCjxMR5zCwYbK1dN4Y/iyOvdOCFh6p9hLexCU
         PE4XndcYLjrXPbLSv2NqstV/IqYtFiAYXm6Cl95gMtGrkU9H8owYhA1W4Dz59pSrdpdq
         /eb6K+zI5ydUroqUY1uWRQEPNRWq5S8GtgqvqFX2JJb/mhtkaBm2YSf0sS2bQlugQB2+
         p1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HPHon2mUcRmh7Jnp3/Jm6baC4/D6vxJyi1f4xjnxiD8=;
        b=h/RZxsLTqCphiMbPUc2XCi3iip/7zsgugmsIUPvfpc4iZckTbwK727Uf2bZo450413
         zCT2NL6S6bWPxFqwc0Yun6UG7oGJBkH3uaO02LNZmRdT7qRRlahCJZQ11grZBH42rGvU
         rDhTEYXFciVKfu3qRE0yjf9x75JW4yqWVcp4IedaPaWndjn8GK6KN60DTWTgxkjoeSG9
         H4354Et+StpCU+U2MtsHYsuB/ODDLh39scU8A7KdsmQfag67TCuBJQ08wer7mxDn69pi
         u6NKgLpE5JUEB+m+PPfRFIYauEHbE/mSYc89BJ+6PIcTVs910Ncbm5wKzUjR03InXxIb
         ffEw==
X-Gm-Message-State: AMCzsaWNOnwS5/2rRbjfY48XFkP94VSx112qwUs99R9Wd0e8pNsefZdO
        V3vDIL2gU1yXXxZgpEJqJaFRXNwR8w==
X-Google-Smtp-Source: ABhQp+TW5JUamNyii/CQcboZLXJOrPmEKZA4gJika5fbrg38G8flAQxoN2AJ1z4xA5TgPeEeFRR6bg==
X-Received: by 10.80.181.27 with SMTP id y27mr5460594edd.297.1509648933286;
        Thu, 02 Nov 2017 11:55:33 -0700 (PDT)
Received: from starfire ([145.129.9.233])
        by smtp.gmail.com with ESMTPSA id d12sm2756999edh.40.2017.11.02.11.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Nov 2017 11:55:32 -0700 (PDT)
Message-ID: <1509648929.1838.1.camel@kaarsemaker.net>
Subject: Re: Git libsecret No Unlock Dialog Issue
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Stefan Beller <sbeller@google.com>,
        Yaroslav Sapozhnyk <yaroslav.sapozhnik@gmail.com>
Cc:     git <git@vger.kernel.org>
Date:   Thu, 02 Nov 2017 19:55:29 +0100
In-Reply-To: <CAGZ79kaDB+nnTZVw-7msVa12RQa3sHn_zFKQ2-5i2eosuHutxQ@mail.gmail.com>
References: <CAOAxMp-vAM7mCWuanj69coM09zF-Sxe=G=-XMd_RmaAne8qFvw@mail.gmail.com>
         <CAGZ79kaDB+nnTZVw-7msVa12RQa3sHn_zFKQ2-5i2eosuHutxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-11-02 at 11:35 -0700, Stefan Beller wrote:
> On Thu, Nov 2, 2017 at 9:00 AM, Yaroslav Sapozhnyk
> <yaroslav.sapozhnik@gmail.com> wrote:
> > When using Git on Fedora with locked password store
> > credential-libsecret asks for username/password instead of displaying
> > the unlock dialog.
> 
> Git as packaged by Fedora or upstream Git (which version)?

Looking at the code: current upstream git. Looking at the documentation
for libsecret, this should fix it. I've not been able to test it
though.

diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/contrib/credential/libsecret/git-credential-libsecret.c
index 4c56979d8a..b4750c9ee8 100644
--- a/contrib/credential/libsecret/git-credential-libsecret.c
+++ b/contrib/credential/libsecret/git-credential-libsecret.c
@@ -104,7 +104,7 @@ static int keyring_get(struct credential *c)
        items = secret_service_search_sync(service,
                                           SECRET_SCHEMA_COMPAT_NETWORK,
                                           attributes,
-                                          SECRET_SEARCH_LOAD_SECRETS,
+                                          SECRET_SEARCH_LOAD_SECRETS | SECRET_SEARCH_UNLOCK,
                                           NULL,
                                           &error);
        g_hash_table_unref(attributes);
