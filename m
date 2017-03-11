Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79124201C2
	for <e@80x24.org>; Sat, 11 Mar 2017 14:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932992AbdCKOwd (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Mar 2017 09:52:33 -0500
Received: from forward17h.cmail.yandex.net ([87.250.230.159]:54486 "EHLO
        forward17h.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753292AbdCKOwb (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 11 Mar 2017 09:52:31 -0500
Received: from mxback2m.mail.yandex.net (mxback2m.mail.yandex.net [IPv6:2a02:6b8:0:2519::10b])
        by forward17h.cmail.yandex.net (Yandex) with ESMTP id 873FD20F06
        for <git@vger.kernel.org>; Sat, 11 Mar 2017 17:52:25 +0300 (MSK)
Received: from web20g.yandex.ru (web20g.yandex.ru [95.108.253.229])
        by mxback2m.mail.yandex.net (nwsmtp/Yandex) with ESMTP id rgbklQn3MR-qPxCOtIq;
        Sat, 11 Mar 2017 17:52:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1489243945;
        bh=RpliORCXd5rJoEh/uInAi6cZ+xNIA4IKkQT2rSUdcVg=;
        h=From:To:Subject:Message-Id:Date;
        b=oY4wSBrH8rrEkIDylAAQsPwoM5UIIxKTueMUfe/sOfizYKcNYmVosLv4bw6Hda4/a
         9jvJR04MGMuzbxJbaU9nACUkJNZB1tG7cYD4drwKlj1iYkIYd55teizmyw3kRbLHh3
         Cpyt9mfkWAjhEezwIE2ucBgGQGfw98JHPP7THvN0=
Authentication-Results: mxback2m.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web20g.yandex.ru with HTTP;
        Sat, 11 Mar 2017 17:52:25 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.ua
To:     git <git@vger.kernel.org>
Subject: How to view diff when doing `git push --force`
MIME-Version: 1.0
Message-Id: <6962041489243945@web20g.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 11 Mar 2017 16:52:25 +0200
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi. I have done `git push --force` but I forget to `pull`, 


Counting objects: 7, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (7/7), done.
Writing objects: 100% (7/7), 765 bytes | 0 bytes/s, done.
Total 7 (delta 6), reused 0 (delta 0)
To xxxgit:cry/cry.git
 + 48e9058...117ee39 staging -> staging (forced update)

But I can not view diff:

git show 48e9058...117ee39
fatal: ambiguous argument '48e9058...117ee39': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'


May I pull info about changes that was deleted?
