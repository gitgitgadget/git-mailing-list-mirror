Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C74BF1F453
	for <e@80x24.org>; Wed,  1 May 2019 22:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfEAWaJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 18:30:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33030 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfEAWaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 18:30:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id k19so121020pgh.0
        for <git@vger.kernel.org>; Wed, 01 May 2019 15:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U6xdA3Jdb8bwWnGiUtj0AYLVxCpMtzYKDnFxA002kiI=;
        b=cvr+0Nw1nGyCjUEjVYUgaKnEgf8PK407l5d6iF0uEXDx8ees6f+/ee3FqQffAGAaPQ
         5vwAQkKA5SdUGAsT65NUKp5VAxBLyFYs1QhTdR1FklvBDAF13Tfx1sASlprMZop8i6LY
         3n4dzwTvep0SSbLHG1B/N9P1FMK30+dWgvj/xoiKn2E2bZbW5vOFV2b4Zt3ms36Gaoh/
         nbkj6QmE9X4bw66tw0cZDZfYCCFz1FzqifwUTAHN2w5lO/Sk7qky0oNoFIQ1e+3DADnR
         NU49Te2bsOCzxibDckDT11F5FwTxROQTNTl344lprSqgISPO7jdmq9Jal3/WlxljeYu9
         5P9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U6xdA3Jdb8bwWnGiUtj0AYLVxCpMtzYKDnFxA002kiI=;
        b=TMvy8+id2zYqNuD3AleC1qU33hCwEQnxoSk+oVd0oUKMw34U4kl7MDEuRJyaO/LZjb
         DilLT1L8f298Y+KzF2jPNuW55mQ9CcsxkeEUJPci+OYjFqaE4e1frDUm+Sn57KPxfJGp
         FijdKZumlZq0mqWMEjI0lxp5AWSALegsSyAmrKJEcc20gW+RFOJo4hkTd6xsvTzymqZS
         b9e9Woi/rWNVIyvbAkhP0Vd7x7izhbzCTBQd6i1VfHZFnBssq2XilL8vNQZj+FqoQMbs
         YSSYWCBP+TENbsBM4EsbzTNiOZ3ToFRh/svj4N995k8APx4w2TGDTTyJSpfTamnjyv4O
         T2BQ==
X-Gm-Message-State: APjAAAUQ1lute4EzzETgebtH7xqYNHGQbV6k18t729m6xhA9DbvulKJw
        vl8Fm0ZJN3Kn0C9sRVJmDTtUGoe7
X-Google-Smtp-Source: APXvYqzsg1H20vzMpKKRydhpPujMRWc+Jvi9/5L+vWHRKRi58m7DQ8snDRL69aHggPvKEl3NXYi/XQ==
X-Received: by 2002:a63:f809:: with SMTP id n9mr435823pgh.201.1556749808004;
        Wed, 01 May 2019 15:30:08 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id r5sm24512410pgv.52.2019.05.01.15.30.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 01 May 2019 15:30:07 -0700 (PDT)
Date:   Wed, 1 May 2019 15:30:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: install: gitweb.cgi was not found anywhere
Message-ID: <20190501223005.GB42435@google.com>
References: <CAH8yC8kec2N0fkt6cWChOEGtGkrOE5S+QuZnQnDP1eM9mg_EOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH8yC8kec2N0fkt6cWChOEGtGkrOE5S+QuZnQnDP1eM9mg_EOQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeffrey Walton wrote:

> I'm attempting to install Git 2.21.0 on Solaris 11.3 x86_64.
> /usr/gnu/bin is on-path.
[...]
> gmake -C gitweb install
> gmake[1]: Entering directory `/export/home/build/git-2.21.0/gitw
> eb'
> gmake[2]: Entering directory `/export/home/build/git-2.21.0'
> gmake[2]: `GIT-VERSION-FILE' is up to date.
> gmake[2]: Leaving directory `/export/home/build/git-2.21.0'
>     GEN gitweb.cgi
>     GEN static/gitweb.js
> install -d -m 755 '/usr/local/share/gitweb'
> directory /usr/local/share/gitweb created
> install -m 755 gitweb.cgi '/usr/local/share/gitweb'
> find: cycle detected for /lib/secure/32/
[...]
> install: gitweb.cgi was not found anywhere!

Sounds like it's using "install" when it should be using "ginstall".
config.mak.uname contains, under the SunOS category:

	INSTALL = /usr/ucb/install

But gitweb/Makefile seems to forget to include ../config.mak.uname.
How about this patch?

-- >8 --
Subject: gitweb: use system-appropriate defaults for commands

Attempting to install gitweb on Solaris 11 produces

 $ gmake install
...
 gmake -C gitweb install
 gmake[1]: Entering directory `/export/home/build/git-2.21.0/gitweb'
 gmake[2]: Entering directory `/export/home/build/git-2.21.0'
 gmake[2]: `GIT-VERSION-FILE' is up to date.
 gmake[2]: Leaving directory `/export/home/build/git-2.21.0'
     GEN gitweb.cgi
     GEN static/gitweb.js
 install -d -m 755 '/usr/local/share/gitweb'
 directory /usr/local/share/gitweb created
 install -m 755 gitweb.cgi '/usr/local/share/gitweb'
 find: cycle detected for /lib/secure/32/
 find: cycle detected for /lib/32/
 find: cycle detected for /lib/crypto/32/
...
 find: cycle detected for /usr/lib/gss/32/
 install: gitweb.cgi was not found anywhere!
 gmake[1]: *** [install] Error 2
 gmake[1]: Leaving directory `/export/home/build/git-2.21.0/gitweb'

This is because the default "install" tool on SunOS doesn't follow the
convention we require.  Use the /usr/ucb/install command specified in
config.mak.uname instead to fix it.

This should also help on other platforms where the default "install"
command is not functional enough.

Reported-by: Jeffrey Walton <noloader@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Completely untested.  Junio, please don't apply this without Jeffrey's
tested-by.

Thanks,
Jonathan

 gitweb/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index cd194d057f..333aa58be0 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -39,7 +39,7 @@ GITWEB_SITE_HEADER =
 GITWEB_SITE_FOOTER =
 HIGHLIGHT_BIN = highlight
 
-# include user config
+include ../config.mak.uname
 -include ../config.mak.autogen
 -include ../config.mak
 -include config.mak
-- 
2.21.0.1020.gf2820cf01a

