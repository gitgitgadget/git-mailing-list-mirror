Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 495BC203C1
	for <e@80x24.org>; Mon, 25 Jul 2016 08:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbcGYI30 (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 04:29:26 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:55374 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752433AbcGYI30 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 04:29:26 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1bRbGK-00018M-A2
	for git@vger.kernel.org; Mon, 25 Jul 2016 17:29:20 +0900
Date:	Mon, 25 Jul 2016 17:29:20 +0900
From:	Mike Hommey <mh@glandium.org>
To:	git@vger.kernel.org
Subject: [ANNOUNCE] git-cinnabar 0.4.0 beta 2
Message-ID: <20160725082920.bmdzddgydwsinfws@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.1-neo (2016-06-11)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Git-cinnabar is a git remote helper to interact with mercurial
repositories. It allows to clone, pull and push from/to mercurial remote
repositories, using git.

Code on https://github.com/glandium/git-cinnabar
This release on
https://github.com/glandium/git-cinnabar/releases/tag/0.4.0b2

[ Previous announcements:
  http://marc.info/?l=git&m=146762932928309
  http://marc.info/?l=git&m=146179749105388
  http://marc.info/?l=git&m=145294370431454
  http://marc.info/?l=git&m=145284823007354
  http://marc.info/?l=git&m=142837367709781 (...)]

What's new since 0.4.0b1?

- Some more bug fixes.
- Updated git to 2.9.2 for cinnabar-helper.
- Now supports `git push --dry-run`.
- Added a new `git cinnabar fetch` command to fetch a specific revision
  that is not necessarily a head.
- Some improvements to the experimental native wire protocol support.

Mike
