Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A783207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753633AbcIKKZI (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:25:08 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38252 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752381AbcIKKZH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:25:07 -0400
Received: by mail-wm0-f47.google.com with SMTP id 1so99773487wmz.1
        for <git@vger.kernel.org>; Sun, 11 Sep 2016 03:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=F1lkvHxbsXYTgQmaY7YhbSh9xlTz+jp1pm2YlKbdrkQ=;
        b=JKWWKD/npZboVq7KCD/Qp4SdOrDb2dwypiYUEE6W/iUAKmC2niVAApcQ/sbxQXiWSs
         7mg5orPVd3avjUnTnSlMuw8/urjxHlCujEuB2LNPIOBxAe0WfCuv4F7lrW4c1r4JhkTS
         bWGFuTK6DjDuctSJGva8sXiASjay0rVwb7W6qcnzIGp5p0yNp8/CnEd0wYO3iaQDOwfD
         xORu68X1afzjPhQPTEvXlZ26d/YoWv4BRFgBNR9lGuECYD3E8tp77TjCrsKl5qsZtisf
         LjFqL5hSqzjB3Rc7CJRGCcrSkERiRWYWBzhjSeSR4zxIwCB7usUGE0Y0xVJ5jlDNZj1P
         Ozpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=F1lkvHxbsXYTgQmaY7YhbSh9xlTz+jp1pm2YlKbdrkQ=;
        b=jA2Qf0F/3avtQxxsgpR6zCRjSrJI+VQUBvzhzR844Sbr8+obub/tz3UfaTHbNEt3x7
         +NFRhjQrd/ZR5jC4bFWq28UoSeEpEVo0+be2iQt0XrTE1rSHS33g4CVbuRGGOlq2VqiJ
         HFVDfg6B1IE+7W+FP3LRR3L0lTzwULgQkz4V+1E0CMtXbSEplHnxQ5KmJpkHuiOs8w0V
         rZgmqrC/z/+c4EWW9CCjPQxDl4I/CvcolYk9QvwZ9XaaKGSI4RfbDKY6veuavxp0xggI
         TTKKjWal39/Epyoz+7OANpbfnxGb2x6gykK+ez9M13kiK4kxZ3d2t2cyVmOkI8x84r+D
         adog==
X-Gm-Message-State: AE9vXwPmlkxo+5QPsmGh9XfjDpc3KfraMa/bO7bTIg1hdDIAtdoaxzqRDgD+rJVbmAJkmHFzekaSdZS+Xr12dg==
X-Received: by 10.28.86.8 with SMTP id k8mr6123640wmb.33.1473589505559; Sun,
 11 Sep 2016 03:25:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.222.132 with HTTP; Sun, 11 Sep 2016 03:25:04 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 11 Sep 2016 12:25:04 +0200
Message-ID: <CAP8UFD3MyKVOdQEjPJuxcVK9NVBY5uoRjN30KR_c4PP6Nf=VQQ@mail.gmail.com>
Subject: Draft of Git Rev News edition 19
To:     git <git@vger.kernel.org>
Cc:     Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Kevin Willford <kcwillford@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-19.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/179

You can also reply to this email.

I tried to cc everyone who appears in this edition but maybe I missed
some people, sorry about that.

Thomas and myself plan to publish this edition on Wednesday
September 14.

Thanks,
Christian.
