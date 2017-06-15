Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D830B20D1F
	for <e@80x24.org>; Thu, 15 Jun 2017 23:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752516AbdFOXQk (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 19:16:40 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:52994 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750899AbdFOXQj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 19:16:39 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.89)
        (envelope-from <mh@glandium.org>)
        id 1dLe0B-0003I2-C9
        for git@vger.kernel.org; Fri, 16 Jun 2017 08:16:35 +0900
Date:   Fri, 16 Jun 2017 08:16:35 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] git-cinnabar 0.5.0b2
Message-ID: <20170615231635.zuclgeenqarlobip@glandium.org>
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
https://github.com/glandium/git-cinnabar/releases/tag/0.5.0b2

What's new since 0.5.0 beta 1?

- Enabled support for clonebundles (https://www.mercurial-scm.org/wiki/ClonebundlesExtension) for faster clones when the server provides them.
- Git packs created by git-cinnabar are now smaller.
- Added a new `git cinnabar upgrade` command to handle metadata
  upgrade separately from `fsck`.
- Metadata upgrade is now significantly faster.
- `git cinnabar fsck` also faster.
- Both now also use significantly less memory.
- Updated git to 2.13.1 for git-cinnabar-helper.

Mike
