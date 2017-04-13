Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF6C520960
	for <e@80x24.org>; Thu, 13 Apr 2017 17:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752912AbdDMRDs (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 13:03:48 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:34904 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752677AbdDMRDr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 13:03:47 -0400
Received: by mail-wr0-f174.google.com with SMTP id o21so39391134wrb.2
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 10:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=37YtxosGPUV13zpmzDKmkeVE+ZIVviXjbWm2I4gK6D8=;
        b=K6PhkXzW9Trhu7RmYHB69oruG3w6gLw6EinXlWTvcZHlIiplKDDbKFGIMTp0H/sQe+
         ETfawTF6/JVTU/F/SxjGFuGrSsKRgW43pyl3l+t/V48gCM9OG6nP87KD1kKX/0eWLIx8
         nTgM3AvVWlGqFREyyVisAbKhs7o3ssoShTYVldbg4SMN1NKDuEdF8d1spklzE/VLdRyu
         sXnaWCamRm0+b7ztnISEsTKEkofYD4nxhVBjE2XBCRkRF81lLeDTqIugZyJMIiQq75hL
         QhRX3H5pqTSmhjj9M0iN1pmFYgTaZ9sduKHebuF3iJLa9WBwICvTBFkqfmAw7CY/arHq
         IGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=37YtxosGPUV13zpmzDKmkeVE+ZIVviXjbWm2I4gK6D8=;
        b=bMlJoX1177lIgVQDMs/bTROiPs3VnOqVp8gDL/rhwhveyWM8QSdjBz4xj245Plezvl
         o2J0//GkCBozWUF22QKLROG2i77Nb2u7p17XzURacZ3xbLXrij66IkaGJtZkurJsyqaQ
         U9dZPz9ppkMf1hrCSwuC5sFPeh3qpEJM+b7i/jxvJKnllt4onjCSPY3JkR8rjy5imBuX
         VBFcPLU6AXVzxWSHlX/omfNHz6PUZUi8DMcbGVTvsMvwVxau1ep5ykSYBr2tqvGvge/9
         NkPg7HCyu7ce+n3J/zSFOYK0xz4E72uLozvqMND5ZI4epTWGh1gWHg7mpR26ZCPWXQ7F
         ur0A==
X-Gm-Message-State: AN3rC/6GZf2W2ImJbpvTOgMXGOcHfjYlxLBMnVF05kaZKc9eIhMM7Y3F
        CWJIMljGYRr3B10ulfAIpg4aHZQ63qyolGzBAA==
X-Received: by 10.223.150.149 with SMTP id u21mr3851103wrb.195.1492103026183;
 Thu, 13 Apr 2017 10:03:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.99.138 with HTTP; Thu, 13 Apr 2017 10:03:45 -0700 (PDT)
From:   Evan Aad <oddeveneven2@gmail.com>
Date:   Thu, 13 Apr 2017 20:03:45 +0300
Message-ID: <CAFzZ5jq5KS9DydO+zCdQ=BHCLOZYHXjp_yDW1S=UVb_u3CfTwA@mail.gmail.com>
Subject: Errors running gitk on OS X
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running gitk from the command line, while at the top level of a Git
working directory, produces the following error message, and gitk
fails to open:

> objc[1031]: Objective-C garbage collection is no longer supported.

> /usr/local/bin/wish: line 2:  1031 Abort trap: 6           "$(dirname $0)/../../../Library/Frameworks/Tk.framework/Versions/8.5/Resources/Wish.app/Contents/MacOS/Wish" "$@"

Additionally, the following error message pops up in a window:

> Wish quit unexpectedly.

> Click Reopen to open the application again. Click Report to see more detailed information and send a report to Apple.

> Ignore | Report... | Reopen

How can this be fixed?

***

OS: macOS Sierra, Version 10.12.4
Git version: 2.11.0 (Apple Git-81)
