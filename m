Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D0681FBB0
	for <e@80x24.org>; Tue, 29 Nov 2016 01:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751577AbcK2BBw (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 20:01:52 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:50530 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751282AbcK2BBv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 20:01:51 -0500
X-Greylist: delayed 2362 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Nov 2016 20:01:49 EST
Received: from glandium by zenigata with local (Exim 4.88)
        (envelope-from <mh@glandium.org>)
        id 1cBWBj-0007uU-Ma
        for git@vger.kernel.org; Tue, 29 Nov 2016 09:22:23 +0900
Date:   Tue, 29 Nov 2016 09:22:23 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] git-cinnabar 0.4.0 release candidate
Message-ID: <20161129002223.kicphqpyosfyz3im@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20161104 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git-cinnabar is a git remote helper to interact with mercurial
repositories. It allows to clone, pull and push from/to mercurial remote
repositories, using git.

Code on https://github.com/glandium/git-cinnabar
This release on
https://github.com/glandium/git-cinnabar/releases/tag/0.4.0rc

[ Previous announcements:
  http://marc.info/?l=git&m=146943537220142
  http://marc.info/?l=git&m=146762932928309
  http://marc.info/?l=git&m=146179749105388 (...)]

What's new since 0.4.0b3?

- Updated git to 2.10.2 for cinnabar-helper.
- Added a new `git cinnabar download` command to download a helper on
  platforms where one is available.
- Fixed some corner cases with pack windows in the helper. This prevented
  cloning mozilla-central with the helper.
- Fixed bundle2 support that broke cloning from a mercurial 4.0 server in
  some cases.
- Fixed some corner cases involving empty files. This prevented cloning
  Mozilla's stylo incubator repository.
- Fixed some correctness issues in file parenting when pushing changesets
  pulled from one mercurial repository to another.
- Various improvements to the rules to build the helper.
- Experimental (and slow) support for pushing merges, with caveats. See
  https://github.com/glandium/git-cinnabar/issues/20 for details about
  the current status. 

And since I realize I didn't announce beta 3:

What's new since 0.4.0b2?

- Properly handle bundle2 errors, avoiding git to believe a push
  happened when it didn't. (0.3.x is unaffected)

Mike
