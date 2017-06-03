Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4E23209FD
	for <e@80x24.org>; Sat,  3 Jun 2017 22:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbdFCWfZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Jun 2017 18:35:25 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:40314 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751162AbdFCWfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2017 18:35:25 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.89)
        (envelope-from <mh@glandium.org>)
        id 1dHHdg-0003iA-I6
        for git@vger.kernel.org; Sun, 04 Jun 2017 07:35:20 +0900
Date:   Sun, 4 Jun 2017 07:35:20 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] git-cinnabar 0.5.0b1
Message-ID: <20170603223520.wlf6xmo3jnn5ldvn@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20170306 (1.8.0)
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
https://github.com/glandium/git-cinnabar/releases/tag/0.5.0b1

What's new since 0.4.0?

- git-cinnabar-helper is now mandatory. You can either download one with
  `git cinnabar download` on supported platforms or build one with `make
  helper`.
- Metadata changes require to run `git cinnabar fsck`.
- Mercurial tags are consolidated in a separate (fake) repository. See
  the README file.
- Updated git to 2.13.0 for git-cinnabar-helper.
- Improved memory consumption and performance.
- Improved experimental support for pushing merges.
- Experimental support for clonebundles
  (https://www.mercurial-scm.org/wiki/ClonebundlesExtension).
- Removed support for the .git/hgrc file for mercurial specific
  configuration.
- Support any version of Git (was previously limited to 1.8.5 minimum)

Mike
