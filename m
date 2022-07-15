Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271BAC43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 22:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiGOWmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 18:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiGOWmd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 18:42:33 -0400
X-Greylist: delayed 1656 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Jul 2022 15:42:30 PDT
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B4176970
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 15:42:30 -0700 (PDT)
Received: from [2400:4160:1877:2b00:4d6d:c6d0:3cc9:8e10] (helo=glandium.org)
        by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1oCTaB-001Y1y-HY
        for git@vger.kernel.org; Fri, 15 Jul 2022 22:14:50 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1oCTa6-006pwC-9Y
        for git@vger.kernel.org; Sat, 16 Jul 2022 07:14:42 +0900
Date:   Sat, 16 Jul 2022 07:14:42 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] git-cinnabar 0.5.9
Message-ID: <20220715221442.tp7xg6oszb5vl3ci@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git-cinnabar is a git remote helper to interact with mercurial
repositories. It allows to clone, pull and push from/to mercurial remote
repositories, using git.

Code on https://github.com/glandium/git-cinnabar
This release is available on
https://github.com/glandium/git-cinnabar/releases/tag/0.5.9

What's new since 0.5.8?

- Updated git to 2.37.1 for the helper.
- Various python 3 fixes.
- Fixed stream bundle
- Added `python` and `py.exe` as executables tried on top of `python3` and
  `python2`.
- Improved handling of ill-formed local urls.
- Fixed using old mercurial libraries that don't support bundlev2 with a server
  that does.
- When fsck reports the metadata as broken, prevent further updates to the repo.
- When issue #207 is detected, mark the metadata as broken
- Added support for logging redirection to a file
- Now ignore refs/cinnabar/replace/ refs, and always use the corresponding
  metadata instead.
- Various `git cinnabar fsck` fixes.

Mike
