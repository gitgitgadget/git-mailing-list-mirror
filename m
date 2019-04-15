Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4A9820248
	for <e@80x24.org>; Mon, 15 Apr 2019 15:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfDOPSj (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 11:18:39 -0400
Received: from mail-it1-f179.google.com ([209.85.166.179]:54238 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbfDOPSj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 11:18:39 -0400
Received: by mail-it1-f179.google.com with SMTP id y204so27604978itf.3
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 08:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ENwFquv0U0jijQUaEeXLPK9Fzh+zqxdPz8o+GsEqLck=;
        b=ULQpM4Jl3u+XfFFf80exwDw4WsithvLziLD9X7cFu+81EUSK9Nlm1+ZLRl/Elp/zq7
         B5Ez1zaE3VcMUICjlilPYgDYJrK0pdJcY7Y1Ntpj2R/feOr/33erke8p6fiLObkbLFZ9
         bpLY3skvdqCTsUerzHNdBd3+iB2aQLYJ7XCl/MFhQl4T294b3EGoiFlu0Dwb27weRTrp
         xE5xX8R5mKbFgNmsn64vB3OIIlerFGenSNA8pD54UhNeVXpUT9zeImM1/qSYABoZcsbi
         jGd95rgymGWPo7z3g4za1PHPIO37fqOn25GDclv5cychIbx5a4Rrr3w+6VWfa6Y5DzpN
         aJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ENwFquv0U0jijQUaEeXLPK9Fzh+zqxdPz8o+GsEqLck=;
        b=EMjah+hEoQkKJU4oYV/9jfFEJj9tpgCUCE23nWOwZlYwu59bYxoG3/UHftbxRNQk1p
         hYIWH6aRabtyrpcZjR84qoqtnWIQNShAYKoNJVznuoO/5Y0T8GLOQiS18TnIZP7pvxQa
         HLxEaR1KmceoJ7cddF9i8o+zOBiZ1g7gy2Ku9YnShyw6zvrDiLQMGrqCWqooEb69EHx3
         paYpRiwsVb9NelVxaILiULpyNWlzyEVEupU2+WT8QIA8yJ6wBOWkcqOMNceAdJhA3aRD
         EkSOI1lozCHYUshLq+r9eZKYg2uWr+lXJHv7qf9True99+/oZQsz3xIU3YutWyH++0Py
         PK0w==
X-Gm-Message-State: APjAAAWhvwKfT3cjAaPVJEIsARJ5ZnzsMq0vdHV0Y4jVEkA8VxN1iGn5
        FhWBicUnvgb43idhsEtNOsXJOlhsoi6v3ueW6wAmLPiq
X-Google-Smtp-Source: APXvYqxksY73iIKd7Dw9LkCphrMSLV2oCAvSoPpEiirRo35YhV3ZqKMhp/az94I9KIZBTWbb5TPf+BPQmJhrg73otEs=
X-Received: by 2002:a24:b610:: with SMTP id g16mr17084563itf.20.1555341517944;
 Mon, 15 Apr 2019 08:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <CA+2sEepTyrK-iH+VBHVF1i9DuYVzDkTNxuM0-yoWbkC9N4f8HA@mail.gmail.com>
In-Reply-To: <CA+2sEepTyrK-iH+VBHVF1i9DuYVzDkTNxuM0-yoWbkC9N4f8HA@mail.gmail.com>
From:   Nick Steinhauser <nicksteinhauser@gmail.com>
Date:   Mon, 15 Apr 2019 10:18:27 -0500
Message-ID: <CA+2sEeqzMZC3+N12JcsStkz=3on5Rygu2m5HjjdCw8Mi-aT1FA@mail.gmail.com>
Subject: Re: bug report
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

user$ git checkout -b "environment-logging"
Switched to a new branch ' environment-logging'
user$ git status
On branch  environment-logging
nothing to commit, working tree clean
user$ git checkout develop
Switched to branch 'develop'
Your branch is up to date with 'origin/develop'.
user$ git branch -D environment-logging
error: branch 'environment-logging' not found.


Regular space:
user$ git branch -D " environment-logging"
error: branch ' environment-logging' not found.


Nonbreaking space:
user$ git branch -D " environment-logging"
Deleted branch  environment-logging (was 267ffff).


Non breaking space inserted into my branch name. Above is copy pasted
from terminal with only the user name and directory altered and
extraneous commands removed. Note the space in the std out of the
first command but not included in the command itself. Whereas in the
last command I explicitly typed the nonbreaking space and it does
appear as a visible space. I do not know how to reproduce.


Thanks,

Nick
