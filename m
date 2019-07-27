Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B4D41F462
	for <e@80x24.org>; Sat, 27 Jul 2019 19:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388060AbfG0TlI (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jul 2019 15:41:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35293 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387995AbfG0TlI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jul 2019 15:41:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so25980442plp.2
        for <git@vger.kernel.org>; Sat, 27 Jul 2019 12:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bwsddKdJLmbVD+7CQ5tZSb+Jrnd6DuiZ26t9UMtoEms=;
        b=S195uDrJueyR2ZWtUWWpOpyYfybnhk8R9Ke0Hx2E4kd9XlfPytJG09oyGbmQjI+3zp
         2DtWLVWniTK5vJjSrStsWYS9dM6Ym85EClL4A4zirzo1KQv6D0fZOgsbMJkONq3Um6xh
         7j5UxxG7TT07VDwTlM5MqHEsoNMt0uFdMEPSouRhT7XoXn2GOSQddiJ8RA6By43vJYDc
         tx4puHtisULcW3hWI4I9EHP9p230cz4b7uctvwDvduzqk0FTvpeAozzll9URmJYef033
         a4mNHaTqQ8ywG+j5+eyn5qwzWpKZOZao4VPGR1P+1F/mtZ0kMbXoCXIGI9tg/aZ733Np
         NuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bwsddKdJLmbVD+7CQ5tZSb+Jrnd6DuiZ26t9UMtoEms=;
        b=d5pYzLvDiiRcdhQIpz1HjFV5NE6Y2PfU/t6tXLfrP9Te8eNDC2T5NWnF0NkYTw0Der
         XeyzvsELXRoDv51EMOlXjW7CbLGX3PYioPe0BWQ/AEX/6iVtag+koDmuiFe8y6X3XiSn
         RwMTvoQ/jgDV0VCg2gaNm5k3kwEdbkyiYLecX2dVWdbKf42KCfo5UTuRQZ5rF3w/9I18
         XX89kQ+M942NIWFvZWgmls4IwOCDsvdBgX9JlGegSmEaL4OKuGfQjDVjQOA20Bw19AMk
         9lHLreg9hxecxKg3Pp0QLN/LEhx6EUd2BHcpgKZzrIH0IM70z3Kf9sTN7GNtt58MYbSn
         CWPA==
X-Gm-Message-State: APjAAAWpkQc04RFEbjGqI2X34vnmtFZjAizDOW948KTwFEXYPnQmWutf
        ytPn04AUHQTGMJt9UJouedaXIlTzzjw=
X-Google-Smtp-Source: APXvYqzkXM5mWbFPp+u16On/Rq9tJ3Ra74AslsEdPO0+kurCBPr1vnWUfYzJ0OueFM3T9OWr9NmuqA==
X-Received: by 2002:a17:902:b608:: with SMTP id b8mr104026413pls.303.1564256467020;
        Sat, 27 Jul 2019 12:41:07 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.218])
        by smtp.gmail.com with ESMTPSA id u1sm53404991pgi.28.2019.07.27.12.41.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 12:41:05 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2019, #06; Thu, 25)
Date:   Sun, 28 Jul 2019 01:08:13 +0530
Message-Id: <20190727193814.7400-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com>
References: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On Thu, 25 Jul 2019 17:19:23 -0700 Junio C Hamano <gitster@pobox.com> wrote:
> 
> [...]
> [New Topics]
> 
> * bb/grep-pcre2-bug-message-fix (2019-07-23) 1 commit
>   (merged to 'next' on 2019-07-23 at 8bd5a68618)
>  + grep: print the pcre2_jit_on value
> 
>  BUG() message fix.
> 
>  The codepath may want to just simply be removed, though.
> 
> 
> * ra/rebase-i-more-options (2019-07-23) 4 commits
>  - SQUASH???

There are only 3 commits in this "series".

>  - rebase -i: support --committer-date-is-author-date
>  - sequencer: add NULL checks under read_author_script
>  - rebase -i: add --ignore-whitespace flag

The correct order should be:
   - rebase -i: add --ignore-whitespace flag
   - sequencer: add NULL checks under read_author_script
   - rebase -i: support --committer-date-is-author-date

I'll soon send another revision and while on it, let's merge
these topics into one. Should I also rebase them on the tip
of git/git's master?

> [...]

Best
Rohit

