Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E1B420A17
	for <e@80x24.org>; Wed, 18 Jan 2017 10:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752636AbdARKRc (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 05:17:32 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:52380 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752261AbdARKR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 05:17:28 -0500
Received: from glandium by mitsuha.glandium.org with local (Exim 4.88)
        (envelope-from <mh@glandium.org>)
        id 1cTmSG-00053c-SV
        for git@vger.kernel.org; Wed, 18 Jan 2017 18:22:56 +0900
Date:   Wed, 18 Jan 2017 18:22:56 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] git-cinnabar 0.4.0
Message-ID: <20170118092256.4p2fne5hf45a25p6@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20161126 (1.7.1)
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
https://github.com/glandium/git-cinnabar/releases/tag/0.4.0

What's new since 0.3.2?

- Various bug fixes.
- Updated git to 2.11.0 for cinnabar-helper.
- Now supports bundle2 for both fetch/clone and push
  (https://www.mercurial-scm.org/wiki/BundleFormat2).
- Now supports `git credential` for HTTP authentication.
- Now supports `git push --dry-run`.
- Added a new `git cinnabar fetch` command to fetch a specific revision
  that is not necessarily a head.
- Added a new `git cinnabar download` command to download a helper on
  platforms where one is available.
- Removed upgrade path from repositories used with version < 0.3.0.
- Experimental (and partial) support for using git-cinnabar without
  having mercurial installed.
- Use a mercurial subprocess to access local mercurial repositories.
- Cinnabar-helper now handles fast-import, with workarounds for
  performance issues on macOS.
- Fixed some corner cases involving empty files. This prevented cloning
  Mozilla's stylo incubator repository.
- Fixed some correctness issues in file parenting when pushing
  changesets pulled from one mercurial repository to another.
- Various improvements to the rules to build the helper.
- Experimental (and slow) support for pushing merges, with caveats. See
  https://github.com/glandium/git-cinnabar/issues/20 for details about
  the current status.
- Fail graft earlier when no commit was found to graft
- Allow graft to work with git version < 1.9
- Allow `git cinnabar bundle` to do the same grafting as git push

Mike
