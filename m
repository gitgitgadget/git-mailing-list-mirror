Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 025461F461
	for <e@80x24.org>; Thu, 11 Jul 2019 21:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfGKVhE (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 17:37:04 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:46419 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfGKVhD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 17:37:03 -0400
Received: by mail-ed1-f48.google.com with SMTP id d4so7297272edr.13
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 14:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=college-harvard-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=NGQHjtVUX2i1QHK6CBQmU9Uj9m9lv8Of+E9npcrd3c8=;
        b=d2ukJnmQJ5RT2ayHBC0P+yTiuZybD11jACr9VcqVuqEEYt+d/CzoH4pAkwT1L7Ys8s
         SyYf33t2G11kOUzdjVPkq9slfvgaaoc6y+sg9wYMM85aCb1naGrGwOgY5xTgMrAwSjxo
         P4GlQTlr3Pe2qtvgkVz4BGv0IS5R0qSzM2ZKtpxKCey+Kl6iDE8PSjiA5B0jLRbLey62
         HoXgd37FBbdYXAMsWEinXZmt7/dgoyRNYDOMOqOf80BWjJrbXidkJ/SAq+C1HNaeWIX8
         xOIW7tL7J0UfZb8ULMYRxgm4RsL2xtoHly1win1yJ3AimNZ2UofcHLE4kZXPHJwIEIVb
         NIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NGQHjtVUX2i1QHK6CBQmU9Uj9m9lv8Of+E9npcrd3c8=;
        b=hSlZejldJdVrt9ddEHwJsGKViZ7XJasMSBwyDDUpoevK9ys2Ix9nMFtj3fNZsGgL6T
         dRsggbG2sbgncdLbGejnLctJUKrkZIsftCvPTfTaSSOjS5feptGJ2x/CtP/eYT9PWVyP
         XHrRna7JCqIJOikRSRIBqni40VjYt69cF7VXMyBdKDHHHQNbSDNRiHxfHPrZIY2tyJ9x
         eAmpwA7ocYLqrtIz+I++Gkeq/I+4SVVSptdiyZKVSM4jcAOPw+3VHOv3S8CZjkcRy3by
         OgU5bU+TA/lI1YXR0KMAG02Wp3x7gdW80vMbobh9r4R6G56YGE/JzXa0EPwX1LG8sCIc
         1BpQ==
X-Gm-Message-State: APjAAAUhwxQxe8e6nN9r2wITJxjk280PZJxRLTsEuK6F2J6fdKkvcew7
        Ay5aOLpvQHSlQKCg8bsfMmXEAowe6I94Jpc9AWRI8SBwhGRN2Q==
X-Google-Smtp-Source: APXvYqyK7v7MgTChji464TTaJzNFV+Goql8D0+Xz+MRk7HLlk6wFSnwhpPu/qtS5ov05KsLpXUqgN08/Cwx63XpbPus=
X-Received: by 2002:a05:6402:78c:: with SMTP id d12mr5930921edy.160.1562881021596;
 Thu, 11 Jul 2019 14:37:01 -0700 (PDT)
MIME-Version: 1.0
From:   Michael Kielstra <pmkielstra@college.harvard.edu>
Date:   Thu, 11 Jul 2019 17:36:50 -0400
Message-ID: <CACf0ZibKt-mpqpavmK3SVMC-Lqm9KB9kUvPj-KFkvT_LVRyOZw@mail.gmail.com>
Subject: Pull vs push messages
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I noticed that git pull reports "Already up to date." but git push
reports "Everything up-to-date".  (I'm using git 2.20.1, the latest in
the Ubuntu repos.)  Just for a consistent user experience, would it be
worth standardizing on:

Hyphenation (up-to-date vs up to date)?
Periods at the end of one-sentence messages?
Colloquialisms and tone of voice?  "Already up to date." sounds like a
terse error message but "Everything up-to-date" sounds like a chatty
friend.

Maybe none of this is worth the effort, but I thought I'd mention it
just in case.

Michael Kielstra
