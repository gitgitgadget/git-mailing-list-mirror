Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAF7520C11
	for <e@80x24.org>; Wed,  6 Dec 2017 14:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbdLFOCq (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 09:02:46 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:38952 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbdLFOCp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 09:02:45 -0500
Received: by mail-wr0-f176.google.com with SMTP id a41so4023952wra.6
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 06:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=s8NmqK3f35KzmkGtviGDnVF66MFcM/gK8Bzk3NbQ+OI=;
        b=t5VOCnjpF1qHGQqvgavjDBQ2/0UyWDu+tI1UdeHbDEwGlDzMkcbmGPR9/FFD1/jLUy
         ic/H4pbrPDmpWtUblLIMYRpAZGvnBGdEgqUseJwOCds0bqHZ20JhBe3HA6lCk3O5Zs35
         yUJbJHoDCtrXEUQl/M9xsAzAdvR0fJJnQhEFqP/DjNgwmLEWpM/6uk19b7LOgofSaHXi
         lyR4UT2tDo6E8kJCJ/Z1Ly9kuX+W8ciYMP5SnbDpHtiBtktbQfMXglFAwhCzRffwFnkH
         /Aou3jpsLlnPq2Ob2oxTLJ2Ozwte/SlWxZ1GgWJjpjNVLHRRxfg1ch+kFPF51beedlO2
         3w6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=s8NmqK3f35KzmkGtviGDnVF66MFcM/gK8Bzk3NbQ+OI=;
        b=qRKwbYEYOCp4AQj1b11/LlqJTGutUGIyiOUl+yYE1lq2NIosB8EcGhy3Go0JTHl19I
         CWrjGl0tHEPWpApCggp2ROH5U5KSJ3Z4tmAPgFyqEmyYG+O3pJKUysACeNLNOvhW7ZVn
         6a1GGks5oZ1Rk0RcLzBtDcIdSE9o4XWusA1mlTP2tYyH+syQ0pJ4kgaK5o8a9p29wrfp
         ahOYIGWxb2ZmgC3OqOHbjj2INMWibF7VFSW6tdKM0Zb6uX0iZiiC/woJyZXOhR+ffyB9
         2a6Yybw0YgNoTPCbuJ/y6Wlga6Ww/aPl9/4MPOJ543w3xyVPETn9q7zAxPAnW9rmys1O
         RPlg==
X-Gm-Message-State: AJaThX5nhml15UCNNUY+OCbzRW+glz2ZoBgfJ1gSxzKUwcVQPyBUZcst
        hjAO8xRAhFdaDf9/JCVk2InmTM3EJBNDbQetyOmyhQ==
X-Google-Smtp-Source: AGs4zMYr1VEYuUwByVqK6d7vTQrAwWKfBGnPSJSVlouB1nAxWMZZYQ1AR9emOlxJjK30vswm6U+yZsSKXy595Rmm7iQ=
X-Received: by 10.223.190.134 with SMTP id i6mr19628614wrh.177.1512568963968;
 Wed, 06 Dec 2017 06:02:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.18.194 with HTTP; Wed, 6 Dec 2017 06:02:43 -0800 (PST)
From:   Saurabh Dixit <isaurabhdixit@gmail.com>
Date:   Wed, 6 Dec 2017 19:32:43 +0530
Message-ID: <CADbksagO806a=nJpQ-uUe83Ne=NdM6TvKBRu=a7OO_MzTRi68Q@mail.gmail.com>
Subject: Git Repository Migration
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am new here. I just wondered if the Merge Requests (aka., Pull
Requests on GitHub) are also imported or cloned while
cloning/importing a Git repository, say from GitHub to BitBucket.
While I consider that, it may not be possible because of the URL to a
remote is already set and cannot be altered while the Import/Clone ( I
could be wrong at the assumption); I am curious to know what actually
goes behind the scene.

Best regards,

Saurabh Dixit
Opensource Enthusiast
