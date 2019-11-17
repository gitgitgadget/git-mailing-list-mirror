Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25F931F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 20:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfKQU5A (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 15:57:00 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:35057 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfKQU5A (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 15:57:00 -0500
Received: by mail-io1-f50.google.com with SMTP id x21so16442848ior.2
        for <git@vger.kernel.org>; Sun, 17 Nov 2019 12:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=IXry6NYD8ui+BSVG3vQGe7dTfeGdoI8Wk37cIKSQN5Y=;
        b=uW0RqmLqlrdgPWn9ydcmHV5B30adun8nqNuJ1TzJunKOZeNOxNJjlfpY5ATR4D21Th
         hkpIJwO6gLe/sD/juLwAUmWJJoLqTOdLIQb2WEQEYnHy0uRa8AZACy0NyWB1/lT8kh6/
         9TRy3OJ1l3vmocmbwYHD5gGTuRDeyNGSkqeQReo9W70TJI1p+eXYv5djvYrDucDLYTmT
         FouiVwZrHcluYpHMX3FamFC86hF3O4yhWamuLlAkjDl7HPrfiHoPviYmLT+rFtdUPyC3
         yZ8dJqtt6xPhhYkRrvzMDJHzOPERAFthVvG3XoZIMmdnDWb4voa4gfLTt6W1I+AUZPq0
         O3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=IXry6NYD8ui+BSVG3vQGe7dTfeGdoI8Wk37cIKSQN5Y=;
        b=klCpId4kwqFg2FBJgJzGUKm0OMAVVemnuXDZ5c9U6LFxePAEWZaz/DLoP0gMXTcdNo
         6kVygziu99vXzPO0Z0sfvWRLsvrIQhLCqjqQs74ysdbnyvr6eAjVG+g2YJHYtFjuj0mc
         I1AUFX0j9BOGu2HebKsZftcufmYmp2oaNeOBVOJS63BmjZt0MX15hI32jO+IC9DkQmOp
         CO/xd0M7B7JYSqN9XJ3jPRJert1sBbcrLxvFuVil2GcdJ/T0qiHC3226wF1Sb+EDQ96z
         L709IUYTyGJM11ko6orEjftXA/+acmdnwkaztIxYmukbCoJnwJNbwRFvkPBoEdocY6qM
         lC8g==
X-Gm-Message-State: APjAAAUNa6UCYfodCWR/KMsQKistqU+yU0XY1gj37bmET1ZgBE5Ivpj8
        IMZCuC8hbfLCO5U+33v1NzIdVEd1USyKihdZuVb9zqxs
X-Google-Smtp-Source: APXvYqwXa/EQgKebC/gnj6DUR1I9MPWSKP5kZY3Bl9RX+lcrgzoiS4yxqm3xh+SqcMqio5PCNT01u8pBzdHSeB2yBlE=
X-Received: by 2002:a02:55ca:: with SMTP id e193mr10636790jab.17.1574024219101;
 Sun, 17 Nov 2019 12:56:59 -0800 (PST)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sun, 17 Nov 2019 15:56:48 -0500
Message-ID: <CAH8yC8m45JGwjd-vRaE-05=MmDHq4qxWBh-wtsK09xuW+mp3mg@mail.gmail.com>
Subject: Please provide a one-liner for syncing with the original/source project
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

One of my common workflows is, clone a open source project like Git,
OpenSSL, etc. Then make some changes and push my changes to my clone.
And maybe submit a pull request to the original/source project. After
the initial clone my project becomes out-of-sync with the project of
interest.

I have to do something special to get my copy of the project back
in-sync with the original/source project. It is not trivial to get
back in sync. It takes three or four separate commands if all goes
well. And in my case, I have to look up the instructions because they
are not ingrained in memory (like
https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/syncing-a-fork).

This sync workflow is so common Git should be providing it. Anyone who
has cloned from GitHub, GitLab, etc needs it. Folks should not need to
do special things for common workflows. When sites like GitHub and
GitLab are providing explicit instructions to sync with the
original/source project should signal it is common and people need it.

I'd like a one-line command to resync with the original or source
project (and not my clone). I think a 'git sync' command would be a
good addition to the Git tools.

It would be nice if sites like GitHub would value add the ' upstream =
...' to a .git/config, but that is not Git's problem. I'll settle for
manually adding upstream so 'git sync' just works.

Thanks in advance.
