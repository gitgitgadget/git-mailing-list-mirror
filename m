Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MIME_QP_LONG_LINE,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4B0220281
	for <e@80x24.org>; Mon, 25 Sep 2017 07:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933603AbdIYHbT (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 03:31:19 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:55007 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932135AbdIYHbS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 03:31:18 -0400
Received: by mail-io0-f178.google.com with SMTP id h66so8934951ioh.11
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 00:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=user-agent:date:subject:from:to:message-id:thread-topic
         :mime-version:content-transfer-encoding;
        bh=ZHiZFgUWAwvSc2vCcoe13wuSt5/K8Moye9wai1mB7J0=;
        b=l0OtYmsIgfNmwNjgemAvi5G1RUeI9ElDWM8kkzlNwN8rxgzzezTygk8XgLbutQ6zTg
         0jfZ8Oc/dJn3IwgJpPxfFnM+x14No0Y19+jaP3anVVTilcyui31punUvjzwZZuMT9q+a
         LcrKU7UZ9Ll5q7X8gxJGN8pENi/LBPeyATVhj12mSchH32K7iwTwebh9gPxazqD4I9aF
         q28YZdA9Ye7+R5m8Eyp4XQGCbxpFNc187ZhhoN5PVEUtaVWXrnuMnbJQ72hEkqNc1SpX
         qFf3DMDskrAXOgQr3a9Kkz8u53Mdwj/J+HsQx8laH6Fpn7jaRwW8knBk00G+X0UEvIe0
         gbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:user-agent:date:subject:from:to:message-id
         :thread-topic:mime-version:content-transfer-encoding;
        bh=ZHiZFgUWAwvSc2vCcoe13wuSt5/K8Moye9wai1mB7J0=;
        b=KaaOheuZSXfK3PHqYPOLqdMYvEadHiHOEPqLXdvuYSOcudtvbD5e+u1V7/zPjDyvyP
         s625fQs844LLEm1GGisGNdAO+XG8aI5jkuzG8/2BJ5irXicmZ2e5JKZy+V0jCrh1G9/g
         CTKGRDuZNoiBsW9N7nAI53fz9NOsZdNrY7Z5+noUqJNU2xTJ7zyXbugWH1uv+ptHbo1H
         4mtFYyDhHYXN1mucaTdwRHD1a8zZQNsVERVl3cm9fHfu+hBKfzHkVzOzwryNP2Y3/iCR
         HL2z106IWX2pI7tqTn5sbDFFPIZcoLW48mKK/LEo6G2ZxdfdHusJ08plrU2JRB5Uy3pr
         MFTw==
X-Gm-Message-State: AHPjjUjo8iw7CM/lMImF0e+gS0KA7pfMGJnkjtDeUApE51r0UWb2M32C
        QgxnLGA2ycTmQiiahr4/PzY4EkOJ
X-Google-Smtp-Source: AOwi7QD/ma2dGu4WFXtWEhh7NKsQHdqpThBDjMLvznT/rzgn34he8NoHTW81lL5vuvy+8PaKhLxSTQ==
X-Received: by 10.107.81.1 with SMTP id f1mr8396036iob.17.1506324677787;
        Mon, 25 Sep 2017 00:31:17 -0700 (PDT)
Received: from [143.248.200.68] ([143.248.200.68])
        by smtp.gmail.com with ESMTPSA id y63sm659613itc.44.2017.09.25.00.31.15
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Sep 2017 00:31:16 -0700 (PDT)
User-Agent: Microsoft-MacOutlook/f.26.0.170902
Date:   Mon, 25 Sep 2017 16:31:10 +0900
Subject: '--shallow-since' option is not available for git-pull in Git version
 2.14.1
From:   Sanggyu Nam <pokeplus@gmail.com>
To:     <git@vger.kernel.org>
Message-ID: <F3F7A768-C844-4D77-9403-53AC3F506080@gmail.com>
Thread-Topic: '--shallow-since' option is not available for git-pull in Git
 version 2.14.1
Mime-version: 1.0
Content-type: text/plain;
        charset="UTF-8"
Content-transfer-encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I=E2=80=99ve found that some subcommands such as git-clone, git-fetch, and git-pu=
ll support an option named =E2=80=98--shallow-since=E2=80=99, as of Git version 2.11. Th=
is option is documented in the man page of each subcommand. In Git 2.14.1, I=
=E2=80=99ve checked that the option is available for git-clone and git-fetch so th=
at the history of a shallow repository is updated. However, running git-pull=
 with this option shows an error as follows:

error: unknown option `shallow-since=3D2017-09-10T00:00:00+00:00'

usage: git pull [<options>] [<repository> [<refspec>...]]
...

I found that this option is not available in Git 2.14.1 on macOS and Ubuntu=
 16.04.1. It seems the option handling of git-pull does not match with what=E2=
=80=99s described in the man page. Since =E2=80=98git pull=E2=80=99 is a shorthand for =E2=80=98gi=
t fetch=E2=80=99 followed by =E2=80=98git merge FETCH_HEAD=E2=80=99 in its default mode, we ca=
n run these two commands in this order as a workaround.


