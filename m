Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83852207D6
	for <e@80x24.org>; Wed,  3 May 2017 09:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbdECJqJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 05:46:09 -0400
Received: from mail-ua0-f174.google.com ([209.85.217.174]:33928 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbdECJqH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 05:46:07 -0400
Received: by mail-ua0-f174.google.com with SMTP id g49so38010211uaa.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 02:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WM/P+emVYQO2h1lKWWvZ7+9yHWxwvtvTn0/v+je2IFU=;
        b=TnbhsZBY6y3yPXWVtCbKtdTA7XurqREQTw2AQlEXw5GIA9E7tWedsAGWBqHTHXeBZg
         yI8aJYY8/29pSBRsoUyiSwC9FfafC6CdV4vCYF1R2TAFc8Gm5gzc7k9UaORaJoBYYgv0
         HCaKKn5Lm9ID9OrejSx9o91BoOlNF/03WGumDIQvXBE4p3RQeL7THJjLmvUf2xqHowlg
         ACF383GbPa4tCikZlC6h7PG8E2Yf7lOsUMWE+OAiPmnluGAD6CtZ8SuanEsz44WAPFqz
         u0gDbFDeDowDj0ly89FwlxUtOmKXwG778YbROC29wxSxKLLkCenraCJOOAIKkiBL8uj4
         DlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WM/P+emVYQO2h1lKWWvZ7+9yHWxwvtvTn0/v+je2IFU=;
        b=hVAumU4YXpJ5gJgkHNsB370i3x7oBhx3OiDxfAjYGzcIqddCHPeQn+sXjIE5iyqVXS
         jCsgXiSwU4Cpqx/KBxlZl3bvJz/+tI+FdTzMwRYS+fY+4uVULefQbIpBodfyo86yPXYu
         EuuKIffiWSAorhTlPDnPAW2Zkguvsqedjo1FT7gPnUwKSYiEgllyx+2cFnvUOnJCMXZI
         Xc+eYy5zEIV6me6RFEfcH0AvDZRDA4yMbUhzVfDJCWkUBfr/6jeC6sOML1sUlw/Hdv9U
         Fdw/ZHB3lXuHdZKtnFKAJypm71Ng18u30I3/2a5BmFgPYb8+C6dREZ7n0HyuPxF4er1y
         ZrQw==
X-Gm-Message-State: AN3rC/6+eZo+zVYn7iw8DudBWEIifftxRMmy/QTm4KtMrsshSeIdlcLg
        Rw1nDytjTpbrdZOGQLobM9i00nZT3Yzp
X-Received: by 10.159.36.146 with SMTP id 18mr2933400uar.56.1493804766826;
 Wed, 03 May 2017 02:46:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.9.133 with HTTP; Wed, 3 May 2017 02:46:06 -0700 (PDT)
From:   Rashmi Pai <rashmipai36@gmail.com>
Date:   Wed, 3 May 2017 15:16:06 +0530
Message-ID: <CAOqCAXTN6_dR=+As_i6yxOL+A3dOzs4bM5Lzbj6qzyT_3ecRcw@mail.gmail.com>
Subject: Bug report: Git Stash; spelling mistake of stash followed by a yes
 prints character 'y' infinite times.
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
I am a corporate user of git. I noticed that when you switch between
the branches and do a git stash ( I miss spelled it as git stahs). Git
asked if i meant git stash. and i entered yes. and git printed the
character y infinite times.

Below are the steps to reproduce.
1. create a local branch and make some code changes in the same branch.
2. now checkout another branch. git says Your local changes to the
following files would be overwritten by checkout.
3. Now do git stahs ( spelling mistake )
4. Now git says git: 'stahs' is not a git command. See 'git --help'.

Did you mean this?

stash

5. Now types yes. and you will see character 'y' getting printed
infinite times!.

Though this is not a major bug, I thought notifying this would be a
good idea. The above mentioned issue is reproducible in Mac Yosemite
in git version 2.4.5

Thank you all for making our lives easier and better :)..

-- 
REGARDS
Rashmi Pai :)
