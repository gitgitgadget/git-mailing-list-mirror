Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01F6C388F7
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 05:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D5E321534
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 05:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbgKLFhW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 00:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbgKLDMN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 22:12:13 -0500
X-Greylist: delayed 1643 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 Nov 2020 19:12:12 PST
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A99C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 19:12:12 -0800 (PST)
Received: from [2400:4160:1877:2b00:3472:c637:1199:61d] (helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1kd2bM-00089n-71
        for git@vger.kernel.org; Thu, 12 Nov 2020 02:44:44 +0000
Received: from glandium by goemon.lan with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1kd2bI-000Jka-2Q
        for git@vger.kernel.org; Thu, 12 Nov 2020 11:44:40 +0900
Date:   Thu, 12 Nov 2020 11:44:40 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] git-cinnabar 0.5.6
Message-ID: <20201112024440.firzkfuqesznqs35@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

[Past or present git-cinnabar user? Please partake in this survey:
https://forms.gle/dpQZxYLKx2FZe9TVA]

Git-cinnabar is a git remote helper to interact with mercurial
repositories. It allows to clone, pull and push from/to mercurial remote
repositories, using git.

Code on https://github.com/glandium/git-cinnabar
This release is available on
https://github.com/glandium/git-cinnabar/releases/tag/0.5.6

What's new since 0.5.5?

- Updated git to 2.29.2 for the helper.
- `git cinnabar git2hg` and `git cinnabar hg2git` now have a `--batch` flag.
- Fixed a few issues with experimental support for python 3.
- Fixed compatibility issues with mercurial >= 5.5.
- Avoid downloading unsupported clonebundles.
- Provide more resilience to network problems during bundle download.
- Prebuilt helper for Apple Silicon macos now available via `git cinnabar download`.

Mike

