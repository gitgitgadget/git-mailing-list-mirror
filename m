Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBA1D208CD
	for <e@80x24.org>; Sun, 20 Aug 2017 07:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbdHTHuh (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 03:50:37 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33545 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbdHTHuf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 03:50:35 -0400
Received: by mail-pg0-f52.google.com with SMTP id t3so55491187pgt.0
        for <git@vger.kernel.org>; Sun, 20 Aug 2017 00:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=Kx6ed+CDGqobn7a5m1yR5ppzqZMQwXKQ4NM9kQ1P/dE=;
        b=P+5XAjY4HQp0T/y6IfDMvHTO1ScmVijfM9PXqHBcwu9mPOQjM7VEW6/fAYFyc2f2Ev
         oF+QoUhxUmt98hMYF+ZaS8Z5pCpCvzbgNDnZyZ4l3P9Hc9EOi/PSI1Qi7OQ2Lv1ShRkz
         N3QVy3rVpCgEtjvnAkhmDn1zupuZ5jHmouO1IC8hD3EXkizIoJ9NCcDOM/A9ATIKq0pf
         SqKg52vbEWgp8Qyv0XTcBh856BH6dsU95Hb62xbISL0rn2s2hlUFQ5M5tquJpiGFMeok
         pmzBi4mW4TK3A2Q26YIJvrvr5FJ1CSmqnvOow4UAwjt3k4RAzDJZ6WXoiuUSxt1XoYLF
         WsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=Kx6ed+CDGqobn7a5m1yR5ppzqZMQwXKQ4NM9kQ1P/dE=;
        b=ODvTc86JUBj4FZDN4u7FqSp6DufeFa6KN1mlpImJ9S7ideHNPhlnxRELZE3kHE61pK
         cbvb0BavUIff4G7zosvAALoqn1/jklBTGGpI1Ajjfx1s6lLdROw/+7HSe68UFZKsYVqp
         tfDgFet6vTprl7PuU90IiKSx+qZKDQsGBZtxNZryfLClCwSuEjQKgD7+25rthrI2U2k/
         x41A2aSOvDYBAT7gVHTJ/FiSCjTrJRRKT3DS3FrlXBtwnkYz+wBQFSaF+WMGuAnajtdQ
         VV7C8srcu0XWKdqe/rzl+yOWYCeMlET70zjqKT88GV2uXirSQjeR1TnzMJtfsqWoe+ie
         +rFA==
X-Gm-Message-State: AHYfb5jW3TnmH7op9vkeKhsEJWxGnZakpIC/XQmqvSTnEhMp/4Yo+AVS
        f65gwrdhTH57uj2FsTg=
X-Received: by 10.99.47.66 with SMTP id v63mr13624056pgv.4.1503215435160;
        Sun, 20 Aug 2017 00:50:35 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id y25sm18746867pfk.162.2017.08.20.00.50.33
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Aug 2017 00:50:34 -0700 (PDT)
Message-ID: <1503215489.5824.4.camel@gmail.com>
Subject: Git *accepts* a branch name, it can't identity in the future?
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date:   Sun, 20 Aug 2017 13:21:29 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

First of all, I would like to tell that this happened completely by
accident and it's partly my mistake. Here's what happened.

I recently started creating 'feature branches' a lot for the few
patches that I sent to this mailing list. To identify the status of the
patch corresponding to that branch I prefixed them with special unicode
characters like ✓, ˅ etc. instead of using conventional hierarchical
names like, 'done/', 'archived/'.

Then I started finding it difficult to distinguish these unicode-
prefixed names probably because they had only one unicode character in
common. So, I thought of switching to the conventional way of using
scoped branch names (old is gold, you see). I wrote a tiny script to
rename the branches by replacing a specific unicode prefix with a
corresponding hierachy. For example, the script would convert a branch
named '✓doc-fix' to 'done/doc-fix'.

I made a small assumption in the script which turned out to be false. I
thought the unicode prefixes I used corresponded to only two bytes.
This lead to the issue. The unicode character '✓' corresponds to three
characters and as a result instead of removing it, my script replaced
it with the unknown character '�'. So, the branch named '✓doc-fix'
became 'done/�doc-fix'. Here's the issue. I couldn't use 

    $ git branch -m done/�doc-fix done/dic-fix 

to rename the branch. Nor could I refer to it in anyway. Git simply
says,

    error: pathspec 'done/�doc-fix' did not match any file(s) known to git.

It's not a big issue as I haven't lost anything out of it. The branches
have been merged into 'master'.

I just wanted to know why git accepted a branch name which it can't
identify later?

If it had rejected that name in the first place it would have been
better. In case you would like to know how I got that weird name,
here's a way to get that

    $ echo '✓doc-fix' | cut -c3-100

-- 
Kaartic
