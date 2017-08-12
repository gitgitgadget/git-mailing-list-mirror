Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44B1D208B8
	for <e@80x24.org>; Sat, 12 Aug 2017 13:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750995AbdHLN32 (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 09:29:28 -0400
Received: from forward101o.mail.yandex.net ([37.140.190.181]:42480 "EHLO
        forward101o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750972AbdHLN31 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 Aug 2017 09:29:27 -0400
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Aug 2017 09:29:27 EDT
Received: from mxback1g.mail.yandex.net (mxback1g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:162])
        by forward101o.mail.yandex.net (Yandex) with ESMTP id E0FB113426D4
        for <git@vger.kernel.org>; Sat, 12 Aug 2017 16:22:08 +0300 (MSK)
Received: from web54o.yandex.ru (web54o.yandex.ru [95.108.205.234])
        by mxback1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id GRNDQbNPmC-M8bS2ntr;
        Sat, 12 Aug 2017 16:22:08 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1502544128;
        bh=ANUZ5N9QKzzqqYFT89vi93D72vhO4e4J8x6y6a2oo/M=;
        h=From:To:Subject:Message-Id:Date;
        b=VVVyaUnAq9NB50vl4uk1AlmWLV6zsrv0tgCWPofd1mMnES7omSHJ/jfZMXrz4f/oG
         +7I7qESHgRAN8O6LQMo/GSe2DMCMwgNf256lZRDzChEJMY40l9YP4ixxw7qLNiRsZO
         GM7z6amYXhw5vYmp6O8gFzaPkiPiPKrij8w+4o6g=
Authentication-Results: mxback1g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web54o.yandex.ru with HTTP;
        Sat, 12 Aug 2017 16:22:08 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.ua
To:     git <git@vger.kernel.org>
Subject: Error: Permition denied. git should not try to access root account if I work under common user
MIME-Version: 1.0
Message-Id: <273951502544128@web54o.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 12 Aug 2017 16:22:08 +0300
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi. 

When I use `git pull -v --rebase` command under user I got this error:

POST git-upload-pack (947 bytes)
POST git-upload-pack (452 bytes)
remote: warning: unable to access '/root/.config/git/attributes': Permission denied
remote: Counting objects: 4, done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 4 (delta 3), reused 0 (delta 0)
Unpacking objects: 100% (4/4), done.
From https://xxxx/gitdev/main
   b446c31..f275d62  master     -> origin/master
 = [up to date]      buy_dev    -> origin/buy_dev
Created autostash: 48d1246
HEAD is now at 3ecd306 Do not guard by default
Changes from b446c313d9a9caccfeb34ef2c521c4ac03c24c6e to f275d62585211806e8e0b2350bbf4f0f3025da79:
 conf/app.staging.conf | 1 +
 1 file changed, 1 insertion(+)
First, rewinding head to replay your work on top of it...
Applying: BUGFIX: Do not fall if we are creating new database
Applying: Do not pull data from server. Do not count all rows
Applying: Do not guard by default
Applied autostash.


git should not try to access root account if I work under common user
