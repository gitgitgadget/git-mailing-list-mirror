Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E6CC6FA8F
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 16:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238164AbjHXQjl convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 24 Aug 2023 12:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238033AbjHXQje (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 12:39:34 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7498E1700
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 09:39:26 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 034181C000A;
        Thu, 24 Aug 2023 16:39:23 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mark Levedahl <mlevedahl@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org
Subject: [GIT PULL] git-gui pull request; also, call for a new maintainer 
Date:   Thu, 24 Aug 2023 18:39:23 +0200
Message-ID: <mafs0wmxkcs3o.fsf@yadavpratyush.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-GND-Sasl: me@yadavpratyush.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Junio, all,

It has been some time since we synced our trees. This PR contains fixes
for CVE-2022-41953, follow up fixes for bugs uncovered in
Cygwin-specific bits, and some other minor fixes.

As you and others might have noticed already, I have been quite inactive
in maintaining git-gui. There are several reasons for that. For one, I
do not find much time and energy for it amongst my responsibilities both
in work and in personal life. For another, I simply do not use git-gui
much these days. I use good old Magit for the most part, and it fares
fairly well.

For these reasons, I would be happy to hand over maintainership of
git-gui to more interested hands. I do not know of anyone myself. But I
hope this email finds itself to someone who would be willing to
volunteer.

In the meantime, I can still pick up odd fixes or security fixes every
now and then. I cannot promise much more than this.

---
The following changes since commit df4f9e28f64ea97032ec70d9c8894dc87a1b7f9e:

  Merge branch 'py/revert-commit-comments' (2021-03-04 13:59:45 +0530)

are available in the Git repository at:

  https://github.com/prati0100/git-gui.git 

for you to fetch changes up to e25cbdf3576f07bda742a4f13d9380a815e43502:

  Merge branch 'ml/cygwin-fixes' (2023-08-24 16:46:29 +0200)

----------------------------------------------------------------
Johannes Schindelin (5):
      windows: ignore empty `PATH` elements
      is_Cygwin: avoid `exec`ing anything
      Move is_<platform> functions to the beginning
      Move the `_which` function (almost) to the top
      Work around Tcl's default `PATH` lookup

Mark Levedahl (4):
      git gui Makefile - remove Cygwin modifications
      git-gui - remove obsolete Cygwin specific code
      git-gui - use cygstart to browse on Cygwin
      git-gui - use mkshortcut on Cygwin

Pratyush Yadav (4):
      Merge branch 'vk/readme-typo'
      Merge branch 'js/windows-rce'
      Merge branch 'ab/makeflags'
      Merge branch 'ml/cygwin-fixes'

Vipul Kumar (1):
      git-gui: Fix a typo in README

Ævar Arnfjörð Bjarmason (1):
      Makefiles: change search through $(MAKEFLAGS) for GNU make 4.4

 Makefile                  |  23 +---
 README.md                 |   2 +-
 git-gui.sh                | 309 ++++++++++++++++++++--------------------------
 lib/choose_repository.tcl |  27 +---
 lib/shortcut.tcl          |  31 +++--
 5 files changed, 154 insertions(+), 238 deletions(-)

-- 
Regards,
Pratyush Yadav
