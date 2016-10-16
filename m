Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F283E2098B
	for <e@80x24.org>; Sun, 16 Oct 2016 12:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756103AbcJPMYa (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 08:24:30 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35675 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755896AbcJPMY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 08:24:28 -0400
Received: by mail-qk0-f174.google.com with SMTP id z190so197308934qkc.2
        for <git@vger.kernel.org>; Sun, 16 Oct 2016 05:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WMwMUTarYV+44gTfXPChTaZm/S7Wl6ndm3LgWhH4oEQ=;
        b=lcA4iuOnaKBaa4mpHSVSebDryz7sMgCkQaNVD2tE5isCoKfrBJ+xzmr0DD7HM52XWW
         N3Vb16ue3vmI4xkm6THL9QqCpgr0cIp8GMByBpTHTAqCKP1Wysk7NJKaTaNBqQWHthQL
         UlDWBoQIBcLqAxr2G9GVeAUYxqdLCHUIweuK/eCviHfHyBh4/Hy4V+m/PVkDh2N9lCG0
         R8bxx+ZuXxlFBcIG9U0kcKy2sqQy5r6GRYOoAPgLFXIEMg+Ym6A8otMf83bW/CEUBNfG
         TRhY5ZvpnQwkq9DXlVUa4ACTtbyo2gBgqKr5DRv8wjhqF2WRMm1rjkBHrAL28mpewzOL
         5arQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WMwMUTarYV+44gTfXPChTaZm/S7Wl6ndm3LgWhH4oEQ=;
        b=HD2SMrOKqDgpFEwW4UmDzX9ikzyTDyl1u4f3B/5iyBslhraZhrEz4FxYZAIrF/TRh4
         75HA1g+3SgdzmUGOcJ1s0xBVpzLSkMvFB6ZhuYoR2DjfK3N0OdG6DYEBLpVNxG8WOgCs
         6uptSGDzEpcwwYySdNlq30WqBVZgMKjdNddiNU9ixE9c//yJ4GfTjAZpDeoZlXzelqZ8
         0miZ7+GhPFvwat259H4wjHUQ+923Pnb0GiA1p/oWAAGMN4jzhlrXy/tOjeaqG9dg50PC
         bl7etZF7Ygd7bS+zhSxN1vg7BS/mA2j6cgqii+FSdI3ChKBitq9S2yFUEO7TMQ1dMS6t
         cdkA==
X-Gm-Message-State: AA6/9Rk3WMgtQKjvpn/3/bUOo/p9oTrBKFgfAZRRdKYGvpMJLvr7Fiasj/noRBrdd4Q08Wq96hk/VhIYsbKZ9A==
X-Received: by 10.55.107.198 with SMTP id g189mr18628097qkc.287.1476620635114;
 Sun, 16 Oct 2016 05:23:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.148.163 with HTTP; Sun, 16 Oct 2016 05:23:54 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sun, 16 Oct 2016 20:23:54 +0800
Message-ID: <CANYiYbEip5fu9gz24ts_xcPBfPRLMOBrhjfF9gjs=bZym1aizg@mail.gmail.com>
Subject: [GIT PULL] l10n updates for 2.10.0 maint branch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the following l10n updates for Git 2.10 to the maint branch.

The following changes since commit 9a4b694c539fead26833c2104c1a93d3a2b4c50a:

  l10n: zh_CN: review for git v2.10.0 l10n (2016-09-11 21:34:23 +0800)

are available in the git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.10.0-rnd2.4

for you to fetch changes up to 4dc2ce92fa170b797c850e0c17083bc376c01a85:

  Merge branch 'russian-l10n' of https://github.com/DJm00n/git-po-ru
(2016-10-16 20:11:41 +0800)

----------------------------------------------------------------
l10n-2.10.0-rnd2.4

----------------------------------------------------------------
Dimitriy Ryazantcev (1):
      l10n: ru.po: update Russian translation

Jiang Xin (1):
      Merge branch 'russian-l10n' of https://github.com/DJm00n/git-po-ru

Ralf Thielow (2):
      l10n: de.po: fix translation of autostash
      l10n: de.po: translate 260 new messages

 po/de.po | 5182 +++++++++++++++++++++++++++++++++-----------------------------
 po/ru.po |   52 +-
 2 files changed, 2815 insertions(+), 2419 deletions(-)

--
Jiang Xin
