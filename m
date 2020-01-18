Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C8DC33C9E
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 03:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE9324656
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 03:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbgARDDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 22:03:05 -0500
Received: from vuizook.err.no ([178.255.151.162]:49008 "EHLO vuizook.err.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgARDDE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 22:03:04 -0500
X-Greylist: delayed 926 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jan 2020 22:03:03 EST
Received: from p576124-ipngn200707tokaisakaetozai.aichi.ocn.ne.jp ([122.31.139.124] helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1ise98-0000Oj-K9
        for git@vger.kernel.org; Sat, 18 Jan 2020 02:47:35 +0000
Received: from glandium by goemon.lan with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1ise92-000Gul-J4
        for git@vger.kernel.org; Sat, 18 Jan 2020 11:47:28 +0900
Date:   Sat, 18 Jan 2020 11:47:28 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] git-cinnabar 0.5.3
Message-ID: <20200118024728.4dugot7nmj3tdkhx@glandium.org>
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
This release is available on
https://github.com/glandium/git-cinnabar/releases/tag/0.5.3

What's new since 0.5.2?

- Updated git to 2.25.0 for the helper.
- Fixed small memory leaks.
- Combinations of remote ref styles are now allowed.
- Added a `git cinnabar unbundle` command that allows to import a
  mercurial bundle.
- Experimental support for python >= 3.5.
- Fixed erroneous behavior of `git cinnabar {hg2git,git2gh}` with some
  forms of abbreviated SHA1s.
- Fixed handling of the `GIT_SSH` environment variable.
- Don't eliminate closed tips when they are the only head of a branch.
- Better handle manifests with double slashes created by `hg convert`
  from Mercurial < 2.0.1, and the following updates to those paths with
  normal Mercurial operations.
- Fix compatibility with Mercurial libraries >= 3.0, < 3.4.
- Windows helper is now statically linked against libcurl.

Mike
