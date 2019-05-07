Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 795921F45F
	for <e@80x24.org>; Tue,  7 May 2019 07:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfEGHK5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 03:10:57 -0400
Received: from mx1.volatile.bz ([185.163.46.97]:32801 "EHLO mx1.volatile.bz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbfEGHK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 03:10:57 -0400
X-Greylist: delayed 533 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 May 2019 03:10:56 EDT
Received: from clamav.local (unknown [198.18.45.2])
        by mx1.volatile.bz (Postfix) with ESMTPSA id BF7DC2A34
        for <git@vger.kernel.org>; Tue,  7 May 2019 07:00:36 +0000 (UTC)
Date:   Tue, 7 May 2019 07:00:28 +0000
From:   opal hart <opal@wowana.me>
To:     git@vger.kernel.org
Subject: Cannot access git-scm.com with Tor
Message-ID: <20190507070028.54c291af@clamav.local>
Organization: Volatile
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-alpine-linux-musl)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MC-Transport: 185.163.46.97 to 209.132.180.67 on Tue May  7 10:10:57 2019 +0300 (EEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I assume this community is at least slightly familiar with Tor and its
usefulness, so I'll cut to the chase. The Git website git-scm.com is
behind Cloudflare, which is currently configured to block suspicious
requests which unfortunately include Tor users. It would be greatly
appreciated to lower Cloudflare security settings to allow Tor users.
If the additional traffic really becomes an issue (I see the website
uses RoR backend [1]) then consider caching pages if that isn't already
done.

Ideally the use of Cloudflare would be avoided entirely, but
I will not get into the politics of that here. Being able to access the
static portions of the site behind Tor is enough for me currently.

[1]<https://github.com/git/git-scm.com>

Thanks,
-- 
wowaname <https://wowana.me/pgp>
