Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3E421F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 19:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfKNTrQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 14:47:16 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:35406 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfKNTrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 14:47:16 -0500
Received: by mail-pg1-f169.google.com with SMTP id q22so4464875pgk.2
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 11:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=e7XgB9twR8AFV1w7LqUbfkbXWr8NYL+ANhY7RV73F+E=;
        b=fS/pC3iWLMjoVWAJZA/hprFb69S+JgZgHFTK98OuQ3QlZumGwAAjbVg3iRw9sLv0d1
         lBiu0THQ5W1vDPK1wL4JH6ILjBhX7E7V8AKlGjdbCyKQ5px0sfs01zqCm+L2aHhD9DsJ
         I9MkKAFSm/ig2Qt67ym0GNi3ICgAyCNgLWJTZxEX2IEpU/0VX55bMQDgqsl/Yg0z2WQH
         IO+5A99ZmvNn1Rs5cEW6AQfdvnX9J13Vwmge8qyQKF7c058U5KgCYeCAet19Sv4roMkY
         c5DKK7JQNIfMDUhP46Koy1KatXgQtVw55ouZ59wjFGKisPqKtt6QMVFkGs/mOGqakvkl
         QH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=e7XgB9twR8AFV1w7LqUbfkbXWr8NYL+ANhY7RV73F+E=;
        b=Am2MEOwt4+FgubLBeIS+b2EMycfU92Jyf1u+BZoLH03U+jwFzj3T6xLJb9svrzXfvo
         SgSMvv/9yqk9blb8wWsPZ9tRWAT2d6J47T5z2KWExWpgVkAkCuFePQ38AxzOdd10KiNz
         3E2k0M2w08XyC/T4tPL4TXRckI/CyU7d12WFFq+q8C0zhmdjzIR9leHhf9UUtmhupQ1F
         3MSv+yWCVE1mn5RZq/9dOizpKqpjuyy3aOWGdUU2QALye6bQkD5ijgvX/SXEaYPTIvL/
         pmozswY5dviVZHpPfTOzIkva8veQuky0yuTWqOkveRcWBkrn2+Nz7ldlfIj/c27Dzz56
         j1nw==
X-Gm-Message-State: APjAAAUJcmIQcPrmlYFcHRxwY3PpzE14ZpHZZ/4jK36HyXDkt/tD3Xac
        y9ai0hHnyjNxX5OKV7dOWr1yfR6zWDo=
X-Google-Smtp-Source: APXvYqyn5dhYxDPW8RW/9k0WP1vXxbQdmFTwjMK9E4Ml1TFIls4FW2RxNBcmmGgDbmpwFwzg5RGSrQ==
X-Received: by 2002:a63:1624:: with SMTP id w36mr11203756pgl.404.1573760833268;
        Thu, 14 Nov 2019 11:47:13 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id y14sm7528142pff.69.2019.11.14.11.47.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 11:47:12 -0800 (PST)
Date:   Thu, 14 Nov 2019 11:47:08 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Subject: Announcing git-mentoring@googlegroups.com
Message-ID: <20191114194708.GD60198@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Since https://public-inbox.org/git/20191114023100.GD22855@google.com/ is
well hidden inside a large thread which diverged into many topics, I'm
happy to announce (redundantly) the creation of a git-mentoring mailing
list!

You can join the list to view messages and participate at
https://groups.google.com/forum/#!forum/git-mentoring.

This list is a great place for those who are new to Git and interested
in learning how to contribute to ask questions and expect kind, thorough
answers out of the spotlight of the main Git mailing list. Use this list
to ask or answer specific questions you have about contributing to the
Git project; rather than pairing with a specific mentor who may not
share your timezone or vacation schedule, you can ask questions of the
mentoring list as a whole to receive answers from any volunteer who is
available.

The community expectations for the mailing list are the same as those
for the main Git list, but posts are only visible to members (anyone can
join) in order to create a more private space for beginner questions.

For now, posting is limited to members only (again, anyone can join) -
but if we find a high incidence of needing to forward messages to and
from the main list, we can change that permission as needed.

I look forward to us learning from each other on that list!

 - Emily
