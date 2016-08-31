Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CC9E1F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 09:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758992AbcHaJMc (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 05:12:32 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35556 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759169AbcHaJMa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 05:12:30 -0400
Received: by mail-wm0-f53.google.com with SMTP id w2so21691385wmd.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 02:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XIcokfIhfIKE9xagWFlrobgB3mM1CAp7JMbGQZBs5pA=;
        b=QPfl5UtmZp8xAZhCCbVcSgB35CVNZFw4I6fRxBGHkwBzT3Pq5dnj94RW6C1qBcOLEm
         dz0hYBBrz7EWc5NY3KgOuDyS+1Di8K3MJr8roMckKKbfHHC82PagbvdbB0+0hGgFrE3X
         zW8b+tVzpfmjZcjby2ZLZ4i2CqOh8Ei/XIlGolXfNfIiI4MsL4f+49MpJKmqDMkH4P1z
         +02RWKHI69EIyPyK+n54xB+bwP+Y7uIJBUyImoDbiFZ6z+yQ9vMgXnaOJbb7vW6EOi6S
         GMQZ32HOGZoBGpb9MdkX/HyJMNzCZt7LsJ2yRkA7LyFf8X1iqmX3iLc+v+1aX19uJssu
         W1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XIcokfIhfIKE9xagWFlrobgB3mM1CAp7JMbGQZBs5pA=;
        b=D1UuqqrYlkb7lQ16m0W+YKAby1jmxOB0Ygv6+z3lgNik1ef8ftph5uqFvTAGlfBEaK
         8/D3Da1kScoLDo6u8mLw997ImpE4NIAQPet4nqkmeiv7IOArJWFTBYCNl09TGVervAYP
         ZYDbLvLIUVfpMxoPzJkf5diLPEebbA8DzjnlHKcNk2+pz24ZMmNuYLl6H62V7KCkqz80
         vSyRfWfiSPI3VIwT9rmiHA4Onz1PIZL2jy84DAm1qCNJOYcRES5MsUF4t2uQdpgGB6HN
         8z0WTSwuI9Dt8W4pSQh/yGpt57s0mgPFMgQJc1BVhZHjd02YkWM09JBY85hKd+MxbX9u
         FmcA==
X-Gm-Message-State: AE9vXwPQXOPQEtlerKQI+cL7ToydCJv9u2v+f5ZuPgjMlu4/BbsH7aCvuh2HcaJKsLiH9g==
X-Received: by 10.194.89.228 with SMTP id br4mr7917887wjb.187.1472634748563;
        Wed, 31 Aug 2016 02:12:28 -0700 (PDT)
Received: from [10.42.1.91] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id p83sm7914376wma.18.2016.08.31.02.12.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 02:12:27 -0700 (PDT)
Message-ID: <1472634746.4265.47.camel@kaarsemaker.net>
Subject: Re: bug: 'core.logallrefupdates' is not set by default in non-bare
 repository
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     doak <doak@gmx.de>, "git@vger.kernel.org" <git@vger.kernel.org>
Date:   Wed, 31 Aug 2016 11:12:26 +0200
In-Reply-To: <c46d36ef-3c2e-374f-0f2e-ffe31104e023@gmx.de>
References: <c46d36ef-3c2e-374f-0f2e-ffe31104e023@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That is indeed a bug. git reads the config of t1 and then thinks a
template config has set that value, so it won't override it.

This is caused by git init reading the config via
get_shared_repository. The comment above it indicates that this may not
be needed, and indeed not doing it makes this bug go away.

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 3a45f0b..b2883a6 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -494,14 +494,6 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
        retry:
                if (chdir(argv[0]) < 0) {
                        if (!mkdir_tried) {
-                               int saved;
-                               /*
-                                * At this point we haven't read any configuration,
-                                * and we know shared_repository should always be 0;
-                                * but just in case we play safe.
-                                */
-                               saved = get_shared_repository();
-                               set_shared_repository(0);
                                switch (safe_create_leading_directories_const(argv[0])) {
                                case SCLD_OK:
                                case SCLD_PERMS:
@@ -513,7 +505,6 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
                                        die_errno(_("cannot mkdir %s"), argv[0]);
                                        break;
                                }
-                               set_shared_repository(saved);
                                if (mkdir(argv[0], 0777) < 0)
                                        die_errno(_("cannot mkdir %s"), argv[0]);
                                mkdir_tried = 1; 

On wo, 2016-08-31 at 10:09 +0200, doak wrote:
> Hi there,
> 
> If 'git init /path/to/repo' is called inside another repository with
> 'core.logallrefupdates' set to true, it will be not set by default in
> the created repository.
> This seems to be a bug.
> I am using Git v2.9.3 (Arch).
> 
> Steps to reproduce:
>     ---------------------
>     git init t1
>     cd t1
>     # 'core.logallrefupdates' will not be set for 't2'.
>     git init ../t2
>     ---------------------
> 
> Stated from 'git-config(1)':
>     ---------------------
>     core.logAllRefUpdates
>         [...]
>         This value is true by default in a repository that has a
> working directory associated with it, and false by default in a bare
> repository.
>     ---------------------
> 
> 
> With best regards,
> doak
> 
> 
