Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2989C1FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 14:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753574AbcIBOhB (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 10:37:01 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33157 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753332AbcIBOhA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 10:37:00 -0400
Received: by mail-lf0-f42.google.com with SMTP id b199so85417147lfe.0
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 07:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beaumartinez.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=zGKT0G7rojtQbiJ1il8q8Wv9rbLBOwZhXQN53bOM5U4=;
        b=hUqED2hJL++PCmPJDKlvgWzRdoUr6giZovfhE7EDQCVgeQkcWI7xy2kFd5PboXJ8Qx
         pzn9zY0kLRXPRt76AkhAkCnh2hg1bKRXcy2ymLZYVanvmNIHU5ijEdbrMh3nLM24VKKY
         fZFmUiytQxPV79MjIfR1DdRCBKc80VlzxgJPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zGKT0G7rojtQbiJ1il8q8Wv9rbLBOwZhXQN53bOM5U4=;
        b=Bv2nzQsV0EFdA+0wjcewy0ASm+IQ6F/aRdDmF8QfzWLvQEYlpXz13sf5ZIaE4VnmhW
         /atxvQlwWNS/DSGZqmb9DkA4WrfdYHR1SDceR2xkzsvXie8Tak0tTmFpRKGb3std58bB
         Kh9t4Q4wqOHhWLaH47roeSWgS6trVVFUy89wP0tB51hNhNclTD4lxsmOLn+XsLD2fmcO
         d4rU/tFfdW+FBmxcw8yXZLOYaPj9g9S0ki3e4uqKK0fYTBhYkTdUEIVMAIsUGnqgrVO8
         0evC5oUS0P0V5OfOXrrqvDtmLIBwJ0WPISqzbXmKbjsILj8rNxCpj69XQLMH5EkWMKdA
         /mnA==
X-Gm-Message-State: AE9vXwProWtwokPHYmW6cYZ68saXjTD7NFibk+qnesUcayARJUdgSUqEVy3CQrCPdEPu/rgx+Zuaxva0haC+5g==
X-Received: by 10.25.125.7 with SMTP id y7mr7698928lfc.140.1472827018452; Fri,
 02 Sep 2016 07:36:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.78.84 with HTTP; Fri, 2 Sep 2016 07:36:58 -0700 (PDT)
X-Originating-IP: [217.138.17.50]
From:   Beau Martinez <beau@beaumartinez.com>
Date:   Fri, 2 Sep 2016 15:36:58 +0100
Message-ID: <CAEtDOuV+0CKRSu9mJa27+yQKJ-QRyNmwecrZKaaCh0St+VagZg@mail.gmail.com>
Subject: =?UTF-8?Q?git_add_=2Dp=E2=80=94splitting_hunks=2C_limit_is_too_large?=
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi git developers and community,

I'd like to inquire as to why `git add -p` can only split hunks so
much. The limit is too large; why can't you split until each hunk is
only a line? I often have to run `edit` and split them manually
myself.

I'd like to contribute a patch to change it, although my C is rusty.
Are there resources that will help me to do this?

Thank you for your time.

Beau
