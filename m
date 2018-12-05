Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7F62211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 18:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeLESoH (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 13:44:07 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38467 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeLESoH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 13:44:07 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so9411545pgc.5
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 10:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=V1zYLGcxCDe1EVyYzMpQQVFpomKIGmPU9jmrG/EVQMM=;
        b=GiwRASyT2eBMhhIWMw0hmA90G88kHzblNDCB21dLEaGycwVoWr/w9QRbIFk3H06lxu
         kF70b7OZGnQlDF1fnt90IyChjUwjeKmhTrwm3YxarIThLBiUjm5/quDLaj0TKJw0JIqx
         Y+zSvifQ9Fma4ZWTgS6QULFRiUXQaNzSaoCkEgcPwEjCumnYtNbwQjeqq3Nz7aR2qhCf
         mh80JQyEY0KUc5liyexG4kXg7NvqJylEjGtxqTk9NAxZU8gI1IgOL0SQD17KEK6HSOCU
         Zi62wtszLRQ+uwS+P7Rw/HZm9BiF+XLVyA6t2o/FHXilPuo4dUK1k1vNzXXGeuD6Eajn
         iMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=V1zYLGcxCDe1EVyYzMpQQVFpomKIGmPU9jmrG/EVQMM=;
        b=gXvSI7NIjk7t3mqCqlZsWna1impWdFvd02bxYQDeNjYGfpS1n2tp6LjIuXpoXCTK7A
         F4KX0ck5a27lzOpyKX4RrrmfqmqtB1D0IZf2V9VQIJXfP8r4LcDslB83wScBKzYTtcUg
         iHN/ZxurGFomaxORuwjjvr6OMhOFWi1Mlsw8dSHXKrDksn8ElIkPiEGW5Z0JSK59D29E
         I9kdYybbeSNiYiCHFIVAl84tgK53bER5JX8Gb3Un55ihNHwSGztqx2Y52s3NfKq3RskJ
         bhSh4e2n7zo011ohC4vrBmWUeC45w4/i5mmMrnAvoQlwjXld9yNDjUIwnmTzMr71nnJF
         2lcw==
X-Gm-Message-State: AA+aEWYRpxYq/bz2UW1ue1y9KMQzoArkf7BX9hmYbv85LLLWd/WESWJk
        9miBKxKPCrU8pxmjXNZEbK8=
X-Google-Smtp-Source: AFSGD/U6yTj84DfyIfE1gh72Y/m75zajZwD4uW0Hx3WQCT11J0x3P2u6ORq43ID/qFfaD/i9T1jrJw==
X-Received: by 2002:a63:151f:: with SMTP id v31mr21104469pgl.34.1544035446202;
        Wed, 05 Dec 2018 10:44:06 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id x2sm45230205pfx.78.2018.12.05.10.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 10:44:05 -0800 (PST)
Date:   Wed, 5 Dec 2018 10:44:04 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Martin Mares <mj@ucw.cz>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: gitweb: local configuration not found
Message-ID: <20181205184404.GC246451@google.com>
References: <154401401074.29584.11169979442731329694.reportbug@gimli.ms.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <154401401074.29584.11169979442731329694.reportbug@gimli.ms.mff.cuni.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Mares wrote[1]:

> After upgrade to Stretch, gitweb no longer finds the configuration file
> "gitweb_config.perl" in the current directory. However, "man gitweb" still
> mentions this as one of the possible locations of the config file (and
> indeed a useful one when using multiple instances of gitweb).
>
> It was probably broken by Perl dropping "." from the default search path
> for security reasons.

Indeed, perldelta(1) tells me that in 5.24.1 (and 5.26, etc),

  Core modules and tools no longer search "." for optional modules

gitweb.perl contains

 sub read_config_file {
         my $filename = shift;
         return unless defined $filename;
         # die if there are errors parsing config file
         if (-e $filename) {
                 do $filename;

which implies an @INC search but it is silly --- as the "-e" test
illustrates, this never intended to search @INC.

Documentation says "If you are absolutely certain that you want your
script to load and execute a file from the current directory, then use
a ./ prefix".  We can do that, like so:

diff --git i/gitweb/Makefile w/gitweb/Makefile
index cd194d057f..3160b6cc5d 100644
--- i/gitweb/Makefile
+++ w/gitweb/Makefile
@@ -18,7 +18,7 @@ RM ?= rm -f
 INSTALL ?= install
 
 # default configuration for gitweb
-GITWEB_CONFIG = gitweb_config.perl
+GITWEB_CONFIG = ./gitweb_config.perl
 GITWEB_CONFIG_SYSTEM = /etc/gitweb.conf
 GITWEB_CONFIG_COMMON = /etc/gitweb-common.conf
 GITWEB_HOME_LINK_STR = projects

but that does not help if someone overrides GITWEB_CONFIG, and besides,
it would be nicer to avoid the possibility of an @INC search altogether.
Another alternative would be to use

	local @INC = ('.');

Would that be better?

Advice from someone more versed than I am in perl would be very welcome
(hence the cc to Ævar).

Thanks for reporting and hope that helps,
Jonathan

[1] https://bugs.debian.org/915632
