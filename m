Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07AB31FAFB
	for <e@80x24.org>; Fri,  7 Apr 2017 05:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbdDGFJG (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 01:09:06 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:33800 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbdDGFJF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 01:09:05 -0400
Received: by mail-vk0-f49.google.com with SMTP id z204so63769051vkd.1
        for <git@vger.kernel.org>; Thu, 06 Apr 2017 22:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=9Qu+9FOIPgJR0t+UtTFUYSjRK6GVHKqC3olWE9hv+HA=;
        b=EDz2yRjNRceVftJU9diym7OZVCFB8eMIj9elfD8Ozs8gOXvWVFtuc5yVeTwlE2AYnz
         cM10sZo540UnvIVlqR8sODFshKwKGqyx0tr9R5Gd/1zPk4nhickxfWljy7QVcNuA+44F
         Di9NJM3pBbNaRlbGZdVW9AcblAMfFn9clj2Oygf8gMzq/LZ3l2jX0FuuBYYVfLLpaNo0
         cdsqZnj7caHy5CyWcfeFCuyynAnkl28h28P0rR9JSPx3D/VDcPg2ZJZXghQVK7anaXD0
         McYKTG9CJ2Hg8UMh7ccoVIvnbCNTzDoG6BScBClh6UMfxrGJoYmElbJDdU5p8GoaZcXH
         JTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9Qu+9FOIPgJR0t+UtTFUYSjRK6GVHKqC3olWE9hv+HA=;
        b=Oh2AJVMa7TgLoovUwy6Tp94O5S9NgycLjcVkOqO2znJNZmswjHUIrj7XMI0Rz7oYc3
         8gM79BZY0mhJxhvmTnloyrB9hxpiMTe2UxkYxqVHRljO+vIY1vFbz2oxK+ql7MMtTq/h
         y8kJ0O4NW3We2clfh4LdvgzPoNVaIyllszVsQt9kX8tAzUH87RgpjLG+TJWdFZYyaQtj
         MnLrfQrUUcsFWmpGmXzkBoDeig0ucP6x25cr4SzTZgj6y+9WQJOHfBGcg4r6bsh3vkhl
         NLiJUlrYp6QTdWZxarS2Qfa30Vflom+zHlDkGjBY+McyHrMpdq5+4+M+2nlS9rGvfKUr
         jUng==
X-Gm-Message-State: AN3rC/4ufm5bcLcWfjeGaOWh5pWWSLGtetSMvSokUmhE/np7daGuki71OfGnmEpBKfkFAMNMKRIqOrPjbSYpXg==
X-Received: by 10.176.93.14 with SMTP id u14mr904229uaf.29.1491541744131; Thu,
 06 Apr 2017 22:09:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.33.193 with HTTP; Thu, 6 Apr 2017 22:08:23 -0700 (PDT)
From:   diguazhixiu@gmail.com
Date:   Fri, 7 Apr 2017 13:08:23 +0800
Message-ID: <CAFQrz2EXJY=f6Yn0SHn0fZf61=hJQFb6t8LO+Dryw0HVf_s0rw@mail.gmail.com>
Subject: [BUG?] Issue with branch -avv command
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, all,

I have a problem when I use command 'git branch -avv', the result is
like  below:

  my_test_branch                        d67ab86 fix some problem
* master                                     27c4e0b [origin/master]
Add new file
 See merge request !146g within bucketsa824 Merge branch 'master' into 'master'
  pref                                           060cac2 Fix bug
  remotes/origin/HEAD                 -> origin/master
  remotes/origin/my_test_branch d67ab86 fix some problem
  remotes/origin/master               27c4e0b Add new file
 See merge request !146g within bucketsa824 Merge branch 'master' into 'master'

The message ' See merge request...'  take the place of branch name, so
I have to user 'git branch -a'
to see the corresponding branch name.

Now, is my usage wrong? or is this a problem?
