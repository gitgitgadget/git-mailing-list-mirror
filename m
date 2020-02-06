Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FA7C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679D420730
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgBFAYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 19:24:34 -0500
Received: from vuizook.err.no ([178.255.151.162]:39440 "EHLO vuizook.err.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbgBFAYe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 19:24:34 -0500
Received: from p576124-ipngn200707tokaisakaetozai.aichi.ocn.ne.jp ([122.31.139.124] helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1izUy6-0004Q8-0h
        for git@vger.kernel.org; Thu, 06 Feb 2020 00:24:31 +0000
Received: from glandium by goemon.lan with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1izUxy-0004Lz-Vk
        for git@vger.kernel.org; Thu, 06 Feb 2020 09:24:22 +0900
Date:   Thu, 6 Feb 2020 09:24:22 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] git-cinnabar 0.5.4
Message-ID: <20200206002422.3mvz3pshrn7ha6fs@glandium.org>
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

[Past or present git-cinnabar user? Please partake in this survey:
https://forms.gle/dpQZxYLKx2FZe9TVA]

Git-cinnabar is a git remote helper to interact with mercurial
repositories. It allows to clone, pull and push from/to mercurial remote
repositories, using git.

Code on https://github.com/glandium/git-cinnabar
This release is available on
https://github.com/glandium/git-cinnabar/releases/tag/0.5.4

What's new since 0.5.3?

- Windows helper is dynamically linked against libcurl again. Static linkage was causing more problems than it was fixing.
- Fix clonebundles support to ignore stream=v2 bundles.
- Ignore graft cinnabarclones when not grafting.
- Fixed a corner case where `git cinnabar fsck` would not skip files it was meant to skip and failed as a result.

Mike
