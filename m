Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7885B2092F
	for <e@80x24.org>; Wed, 28 Dec 2016 13:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751675AbcL1NUp (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 08:20:45 -0500
Received: from forward17m.cmail.yandex.net ([5.255.216.148]:46380 "EHLO
        forward17m.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751626AbcL1NUo (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Dec 2016 08:20:44 -0500
X-Greylist: delayed 650 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Dec 2016 08:20:44 EST
Received: from mxback10j.mail.yandex.net (mxback10j.mail.yandex.net [5.45.198.24])
        by forward17m.cmail.yandex.net (Yandex) with ESMTP id 2C8B9220B1
        for <git@vger.kernel.org>; Wed, 28 Dec 2016 16:09:39 +0300 (MSK)
Received: from web15j.yandex.ru (web15j.yandex.ru [5.45.198.56])
        by mxback10j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id andPuyJdRh-9cUu2ZZO;
        Wed, 28 Dec 2016 16:09:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1482930578;
        bh=NduQ7flTmCKSFpOeZwlOBJXr9lWCNkgGXwkQX/9NQ7U=;
        h=From:To:Subject:Message-Id:Date;
        b=Flf+e8DXEXISXSVi/FvAdkaUjgDd/bNdj3m9i9nwP7KnBvRW7Jp1W85R8nrAiC1sV
         HurTxtE+Akn4P0cZQ1k2+dBmrwHSgjhWKVmn6Apcl0olBw/adpobkxgRdt4xUsGjF7
         JPpxWWYp8XcUQRHTtfeBPNgexzEWSKJWMwcUuLTg=
Authentication-Results: mxback10j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web15j.yandex.ru with HTTP;
        Wed, 28 Dec 2016 16:09:38 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.ua
To:     git <git@vger.kernel.org>
Subject: git mergetool Segmentation fault
MIME-Version: 1.0
Message-Id: <950881482930578@web15j.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 28 Dec 2016 15:09:38 +0200
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I suppose this is some bug. Because `Segmentation fault` is not expected in any case

http://stackoverflow.com/questions/41362676/how-to-resolve-merge-conflict-while-rebasing
