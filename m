Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 443E91F45F
	for <e@80x24.org>; Wed,  8 May 2019 22:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbfEHWNT (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 18:13:19 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:40186 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbfEHWNT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 18:13:19 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1hOUoO-0007ce-8h
        for git@vger.kernel.org; Thu, 09 May 2019 07:13:16 +0900
Date:   Thu, 9 May 2019 07:13:16 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] git-cinnabar 0.5.1
Message-ID: <20190508221316.otsflud4qlcpwaeb@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
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
https://github.com/glandium/git-cinnabar/releases/tag/0.5.1

What's new since 0.5.0?

- Updated git to 2.21.0 for the helper.
- Experimental native mercurial support (used when mercurial libraries are not available) now has feature parity.
- Try to read the git system config from the same place as git does. This fixes native HTTPS support with Git on Windows.
- Avoid pushing more commits than necessary in some corner cases (see e.g. https://bugzilla.mozilla.org/show_bug.cgi?id=1529360).
- Added an --abbrev argument for `git cinnabar {git2hg,hg2git}` to display shortened sha1s.
- Can now pass multiple revisions to `git cinnabar fetch`.
- Don't require the requests python module for `git cinnabar download`.
- Fixed `git cinnabar fsck` file checks to actually report errors.
- Properly return an error code from `git cinnabar rollback`.
- Track last fsck'ed metadata and allow `git cinnabar rollback --fsck` to go back to last known good metadata directly.
- `git cinnabar reclone` can now be rolled back.
- Added support for git bundles as cinnabarclone source.
- Added alternate styles of remote refs.
- More resilient to interruptions when HTTP Range requests are supported.
- Fixed off-by-one when storing mercurial heads.
- Better handling of mercurial branchmap tips.
- Better support for end of parts in bundle v2.
- Improvements handling urls to local mercurial repositories.
- Fixed compatibility with (very) old mercurial servers when using mercurial 5.0 libraries.
- Converted Continuous Integration scripts to Python 3.

Mike
