Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 909F81F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 18:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfJUSn0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 14:43:26 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:44680 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfJUSn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 14:43:26 -0400
Received: by mail-pf1-f181.google.com with SMTP id q21so8946736pfn.11
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 11:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WRXxdJBjof2b0wNaeY+vn+n0IlLselMzI+hyKgXvzms=;
        b=c5g3ofale21GVCCg0mrvQHfN16IWbFvyUNdkO1Wj7+5M5R4MfQQgf8iN5bZhRIdE/E
         5uDeMeR97I71vFdztS0d56MEkJCOWGJzlK9Sr6Xf2+0reubqJCbtcmhgbi8v5YKnstMQ
         CwQ0stX77Iaf1WF8AxGgWKfgb7zYYMj/XmO9lJY1VwE6JRrDvB/IL99FKD45goeaa8MN
         4KIDxwC6c6avgqVrQ7/qjYXwy59QILEnGedKoiDn+/GWxG/RFH+N2tTcRNFbKaPn9oyF
         ncfs2QGZioj15Hp/O8X82svwFgkhdeVFFp47GxD2PYBTRpx2OkizlJ3mKLPFwAdgRFPK
         tHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WRXxdJBjof2b0wNaeY+vn+n0IlLselMzI+hyKgXvzms=;
        b=UzIq6LfYMXJnfI2CBk2JxFuG387GKv6VJ2NlLww2y1h1FW9SNuyZ+T0FglKr2GxZ+Y
         /ZBnK6b4zU859M/lkLyEUTp6ZWYVuZYqI8dZ3e37hh/aSvwGsEKxyEsd+VFY1pvoSFAQ
         DF70ELAb/eb48KJZJa4JRGHqC5pV7jgdyibJ/7TWwFdI/BwoO70PQXG9nktCt6A41k7O
         4pIVn8CmDJSCV4ej+iUNaI7wnGCOBFvtBJe3d3v+Lk4wLYnvCzRaQmHpiBTv0n0kyXhj
         4sz7gGEbIvJW3pPG7iNRYUK8agCDiR678SuuqnmjqnYpE7DA9koJvsjIeQZvp9zLapjW
         ryuw==
X-Gm-Message-State: APjAAAVuFWMHkYsMtypgrcy3SJu1S314APcNqTpIWvYuvhsIaTXwyR9f
        x56FFOtTBE2pXh7RQF6YDF2iMw==
X-Google-Smtp-Source: APXvYqwReOg1eUV2+jWCf/pbC3K/zi0qlQBv4UjFxRje6qUln5zREBZ/q5g7rjPVZaeibTGkTJzpzg==
X-Received: by 2002:a62:ae06:: with SMTP id q6mr24536062pff.96.1571683404954;
        Mon, 21 Oct 2019 11:43:24 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id b4sm13980282pju.16.2019.10.21.11.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 11:43:24 -0700 (PDT)
Date:   Mon, 21 Oct 2019 11:43:20 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Karina Saucedo <karina.saucedogza@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Outreachy Winter 2019
Message-ID: <20191021184320.GB139951@google.com>
References: <CAJxDvSsZLz+oxPQ15YiGatURSyuxnriiL5TjXMay0W7VPVjNsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJxDvSsZLz+oxPQ15YiGatURSyuxnriiL5TjXMay0W7VPVjNsQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 21, 2019 at 11:54:01AM -0500, Karina Saucedo wrote:
> Hello, my name is Karina and I'm and Outreachy applicant. I´m interested in
> applying to the project 'Add did you mean hints´ and I was wondering how
> can I start contributing since there seem to be no issues on the github
> page. Thank you!

Hi Karina!

It's best to start on a microproject; some of the other applicants are
already doing so as well. You can search this list for "outreachy" (try
it from public-inbox.org/git) to see some of the discussions with other
applicants and what they are or are not working on; there are also some
good-first-issues in the GitGitGadget bug tracker
(github.com/gitgitgadget/git/issues). Git project doesn't use Github to
organize bugs itself; the bug trackers are all abstractions of
conversation on the list (such as this one -
https://public-inbox.org/git/20190916184208.GB17913@google.com/ -
explaining some possible Outreachy microprojects).

Thanks and good luck - I'm the mentor for "Did you mean" so you can feel
free to ask me directly if there's something you're not sure of and you
don't want to ask the list. :) Although, of course the list will be
happy to answer your questions as well.

 - Emily
