Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F01691F406
	for <e@80x24.org>; Thu, 10 May 2018 13:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757082AbeEJNP1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 09:15:27 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:45253 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935041AbeEJNPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 09:15:25 -0400
Received: by mail-wr0-f173.google.com with SMTP id p5-v6so1971006wre.12
        for <git@vger.kernel.org>; Thu, 10 May 2018 06:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=knFZBjcCbJNJBP48RsBaPI2hv64Zr6PVZhbjQeZHDUk=;
        b=RyeMN++86VRxlqWsce+mK+Tgum+0RuQF/jjmbAuczXUhAay7oOWrlNDhEk9Du5niGa
         1406GHcAPszvyfwPtAoCdBTojxFwxhuhd3zJNZKPA4g1iwkycjfA5d+YYQrUXbiK0+R6
         N7IrkE4Uy3WFnauBQhJTNXmCbpcUmfpZyhUilV67gQMGhhEVOa4KIjNikO2GZiKUUXjV
         3FMoUy3nLLj5XhUYHr53VxIJZOVQ1hpi/51ZjxFiOvlS5ga4v0GlHG1n3tmD1Eu1oc7B
         uu6CDNs4s6m6qjCfdsvZRxqajN2NCr3aPfaplJ1zZqJpc4MhR0yKEEolmzmSlFyqmiHY
         gjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=knFZBjcCbJNJBP48RsBaPI2hv64Zr6PVZhbjQeZHDUk=;
        b=XZnRgFgmslubPwBq6Y6R9oTdNVmj8IviF8pxBSjzKOI/xjwhUdHuktmt/kbYzplLz2
         2Y/fBMWcI88cz5gfnx10aD+IAMl4BZebVxB1AnvzR88nKXG1y7+LtLf1ImLKtrbpIhNj
         a3oXMJyRlCEkFk0N0jVgw0RHiFDjpsL0rsHHbpGqvynNLCeVNH1LO+4emAw9CJrtVoJF
         qAi3na77oj+STrA+IB0cbZGX3zy5BCeXb9KT0En+cjo3+70L1LiEw1junxGzyvEf/YtK
         iWMc/3STiNZlCuIX+o0gqllqmqUqR5UQCRtz0eKkxnM5FsZd1afufFQG2TSrlSzEHTna
         RJZA==
X-Gm-Message-State: ALKqPwf4EYxc/5mwel7w4V0y5wDpHKz6UAFj41VoimpfR5LzEt2uK4hi
        aoGago7Yjs9N4/QxH7RnXtfRO5/K
X-Google-Smtp-Source: AB8JxZoRSNUxKM1L2ygJou/D2Ot65LvGL0s3gcaxbYugmTbI/gTi3Pv+vF6QuWYIL8zY2Bd4s6kH6Q==
X-Received: by 2002:adf:cd08:: with SMTP id w8-v6mr1337300wrm.187.1525958123980;
        Thu, 10 May 2018 06:15:23 -0700 (PDT)
Received: from localhost.localdomain ([94.10.164.188])
        by smtp.gmail.com with ESMTPSA id d17-v6sm1078557wrc.0.2018.05.10.06.15.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 May 2018 06:15:22 -0700 (PDT)
From:   Oliver Joseph Ash <oliverjash@gmail.com>
To:     mqudsi@neosmart.net
Cc:     git@vger.kernel.org
Subject: Re: Regression in patch add?
Date:   Thu, 10 May 2018 14:15:02 +0100
Message-Id: <20180510131502.17739-1-oliverjash@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <01010162c940b8bb-d8139971-3ee2-4cd6-bb19-35126d46753b-000000@us-west-2.amazonses.com>
References: <01010162c940b8bb-d8139971-3ee2-4cd6-bb19-35126d46753b-000000@us-west-2.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> does your test involve unusual file systems, funny characters in filenames, ..? You are on some sort of Linux, right?

I'm running macOS 10.13.4. I don't have any unusual file system setup, as far as I'm aware. The filename in my test case is simply `foo`.

I tried the steps you suggested: on git 2.17.0, saving the patch, editing it, and applying it, and it succeeded.

> should now show bar2 in the first hunk and bar1 in the second hunk, just like your edited test.patch.

That was the case, although I had to remove the `--check` flag from `git apply`.

> How comfortable are you with building Git from the sources?

I've never done it before, but I assume it's well documented, so I'm willing to give it a shot!

Happy to try any steps to debug this! Although I'm a bit surprised no-one else can reproduce it with the same version of Git, which makes it seem less likely this could be a bug, and more likely it's something in my setup.
