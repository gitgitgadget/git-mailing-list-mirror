Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D93071F4B6
	for <e@80x24.org>; Mon,  1 Jul 2019 05:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfGAFYN (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 01:24:13 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:40102 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727193AbfGAFYN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 01:24:13 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1hhonQ-0002AM-7i
        for git@vger.kernel.org; Mon, 01 Jul 2019 14:24:08 +0900
Date:   Mon, 1 Jul 2019 14:24:08 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] git-cinnabar 0.5.2
Message-ID: <20190701052408.izz55nkoi7req64h@glandium.org>
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
https://github.com/glandium/git-cinnabar/releases/tag/0.5.2

What's new since 0.5.1?

- Updated git to 2.22.0 for the helper.
- cinnabarclone support is now enabled by default. See details in
  `README.md` and `mercurial/cinnabarclone.py`.
- cinnabarclone now supports grafted repositories.
- `git cinnabar fsck` now does incremental checks against last known
  good state.
- Avoid git cinnabar sometimes thinking the helper is not up-to-date
  when it is.
- Removing bookmarks on a Mercurial server is now working properly.

Mike
