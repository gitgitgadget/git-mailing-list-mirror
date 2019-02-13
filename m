Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 958B71F453
	for <e@80x24.org>; Wed, 13 Feb 2019 18:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbfBMSUR (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 13:20:17 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:46020 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbfBMSUR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 13:20:17 -0500
Received: by mail-ot1-f50.google.com with SMTP id 32so5853241ota.12
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 10:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=b6nGohsIBYulSaLpQNR0/YxCISzXxh7ha0i6ZyLHYwI=;
        b=obgaTMXdxnBbprVDjvyzhpQPwE6dJ+upuaUV4HHc38znUM03/2tPx3mAXA2TNPLNnk
         R+Mx315NZpGEbbwIdaaESzpnm2E4nDwJWsGeDgqAMW/jcP51GtB1UwEOmgNXvRmGcNvB
         2porRCsHp/rOn7pbSsNyg+K7eR4FMxtuqBGSvbiXa1MCD8UOyzLEKJM8m7O8BFNBTtm6
         BPi5seg/zibp27hFfddunANVusRh6/X85Vv8ctzZJSM+YUnl7FSnkMDcbVIUUe3TmLf8
         /YyySmfTAh1imPidXJvr8lIdeKjmD1BLNFuyTItQQK9Bg0MOfSt4UEUy4uBiB01em7lx
         btvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=b6nGohsIBYulSaLpQNR0/YxCISzXxh7ha0i6ZyLHYwI=;
        b=HRGfxQlQZFkmt7a4LDPcVNMe+yxuPwkB1Qoa+39lO0G7ou2JLKR0/lOBZWq5K16yLW
         L8wH+ThDJZ5GPK2LUyDTGaYF0y6crvy2EMaafdUHr3q+PjZsBPgWacKuJ68EbHFlasCv
         k3IFDQalRZeOugJG0x8A/mrzlraIZZGKZ/UF6yZ++8eUjUeyVRbIfbYh/2UHw7S/yY0Z
         bVvLTCCJ+7m9lTnK1v7HFr2bK2YrQTE0X83Wq2zhwp75v/xMFQDN63TOE9ancXoM5j4q
         8JUH2LgwLCaUCzw5Kc2dJ26wyyisHxjcGTpaiucj9tPmw7yPeMljyEc5fPLmMrUdGhan
         E+Qg==
X-Gm-Message-State: AHQUAuZtLal7q7FvZkXM9CwWvuihjKvlxZjqnfreQvDGeG7zD3DyT/LI
        MLX1CTtZvFwTGQ+zquxBlLYWbZKvfbUddwlapTQyoh7m
X-Google-Smtp-Source: AHgI3IZBfMv+lIkpbvHu151ZxmZ+eswXwcXL3BLpfIpHGa+1m4yxd60QibiwBlvQPr5uHgjFyw9Zuz/bhQx89mPkKvA=
X-Received: by 2002:aca:4506:: with SMTP id s6mr1014947oia.115.1550081600823;
 Wed, 13 Feb 2019 10:13:20 -0800 (PST)
MIME-Version: 1.0
From:   Maris Razvan <razvan.alex.maris@gmail.com>
Date:   Wed, 13 Feb 2019 20:13:09 +0200
Message-ID: <CALZbgSSzpd7bDWE1iyfqAsv9oovsSK22oReDiPGG-Td5D2qgaA@mail.gmail.com>
Subject: Git-pull Documentation
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

In the "EXAMPLES" section of the git-pull documentation
(https://git-scm.com/docs/git-pull#_examples) there is the following:

    "[...] Merge into the current branch the remote branch next:

    $ git pull origin next

    This leaves a copy of next temporarily in FETCH_HEAD, but does not
update any remote-
    tracking branches. [...]"

However, the second bullet-point in the "CONFIGURED REMOTE-TRACKING
BRANCHES" section of the git-fetch documentation
(https://git-scm.com/docs/git-fetch#_configured_remote_tracking_branches_a_id_crtb_a)
states that it is possible for a command of the form "git fetch
<remote> <branch>" to update a remote-tracking branch.

I checked and the current behaviour of "git pull <remote> <branch>" is
to update the remote-tracking branch if required, because, as I have
seen in the code, it just calls "git fetch".

I believe that the quoted example from the git-pull documentation is wrong.

Also, in the beginning of the git-pull documentation there is the
following paragraph:

    "Default values for <repository> and <branch> are read from the
"remote" and "merge"
    configuration for the current branch as set by git-branch[1] --track."

I believe that this paragraph tries to state that if the <remote> and
the <refspec> arguments are missing, they are replaced with
branch.<name>.remote and branch.<name>.merge, respectively. However I
think that this paragraph is unnecessary (and partially wrong), as the
behaviour of git-pull when no arguments are given is described in the
"DEFAULT BEHAVIOUR" section
(https://git-scm.com/docs/git-pull#_default_behaviour) and it is a
little more complicated than that, as one set of branches are used for
fetching (e.g. the values of remote.<origin>.fetch) and another set of
branches are used for merging (e.g. the value of branch.<name>.merge).


I hope I did not miss anything.


Thank you,
Razvan Maris
