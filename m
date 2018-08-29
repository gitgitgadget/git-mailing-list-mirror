Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3FFF1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 16:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeH2UrM (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 16:47:12 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:38773 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeH2UrM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 16:47:12 -0400
Received: by mail-pl1-f173.google.com with SMTP id u11-v6so2551218plq.5
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 09:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomaszubiri-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=KQELEXjJUFJ2CePdh9rcDZakZaSyzMrEIT5LqwmAmSA=;
        b=R6kX+obgk7AJx8QvNWqoAl31CM+cUeITgEyWvWXc7SBOx+R5kAFdv2R0oyhkW+mG71
         deqZ7KuN1p51GvrD3/k/U8MPIDp42kvKIzrHXy+arbOz45hPHPnp9UvP8wy7L+lMo5fW
         p+L+cjPg2jpe7gElTyN/lQPCkkrwzA+Mspd2iBJG8xp/2HVcAcrPHynrQvUCC65XGcWg
         dxX5LTaGwTNAOfaMFWNllCxagMw7Tl193X3At3jU4fbiu6zJUFUXtSElbA5zXAjH0Rz6
         u1EWAYyPchO7/SSmiBmk1AqTSaZoQ1jFNGLs6r9u3GY+Z4QRc9kG0qfhKyScaX037qmx
         tPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=KQELEXjJUFJ2CePdh9rcDZakZaSyzMrEIT5LqwmAmSA=;
        b=d+TbmHwZYqXxtiaHv6Qw4h+64wuAghcUWbFZq1q10hVehRqmw7tYM0GkDdhI3wS00z
         nw4xvfIF3Qu2EkDyE/9Qmmd6ohfujfBk6ssUIj/rQpclA7bMGOHrpSQY3NX+FhwbtMBF
         9K8YrImyEkhOwF+OyZ1jqIMhHnfC6zWRQm3GlbIXcMzp7uzZyOIN8fRLQinnt4o0kZ0H
         Qv8dHJlRjknYMXXJNz96ghBxwvGXi0VQXyEgROfiGCH1fDTisPwRPpeFvot+vOzAIn29
         2O2gzozMJcwMIQG1ypjHijQJq1RBojCwr4Pw+aIRoP/+xTNrCpdZ/t9jfnrR3rbUL4g3
         qa6g==
X-Gm-Message-State: APzg51Bke0k+emDcmxCTj97EZ3LLOjHk1Uzhq4PosvHau91kfTQaXW8q
        czkxaYsleuTHN3QjHzd5RPqqHz7MYRmd9xUd6atNyWbYn3O5uw==
X-Google-Smtp-Source: ANB0VdYm1stwxjVkicbRj1BFAmwIDawWIqW/nWB2hCUDubeFO4RmMgCWFizgmBKysuph79hEIe5bnftQ9V+qDrE/8XE=
X-Received: by 2002:a17:902:758b:: with SMTP id j11-v6mr6751161pll.29.1535561365849;
 Wed, 29 Aug 2018 09:49:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:da03:0:0:0:0 with HTTP; Wed, 29 Aug 2018 09:49:25
 -0700 (PDT)
From:   Tomas Zubiri <me@tomaszubiri.com>
Date:   Wed, 29 Aug 2018 13:49:25 -0300
Message-ID: <CAE3VKEp3PJLCy3tL=K51nNzGry-HySb57QHemZzMtg3RkBmzUw@mail.gmail.com>
Subject: Git Unrelated Histories
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I have recently joined a team there seems to be a couple of  issue
with the git repositories:


1- A branch created from development cannot be merged into the
production branch.



(production)

git merge development_feature_branch



fatal: refusing to merge unrelated histories




2- If there is a file that only has a 1 line difference in production,
a git diff will return that the whole file is different:

git diff production:folder development:folder


=E2=80=9C
diff --git a/folder/file.py b/folder/file.py

index 9bfd6612..20cce520 100644

--- a/folder/file py

+++ b/folder/file.py

@@ -1,245 +1,245 @@

=E2=80=9C

I=E2=80=99m not 100% sure what happened here. But it seems that changes and
added files are copied and pasted into the production branch and
uploaded indepenedently as separate files, contributing to a huge
difference between branches.

How can I confirm this hypothesis, and what steps can I take to solve it?

Thank you.
