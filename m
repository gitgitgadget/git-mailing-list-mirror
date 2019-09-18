Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77F881F463
	for <e@80x24.org>; Wed, 18 Sep 2019 07:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfIRHFZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 03:05:25 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:44418 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfIRHFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 03:05:25 -0400
Received: by mail-lj1-f180.google.com with SMTP id m13so6005661ljj.11
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 00:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=yIJVP6Nhv5pZQIM4MfCLixV7S0RlSAiMtG9fY3sQ7aE=;
        b=QFOXMJZ8Ue9fB4KF1eDh8TuTYaffMumpXiDLvP71V1Y/ZpNyI6UtMjZp4XPrHSCi8x
         XeeBavExJvO+jd3QgraJf/X1lU8yvYv5d7/gHT+jYpQiXJGpyupDOY5OGu1D3AALOaC9
         3EctkbcdeMqhWIGyeLAFEdSmjjunOb9uuufy8CUR8dJXIY6SdmbTxuzZdDlQ5zev9vVp
         CzmPFM9unlM4g/p4bdHixA7/Unz94f+BInPiYQ2bcGIspXXUqogUe6iZuAC7D1nYllEt
         E5CIqUK4F9zdaBeaIyxl7u5CSM0GdbnRYkQeqyDzrXEfq5yY0YxfrBZYnvUNix0TtONL
         5ksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yIJVP6Nhv5pZQIM4MfCLixV7S0RlSAiMtG9fY3sQ7aE=;
        b=L57Bb+NZpe7z2djZOXPJvM1k2ZKudgCo5wWpXMybBeWYe7lTL6U33OQi1IGSUAbTp3
         hd6x98bxf82OjuAM6KsKGZIhoKTtV+nqj+9UMzSFJ3FeUmCm04Ioy1UK0ZAOETz/+j3G
         9bIMwJwhtMj+0sha6AjqstUbuj3A2wFqW8Rkq0k6tlFqOIxfGoMH8UJ2M1PzExhYvWhY
         ujTXrI6S0AlmLE6R0yTItThWZ5XYcvKD1lEY5GOoMOpEVNJriP9MUoESMrrkB/ZJROjK
         GTP4DnaCEQgKjs4KTVJ+JytVcm0Ftz/SIIDvzFtOCWW5UXAbiHfUnWV+4rpUsk86QiTI
         KHIA==
X-Gm-Message-State: APjAAAWyI4cPrwLA0qlzes5Y7l6EKetAWYzK/PzOoRblsKzJECYM9yib
        9xgHAqwrZiF8E60PlRUCwrkhQXwpVUKreGMErpcH6rw3C24=
X-Google-Smtp-Source: APXvYqxUpCeZi02Iuu9S+YFrVqV+lL+zqJqZNMn4gZD6XR2lmU9g8vlEX1pS4hpJSUa2u4oN4tFJV4U0pu4BqhsNbQs=
X-Received: by 2002:a2e:9c16:: with SMTP id s22mr1278324lji.70.1568790323134;
 Wed, 18 Sep 2019 00:05:23 -0700 (PDT)
MIME-Version: 1.0
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Wed, 18 Sep 2019 09:02:37 +0200
Message-ID: <CAGr--=KXqFbivuXHPNecb3dBR_hx8QqWoR4pBGXy7uOiT+ESbg@mail.gmail.com>
Subject: git-gui: missing some patches from git?
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,


I was comparing your git-gui repo[1] with the source code of
git/git-gui[2]. There seems to be a couple of things missing.

For example, I created a patch back in March 2018[3]. Junio pulled it
so the changes are really there in git/git-gui/git-gui.sh (see this[4]
line). This was while there was no git-gui maintainer. I guess the
change never got merged to git-gui, but directly to git.

Not sure what you should to about it, I just wanted to let you know.

[1] https://github.com/prati0100/git-gui
[2] https://github.com/gitster/git/tree/master/git-gui
[3] https://public-inbox.org/git/20180302100148.23899-1-birgersp@gmail.com/
[4] https://github.com/gitster/git/blob/master/git-gui/git-gui.sh#L3885


Birger
