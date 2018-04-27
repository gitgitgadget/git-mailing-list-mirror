Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ADDE1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 17:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759012AbeD0Rks (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 13:40:48 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:35925 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759005AbeD0Rkr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 13:40:47 -0400
Received: by mail-it0-f43.google.com with SMTP id e20-v6so2781627itc.1
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 10:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=RLEeJtP3hUiE3J83nguMV6HFOo+dRgm5uh75qjAEvMM=;
        b=svjG/WAYDQGN+rn2AbV+HqEoYODXzDazUANgpja+usjWnoJGJSKysXs4pMcLnz+OOh
         Ips/Plqz0QU+Q8579Q1uh+uvyCVfcV7AtWj9i/gMbOr6A2Rx132KXacQQOTJNMmXyK1i
         g1QJ3fdQR4f68LKs1WBjPOhu++QBok4BwxA/4+bvQXqhg5qMmXtlN7kMqL1nOXkltSkz
         PSLfik52OodZYp6dtEk5JgR0HahCk8s18udQmIwcj+92weW2aQdZZ4BuRNUYxSBpOujj
         WGjH+LqwHkim1wVYKKB3luBCdnI9rjcVjUHHaQ7aOeSh8RXoqLPDDiyXb68NeJEAX/Ff
         KDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RLEeJtP3hUiE3J83nguMV6HFOo+dRgm5uh75qjAEvMM=;
        b=Yg+GbmTOXhSv9GGFPqv00ke/PkZAj5ynd9amgkrxs3yXCahigm4xu9sujQlhQhUoEN
         KDE1YYOJQEZQrMgOO3cLlGAI/KC9UU56OR9k42oq0JIe3TX1ja4Se3449XUKUZHzf2f6
         2dI72/Y87Emxk1Cmxrkam8jHVenhJSLf5o3p+zPgAn7f+RpsBwiO2DoF4OBwOmAilvIG
         +ttNLBTajBjWkmvfH0JtXfTkFqiVABUpjcvj58Q/fu6bTv7PA2ECEbAWn6+fqZpr1oH7
         Kmfu8uy8uEhK+FUPql9di5KeUYUJ7CET/nJIjqanVOD6jfjX0vsxobpPTU1uI5i1o/IO
         zWEw==
X-Gm-Message-State: ALQs6tC0Pe04OtA+whSLMiS4YqpWdYi08T5t9PXyQp//zFpix7huyLqR
        KXlBsO9q0eR9ErrIVUC4ElrD06uYBpevwAQ+eq81B3lG
X-Google-Smtp-Source: AB8JxZo/KE3serP/FivQ+YZ/PxICGZxn8YLbFYXc7aBpxel76SDSXnfbRXvwlioUOhx7hYiGhAc9LZpUd2TZB7L0GNc=
X-Received: by 2002:a24:3992:: with SMTP id l140-v6mr3046612ita.33.1524850846117;
 Fri, 27 Apr 2018 10:40:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:cbcb:0:0:0:0:0 with HTTP; Fri, 27 Apr 2018 10:40:05
 -0700 (PDT)
From:   kelly elton <its.the.doc@gmail.com>
Date:   Fri, 27 Apr 2018 12:40:05 -0500
Message-ID: <CALVfKe_em046aO9QUqJ0TXcLh6Oe7ydYQKr9Zwvheq8RV4=43g@mail.gmail.com>
Subject: Confusing documentation for git apply -p<n>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

https://git-scm.com/docs/git-apply#git-apply--pltngt

>  -p<n>
> Remove <n> leading slashes from traditional diff paths. The default is 1.

This suggests to me the following outcomes:
1) home/user/repos/myrepo with -p1 becomes home/user/repos/myrepo
2) home/user/repos/myrepo with -p2 becomes home/user/repos/myrepo
3) /home/user/repos/myrepo with -p1 becomes home/user/repos/myrepo
4) /home/user/repos/myrepo with -p2 becomes home/user/repos/myrepo
5) //home/user/repos/myrepo with -p1 becomes /home/user/repos/myrepo
6) //home/user/repos/myrepo with -p2 becomes home/user/repos/myrepo

`Remove <n> leading slashes`...That's not really what's happening.

What seems to actually happen is that it is removing directories from the path:
1) home/user/repos/myrepo with -p1 becomes home/user/repos/myrepo
2) home/user/repos/myrepo with -p2 becomes user/repos/myrepo

This argument seems to be removing folders from the path, not slashes.

I'm sure it's doing both removing slashes and folders, but at
different times, which makes it even more confusing to anyone trying
to wrap their head around it.

-p1= /home/a -> home/a
-p1= home/a -> home/a ?? Does this happen, or does it actually remove `home`???
-p2=/home/a -> home/a OR a ??? I have no idea after reading the docs
and seeing different behavior. I literally have to experiment with it
to know what it does in each scenario.
-p2=home/a -> a ?? folder and slash removed.

All of this doesn't have to be so complicated, it's just being
expressed in a complicated way.

Break this out into two separate functions maybe, or update the
documentation so it's clearer how this behaves.

> -p<n> - number of folders in path to remove from the beginning of the path.

Not great, but clearer than what's there.


Thanks,
Kelly Elton
http://www.kellyelton.com
