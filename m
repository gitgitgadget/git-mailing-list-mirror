Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BB071FF6D
	for <e@80x24.org>; Tue, 20 Dec 2016 08:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753733AbcLTIru (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 03:47:50 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:55154 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752772AbcLTIrt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 03:47:49 -0500
Received: from glandium by mitsuha.glandium.org with local (Exim 4.88)
        (envelope-from <mh@glandium.org>)
        id 1cJG5I-0003Zy-Nx
        for git@vger.kernel.org; Tue, 20 Dec 2016 17:47:44 +0900
Date:   Tue, 20 Dec 2016 17:47:44 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] git-cinnabar 0.4.0 release candidate 2
Message-ID: <20161220084744.xdy2vwvoyudsubqn@glandium.org>
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
https://github.com/glandium/git-cinnabar/releases/tag/0.4.0rc2

[ Previous announcements:
  http://marc.info/?l=git&m=148038131415810
  http://marc.info/?l=git&m=146943537220142
  http://marc.info/?l=git&m=146762932928309 (...)]

What's new since 0.4.0rc?

- /!\ Warning /!\ If you have been using a version of the `release`
  branch between 0.4.0rc and 0.4.0rc2 (more precisely, in the range
  0335aa1432bdb0a8b5bdbefa98f7c2cd95fc72d2^..0.4.0rc2^), *and* used `git
  cinnabar download` *and* run on Mac or Windows, please ensure your
  mercurial clones have not been corrupted by case-sensitivity issues by
  running `git cinnabar fsck --manifests`.  If they contain sha1
  mismatches, please reclone.

- Updated git to 2.11.0 for cinnabar-helper
- Improvements to the `git cinnabar download` command
- Various small code cleanups
- Improvement to the experimental support for pushing merges.

Mike
