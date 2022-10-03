Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D8EC433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 00:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJDAoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 20:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJDAoL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 20:44:11 -0400
X-Greylist: delayed 2738 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Oct 2022 17:44:09 PDT
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663972AC73
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 17:44:09 -0700 (PDT)
Received: from [2400:4160:1877:2b00:14b0:8139:a14f:79f8] (helo=glandium.org)
        by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <mh@glandium.org>)
        id 1ofVKM-00AIOL-0Z
        for git@vger.kernel.org;
        Mon, 03 Oct 2022 23:58:28 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1ofVKG-006viz-0u
        for git@vger.kernel.org; Tue, 04 Oct 2022 08:58:20 +0900
Date:   Tue, 4 Oct 2022 08:58:20 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] git-cinnabar 0.6.0rc1
Message-ID: <20221003235820.6h4cgsxcjnbniekd@glandium.org>
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
https://github.com/glandium/git-cinnabar/releases/tag/0.6.0rc1

What's new since 0.5.10?

- Full rewrite of git-cinnabar in Rust.
- Push performance is between twice and 10 times faster than 0.5.x,
  depending on scenarios.
- Based on git 2.38.0.
- `git cinnabar fetch` now accepts a `--tags` flag to fetch tags.
- `git cinnabar bundle` now accepts a `-t` flag to give a specific
  bundlespec.
- `git cinnabar rollback` now accepts a `--candidates` flag to list the
  metadata sha1 that can be used as target of the rollback.
- `git cinnabar rollback` now also accepts a `--force` flag to allow
  any commit sha1 as metadata.
- `git cinnabar` now has a `self-update` subcommand that upgrades it
  when a new version is available. The subcommand is only available
  when building with the `self-update` feature (enabled on prebuilt
  versions of git-cinnabar).

Mike
