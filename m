Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4275B1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 19:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752872AbeDETsI (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 15:48:08 -0400
Received: from mail-ot0-f171.google.com ([74.125.82.171]:38154 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752848AbeDETsH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 15:48:07 -0400
Received: by mail-ot0-f171.google.com with SMTP id o9-v6so28721258otj.5
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 12:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2EkQpRrX5dXQOmdtFWqNFXu6AqzfaJSwUzDEtfNn4qU=;
        b=g7GRjeqpA3MhbK4SXbhmmK3c4ADmgjJjWRSiNWltn8fQwl/7G80WSqYs5YEWdUWym1
         QCZ/D7QWHDnJbL58wBaO2hQxP/qYh1ob3SNwYwG1tQ9vPNWeb+KezUIXqDDdYlbTQ5ut
         x6W+iQAs1e/AjmCCaCaLJSCT303hsPYpaIU4K/NDW+O0+Yazdvs9yNIuWtbGtslIJwCQ
         mMlDjEXEYS9Rmx5voESg1/2M3nxyAj8p5htVB3iDbwvv+REh8rzItYMsnzXPQiRswhfT
         3XXrn6mtQr38blyFDAx0pj8TTe7vFZmm72Pe9HrfKb0/cr0Kaeto/AosOrMWNc+HeHiS
         h0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2EkQpRrX5dXQOmdtFWqNFXu6AqzfaJSwUzDEtfNn4qU=;
        b=r4MHRKZHFUR89VKdMuSe+JkjaWaDPzJVZcxpsXbXMOa9q7qY9i3VZvJP5ktCBw94fc
         CR6HfbBx9Q8n+meGbJRg6orF1an51MlI88MANH4tEivd4cOuIdXbD80au3rQbongVkLG
         7NF0fB+srpu0SKLe60hci18ZhQzXsQMT92vVomrZsr+CN0VdLrl3zIOlhco9EDtoDjZ2
         FnHAaP+eDihIM56XszRwcC6QknvT5+M2i3qtIASboe3/1gBG1bq1H6tlIocEUKt/kdS7
         6eiOgHZSnHsI/0S+wecm2utu3KdiKO5qgJRXL2QuXm73ytHSQ84nAhxT5wxoaxylhz5p
         t81g==
X-Gm-Message-State: ALQs6tBVMrpLAowOxDMqzWjQvzQuKTan3GsbZweGYaLr1iBChNDnIJ6X
        /FrZYj1GoG2Ey7p0DQjAjCuWEWwJ9v9UDvHILbzGlw==
X-Google-Smtp-Source: AIpwx49IPnQ8DJ96BvWE+GndOix0g+neudX58WwfX8XcjBrcIgSYU/0Of7uLwQJAKytaGhZC+WtnGHRnAdURLjHT84w=
X-Received: by 2002:a9d:528f:: with SMTP id f15-v6mr15476974oth.134.1522957686642;
 Thu, 05 Apr 2018 12:48:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.43.98 with HTTP; Thu, 5 Apr 2018 12:48:06 -0700 (PDT)
From:   Igor Korot <ikorot01@gmail.com>
Date:   Thu, 5 Apr 2018 14:48:06 -0500
Message-ID: <CA+FnnTxbg97A4P3AP7n5RT8+=W8PY0yx3644Ay2Zi9xgKD2aoA@mail.gmail.com>
Subject: Is support for 10.8 dropped?
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, ALL,
I am a successful user of git and my project is locad on GitHub (still
in development).

I have console git client installed on  all 3 major platforms -
Windows, Linux and Mac.

Up until recently everything was working fine. However about a month
ago I started experiencing issues with OSX.

I am running OSX 10.8 and initially I was receiving the following:

[quote]
fatal: unable to access
'https://github.com/oneeyeman1/dbhandler.git/': error:1407742E:SSL
routines:SSL23_GET_SERVER_HELLO:tlsv1 alert protocol version
[/quote].

After asking on the stackoverflow I received a suggestion of updating
the git application.
I did that successfully) and now am getting the following:

[quote]
MyMac:dbhandler igorkorot$ /usr/local/git/bin/git pull
dyld: lazy symbol binding failed: Symbol not found: ___strlcpy_chk
  Referenced from: /usr/local/git/libexec/git-core/git
  Expected in: /usr/lib/libSystem.B.dylib
dyld: Symbol not found: ___strlcpy_chk
  Referenced from: /usr/local/git/libexec/git-core/git
  Expected in: /usr/lib/libSystem.B.dylib
error: fetch died of signal 5
[/quote]

Now my question is - how I can upgrade the git console client for my
OSX version?
It looks like all installers are written for 10.9+ and the only way to
work it is to update the OS?

Is there a version of the git console app for OSX 10.8?

Thank you.
