Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37012202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 16:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbdJ2QOz (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 12:14:55 -0400
Received: from marcos.anarc.at ([206.248.172.91]:50706 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750929AbdJ2QOn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 12:14:43 -0400
X-Greylist: delayed 330 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Oct 2017 12:14:42 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id 37F361A00A8
From:   =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
To:     git@vger.kernel.org
Subject: [PATCH 0/4] WIP: git-remote-media wiki namespace support
Date:   Sun, 29 Oct 2017 12:08:53 -0400
Message-Id: <20171029160857.29460-1-anarcat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

For a few years now, work has been happening in a [GitHub issue] to
improve git's support for MediaWiki sites, which are implemented in
the contrib/mw-to-git/ module, mostly visible in the
git-remote-mediawiki command.

 [GitHub issue]: https://github.com/Git-Mediawiki/Git-Mediawiki/issues/10

This specific patchset adds support for namespaces in
MediaWiki. Without this, it is impossible to fetch pages outside the
"(Main)" namespace (e.g. Talk pages or "meta"). Namespaces are heavily
used on many wikis and this seems like an essential feature to have.

I have been hesitant in pushing those patches here because I know how
strict the git community is regarding patchsets and I was afraid they
would just get shot down, especially because there are no unit tests
for the new functionality. Obviously, doing unit tests against a full
MediaWiki instance isn't exactly trivial. Even though the contrib
module features a test suite and a way to install MediaWiki, I haven't
had the chance to test this yet, so unit tests are still missing. This
is the main reason why this is marked WIP.

I have tried to follow the patch submission guide, but I believe this
is my first Git patch, so please be gentle. Any review would be
greatly appreciated and I hope this can be eventually merged in. This
work is also available on GitHub:

https://github.com/anarcat/git/tree/mediawiki-namespaces

Thanks in advance,

A.

